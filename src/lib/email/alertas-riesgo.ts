import "server-only";

import { createHash } from "node:crypto";
import { createTransport } from "nodemailer";
import { createClient as createSupabaseAdmin } from "@supabase/supabase-js";

type FactorAlerta = {
  titulo: string;
  detalle: string;
  nivel: "Alto" | "Medio" | "Informativo";
};

type ReporteAlerta = {
  id: string;
  nombre_completo: string;
  curso: string;
  promedioP1: number | null;
  promedioP2: number | null;
  faltas: number;
  retardos: number;
  maxConsecutivas: number;
  factores: FactorAlerta[];
  probabilidad: number | null;
  indice: number | null;
};

function crearAdmin() {
  const url = process.env.NEXT_PUBLIC_SUPABASE_URL;
  const key = process.env.SUPABASE_SERVICE_ROLE_KEY;

  if (!url || !key) return null;

  return createSupabaseAdmin(url, key, {
    auth: {
      autoRefreshToken: false,
      persistSession: false,
    },
  });
}

function formatoNumero(value: number | null, suffix = "") {
  return value == null || !Number.isFinite(value)
    ? "Sin datos"
    : `${value.toFixed(2)}${suffix}`;
}

function escaparHtml(value: unknown) {
  return String(value ?? "")
    .replace(/&/g, "&amp;")
    .replace(/</g, "&lt;")
    .replace(/>/g, "&gt;")
    .replace(/"/g, "&quot;")
    .replace(/'/g, "&#39;");
}

function crearHtml(
  reporte: ReporteAlerta,
  nivel: "Alto" | "Medio",
  factores: FactorAlerta[],
) {
  const alto = nivel === "Alto";
  const colorNivel = alto ? "#b42318" : "#a15c07";
  const fondoNivel = alto ? "#fff0ef" : "#fff6e5";

  const factoresHtml = factores
    .map((factor) => {
      const factorAlto = factor.nivel === "Alto";
      const color = factorAlto ? "#b42318" : "#a15c07";
      const fondo = factorAlto ? "#fff5f4" : "#fff9ee";
      const borde = factorAlto ? "#f3c6c3" : "#f0ddb7";

      return `
        <tr>
          <td style="padding:0 0 12px;">
            <table role="presentation" width="100%" cellpadding="0" cellspacing="0"
              style="border:1px solid ${borde};border-radius:10px;background:${fondo};">
              <tr>
                <td style="padding:14px 16px;font-family:Arial,sans-serif;">
                  <div style="font-size:11px;font-weight:700;letter-spacing:.6px;text-transform:uppercase;color:${color};margin-bottom:5px;">
                    ${escaparHtml(factor.nivel)}
                  </div>
                  <div style="font-size:15px;line-height:22px;font-weight:700;color:#253858;">
                    ${escaparHtml(factor.titulo)}
                  </div>
                  <div style="font-size:13px;line-height:20px;color:#526174;margin-top:5px;">
                    ${escaparHtml(factor.detalle)}
                  </div>
                </td>
              </tr>
            </table>
          </td>
        </tr>`;
    })
    .join("");

  // Cada fila contiene cuatro strings: etiqueta, valor, fondo y color.
  const metricas: [string, string, string, string][] = [
    [
      "Promedio periodo 1",
      formatoNumero(reporte.promedioP1),
      "#eaf2ff",
      "#2457a7",
    ],
    [
      "Promedio periodo 2",
      formatoNumero(reporte.promedioP2),
      "#eaf2ff",
      "#2457a7",
    ],
    [
      "Faltas registradas",
      String(reporte.faltas),
      "#fff6e5",
      "#945b08",
    ],
    [
      "Retardos registrados",
      String(reporte.retardos),
      "#fff6e5",
      "#945b08",
    ],
    [
      "Máximo de faltas consecutivas",
      String(reporte.maxConsecutivas),
      "#f1f5f9",
      "#334155",
    ],
    [
      "Probabilidad estimada por el modelo",
      formatoNumero(reporte.probabilidad, "%"),
      "#f1f5f9",
      "#334155",
    ],
    [
      "Índice de riesgo estimado",
      formatoNumero(reporte.indice, "%"),
      "#f1f5f9",
      "#334155",
    ],
  ];

  const metricasHtml = metricas
    .map(([etiqueta, valor, fondo, color]) => `
      <tr>
        <td style="padding:0 0 9px;">
          <table role="presentation" width="100%" cellpadding="0" cellspacing="0"
            style="background:${fondo};border-radius:9px;">
            <tr>
              <td style="padding:12px 14px;font-family:Arial,sans-serif;font-size:12px;line-height:17px;color:#536174;">
                ${escaparHtml(etiqueta)}
              </td>
              <td align="right" style="padding:12px 14px;font-family:Arial,sans-serif;font-size:16px;line-height:20px;font-weight:700;color:${color};">
                ${escaparHtml(valor)}
              </td>
            </tr>
          </table>
        </td>
      </tr>`)
    .join("");

  return `<!doctype html>
<html lang="es">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width,initial-scale=1">
</head>
<body style="margin:0;padding:0;background:#f3f6fb;">
  <table role="presentation" width="100%" cellpadding="0" cellspacing="0" style="background:#f3f6fb;padding:24px 10px;">
    <tr>
      <td align="center">
        <table role="presentation" width="600" cellpadding="0" cellspacing="0" style="width:100%;max-width:600px;background:#ffffff;border-radius:16px;overflow:hidden;">
          <tr>
            <td style="padding:26px 28px;background:#173b68;font-family:Arial,sans-serif;">
              <div style="font-size:11px;letter-spacing:1.4px;font-weight:700;color:#cfe0f8;text-transform:uppercase;">
                Sistema de Gestión Académica
              </div>
              <div style="font-size:25px;line-height:32px;font-weight:700;color:#ffffff;margin-top:8px;">
                Seguimiento escolar
              </div>
              <div style="font-size:13px;line-height:20px;color:#e2ecf8;margin-top:5px;">
                Alerta preventiva y acompañamiento estudiantil
              </div>
            </td>
          </tr>
          <tr>
            <td style="padding:26px 28px 8px;font-family:Arial,sans-serif;">
              <div style="font-size:11px;letter-spacing:1px;font-weight:700;color:#66758a;text-transform:uppercase;">
                Estudiante
              </div>
              <div style="font-size:22px;line-height:29px;font-weight:700;color:#172b4d;margin-top:6px;">
                ${escaparHtml(reporte.nombre_completo)}
              </div>
              <div style="font-size:14px;color:#64748b;margin-top:4px;">
                Curso: ${escaparHtml(reporte.curso)}
              </div>
            </td>
          </tr>
          <tr>
            <td style="padding:14px 28px 22px;">
              <table role="presentation" width="100%" cellpadding="0" cellspacing="0"
                style="background:${fondoNivel};border:1px solid ${alto ? "#f2c5c2" : "#f0d7a6"};border-radius:12px;">
                <tr>
                  <td style="padding:16px 18px;font-family:Arial,sans-serif;">
                    <div style="font-size:11px;letter-spacing:.8px;text-transform:uppercase;font-weight:700;color:${colorNivel};">
                      Nivel de alerta
                    </div>
                    <div style="font-size:22px;line-height:28px;font-weight:700;color:${colorNivel};margin-top:4px;">
                      Riesgo ${nivel.toLowerCase()}
                    </div>
                    <div style="font-size:13px;line-height:20px;color:#526174;margin-top:5px;">
                      Se identificaron factores que requieren seguimiento y acompañamiento oportuno.
                    </div>
                  </td>
                </tr>
              </table>
            </td>
          </tr>
          <tr>
            <td style="padding:0 28px 8px;font-family:Arial,sans-serif;font-size:17px;font-weight:700;color:#173b68;">
              Factores que requieren seguimiento
            </td>
          </tr>
          <tr>
            <td style="padding:10px 28px 14px;">
              <table role="presentation" width="100%" cellpadding="0" cellspacing="0">
                ${factoresHtml}
              </table>
            </td>
          </tr>
          <tr>
            <td style="padding:4px 28px 10px;font-family:Arial,sans-serif;font-size:17px;font-weight:700;color:#173b68;">
              Resumen académico y de asistencia
            </td>
          </tr>
          <tr>
            <td style="padding:10px 28px 22px;">
              <table role="presentation" width="100%" cellpadding="0" cellspacing="0">
                ${metricasHtml}
              </table>
            </td>
          </tr>
          <tr>
            <td style="padding:18px 28px;background:#f1f5f9;font-family:Arial,sans-serif;">
              <div style="font-size:13px;line-height:20px;color:#334155;">
                Este mensaje es una alerta preventiva para facilitar el acompañamiento escolar. No constituye por sí solo un diagnóstico ni una decisión definitiva.
              </div>
              <div style="font-size:12px;line-height:19px;color:#64748b;margin-top:8px;">
                Si considera que recibió este correo por error, comuníquese con la institución educativa.
              </div>
              <div style="font-size:11px;line-height:17px;color:#64748b;margin-top:14px;border-top:1px solid #dbe3ed;padding-top:12px;">
                SGA · Información confidencial para el destinatario autorizado.
              </div>
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
</body>
</html>`;
}

/**
 * Envía una alerta por estudiante y por semana.
 * cicloEnvio debe representar el lunes de la semana en hora Colombia.
 */
export async function enviarAlertasDeRiesgo(
  reportes: ReporteAlerta[],
  cicloEnvio: string,
) {
  const gmailUser = process.env.GMAIL_USER;
  const gmailPassword = process.env.GMAIL_APP_PASSWORD?.replace(/\s/g, "");
  const admin = crearAdmin();

  if (!gmailUser || !gmailPassword || !admin) {
    console.error(
      "Alertas SGA: configura GMAIL_USER, GMAIL_APP_PASSWORD y las variables de Supabase.",
    );
    return;
  }

  const pendientes = reportes
    .map((reporte) => ({
      ...reporte,
      factoresAlerta: reporte.factores.filter(
        (factor) => factor.nivel === "Alto" || factor.nivel === "Medio",
      ),
    }))
    .filter((reporte) => reporte.factoresAlerta.length > 0);

  if (pendientes.length === 0) return;

  const ids = pendientes.map((reporte) => reporte.id);

  const { data: perfiles, error: errorPerfiles } = await admin
    .from("perfiles")
    .select("estudiante_id,correo,nombre_completo")
    .in("estudiante_id", ids)
    .eq("rol", "estudiante");

  if (errorPerfiles) {
    console.error(
      "No fue posible consultar los correos de alertas SGA:",
      errorPerfiles.message,
    );
    return;
  }

  const correoPorEstudiante = new Map<string, string>(
    (perfiles ?? [])
      .filter((perfil) => Boolean(perfil.estudiante_id && perfil.correo))
      .map(
        (perfil) =>
          [perfil.estudiante_id as string, perfil.correo as string] as [
            string,
            string,
          ],
      ),
  );

  const transport = createTransport({
    host: "smtp.gmail.com",
    port: 465,
    secure: true,
    auth: {
      user: gmailUser,
      pass: gmailPassword,
    },
  });

  try {
    for (const reporte of pendientes) {
      const destinatario = correoPorEstudiante.get(reporte.id);

      if (!destinatario) {
        console.warn(
          `No se encontró correo de estudiante para la alerta ${reporte.id}.`,
        );
        continue;
      }

      const nivel: "Alto" | "Medio" = reporte.factoresAlerta.some(
        (factor) => factor.nivel === "Alto",
      )
        ? "Alto"
        : "Medio";

      const huella = createHash("sha256")
        .update(
          JSON.stringify({
            cicloEnvio,
            nivel,
            destinatario,
            curso: reporte.curso,
            promedioP1: reporte.promedioP1,
            promedioP2: reporte.promedioP2,
            faltas: reporte.faltas,
            retardos: reporte.retardos,
            maxConsecutivas: reporte.maxConsecutivas,
            factores: reporte.factoresAlerta,
            probabilidad: reporte.probabilidad,
            indice: reporte.indice,
          }),
        )
        .digest("hex");

      const { error: errorRegistro } = await admin
        .from("alertas_riesgo_email")
        .insert({
          estudiante_id: reporte.id,
          huella,
          nivel,
          destinatario,
          estado: "pendiente",
        });

      // La restricción única impide duplicar la misma alerta semanal.
      if (errorRegistro) {
        if (errorRegistro.code !== "23505") {
          console.error(
            "No se pudo registrar la alerta SGA:",
            errorRegistro.message,
          );
        }
        continue;
      }

      const detalles = reporte.factoresAlerta
        .map(
          (factor) =>
            `- [${factor.nivel}] ${factor.titulo}: ${factor.detalle}`,
        )
        .join("\n");

      const texto = [
        "ALERTA DE SEGUIMIENTO ESCOLAR",
        "",
        `Estudiante: ${reporte.nombre_completo}`,
        `Curso: ${reporte.curso}`,
        `Nivel de alerta: ${nivel.toUpperCase()}`,
        "",
        "Factores que requieren seguimiento:",
        detalles,
        "",
        "Resumen académico y de asistencia:",
        `Promedio periodo 1: ${formatoNumero(reporte.promedioP1)}`,
        `Promedio periodo 2: ${formatoNumero(reporte.promedioP2)}`,
        `Faltas registradas: ${reporte.faltas}`,
        `Retardos registrados: ${reporte.retardos}`,
        `Máximo de faltas consecutivas: ${reporte.maxConsecutivas}`,
        `Probabilidad estimada por el modelo: ${formatoNumero(reporte.probabilidad, "%")}`,
        `Índice de riesgo estimado: ${formatoNumero(reporte.indice, "%")}`,
        "",
        "Este mensaje es una alerta preventiva para facilitar el acompañamiento escolar. No constituye por sí por sí un diagnóstico ni una decisión definitiva.",
        "Si considera que recibió este correo por error, comuníquese con la institución educativa.",
      ].join("\n");

      try {
        await transport.sendMail({
          from: `Seguimiento escolar SGA <${gmailUser}>`,
          to: destinatario,
          subject: `Seguimiento escolar semanal: riesgo ${nivel.toLowerCase()}`,
          text: texto,
          html: crearHtml(reporte, nivel, reporte.factoresAlerta),
        });

        const { error: errorActualizacion } = await admin
          .from("alertas_riesgo_email")
          .update({
            estado: "enviado",
            enviado_at: new Date().toISOString(),
          })
          .eq("estudiante_id", reporte.id)
          .eq("huella", huella);

        if (errorActualizacion) {
          console.error(
            `El correo se envió, pero no se pudo actualizar el registro del estudiante ${reporte.id}:`,
            errorActualizacion.message,
          );
        }
      } catch (error) {
        console.error(
          `No se pudo enviar la alerta escolar para el estudiante ${reporte.id}:`,
          error instanceof Error ? error.message : error,
        );

        // Si SMTP falla, se elimina el registro pendiente para permitir reintento.
        const { error: errorEliminacion } = await admin
          .from("alertas_riesgo_email")
          .delete()
          .eq("estudiante_id", reporte.id)
          .eq("huella", huella);

        if (errorEliminacion) {
          console.error(
            "No se pudo limpiar el registro pendiente de alerta:",
            errorEliminacion.message,
          );
        }
      }
    }
  } finally {
    transport.close();
  }
}