"use server";

import { revalidatePath } from "next/cache";
import { z } from "zod";
import { createClient } from "@/lib/supabase/server";

const cursoSchema = z.object({
  nombre: z.string().trim().min(2, "El nombre es obligatorio"),
  jornada: z.string().trim().min(1, "La jornada es obligatoria"),
});

export async function crearCurso(input: unknown) {
  const parsed = cursoSchema.safeParse(input);
  if (!parsed.success) {
    return { error: parsed.error.issues[0].message };
  }

  const supabase = await createClient();
  const { error } = await supabase.from("cursos").insert(parsed.data);
  if (error) {
    return { error: traducirError(error.message) };
  }

  revalidatePath("/dashboard/cursos");
  revalidatePath("/dashboard");
  return {};
}

export async function actualizarCurso(id: string, input: unknown) {
  const parsed = cursoSchema.safeParse(input);
  if (!parsed.success) {
    return { error: parsed.error.issues[0].message };
  }

  const supabase = await createClient();
  const { error } = await supabase.from("cursos").update(parsed.data).eq("id", id);
  if (error) {
    return { error: traducirError(error.message) };
  }

  revalidatePath("/dashboard/cursos");
  revalidatePath("/dashboard");
  return {};
}

export async function eliminarCurso(id: string) {
  const supabase = await createClient();
  const { error } = await supabase.from("cursos").delete().eq("id", id);
  if (error) {
    return { error: traducirError(error.message) };
  }

  revalidatePath("/dashboard/cursos");
  revalidatePath("/dashboard");
  return {};
}

function traducirError(message: string) {
  if (message.includes("duplicate key")) {
    return "Ya existe un curso con ese nombre.";
  }
  return message;
}
