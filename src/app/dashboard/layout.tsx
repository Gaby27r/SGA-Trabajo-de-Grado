import { GraduationCap } from "lucide-react";
import { getPerfil } from "@/lib/auth";
import { Sidebar } from "@/components/sidebar";
import { LogoutButton } from "@/components/logout-button";

export default async function DashboardLayout({ children }: { children: React.ReactNode }) {
  const perfil = await getPerfil();
  const nombre = perfil?.nombre_completo ?? "Usuario";
  const rol = perfil?.rol ?? "coordinador";
  const rolTexto = rol === "coordinador" ? "Coordinador" : rol === "profesor" ? "Profesor" : "Estudiante";

  return (
    <div className="flex min-h-screen">
      <aside className="ruled hidden w-64 shrink-0 border-r border-rule-strong bg-paper-raised md:flex md:flex-col">
        <div className="flex items-center gap-2 border-b border-rule px-5 py-5">
          <GraduationCap className="h-5 w-5 text-accent" />
          <span className="font-display text-lg text-ink">Gestión Académica</span>
        </div>
        <div className="flex-1 overflow-y-auto py-3"><Sidebar role={rol} /></div>
        <div className="border-t border-rule px-3 py-3">
          <p className="truncate px-3 text-xs font-medium text-ink">{nombre}</p>
          <p className="px-3 text-[11px] text-ink-soft">{rolTexto}</p>
          <LogoutButton />
        </div>
      </aside>
      <div className="flex min-h-screen flex-1 flex-col">
        <header className="flex items-center justify-between border-b border-rule-strong bg-paper-raised px-5 py-3 md:hidden">
          <div className="flex items-center gap-2"><GraduationCap className="h-5 w-5 text-accent" /><span className="font-display text-lg text-ink">Gestión Académica</span></div>
          <LogoutButton />
        </header>
        <div className="md:hidden border-b border-rule-strong bg-paper-raised px-3 pb-2"><Sidebar role={rol} /></div>
        <main className="flex-1 px-5 py-8 md:px-10">{children}</main>
      </div>
    </div>
  );
}
