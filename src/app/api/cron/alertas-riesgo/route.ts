import { NextRequest, NextResponse } from "next/server";
import { createClient as createSupabaseAdmin } from "@supabase/supabase-js";
import { enviarAlertasDeRiesgo } from "@/lib/email/alertas-riesgo";
import { encontrar_riesgo } from "@/lib/riesgo/proceso";
import type { datos_crudos } from "@/app/Interfaces";

export const runtime = "nodejs";
export const dynamic = "force-dynamic";

const TZ = "America/Bogota";

type Factor = {
  titulo: string;
  detalle: string;
  nivel: "Alto" | "Medio" | "Informativo";
};

type StudentRow = {
  id: string;
  nombre_completo: string | null;
  estrato: number | null;
  anio_repetido: string | number | boolean | null;
  total_anotaciones: number | null;
  graves: number | null;
  leves: number | null;
  cursos: { nombre: string } | { nombre: string }[] | null;
};

type GradeRow = {
  estudiante_id: string;
  periodo: number | null;
  nota: number | null;
};

type AttendanceRow = {
  estudiante_id: string;
  fecha: string;
  estado: string | null;
};

function normalizar(valor: unknown): string {
  return String(valor ?? "")
    .trim()
    .toLocaleLowerCase("es")
    .normalize("NFD")
    .replace(/[\u0300-\u036f]/g, "");
}

function promedio(values: number[]): number | null {
  const valid = values.filter(Number.isFinite);

  return valid.length
    ? valid.reduce((a, b) => a + b, 0) / valid.length
    : null;
}

function maxConsecutivas(fechas: string[]): number {
  const sorted = [...new Set(fechas)].sort();

  let max = 0;
  let run = 0;
  let previous: Date | null = null;

  for (const date of sorted) {
    const current = new Date(`${date}T00:00:00Z`);

    if (
      previous &&
      (current.getTime() - previous.getTime()) / 86400000 === 1
    ) {
      run++;
    } else {
      run = 1;
    }

    max = Math.max(max, run);
    previous = current;
  }

  return max;
}

function cursoNombre(cursos: StudentRow["cursos"]): string {
  return Array.isArray(cursos)
    ? cursos[0]?.nombre ?? "Sin curso"
    : cursos?.nombre ?? "Sin curso";
}

function haRepetido(value: StudentRow["anio_repetido"]): boolean {
  if (typeof value === "number") return value === 1;
  if (typeof value === "boolean") return value;

  return [
    "si",
    "1",
    "true",
    "repitente",
    "repetido",
    "repetida",
  ].includes(normalizar(value));
}

function factores(
  student: StudentRow,
  p1: number | null,
  p2: number | null,
  faltas: number,
  retardos: number,
  consecutive: number,
): Factor[] {
  const result: Factor[] = [];

  if (p1 !== null && p1 < 3) {
    result.push({
      titulo: "Promedio bajo en el periodo 1",
      detalle: `Promedio registrado: ${p1.toFixed(2)}.`,
      nivel: "Alto",
    });
  }

  if (p2 !== null && p2 < 3) {
    result.push({
      titulo: "Promedio bajo en el periodo 2",
      detalle: `Promedio registrado: ${p2.toFixed(2)}.`,
      nivel: "Alto",
    });
  }

  if (faltas >= 5) {
    result.push({
      titulo: "Inasistencias frecuentes",
      detalle: `Se registran ${faltas} faltas.`,
      nivel: faltas >= 10 ? "Alto" : "Medio",
    });
  }

  if (consecutive >= 2) {
    result.push({
      titulo: "Ausencias consecutivas",
      detalle: `Se registran hasta ${consecutive} faltas consecutivas por fecha.`,
      nivel: consecutive >= 4 ? "Alto" : "Medio",
    });
  }

  if (retardos >= 5) {
    result.push({
      titulo: "Retardos frecuentes",
      detalle: `Se registran ${retardos} retardos.`,
      nivel: retardos >= 10 ? "Alto" : "Medio",
    });
  }

  const graves = Math.max(0, student.graves ?? 0);
  const leves = Math.max(0, student.leves ?? 0);
  const total = student.total_anotaciones ?? 0;

  if (graves > 0) {
    result.push({
      titulo: "Anotaciones graves",
      detalle: `Se registran ${graves} anotaciones graves.`,
      nivel: "Alto",
    });
  }

  if (leves > 0) {
    result.push({
      titulo: "Anotaciones leves",
      detalle: `Se registran ${leves} anotaciones leves.`,
      nivel: leves >= 5 ? "Alto" : leves >= 3 ? "Medio" : "Informativo",
    });
  }

  if (total > 0 && graves === 0 && leves === 0) {
    result.push({
      titulo: "Anotaciones registradas",
      detalle: `Total de anotaciones: ${total}.`,
      nivel: "Informativo",
    });
  }

  if (haRepetido(student.anio_repetido)) {
    result.push({
      titulo: "Año escolar repetido",
      detalle: "El registro indica que el estudiante ha repetido un año.",
      nivel: "Medio",
    });
  }

  if (student.estrato != null) {
    result.push({
      titulo: "Información socioeconómica registrada",
      detalle: `Estrato registrado: ${student.estrato}. Este dato por sí solo no determina el riesgo.`,
      nivel: "Informativo",
    });
  }

  return result;
}

function porcentaje(value: unknown): number | null {
  if (typeof value !== "number" || !Number.isFinite(value)) {
    return null;
  }

  return Math.min(100, Math.max(0, value * 100));
}

