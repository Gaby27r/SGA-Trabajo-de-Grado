import { createClient } from "@/lib/supabase/server";
import { EstudiantesManager } from "./estudiantes-manager";

export default async function EstudiantesPage() {
  const supabase = await createClient();
  const [{ data: estudiantes }, { data: cursos }] = await Promise.all([
    supabase
      .from("estudiantes")
      .select("*, cursos(nombre)")
      .order("nombre_completo"),
    supabase.from("cursos").select("*").order("nombre"),
  ]);

  return (
    <div className="flex flex-col gap-6">
      <div>
        <h1 className="font-display text-3xl text-ink">Estudiantes</h1>
        <p className="mt-1 text-ink-soft">
          La lista de matriculados, con su curso y datos de contacto del
          acudiente.
        </p>
      </div>
      <EstudiantesManager estudiantes={estudiantes ?? []} cursos={cursos ?? []} />
    </div>
  );
}
