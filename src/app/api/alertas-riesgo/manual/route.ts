import { NextRequest, NextResponse } from "next/server";
import { createHash } from "node:crypto";
import { createTransport } from "nodemailer";
import { createClient as createSupabaseAdmin } from "@supabase/supabase-js";
import { getPerfil } from "@/lib/auth";
import {
  obtenerDatosEstudiantes,
  encontrar_riesgo,
} from "@/lib/riesgo/proceso";

export const runtime = "nodejs";
export const dynamic = "force-dynamic";

type Nivel = "Alto" | "Medio" | "Informativo";

type Factor = {
  titulo: string;
  detalle: string;
  nivel: Nivel;
};

function normalizar(valor: unknown): string {
  return String(valor ?? "")
    .trim()
    .toLocaleLowerCase("es")
    .normalize("NFD")
    .replace(/[\u0300-\u036f]/g, "")
    .replace(/\s+/g, " ");
}

function promedio(notas: number[]): number | null {
  const validas = notas.filter(Number.isFinite);

  if (!validas.length) return null;

  return validas.reduce((total, nota) => total + nota, 0) / validas.length;
}

function maxConsecutivas(fechas: string[]): number {
  const ordenadas = [...new Set(fechas)].sort();
  let maximo = 0;
  let consecutivas = 0;
  let anterior: Date | null = null;

  for (const fecha of ordenadas) {
    const actual = new Date(`${fecha}T00:00:00Z`);

    if (
      anterior &&
      Math.round(
        (actual.getTime() - anterior.getTime()) / 86400000,
      ) === 1
    ) {
      consecutivas++;
    } else {
      consecutivas = 1;
    }

    maximo = Math.max(maximo, consecutivas);
    anterior = actual;
  }

  return maximo;
}

function semanaColombia(): { inicio: string; fin: string } {
  const partes = new Intl.DateTimeFormat("en-CA", {
    timeZone: "America/Bogota",
    year: "numeric",
    month: "2-digit",
    day: "2-digit",
  }).formatToParts(new Date());

  const obtener = (tipo: string) =>
    partes.find((parte) => parte.type === tipo)?.value ?? "";

  const fecha = new Date(
    `${obtener("year")}-${obtener("month")}-${obtener("day")}T00:00:00Z`,
  );

  const diasDesdeLunes = (fecha.getUTCDay() + 6) % 7;
  fecha.setUTCDate(fecha.getUTCDate() - diasDesdeLunes);

  const inicio = fecha.toISOString().slice(0, 10);
  fecha.setUTCDate(fecha.getUTCDate() + 7);

  return {
    inicio,
    fin: fecha.toISOString().slice(0, 10),
  };
}

function escaparHtml(valor: unknown): string {
  return String(valor ?? "").replace(/[&<>"']/g, (caracter) => {
    const entidades: Record<string, string> = {
      "&": "&amp;",
      "<": "&lt;",
      ">": "&gt;",
      '"': "&quot;",
      "'": "&#39;",
    };

    return entidades[caracter];
  });
}

export function formatoPromedio(valor: number | null): string {
  return valor === null ? "Sin datos" : valor.toFixed(2);
}

export function porcentajeDesdeModelo(
  valor: number | null | undefined,
): number | null {
  if (
    valor === null ||
    valor === undefined ||
    !Number.isFinite(valor)
  ) {
    return null;
  }

  // El modelo entrega la probabilidad en escala de 0 a 1.
  // Se convierte a porcentaje para mostrarla igual que en el informe.
  return valor * 100;
}

export function formatoPorcentajeModelo(valor: number | null): string {
  return valor === null ? "No disponible" : `${valor.toFixed(1)} %`;
}

