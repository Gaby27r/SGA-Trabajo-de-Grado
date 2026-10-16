
import { requireRole } from "@/lib/auth";
import { createClient } from "@/lib/supabase/server";
import { ProfesorManager } from "./profesor-manager";

export default async function ProfesorPage() {
  const perfil = await requireRole(["profesor"]);
  const supabase = await createClient();

  if (!perfil.profesor_id) {
    return (
      <div className="rounded-sm border border-amber-200 bg-amber-50 p-5 text-amber-900">
        Tu usuario no tiene un profesor asociado. Solicita al coordinador
        que revise tu perfil.
      </div>
    );
  }

  // Consultar los cursos y materias asignados al profesor.
  const { data: horario, error: errorHorario } = await supabase
    .from("horario_clases")
    .select("id, curso_id, materia, profesor_id, cursos(nombre)")
    .eq("profesor_id", perfil.profesor_id)
    .eq("es_descanso", false);

  if (errorHorario) {
    throw new Error(
      `No se pudo consultar el horario: ${errorHorario.message}`
    );
  }

  const courseIds = [
    ...new Set(
      (horario ?? []).map((h) => h.curso_id).filter(Boolean)
    ),
  ];

  // Consultar estudiantes de los cursos asignados.
  const { data: estudiantesData, error: errorEstudiantes } =
    courseIds.length
      ? await supabase
          .from("estudiantes")
          .select("*, cursos(nombre)")
          .in("curso_id", courseIds)
          .order("nombre_completo")
      : { data: [], error: null };

  if (errorEstudiantes) {
    throw new Error(
      `No se pudieron consultar los estudiantes: ${errorEstudiantes.message}`
    );
  }

  const estudiantes = estudiantesData ?? [];
  const ids = estudiantes.map((e) => e.id);

  // Consultar las calificaciones directamente desde la base de datos.
  // No se utiliza la vista de promedios.
  const { data: notasData, error: errorNotas } = ids.length
    ? await supabase
        .from("calificaciones")
        .select("*")
        .in("estudiante_id", ids)
    : { data: [], error: null };

  if (errorNotas) {
    throw new Error(
      `No se pudieron consultar las calificaciones: ${errorNotas.message}`
    );
  }

  // Consultar asistencias de los estudiantes.
  const { data: asistenciasData, error: errorAsistencias } =
    ids.length
      ? await supabase
          .from("asistencias")
          .select("*")
          .in("estudiante_id", ids)
          .order("fecha", { ascending: false })
      : { data: [], error: null };

  if (errorAsistencias) {
    throw new Error(
      `No se pudo consultar la asistencia: ${errorAsistencias.message}`
    );
  }

  // Consultar los cursos para el formulario de estudiantes.
  const { data: cursosData, error: errorCursos } = courseIds.length
    ? await supabase
        .from("cursos")
        .select("id, nombre, jornada, created_at")
        .in("id", courseIds)
        .order("nombre")
    : { data: [], error: null };

  if (errorCursos) {
    throw new Error(
      `No se pudieron consultar los cursos: ${errorCursos.message}`
    );
  }

  // Crear una lista sin materias duplicadas por curso.
  const materias = [
    ...new Map(
      (horario ?? []).map((h) => [
        `${h.curso_id}|${h.materia}`,
        {
          curso_id: h.curso_id,
          materia: h.materia,
        },
      ])
    ).values(),
  ];

  return (
    <div className="flex flex-col gap-6">
      <div>
        <h1 className="font-display text-3xl text-ink">
          Mis estudiantes
        </h1>

        <p className="mt-1 text-ink-soft">
          Aquí aparecen los estudiantes de los cursos donde tienes clases.
          Selecciona uno para consultar o actualizar sus notas y asistencia.
        </p>
      </div>

      <ProfesorManager
        estudiantes={estudiantes}
        notas={notasData ?? []}
        asistencias={asistenciasData ?? []}
        cursos={cursosData ?? []}
        materias={materias}
      />
    </div>
  );
}