function semanaColombia(): string {
  const parts = new Intl.DateTimeFormat("en-CA", {
    timeZone: TZ,
    year: "numeric",
    month: "2-digit",
    day: "2-digit",
  }).formatToParts(new Date());

  const part = (type: string) =>
    parts.find((p) => p.type === type)?.value ?? "";

  const date = new Date(
    `${part("year")}-${part("month")}-${part("day")}T00:00:00Z`,
  );

  const daysSinceMonday = (date.getUTCDay() + 6) % 7;

  date.setUTCDate(date.getUTCDate() - daysSinceMonday);

  return date.toISOString().slice(0, 10);
}

export async function GET(request: NextRequest) {
  const secret = process.env.CRON_SECRET;

  if (!secret) {
    console.error(
      "CRON_SECRET no está configurado; se bloquea la ejecución de alertas.",
    );

    return NextResponse.json(
      { error: "Configuración de cron incompleta" },
      { status: 500 },
    );
  }

  if (request.headers.get("authorization") !== `Bearer ${secret}`) {
    return NextResponse.json({ error: "No autorizado" }, { status: 401 });
  }

  const url = process.env.NEXT_PUBLIC_SUPABASE_URL;
  const serviceKey = process.env.SUPABASE_SERVICE_ROLE_KEY;

  if (!url || !serviceKey) {
    return NextResponse.json(
      { error: "Configuración de Supabase incompleta" },
      { status: 500 },
    );
  }

  const admin = createSupabaseAdmin(url, serviceKey, {
    auth: {
      autoRefreshToken: false,
      persistSession: false,
    },
  });

  try {
    const { data: studentsData, error: studentsError } = await admin
      .from("estudiantes")
      .select(
        "id,nombre_completo,estrato,anio_repetido,total_anotaciones,graves,leves,cursos(nombre)",
      );

    if (studentsError) {
      throw new Error(
        `Consulta de estudiantes falló: ${studentsError.message}`,
      );
    }

    const students = (studentsData ?? []) as unknown as StudentRow[];

    if (!students.length) {
      return NextResponse.json({
        ok: true,
        enviados: 0,
        motivo: "Sin estudiantes",
      });
    }

    const ids = students.map((student) => student.id);

    const [
      { data: gradesData, error: gradesError },
      { data: attendanceData, error: attendanceError },
      { data: viewData, error: viewError },
    ] = await Promise.all([
      admin
        .from("calificaciones")
        .select("estudiante_id,periodo,nota")
        .in("estudiante_id", ids),

      admin
        .from("asistencias")
        .select("estudiante_id,fecha,estado")
        .in("estudiante_id", ids),

      admin.from("vista_reporte_estudiantes").select("*"),
    ]);

    if (gradesError) {
      throw new Error(
        `Consulta de calificaciones falló: ${gradesError.message}`,
      );
    }

    if (attendanceError) {
      throw new Error(
        `Consulta de asistencias falló: ${attendanceError.message}`,
      );
    }

    if (viewError) {
      throw new Error(
        `Consulta del modelo de riesgo falló: ${viewError.message}`,
      );
    }

    const grades = (gradesData ?? []) as GradeRow[];
    const attendance = (attendanceData ?? []) as AttendanceRow[];

    let riskByName = new Map<
      string,
      { probability: number | null; index: number | null }
    >();

    try {
      const modelRisks = await encontrar_riesgo(
        (viewData ?? []) as unknown as datos_crudos[],
      );

      riskByName = new Map(
        modelRisks.map((risk) => [
          normalizar(risk.nombre_estudiante),
          {
            probability: porcentaje(risk.probabilidad_de_desercion),
            index: porcentaje(risk.indice_de_riesgo),
          },
        ]),
      );
    } catch (error) {
      console.error(
        "No se pudo calcular el modelo de riesgo para el envío semanal:",
        error instanceof Error ? error.message : "error desconocido",
      );
    }

    const reports = students.map((student) => {
      const studentGrades = grades.filter(
        (grade) => grade.estudiante_id === student.id,
      );

      const p1 = promedio(
        studentGrades
          .filter((grade) => Number(grade.periodo) === 1)
          .map((grade) => Number(grade.nota))
          .filter(Number.isFinite),
      );

      const p2 = promedio(
        studentGrades
          .filter((grade) => Number(grade.periodo) === 2)
          .map((grade) => Number(grade.nota))
          .filter(Number.isFinite),
      );

      const studentAttendance = attendance.filter(
        (item) => item.estudiante_id === student.id,
      );

      const absences = studentAttendance
        .filter((item) =>
          ["falto", "falta"].includes(normalizar(item.estado)),
        )
        .map((item) => item.fecha)
        .sort();

      const late = studentAttendance.filter(
        (item) => normalizar(item.estado) === "retardo",
      ).length;

      const consecutive = maxConsecutivas(absences);
      const risk = riskByName.get(normalizar(student.nombre_completo));

      return {
        id: student.id,
        nombre_completo: student.nombre_completo ?? "Sin nombre",
        curso: cursoNombre(student.cursos),
        promedioP1: p1,
        promedioP2: p2,
        faltas: absences.length,
        retardos: late,
        maxConsecutivas: consecutive,
        factores: factores(
          student,
          p1,
          p2,
          absences.length,
          late,
          consecutive,
        ),
        probabilidad: risk?.probability ?? null,
        indice: risk?.index ?? null,
      };
    });

    const ciclo = semanaColombia();

    await enviarAlertasDeRiesgo(reports, ciclo);

    return NextResponse.json({
      ok: true,
      ciclo,
      estudiantesRevisados: reports.length,
      mensaje:
        "Proceso semanal ejecutado; los detalles de envío se registran en los logs del servidor.",
    });
  } catch (error) {
    console.error(
      "Falló el proceso semanal de alertas SGA:",
      error instanceof Error ? error.message : "error desconocido",
    );

    return NextResponse.json(
      { error: "No fue posible procesar las alertas semanales" },
      { status: 500 },
    );
  }
}