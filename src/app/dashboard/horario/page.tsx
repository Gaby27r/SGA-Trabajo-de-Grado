import { createClient } from "@/lib/supabase/server";
import { HorarioManager } from "./horario-manager";

export default async function HorarioPage({
  searchParams,
}: {
  searchParams: Promise<{ curso?: string }>;
}) {
  const { curso } = await searchParams;
  const supabase = await createClient();

  const [{ data: cursos }, { data: profesores }, { data: horario }] = await Promise.all([
    supabase.from("cursos").select("*").order("nombre"),
    supabase.from("profesores").select("*").order("nombre_completo"),
    supabase
      .from("horario_clases")
      .select("*, profesores(nombre_completo)")
      .order("hora_inicio"),
  ]);

  return (
    <div className="flex flex-col gap-6">
      <div>
        <h1 className="font-display text-3xl text-ink">Horario</h1>
        <p className="mt-1 text-ink-soft">
          La parrilla semanal de cada curso: materia y profesor por bloque.
        </p>
      </div>
      <HorarioManager
        cursos={cursos ?? []}
        profesores={profesores ?? []}
        horario={horario ?? []}
        cursoInicial={curso}
      />
    </div>
  );
}
