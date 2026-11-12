
import { requireRole } from "@/lib/auth";
import { createClient } from "@/lib/supabase/server";

function normalizarEstado(valor: string | null | undefined): string {
  return (valor ?? "")
    .trim()
    .toLocaleLowerCase("es")
    .normalize("NFD")
    .replace(/[\u0300-\u036f]/g, "");
}

function obtenerNombreCurso(
  cursos: { nombre: string } | { nombre: string }[] | null
): string {
  if (Array.isArray(cursos)) {
    return cursos[0]?.nombre ?? "Sin curso";
  }

  return cursos?.nombre ?? "Sin curso";
}

function calcularMaxConsecutivas(fechas: string[]): number {
  const fechasOrdenadas = [...new Set(fechas)].sort();

  let maximo = 0;
  let consecutivas = 0;
  let fechaAnterior: Date | null = null;

  for (const fecha of fechasOrdenadas) {
    const fechaActual = new Date(`${fecha}T00:00:00`);

    const esConsecutiva =
      fechaAnterior !== null &&
      Math.round(
        (fechaActual.getTime() - fechaAnterior.getTime()) /
          86400000
      ) === 1;

    consecutivas = esConsecutiva ? consecutivas + 1 : 1;
    maximo = Math.max(maximo, consecutivas);
    fechaAnterior = fechaActual;
  }

  return maximo;
}

export default async function SeguimientoPage() {
  await requireRole(["coordinador"]);

  const supabase = await createClient();

  const [
    { data: estudiantes, error: estudiantesError },
    { data: notas, error: notasError },
    { data: asistencias, error: asistenciasError },
    { data: cursos, error: cursosError },
    { data: profesores, error: profesoresError },
  ] = await Promise.all([
    supabase
      .from("estudiantes")
      .select(
        "id,nombre_completo,curso_id,cursos(nombre),total_anotaciones,graves,leves"
      ),

    supabase
      .from("calificaciones")
      .select("estudiante_id,periodo,nota"),

    supabase
      .from("asistencias")
      .select("estudiante_id,fecha,estado"),

    supabase
      .from("cursos")
      .select("id,nombre")
      .order("nombre"),

    supabase
      .from("profesores")
      .select("id,nombre_completo")
      .order("nombre_completo"),
  ]);

  const errores = [
    estudiantesError,
    notasError,
    asistenciasError,
    cursosError,
    profesoresError,
  ].filter(Boolean);

  if (errores.length > 0) {
    console.error("Error cargando seguimiento académico:", errores);

    return (
      <div className="flex flex-col gap-6">
        <h1 className="font-display text-3xl text-ink">
          Seguimiento académico
        </h1>

        <div className="rounded-sm border border-red-300 bg-red-50 px-5 py-4 text-red-800">
          No se pudo cargar el seguimiento académico. Revisa la
          consola del servidor para conocer el error de Supabase.
        </div>
      </div>
    );
  }

  return (
    <div className="flex flex-col gap-6">
      <div>
        <h1 className="font-display text-3xl text-ink">
          Seguimiento académico
        </h1>

        <p className="mt-1 text-ink-soft">
          Vista global del coordinador sobre estudiantes, cursos,
          profesores, notas y asistencia.
        </p>
      </div>

      <div className="grid gap-4 sm:grid-cols-3">
        <Metric label="Cursos" value={String(cursos?.length ?? 0)} />
        <Metric
          label="Profesores"
          value={String(profesores?.length ?? 0)}
        />
        <Metric
          label="Estudiantes"
          value={String(estudiantes?.length ?? 0)}
        />
      </div>

      <div className="overflow-x-auto rounded-sm border border-rule-strong bg-paper-raised">
        <table className="w-full text-left text-sm">
          <thead>
            <tr className="border-b border-rule text-ink-soft">
              <th className="px-4 py-3">Estudiante</th>
              <th className="px-4 py-3">Curso</th>
              <th className="px-4 py-3">Prom. P1</th>
              <th className="px-4 py-3">Prom. P2</th>
              <th className="px-4 py-3">Faltas</th>
              <th className="px-4 py-3">Máx. consecutivas</th>
              <th className="px-4 py-3">Retardos</th>
              <th className="px-4 py-3">Anotaciones</th>
            </tr>
          </thead>

          <tbody>
            {(estudiantes ?? []).map((estudiante) => {
              const notasEstudiante = (notas ?? []).filter(
                (nota) => nota.estudiante_id === estudiante.id
              );

              const promedioPeriodo = (periodo: number) => {
                const notasPeriodo = notasEstudiante
                  .filter((nota) => Number(nota.periodo) === periodo)
                  .map((nota) => Number(nota.nota))
                  .filter(Number.isFinite);

                if (notasPeriodo.length === 0) {
                  return "—";
                }

                const suma = notasPeriodo.reduce(
                  (total, nota) => total + nota,
                  0
                );

                return (suma / notasPeriodo.length).toFixed(2);
              };

              const asistenciasEstudiante = (asistencias ?? []).filter(
                (asistencia) =>
                  asistencia.estudiante_id === estudiante.id
              );

              const faltas = asistenciasEstudiante.filter(
                (asistencia) => {
                  const estado = normalizarEstado(asistencia.estado);
                  return estado === "falto" || estado === "falta";
                }
              );

              const maxConsecutivas = calcularMaxConsecutivas(
                faltas.map((falta) => falta.fecha)
              );

              const totalRetardos = asistenciasEstudiante.filter(
                (asistencia) =>
                  normalizarEstado(asistencia.estado) === "retardo"
              ).length;

              return (
                <tr
                  key={estudiante.id}
                  className="border-b border-rule"
                >
                  <td className="px-4 py-3">
                    {estudiante.nombre_completo ?? "Sin nombre"}
                  </td>

                  <td className="px-4 py-3">
                    {obtenerNombreCurso(estudiante.cursos)}
                  </td>

                  <td className="px-4 py-3">
                    {promedioPeriodo(1)}
                  </td>

                  <td className="px-4 py-3">
                    {promedioPeriodo(2)}
                  </td>

                  <td className="px-4 py-3">{faltas.length}</td>

                  <td className="px-4 py-3">{maxConsecutivas}</td>

                  <td className="px-4 py-3">{totalRetardos}</td>

                  <td className="px-4 py-3">
                    {estudiante.total_anotaciones ?? 0}{" "}
                    (G:{estudiante.graves ?? 0}{" "}
                    L:{estudiante.leves ?? 0})
                  </td>
                </tr>
              );
            })}
          </tbody>
        </table>
      </div>
    </div>
  );
}

function Metric({
  label,
  value,
}: {
  label: string;
  value: string;
}) {
  return (
    <div className="rounded-sm border border-rule-strong bg-paper-raised px-5 py-4">
      <p className="font-display text-3xl text-ink">{value}</p>
      <p className="text-sm text-ink-soft">{label}</p>
    </div>
  );
}
