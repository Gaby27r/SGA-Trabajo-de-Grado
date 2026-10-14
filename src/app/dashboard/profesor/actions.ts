"use server";

import { revalidatePath } from "next/cache";
import { z } from "zod";
import { createClient } from "@/lib/supabase/server";

const gradeSchema = z.object({
  estudiante_id: z.string().uuid(),
  curso_id: z.string().uuid(),
  materia: z.string().trim().min(2),
  periodo: z.coerce.number().int().refine((v) => v === 1 || v === 2),
  nota: z.coerce.number().min(0).max(5),
});

export async function guardarCalificacion(input: unknown) {
  const parsed = gradeSchema.safeParse(input);
  if (!parsed.success) return { error: parsed.error.issues[0].message };
  const supabase = await createClient();
  const { data: perfil } = await supabase.from("perfiles").select("profesor_id,rol").eq("id",(await supabase.auth.getUser()).data.user?.id ?? "").maybeSingle();
  if (perfil?.rol !== "profesor" || !perfil.profesor_id) return { error: "Solo un profesor puede registrar notas." };

  const { error } = await supabase.from("calificaciones").upsert({
    estudiante_id: parsed.data.estudiante_id,
    curso_id: parsed.data.curso_id,
    profesor_id: perfil.profesor_id,
    materia: parsed.data.materia,
    periodo: parsed.data.periodo,
    nota: parsed.data.nota,
    updated_at: new Date().toISOString(),
  }, { onConflict: "estudiante_id,materia,periodo" });

  if (error) return { error: error.message };
  revalidatePath("/dashboard/profesor");
  revalidatePath("/dashboard/estudiante");
  return {};
}

const attendanceSchema = z.object({
  estudiante_id: z.string().uuid(),
  curso_id: z.string().uuid(),
  fecha: z.string().min(10),
  estado: z.enum(["Asistio","Falto","Justificacion","Retardo"]),
  observacion: z.string().trim().optional(),
});

export async function guardarAsistencia(input: unknown) {
  const parsed = attendanceSchema.safeParse(input);
  if (!parsed.success) return { error: parsed.error.issues[0].message };
  const supabase = await createClient();
  const { data: perfil } = await supabase.from("perfiles").select("profesor_id,rol").eq("id",(await supabase.auth.getUser()).data.user?.id ?? "").maybeSingle();
  if (perfil?.rol !== "profesor" || !perfil.profesor_id) return { error: "Solo un profesor puede registrar asistencia." };

  const { error } = await supabase.from("asistencias").upsert({
    estudiante_id: parsed.data.estudiante_id,
    curso_id: parsed.data.curso_id,
    profesor_id: perfil.profesor_id,
    fecha: parsed.data.fecha,
    estado: parsed.data.estado,
    observacion: parsed.data.observacion || null,
    updated_at: new Date().toISOString(),
  }, { onConflict: "estudiante_id,fecha" });

  if (error) return { error: error.message };
  revalidatePath("/dashboard/profesor");
  revalidatePath("/dashboard/estudiante");
  return {};
}

const anotacionSchema = z.object({
  estudiante_id: z.string().uuid(),
  curso_id: z.string().uuid(),
  tipo: z.enum(["grave", "leve"]),
  observacion: z
    .string()
    .trim()
    .min(3, "La observación debe tener al menos 3 caracteres."),
});

export async function guardarAnotacion(input: unknown) {
  const parsed = anotacionSchema.safeParse(input);

  if (!parsed.success) {
    return {
      error: parsed.error.issues[0].message,
    };
  }

  const supabase = await createClient();

  const {
    data: { user },
  } = await supabase.auth.getUser();

  if (!user) {
    return {
      error: "No hay una sesión activa.",
    };
  }

  const { data: perfil, error: perfilError } = await supabase
    .from("perfiles")
    .select("profesor_id,rol")
    .eq("id", user.id)
    .maybeSingle();

  if (
    perfilError ||
    perfil?.rol !== "profesor" ||
    !perfil.profesor_id
  ) {
    return {
      error: "Solo un profesor puede registrar anotaciones.",
    };
  }

  const { error } = await supabase
    .from("anotaciones")
    .insert({
      estudiante_id: parsed.data.estudiante_id,
      curso_id: parsed.data.curso_id,
      profesor_id: perfil.profesor_id,
      tipo: parsed.data.tipo,
      observacion: parsed.data.observacion,
      fecha: new Date().toISOString().slice(0, 10),
    });

  if (error) {
    return {
      error: error.message,
    };
  }

  revalidatePath("/dashboard/profesor");
  revalidatePath("/dashboard/estudiante");
  revalidatePath("/dashboard/seguimiento");

  return {};
}
