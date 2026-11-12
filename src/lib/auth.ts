import { redirect } from "next/navigation";
import { createClient } from "@/lib/supabase/server";
import type { Perfil, RolSGA } from "./types";

export async function getPerfil(): Promise<Perfil | null> {
  const supabase = await createClient();

  const {
    data: { user },
  } = await supabase.auth.getUser();

  if (!user) return null;

  const { data, error } = await supabase
    .from("perfiles")
    .select(
      "id,nombre_completo,correo,rol,profesor_id,estudiante_id",
    )
    .eq("id", user.id)
    .maybeSingle();

  if (error || !data) {
    return null;
  }

  return data as Perfil;
}

export async function requireRole(roles: RolSGA[]) {
  const perfil = await getPerfil();

  if (!perfil) {
    redirect("/login");
  }

  if (!roles.includes(perfil.rol)) {
    if (perfil.rol === "profesor") {
      redirect("/dashboard/profesor");
    }

    if (perfil.rol === "estudiante") {
      redirect("/dashboard/estudiante");
    }

    redirect("/dashboard");
  }

  return perfil;
}