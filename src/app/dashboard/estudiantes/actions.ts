"use server";

import { revalidatePath } from "next/cache";
import { z } from "zod";
import { createClient } from "@/lib/supabase/server";

const optionalText = z.string().trim().optional().or(z.literal(""));

const estudianteSchema = z.object({
  nombre_completo: z.string().trim().min(2, "El nombre es obligatorio"),
  documento: z.string().trim().optional().or(z.literal("")),
  curso_id: optionalText,
  acudiente: optionalText,
  telefono_acudiente: optionalText,
  fecha_nacimiento: optionalText,
  edad_actual: z.coerce.number().int().min(0).max(30).optional(),
  direccion: optionalText,
  estrato: z.coerce.number().int().min(1).max(6).optional(),
  con_quien_vive: optionalText,
  anio_repetido: optionalText,
  matriculado: optionalText,
  reuniones_padres: z.boolean().optional(),
  total_anotaciones: z.coerce.number().int().min(0).optional(),
  graves: z.coerce.number().int().min(0).optional(),
  leves: z.coerce.number().int().min(0).optional(),
});

function clean(data: z.infer<typeof estudianteSchema>) {
  return {
    nombre_completo: data.nombre_completo,
    documento: data.documento || null,
    curso_id: data.curso_id || null,
    acudiente: data.acudiente || null,
    telefono_acudiente: data.telefono_acudiente || null,
    fecha_nacimiento: data.fecha_nacimiento || null,
    edad_actual: data.edad_actual ?? null,
    direccion: data.direccion || null,
    estrato: data.estrato ?? null,
    con_quien_vive: data.con_quien_vive || null,
    anio_repetido: data.anio_repetido || null,
    matriculado: data.matriculado || null,
    reuniones_padres: data.reuniones_padres ?? null,
    total_anotaciones: data.total_anotaciones ?? 0,
    graves: data.graves ?? 0,
    leves: data.leves ?? 0,
  };
}

export async function crearEstudiante(input: unknown) {
  const parsed = estudianteSchema.safeParse(input);
  if (!parsed.success) return { error: parsed.error.issues[0].message };
  const supabase = await createClient();
  const { error } = await supabase.from("estudiantes").insert(clean(parsed.data));
  if (error) return { error: traducirError(error.message) };
  revalidatePath("/dashboard/estudiantes");
  revalidatePath("/dashboard/profesor");
  revalidatePath("/dashboard");
  return {};
}

export async function actualizarEstudiante(id: string, input: unknown) {
  const parsed = estudianteSchema.safeParse(input);
  if (!parsed.success) return { error: parsed.error.issues[0].message };
  const supabase = await createClient();
  const { error } = await supabase.from("estudiantes").update(clean(parsed.data)).eq("id", id);
  if (error) return { error: traducirError(error.message) };
  revalidatePath("/dashboard/estudiantes");
  revalidatePath("/dashboard/profesor");
  revalidatePath("/dashboard/estudiante");
  revalidatePath("/dashboard");
  return {};
}

export async function eliminarEstudiante(id: string) {
  const supabase = await createClient();
  const { error } = await supabase.from("estudiantes").delete().eq("id", id);
  if (error) return { error: traducirError(error.message) };
  revalidatePath("/dashboard/estudiantes");
  revalidatePath("/dashboard/profesor");
  revalidatePath("/dashboard");
  return {};
}

function traducirError(message: string) {
  if (message.includes("duplicate key")) return "Ya existe un estudiante con ese documento.";
  return message;
}
