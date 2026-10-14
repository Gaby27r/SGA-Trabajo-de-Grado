import { requireRole } from "@/lib/auth";
import { createClient } from "@/lib/supabase/server";

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
        "id,nombre_completo,curso_id,cursos(nombre),estrato,matriculado,anio_repetido,total_anotaciones,graves,leves"
      ),

    supabase
      .from("calificaciones")
      .select(
        "estudiante_id,periodo,nota,materia,profesores(nombre_completo)"
      ),

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

  // Si alguna consulta falla, mostramos el error real
  // en lugar de presentar simplemente una tabla vacía.
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
        <div>
          <h1 className="font-display text-3xl text-ink">
            Seguimiento académico
          </h1>

          <p className="mt-1 text-ink-soft">
            Vista global del coordinador sobre estudiantes, cursos, profesores,
            notas y asistencia.
          </p>
        </div>

        <div className="rounded-sm border border-red-300 bg-red-50 px-5 py-4 text-red-800">
          <p className="font-semibold">
            No se pudo cargar el seguimiento académico.
          </p>

          <p className="mt-1 text-sm">
            Revisa la consola del servidor para ver el error de Supabase.
          </p>
        </div>
      </div>
    );
  }

  return (
    <div className="flex flex-col gap-6">
      {/* Encabezado */}
      <div>
        <h1 className="font-display text-3xl text-ink">
          Seguimiento académico
        </h1>

        <p className="mt-1 text-ink-soft">
          Vista global del coordinador sobre estudiantes, cursos, profesores,
          notas y asistencia.
        </p>
      </div>

      {/* Indicadores */}
      <div className="grid gap-4 sm:grid-cols-3">
        <Metric
          label="Cursos"
          value={String(cursos?.length ?? 0)}
        />

        <Metric
          label="Profesores"
          value={String(profesores?.length ?? 0)}
        />

        <Metric
          label="Estudiantes"
          value={String(estudiantes?.length ?? 0)}
        />
      </div>

      {/* Tabla */}
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
                const notasPeriodo = notasEstudiante.filter(
                  (nota) => nota.periodo === periodo
                );

                if (notasPeriodo.length === 0) {
                  return "—";
                }

                const suma = notasPeriodo.reduce(
                  (total, nota) => total + Number(nota.nota),
                  0
                );

                return (suma / notasPeriodo.length).toFixed(2);
              };

              const asistenciasEstudiante = (asistencias ?? []).filter(
                (asistencia) =>
                  asistencia.estudiante_id === estudiante.id
              );

              const faltas = asistenciasEstudiante
                .filter((asistencia) => asistencia.estado === "Falto")
                .sort((a, b) =>
                  a.fecha.localeCompare(b.fecha)
                );

              let maxConsecutivas = 0;
              let consecutivas = 0;
              let fechaAnterior = "";

              for (const falta of faltas) {
                const fechaActual = new Date(
                  `${falta.fecha}T00:00:00`
                );

                const fechaPrev = fechaAnterior
                  ? new Date(`${fechaAnterior}T00:00:00`)
                  : null;

                const esConsecutiva = fechaPrev
                  ? Math.round(
                      (fechaActual.getTime() -
                        fechaPrev.getTime()) /
                        86400000
                    ) === 1
                  : false;

                consecutivas = esConsecutiva
                  ? consecutivas + 1
                  : 1;

                maxConsecutivas = Math.max(
                  maxConsecutivas,
                  consecutivas
                );

                fechaAnterior = falta.fecha;
              }

              const totalFaltas = asistenciasEstudiante.filter(
                (asistencia) => asistencia.estado === "Falto"
              ).length;

              const totalRetardos = asistenciasEstudiante.filter(
                (asistencia) => asistencia.estado === "Retardo"
              ).length;

              return (
                <tr
                  key={estudiante.id}
                  className="border-b border-rule"
                >
                  <td className="px-4 py-3">
                    {estudiante.nombre_completo}
                  </td>

                  <td className="px-4 py-3">
                    {estudiante.cursos?.nombre ?? "—"}
                  </td>

                  <td className="px-4 py-3">
                    {promedioPeriodo(1)}
                  </td>

                  <td className="px-4 py-3">
                    {promedioPeriodo(2)}
                  </td>

                  <td className="px-4 py-3">
                    {totalFaltas}
                  </td>

                  <td className="px-4 py-3">
                    {maxConsecutivas}
                  </td>

                  <td className="px-4 py-3">
                    {totalRetardos}
                  </td>

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
      <p className="font-display text-3xl text-ink">
        {value}
      </p>

      <p className="text-sm text-ink-soft">
        {label}
      </p>
    </div>
  );
}