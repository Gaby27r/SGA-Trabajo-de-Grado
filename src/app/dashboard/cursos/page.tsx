import { createClient } from "@/lib/supabase/server";
import { CursosManager } from "./cursos-manager";

export default async function CursosPage() {
  const supabase = await createClient();
  const { data: cursos } = await supabase
    .from("cursos")
    .select("*")
    .order("nombre");

  return (
    <div className="flex flex-col gap-6">
      <div>
        <h1 className="font-display text-3xl text-ink">Cursos</h1>
        <p className="mt-1 text-ink-soft">
          Los grupos del colegio. Cada curso tiene su propio horario y lista
          de estudiantes.
        </p>
      </div>
      <CursosManager cursos={cursos ?? []} />
    </div>
  );
}
