import { redirect } from "next/navigation";
import { requireRole } from "@/lib/auth";
import Link from "next/link";
import { createClient } from "@/lib/supabase/server";
import { cursoColor } from "@/lib/curso-color";
import { Badge } from "@/components/ui/badge";

export default async function DashboardHome() {
  const perfil = await requireRole(["coordinador"]);
  if (perfil.rol !== "coordinador") redirect(`/dashboard/${perfil.rol}`);

  const supabase = await createClient();
  const [{ count: totalCursos }, { count: totalEstudiantes }, { count: totalProfesores }, { data: cursos }] =
    await Promise.all([
      supabase.from("cursos").select("*", { count: "exact", head: true }),
      supabase.from("estudiantes").select("*", { count: "exact", head: true }),
      supabase.from("profesores").select("*", { count: "exact", head: true }),
      supabase.from("cursos").select("id, nombre").order("nombre"),
    ]);

  const conteosPorCurso = await Promise.all(
    (cursos ?? []).map(async (curso) => {
      const { count } = await supabase.from("estudiantes").select("*", { count: "exact", head: true }).eq("curso_id", curso.id);
      return { ...curso, total: count ?? 0 };
    }),
  );

  const stats = [
    { label: "Cursos activos", value: totalCursos ?? 0, href: "/dashboard/cursos" },
    { label: "Estudiantes matriculados", value: totalEstudiantes ?? 0, href: "/dashboard/estudiantes" },
    { label: "Profesores", value: totalProfesores ?? 0, href: "/dashboard/profesores" },
  ];

  return (
    <div className="flex flex-col gap-10">
      <div>
        <h1 className="font-display text-3xl text-ink">Panel del coordinador</h1>
        <p className="mt-1 text-ink-soft">Administración general de cursos, profesores, estudiantes, notas, asistencia y horarios.</p>
      </div>
      <div className="grid gap-4 sm:grid-cols-3">
        {stats.map((stat) => (
          <Link key={stat.label} href={stat.href} className="rounded-sm border border-rule-strong bg-paper-raised px-5 py-4 hover:border-accent">
            <p className="font-display text-4xl text-ink">{stat.value}</p>
            <p className="mt-1 text-sm text-ink-soft">{stat.label}</p>
          </Link>
        ))}
      </div>
      <div>
        <h2 className="font-display text-xl text-ink">Cursos</h2>
        <div className="mt-4 grid gap-3 sm:grid-cols-2">
          {conteosPorCurso.map((curso, i) => (
            <Link key={curso.id} href={`/dashboard/horario?curso=${curso.id}`} className="flex items-center justify-between rounded-sm border border-rule-strong bg-paper-raised px-5 py-4 hover:border-accent">
              <div>
                <Badge bg={cursoColor(i).bg} fg={cursoColor(i).fg}>{curso.nombre}</Badge>
                <p className="mt-2 text-sm text-ink-soft">{curso.total} estudiantes</p>
              </div>
            </Link>
          ))}
        </div>
      </div>
    </div>
  );
}
