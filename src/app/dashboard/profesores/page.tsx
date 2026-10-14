import { createClient } from "@/lib/supabase/server";
import { ProfesoresManager } from "./profesores-manager";

export default async function ProfesoresPage() {
  const supabase = await createClient();
  const { data: profesores } = await supabase
    .from("profesores")
    .select("*")
    .order("nombre_completo");

  return (
    <div className="flex flex-col gap-6">
      <div>
        <h1 className="font-display text-3xl text-ink">Profesores</h1>
        <p className="mt-1 text-ink-soft">
          El cuerpo docente. Cada profesor se puede asignar a bloques del
          horario de cualquier curso.
        </p>
      </div>
      <ProfesoresManager profesores={profesores ?? []} />
    </div>
  );
}
