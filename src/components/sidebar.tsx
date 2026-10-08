"use client";

import Link from "next/link";
import { usePathname } from "next/navigation";
import { GraduationCap, LayoutGrid, Users, UserRound, CalendarDays, ClipboardCheck, BookOpen } from "lucide-react";

const NAV = [
  { href: "/dashboard", label: "Inicio", icon: LayoutGrid, roles: ["coordinador"] },
  { href: "/dashboard/cursos", label: "Cursos", icon: GraduationCap, roles: ["coordinador"] },
  { href: "/dashboard/estudiantes", label: "Estudiantes", icon: Users, roles: ["coordinador"] },
  { href: "/dashboard/profesores", label: "Profesores", icon: UserRound, roles: ["coordinador"] },
  { href: "/dashboard/horario", label: "Horario", icon: CalendarDays, roles: ["coordinador"] },
  { href: "/dashboard/seguimiento", label: "Seguimiento", icon: ClipboardCheck, roles: ["coordinador"] },
  { href: "/dashboard/profesor", label: "Mis estudiantes", icon: ClipboardCheck, roles: ["profesor"] },
  { href: "/dashboard/estudiante", label: "Mi información", icon: BookOpen, roles: ["estudiante"] },
];

export function Sidebar({ role = "coordinador" }: { role?: "coordinador" | "profesor" | "estudiante" }) {
  const pathname = usePathname();
  const nav = NAV.filter((item) => item.roles.includes(role));
  return (
    <nav className="flex flex-col gap-1 px-3 py-2">
      {nav.map(({ href, label, icon: Icon }) => {
        const active = href === "/dashboard" ? pathname === href : pathname.startsWith(href);
        return (
          <Link key={href} href={href} className={`flex items-center gap-3 rounded-sm border-l-2 px-3 py-2 text-sm transition-colors ${active ? "border-accent bg-accent/10 font-medium text-ink" : "border-transparent text-ink-soft hover:bg-rule/30 hover:text-ink"}`}>
            <Icon className="h-4 w-4" />{label}
          </Link>
        );
      })}
    </nav>
  );
}
