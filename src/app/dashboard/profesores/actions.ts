"use server";

import { revalidatePath } from "next/cache";
import { z } from "zod";
import { createClient } from "@/lib/supabase/server";

const profesorSchema = z.object({
  nombre_completo: z.string().trim().min(2, "El nombre es obligatorio"),
  correo: z
    .string()
    .trim()
    .email("Correo inválido")
    .optional()
    .or(z.literal("")),
  telefono: z.string().trim().optional().or(z.literal("")),
});

export async function crearProfesor(input: unknown) {
  const parsed = profesorSchema.safeParse(input);
  if (!parsed.success) {
    return { error: parsed.error.issues[0].message };
  }

  const supabase = await createClient();
  const { error } = await supabase.from("profesores").insert({
    nombre_completo: parsed.data.nombre_completo,
    correo: parsed.data.correo || null,
    telefono: parsed.data.telefono || null,
  });
  if (error) return { error: traducirError(error.message) };

  revalidatePath("/dashboard/profesores");
  revalidatePath("/dashboard/horario");
  return {};
}

export async function actualizarProfesor(id: string, input: unknown) {
  const parsed = profesorSchema.safeParse(input);
  if (!parsed.success) {
    return { error: parsed.error.issues[0].message };
  }

  const supabase = await createClient();
  const { error } = await supabase
    .from("profesores")
    .update({
      nombre_completo: parsed.data.nombre_completo,
      correo: parsed.data.correo || null,
      telefono: parsed.data.telefono || null,
    })
    .eq("id", id);
  if (error) return { error: traducirError(error.message) };

  revalidatePath("/dashboard/profesores");
  revalidatePath("/dashboard/horario");
  return {};
}

export async function eliminarProfesor(id: string) {
  const supabase = await createClient();
  const { error } = await supabase.from("profesores").delete().eq("id", id);
  if (error) return { error: traducirError(error.message) };

  revalidatePath("/dashboard/profesores");
  revalidatePath("/dashboard/horario");
  return {};
}

function traducirError(message: string) {
  if (message.includes("duplicate key")) {
    return "Ya existe un profesor con ese correo.";
  }
  return message;
}