export function crearFactores(
  estudiante: {
    estrato: number | null;
    anio_repetido: string | number | boolean | null;
    total_anotaciones: number | null;
    graves: number | null;
    leves: number | null;
  },
  p1: number | null,
  p2: number | null,
  faltas: number,
  retardos: number,
  consecutivas: number,
): Factor[] {
  const factores: Factor[] = [];

  if (p1 !== null && p1 < 3) {
    factores.push({
      titulo: "Promedio bajo en el periodo 1",
      detalle: `Promedio registrado: ${p1.toFixed(2)}.`,
      nivel: "Alto",
    });
  }

  if (p2 !== null && p2 < 3) {
    factores.push({
      titulo: "Promedio bajo en el periodo 2",
      detalle: `Promedio registrado: ${p2.toFixed(2)}.`,
      nivel: "Alto",
    });
  }

  if (faltas >= 5) {
    factores.push({
      titulo: "Inasistencias frecuentes",
      detalle: `Se registran ${faltas} faltas.`,
      nivel: faltas >= 10 ? "Alto" : "Medio",
    });
  }

  if (consecutivas >= 2) {
    factores.push({
      titulo: "Ausencias consecutivas",
      detalle: `Se registran hasta ${consecutivas} faltas consecutivas.`,
      nivel: consecutivas >= 4 ? "Alto" : "Medio",
    });
  }

  if (retardos >= 5) {
    factores.push({
      titulo: "Retardos frecuentes",
      detalle: `Se registran ${retardos} retardos.`,
      nivel: retardos >= 10 ? "Alto" : "Medio",
    });
  }

  const graves = Math.max(0, estudiante.graves ?? 0);
  const leves = Math.max(0, estudiante.leves ?? 0);
  const total = Math.max(0, estudiante.total_anotaciones ?? 0);

  if (graves > 0) {
    factores.push({
      titulo: "Anotaciones graves",
      detalle: `Se registran ${graves} anotaciones graves.`,
      nivel: "Alto",
    });
  }

  if (leves > 0) {
    factores.push({
      titulo: "Anotaciones leves",
      detalle: `Se registran ${leves} anotaciones leves.`,
      nivel: leves >= 5 ? "Alto" : leves >= 3 ? "Medio" : "Informativo",
    });
  }

  if (total > 0 && graves === 0 && leves === 0) {
    factores.push({
      titulo: "Anotaciones registradas",
      detalle: `Total de anotaciones: ${total}.`,
      nivel: "Informativo",
    });
  }

  const repetido = estudiante.anio_repetido;

  const repitio =
    typeof repetido === "boolean"
      ? repetido
      : typeof repetido === "number"
        ? repetido === 1
        : ["si", "1", "true", "repitente", "repetido", "repetida"].includes(
            normalizar(repetido),
          );

  if (repitio) {
    factores.push({
      titulo: "Año escolar repetido",
      detalle: "El registro indica que el estudiante ha repetido un año.",
      nivel: "Medio",
    });
  }

  if (estudiante.estrato !== null) {
    factores.push({
      titulo: "Información socioeconómica registrada",
      detalle: `Estrato registrado: ${estudiante.estrato}. Este dato por sí solo no determina el riesgo.`,
      nivel: "Informativo",
    });
  }

  return factores;
}

