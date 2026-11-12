import { requireRole } from "@/lib/auth";
import { createClient } from "@/lib/supabase/server";
import { EstudiantesManager } from "./estudiantes-manager";

export default async function EstudiantesPage() {
  // La sección de administración de estudiantes es exclusiva del coordinador.
  await requireRole(["coordinador"]);

  const supabase = await createClient();
  const [{ data: estudiantes }, { data: cursos }, { data: clases }, { data: asignaciones }] = await Promise.all([
    supabase.from("estudiantes").select("*, cursos(nombre)").order("nombre_completo"),
    supabase.from("cursos").select("*").order("nombre"),
    supabase.from("horario_clases").select("id,curso_id,dia,hora_inicio,hora_fin,materia,profesor_id,es_descanso").eq("es_descanso", false).order("dia").order("hora_inicio"),
    supabase.from("estudiante_clases").select("estudiante_id,horario_clase_id"),
  ]);
  const clasesPorEstudiante: Record<string, string[]> = {};
  for (const asignacion of asignaciones ?? []) {
    (clasesPorEstudiante[asignacion.estudiante_id] ??= []).push(asignacion.horario_clase_id);
  }

  return (
    <div className="flex flex-col gap-6">
      <div>
        <h1 className="font-display text-3xl text-ink">Estudiantes</h1>
        <p className="mt-1 text-ink-soft">
          La lista de matriculados, con su curso y datos de contacto del
          acudiente.
        </p>
      </div>
      <EstudiantesManager
        estudiantes={estudiantes ?? []}
        cursos={cursos ?? []}
        clases={clases ?? []}
        clasesPorEstudiante={clasesPorEstudiante}
      />
    </div>
  );
}
