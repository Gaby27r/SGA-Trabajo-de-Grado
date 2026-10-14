import { requireRole } from "@/lib/auth";
import { createClient } from "@/lib/supabase/server";
import { ProfesorManager } from "./profesor-manager";

export default async function ProfesorPage() {
  const perfil = await requireRole(["profesor"]);
  const supabase = await createClient();

  const { data: horario } = await supabase
    .from("horario_clases")
    .select("id,curso_id,materia,profesor_id,cursos(nombre)")
    .eq("profesor_id", perfil.profesor_id)
    .eq("es_descanso", false);

  const courseIds = [...new Set((horario ?? []).map((h) => h.curso_id))];
  const { data: estudiantes } = courseIds.length
    ? await supabase.from("estudiantes").select("*,cursos(nombre)").in("curso_id", courseIds).order("nombre_completo")
    : { data: [] };

  const ids = (estudiantes ?? []).map((e) => e.id);
  const { data: notas } = ids.length
    ? await supabase.from("calificaciones").select("*").in("estudiante_id", ids).eq("profesor_id", perfil.profesor_id)
    : { data: [] };
  const { data: asistencias } = ids.length
    ? await supabase.from("asistencias").select("*").in("estudiante_id", ids).order("fecha", { ascending: false })
    : { data: [] };

  const cursos = (courseIds.length
    ? await supabase.from("cursos").select("id,nombre").in("id", courseIds).order("nombre")
    : { data: [] }).data ?? [];

  const materias = [...new Map(
    (horario ?? []).map((h) => [`${h.curso_id}|${h.materia}`, { curso_id: h.curso_id, materia: h.materia }])
  ).values()];

  return (
    <div className="flex flex-col gap-6">
      <div>
        <h1 className="font-display text-3xl text-ink">Mis estudiantes</h1>
        <p className="mt-1 text-ink-soft">
          Aquí aparecen los estudiantes de los cursos donde tienes clases. Selecciona uno para consultar o actualizar sus notas y asistencia.
        </p>
      </div>
      <ProfesorManager
        estudiantes={estudiantes ?? []}
        notas={notas ?? []}
        asistencias={asistencias ?? []}
        cursos={cursos}
        materias={materias}
      />
    </div>
  );
}