export async function POST(request: NextRequest) {
  let transport: ReturnType<typeof createTransport> | null = null;

  try {
    // 1. Verificar la sesión.
    const perfil = await getPerfil();

    if (!perfil) {
      return NextResponse.json(
        { error: "Debes iniciar sesión para enviar una alerta." },
        { status: 401 },
      );
    }

    if (!["coordinador", "profesor"].includes(perfil.rol)) {
      return NextResponse.json(
        { error: "No tienes permisos para enviar alertas de seguimiento." },
        { status: 403 },
      );
    }

    // 2. Validar el estudiante recibido.
    const body: unknown = await request.json().catch(() => null);

    if (
      !body ||
      typeof body !== "object" ||
      !("estudianteId" in body) ||
      typeof body.estudianteId !== "string" ||
      !body.estudianteId.trim()
    ) {
      return NextResponse.json(
        { error: "Debes indicar un estudianteId válido." },
        { status: 400 },
      );
    }

    const estudianteId = body.estudianteId.trim();

    // 3. Validar configuración de Supabase y Gmail.
    const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL;
    const serviceRoleKey = process.env.SUPABASE_SERVICE_ROLE_KEY;
    const gmailUser = process.env.GMAIL_USER;
    const gmailPassword = process.env.GMAIL_APP_PASSWORD?.replace(/\s/g, "");

    if (!supabaseUrl || !serviceRoleKey) {
      return NextResponse.json(
        { error: "Falta configurar Supabase en el servidor." },
        { status: 500 },
      );
    }

    if (!gmailUser || !gmailPassword) {
      return NextResponse.json(
        { error: "Falta configurar GMAIL_USER o GMAIL_APP_PASSWORD." },
        { status: 500 },
      );
    }

    const admin = createSupabaseAdmin(supabaseUrl, serviceRoleKey, {
      auth: {
        autoRefreshToken: false,
        persistSession: false,
      },
    });

    // 4. Consultar al estudiante.
    const { data: estudiante, error: errorEstudiante } = await admin
      .from("estudiantes")
      .select(
        "id,nombre_completo,curso_id,estrato,anio_repetido,total_anotaciones,graves,leves,cursos(nombre)",
      )
      .eq("id", estudianteId)
      .maybeSingle();

    if (errorEstudiante) {
      console.error(
        "Error consultando estudiante:",
        errorEstudiante.message,
      );

      return NextResponse.json(
        { error: "No se pudo consultar el estudiante." },
        { status: 500 },
      );
    }

    if (!estudiante) {
      return NextResponse.json(
        { error: "El estudiante solicitado no existe." },
        { status: 404 },
      );
    }

    // 5. Los profesores solo pueden enviar alertas a sus cursos asignados.
    if (perfil.rol === "profesor") {
      if (!perfil.profesor_id || !estudiante.curso_id) {
        return NextResponse.json(
          { error: "No se pudo verificar la asignación del curso." },
          { status: 403 },
        );
      }

      const { data: asignacion, error: errorAsignacion } = await admin
        .from("horario_clases")
        .select("curso_id")
        .eq("profesor_id", perfil.profesor_id)
        .eq("curso_id", estudiante.curso_id)
        .eq("es_descanso", false)
        .limit(1);

      if (errorAsignacion) {
        console.error(
          "Error verificando curso:",
          errorAsignacion.message,
        );

        return NextResponse.json(
          { error: "No se pudo verificar el permiso sobre el curso." },
          { status: 500 },
        );
      }

      if (!asignacion?.length) {
        return NextResponse.json(
          { error: "No tienes permiso para enviar alertas a este estudiante." },
          { status: 403 },
        );
      }
    }

    // 6. Consultar el correo del estudiante.
    const { data: perfilEstudiante, error: errorPerfil } = await admin
      .from("perfiles")
      .select("correo")
      .eq("estudiante_id", estudianteId)
      .eq("rol", "estudiante")
      .maybeSingle();

    if (errorPerfil) {
      console.error("Error consultando correo:", errorPerfil.message);

      return NextResponse.json(
        { error: "No se pudo consultar el correo del estudiante." },
        { status: 500 },
      );
    }

    const destinatario = perfilEstudiante?.correo?.trim();

    if (!destinatario) {
      return NextResponse.json(
        {
          error:
            "El estudiante no tiene un correo registrado en su perfil de usuario.",
        },
        { status: 422 },
      );
    }

    // 7. Consultar las calificaciones y asistencias.
    const [
      { data: notas, error: errorNotas },
      { data: asistencias, error: errorAsistencias },
    ] = await Promise.all([
      admin
        .from("calificaciones")
        .select("estudiante_id,periodo,nota")
        .eq("estudiante_id", estudianteId),

      admin
        .from("asistencias")
        .select("estudiante_id,fecha,estado")
        .eq("estudiante_id", estudianteId),
    ]);

    if (errorNotas || errorAsistencias) {
      console.error(
        "Error consultando datos del informe:",
        errorNotas?.message,
        errorAsistencias?.message,
      );

      return NextResponse.json(
        { error: "No se pudieron consultar las notas o asistencias." },
        { status: 500 },
      );
    }

    const promedioP1 = promedio(
      (notas ?? [])
        .filter((nota) => Number(nota.periodo) === 1)
        .map((nota) => Number(nota.nota)),
    );

    const promedioP2 = promedio(
      (notas ?? [])
        .filter((nota) => Number(nota.periodo) === 2)
        .map((nota) => Number(nota.nota)),
    );

    const faltasFechas = (asistencias ?? [])
      .filter((item) =>
        ["falto", "falta"].includes(normalizar(item.estado)),
      )
      .map((item) => String(item.fecha))
      .sort();

    const retardos = (asistencias ?? []).filter(
      (item) => normalizar(item.estado) === "retardo",
    ).length;

    const consecutivas = maxConsecutivas(faltasFechas);

    // 8. Obtener el nombre del curso.
    const cursosRelacionados = estudiante.cursos as
      | { nombre: string | null }[]
      | { nombre: string | null }
      | null;

    const curso = Array.isArray(cursosRelacionados)
      ? cursosRelacionados[0]?.nombre ?? "Sin curso"
      : cursosRelacionados?.nombre ?? "Sin curso";

    // 9. Calcular los factores académicos y de asistencia.
    const factores = crearFactores(
      estudiante,
      promedioP1,
      promedioP2,
      faltasFechas.length,
      retardos,
      consecutivas,
    );

    const factoresAlerta = factores.filter(
      (factor) => factor.nivel === "Alto" || factor.nivel === "Medio",
    );

    if (factoresAlerta.length === 0) {
      return NextResponse.json(
        {
          error:
            "Este estudiante no tiene factores de riesgo Alto o Medio. No se envió una alerta.",
        },
        { status: 422 },
      );
    }

    const nivel: "Alto" | "Medio" = factoresAlerta.some(
      (factor) => factor.nivel === "Alto",
    )
      ? "Alto"
      : "Medio";

    const nombre = estudiante.nombre_completo ?? "Estudiante";

    // 10. Calcular los valores del modelo utilizado en el informe.
    // Se usa el mismo proceso que en el reporte de estudiantes.
    let probabilidadModelo: number | null = null;
    let indiceModelo: number | null = null;

    try {
      const datosModelo = await obtenerDatosEstudiantes();
      const resultadosModelo = await encontrar_riesgo(datosModelo);

      const resultadoModelo = resultadosModelo.find(
        (resultado) =>
          normalizar(resultado.nombre_estudiante) === normalizar(nombre),
      );

      probabilidadModelo = porcentajeDesdeModelo(
        resultadoModelo?.probabilidad_de_desercion,
      );

      indiceModelo = porcentajeDesdeModelo(
        resultadoModelo?.indice_de_riesgo,
      );
    } catch (errorModelo) {
      // Un error del modelo no debe mostrar porcentajes inventados.
      // La alerta académica puede enviarse indicando que no hay datos del modelo.
      console.error(
        "No fue posible obtener los valores del modelo de riesgo:",
        errorModelo instanceof Error ? errorModelo.message : errorModelo,
      );
    }

    const probabilidadTexto = formatoPorcentajeModelo(probabilidadModelo);
    const indiceTexto = formatoPorcentajeModelo(indiceModelo);

    const resumenFactores = factoresAlerta
      .map(
        (factor) =>
          `• [${factor.nivel}] ${factor.titulo}: ${factor.detalle}`,
      )
      .join("\n");

    // 11. Construir las tarjetas de factores para el correo HTML.
    const resumenHtml = factoresAlerta
      .map((factor) => {
        const colorNivel =
          factor.nivel === "Alto"
            ? "#b91c1c"
            : factor.nivel === "Medio"
              ? "#b45309"
              : "#475569";

        const fondoNivel =
          factor.nivel === "Alto"
            ? "#fef2f2"
            : factor.nivel === "Medio"
              ? "#fffbeb"
              : "#f1f5f9";

        return `
          <tr>
            <td style="padding:14px;border:1px solid #e2e8f0;border-radius:8px;">
              <div style="font-size:15px;font-weight:bold;color:#172b4d;">
                ${escaparHtml(factor.titulo)}
              </div>
              <div style="font-size:13px;line-height:1.6;margin-top:6px;color:#475569;">
                ${escaparHtml(factor.detalle)}
              </div>
              <div style="display:inline-block;margin-top:9px;padding:5px 9px;border-radius:20px;background:${fondoNivel};color:${colorNivel};font-size:12px;font-weight:bold;">
                Nivel: ${escaparHtml(factor.nivel)}
              </div>
            </td>
          </tr>
          <tr><td style="height:8px;font-size:1px;">&nbsp;</td></tr>
        `;
      })
      .join("");

    // 12. Diseño del correo.
    const html = `
      <!doctype html>
      <html lang="es">
      <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width,initial-scale=1">
        <title>Alerta de seguimiento escolar</title>
      </head>

      <body style="margin:0;padding:0;background:#f1f5f9;font-family:Arial,Helvetica,sans-serif;color:#172b4d;">
        <div style="max-width:680px;margin:0 auto;padding:24px 12px;">

          <div style="background:#ffffff;border:1px solid #e2e8f0;border-radius:14px;overflow:hidden;">

            <div style="background:#173b68;padding:26px 28px;color:#ffffff;">
              <div style="font-size:12px;letter-spacing:1.5px;text-transform:uppercase;color:#dbeafe;font-weight:bold;">
                Sistema de Gestión Académica
              </div>
              <h1 style="font-size:25px;line-height:1.3;margin:10px 0 6px;color:#ffffff;">
                Alerta de seguimiento escolar
              </h1>
              <p style="margin:0;font-size:14px;line-height:1.6;color:#e2e8f0;">
                Información académica para apoyar el acompañamiento oportuno del estudiante.
              </p>
            </div>

            <div style="padding:26px 28px;">

              <p style="font-size:14px;line-height:1.7;margin:0 0 20px;color:#334155;">
                Se ha generado una alerta preventiva a partir de los datos académicos,
                de asistencia y de seguimiento registrados en el sistema.
              </p>

              <div style="border:1px solid #e2e8f0;border-radius:10px;padding:18px;margin-bottom:22px;">
                <div style="font-size:12px;text-transform:uppercase;letter-spacing:1px;color:#64748b;font-weight:bold;margin-bottom:7px;">
                  Estudiante
                </div>
                <div style="font-size:20px;font-weight:bold;color:#172b4d;">
                  ${escaparHtml(nombre)}
                </div>
                <div style="font-size:14px;color:#64748b;margin-top:6px;">
                  Curso: ${escaparHtml(curso)}
                </div>

                <div style="margin-top:15px;">
                  <span style="display:inline-block;padding:7px 12px;border-radius:20px;font-size:12px;font-weight:bold;${
                    nivel === "Alto"
                      ? "background:#fee2e2;color:#991b1b;"
                      : "background:#fef3c7;color:#92400e;"
                  }">
                    Nivel de alerta: ${escaparHtml(nivel)}
                  </span>
                </div>
              </div>

              <h2 style="font-size:18px;margin:0 0 12px;color:#173b68;">
                Resultados del modelo de riesgo
              </h2>

              <p style="font-size:13px;line-height:1.6;color:#64748b;margin:0 0 14px;">
                Valores calculados por el modelo utilizado en el informe de estudiantes.
              </p>

              <table role="presentation" width="100%" cellpadding="0" cellspacing="0" style="margin-bottom:24px;">
                <tr>
                  <td width="50%" style="padding:0 6px 0 0;vertical-align:top;">
                    <div style="border:1px solid #dbeafe;background:#eff6ff;border-radius:10px;padding:16px;">
                      <div style="font-size:12px;line-height:1.5;color:#1d4ed8;">
                        Probabilidad estimada de deserción
                      </div>
                      <div style="font-size:25px;font-weight:bold;color:#1e3a8a;margin-top:8px;">
                        ${escaparHtml(probabilidadTexto)}
                      </div>
                    </div>
                  </td>
                  <td width="50%" style="padding:0 0 0 6px;vertical-align:top;">
                    <div style="border:1px solid #e2e8f0;background:#f8fafc;border-radius:10px;padding:16px;">
                      <div style="font-size:12px;line-height:1.5;color:#475569;">
                        Índice de riesgo
                      </div>
                      <div style="font-size:25px;font-weight:bold;color:#172b4d;margin-top:8px;">
                        ${escaparHtml(indiceTexto)}
                      </div>
                    </div>
                  </td>
                </tr>
              </table>

              <h2 style="font-size:18px;margin:0 0 12px;color:#173b68;">
                Factores que requieren seguimiento
              </h2>

              <table role="presentation" width="100%" cellpadding="0" cellspacing="0">
                ${resumenHtml}
              </table>

              <h2 style="font-size:18px;margin:24px 0 12px;color:#173b68;">
                Resumen académico y de asistencia
              </h2>

              <table role="presentation" width="100%" cellpadding="0" cellspacing="0" style="border-collapse:collapse;border:1px solid #e2e8f0;border-radius:8px;">
                <tr>
                  <td style="padding:11px 12px;border-bottom:1px solid #e2e8f0;color:#475569;font-size:13px;">
                    Promedio del periodo 1
                  </td>
                  <td align="right" style="padding:11px 12px;border-bottom:1px solid #e2e8f0;font-weight:bold;font-size:14px;">
                    ${escaparHtml(formatoPromedio(promedioP1))}
                  </td>
                </tr>
                <tr>
                  <td style="padding:11px 12px;border-bottom:1px solid #e2e8f0;color:#475569;font-size:13px;">
                    Promedio del periodo 2
                  </td>
                  <td align="right" style="padding:11px 12px;border-bottom:1px solid #e2e8f0;font-weight:bold;font-size:14px;">
                    ${escaparHtml(formatoPromedio(promedioP2))}
                  </td>
                </tr>
                <tr>
                  <td style="padding:11px 12px;border-bottom:1px solid #e2e8f0;color:#475569;font-size:13px;">
                    Faltas registradas
                  </td>
                  <td align="right" style="padding:11px 12px;border-bottom:1px solid #e2e8f0;font-weight:bold;font-size:14px;">
                    ${faltasFechas.length}
                  </td>
                </tr>
                <tr>
                  <td style="padding:11px 12px;border-bottom:1px solid #e2e8f0;color:#475569;font-size:13px;">
                    Retardos registrados
                  </td>
                  <td align="right" style="padding:11px 12px;border-bottom:1px solid #e2e8f0;font-weight:bold;font-size:14px;">
                    ${retardos}
                  </td>
                </tr>
                <tr>
                  <td style="padding:11px 12px;color:#475569;font-size:13px;">
                    Máximo de faltas consecutivas
                  </td>
                  <td align="right" style="padding:11px 12px;font-weight:bold;font-size:14px;">
                    ${consecutivas}
                  </td>
                </tr>
              </table>

              <div style="margin-top:24px;padding:15px;border-left:4px solid #93c5fd;background:#f8fafc;">
                <p style="font-size:13px;line-height:1.7;margin:0;color:#475569;">
                  Esta alerta tiene un propósito preventivo y busca facilitar el acompañamiento
                  escolar. Los resultados del modelo son estimaciones y no constituyen por sí
                  solos un diagnóstico ni una decisión definitiva sobre el estudiante.
                </p>
              </div>

              <div style="border-top:1px solid #e2e8f0;margin-top:24px;padding-top:16px;">
                <p style="font-size:11px;line-height:1.6;color:#94a3b8;margin:0;">
                  SGA · Información confidencial para el destinatario autorizado.
                  Este mensaje fue generado automáticamente por el sistema de seguimiento escolar.
                </p>
              </div>

            </div>
          </div>
        </div>
      </body>
      </html>
    `;

    // 13. Versión de texto plano del correo.
    const texto = [
      "ALERTA DE SEGUIMIENTO ESCOLAR",
      "",
      `Estudiante: ${nombre}`,
      `Curso: ${curso}`,
      `Nivel de alerta: ${nivel}`,
      "",
      "RESULTADOS DEL MODELO DE RIESGO",
      `Probabilidad estimada de deserción: ${probabilidadTexto}`,
      `Índice de riesgo: ${indiceTexto}`,
      "",
      "FACTORES QUE REQUIEREN SEGUIMIENTO",
      resumenFactores,
      "",
      "RESUMEN ACADÉMICO Y DE ASISTENCIA",
      `Promedio periodo 1: ${formatoPromedio(promedioP1)}`,
      `Promedio periodo 2: ${formatoPromedio(promedioP2)}`,
      `Faltas registradas: ${faltasFechas.length}`,
      `Retardos registrados: ${retardos}`,
      `Máximo de faltas consecutivas: ${consecutivas}`,
      "",
      "Esta alerta es preventiva. Los resultados del modelo son estimaciones y no constituyen por sí solos un diagnóstico ni una decisión definitiva.",
      "",
      "SGA - Información confidencial para el destinatario autorizado.",
    ].join("\n");

    // 14. Enviar el correo antes de modificar el historial semanal.
    transport = createTransport({
      host: "smtp.gmail.com",
      port: 465,
      secure: true,
      auth: {
        user: gmailUser,
        pass: gmailPassword,
      },
    });

    await transport.sendMail({
      from: `Seguimiento escolar SGA <${gmailUser}>`,
      to: destinatario,
      subject: `Seguimiento escolar: riesgo ${nivel.toLowerCase()}`,
      text: texto,
      html,
    });

    // 15. Reemplazar los registros de esta semana.
    // Los registros de semanas anteriores se conservan.
    const semana = semanaColombia();

    const { error: errorEliminar } = await admin
      .from("alertas_riesgo_email")
      .delete()
      .eq("estudiante_id", estudianteId)
      .gte("creado_at", `${semana.inicio}T00:00:00-05:00`)
      .lt("creado_at", `${semana.fin}T00:00:00-05:00`);

    if (errorEliminar) {
      console.error(
        "El correo fue enviado, pero no se pudieron reemplazar los registros semanales:",
        errorEliminar.message,
      );

      return NextResponse.json({
        ok: true,
        mensaje:
          "El correo se envió, pero no fue posible actualizar el registro semanal de alertas. Revisa los logs del servidor.",
      });
    }

    const huella = createHash("sha256")
      .update(
        JSON.stringify({
          estudianteId,
          semana: semana.inicio,
          fechaEnvio: new Date().toISOString(),
          destinatario,
          nivel,
          factoresAlerta,
          probabilidadModelo,
          indiceModelo,
        }),
      )
      .digest("hex");

    const { error: errorRegistro } = await admin
      .from("alertas_riesgo_email")
      .insert({
        estudiante_id: estudianteId,
        huella,
        nivel,
        destinatario,
        estado: "enviado",
        enviado_at: new Date().toISOString(),
      });

    if (errorRegistro) {
      console.error(
        "El correo se envió, pero no se pudo guardar el registro:",
        errorRegistro.message,
      );

      return NextResponse.json({
        ok: true,
        mensaje:
          "El correo se envió correctamente, pero no se pudo guardar el registro de seguimiento.",
      });
    }

    return NextResponse.json({
      ok: true,
      mensaje: `La alerta se envió correctamente a ${destinatario}.`,
      modelo: {
        probabilidad: probabilidadModelo,
        indice: indiceModelo,
      },
    });
  } catch (error) {
    console.error(
      "Error en el envío manual de alerta:",
      error instanceof Error ? error.message : error,
    );

    return NextResponse.json(
      {
        error:
          "No fue posible enviar la alerta. Verifica la configuración de Gmail y los logs del servidor.",
      },
      { status: 500 },
    );
  } finally {
    transport?.close();
  }
}