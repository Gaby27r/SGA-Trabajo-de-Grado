
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

  // 1. Consultar cursos y materias asignados al profesor.
  const { data: horario, error: errorHorario } = await supabase
    .from("horario_clases")
    .select("id, curso_id, materia, profesor_id, cursos(nombre)")
    .eq("profesor_id", perfil.profesor_id)
    .eq("es_descanso", false);

  if (errorHorario) {
    console.error("[Mis estudiantes] Error consultando horario:", errorHorario);

    throw new Error(
      `No se pudo consultar el horario: ${errorHorario.message}`
    );
  }

  const courseIds = [
    ...new Set(
      (horario ?? []).map((h) => h.curso_id).filter(Boolean)
    ),
  ];

  console.log("[Mis estudiantes] Profesor ID:", perfil.profesor_id);
  console.log("[Mis estudiantes] Cursos asignados:", courseIds);

  // 2. Consultar estudiantes de los cursos asignados.
  const { data: estudiantesData, error: errorEstudiantes } =
    courseIds.length > 0
      ? await supabase
          .from("estudiantes")
          .select("*, cursos(nombre)")
          .in("curso_id", courseIds)
          .order("nombre_completo")
      : { data: [], error: null };

  if (errorEstudiantes) {
    console.error(
      "[Mis estudiantes] Error consultando estudiantes:",
      errorEstudiantes
    );

    throw new Error(
      `No se pudieron consultar los estudiantes: ${errorEstudiantes.message}`
    );
  }

  const estudiantes = estudiantesData ?? [];
  const ids = estudiantes.map((e) => e.id);

  console.log(
    "[Mis estudiantes] Total de estudiantes cargados:",
    estudiantes.length
  );

  // 3. Consultar calificaciones de los estudiantes.
  const { data: notasData, error: errorNotas } =
    ids.length > 0
      ? await supabase
          .from("calificaciones")
          .select("*")
          .in("estudiante_id", ids)
      : { data: [], error: null };

  if (errorNotas) {
    console.error("[Mis estudiantes] Error consultando notas:", errorNotas);

    throw new Error(
      `No se pudieron consultar las calificaciones: ${errorNotas.message}`
    );
  }

  // 4. Consultar asistencias por estudiante y paginar los resultados.
  // Esto evita depender de una única consulta limitada a 2000 filas.
  const asistenciasData: Record<string, unknown>[] = [];

  for (const estudianteId of ids) {
    let desde = 0;
    const tamanoPagina = 500;

    while (true) {
      const { data, error } = await supabase
        .from("asistencias")
        .select("*")
        .eq("estudiante_id", estudianteId)
        .order("fecha", { ascending: false })
        .range(desde, desde + tamanoPagina - 1);

      if (error) {
        console.error(
          "[Mis estudiantes] Error consultando asistencia:",
          estudianteId,
          error
        );

        throw new Error(
          `No se pudo consultar la asistencia: ${error.message}`
        );
      }

      const pagina = data ?? [];
      asistenciasData.push(...pagina);

      if (pagina.length < tamanoPagina) {
        break;
      }

      desde += tamanoPagina;
    }
  }

  console.log(
    "[Mis estudiantes] Total de asistencias recuperadas:",
    asistenciasData.length
  );

  // Depuración temporal: comprobar las asistencias de Victor.
  const estudiantePrueba = estudiantes.find(
    (e) =>
      e.nombre_completo?.toLowerCase().trim() ===
      "victor peñaranda florez"
  );

  if (estudiantePrueba) {
    console.log(
      "[Mis estudiantes] Estudiante de prueba:",
      estudiantePrueba.id
    );

    console.log(
      "[Mis estudiantes] Asistencias del estudiante de prueba:",
      asistenciasData.filter(
        (a) => a.estudiante_id === estudiantePrueba.id
      )
    );
  }

  // 5. Consultar cursos para el formulario de estudiantes.
  const { data: cursosData, error: errorCursos } =
    courseIds.length > 0
      ? await supabase
          .from("cursos")
          .select("id, nombre, jornada, created_at")
          .in("id", courseIds)
          .order("nombre")
      : { data: [], error: null };

  if (errorCursos) {
    console.error("[Mis estudiantes] Error consultando cursos:", errorCursos);

    throw new Error(
      `No se pudieron consultar los cursos: ${errorCursos.message}`
    );
  }

  // 6. Crear una lista de materias sin duplicados por curso.
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
        asistencias={asistenciasData as never[]}
        cursos={cursosData ?? []}
        materias={materias}
      />
    </div>
  );
}
