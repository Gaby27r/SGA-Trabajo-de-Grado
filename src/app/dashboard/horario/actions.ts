"use server";

import { revalidatePath } from "next/cache";
import { z } from "zod";
import { createClient } from "@/lib/supabase/server";
import { DIAS_SEMANA } from "@/lib/types";

const bloqueSchema = z
  .object({
    curso_id: z.string().min(1, "Selecciona un curso"),
    dia: z.enum(DIAS_SEMANA),
    hora_inicio: z.string().min(1, "La hora de inicio es obligatoria"),
    hora_fin: z.string().min(1, "La hora de fin es obligatoria"),
    materia: z.string().trim().min(2, "La materia es obligatoria"),
    profesor_id: z.string().trim().optional().or(z.literal("")),
    es_descanso: z.boolean(),
  })
  .refine((data) => data.hora_fin > data.hora_inicio, {
    message: "La hora de fin debe ser posterior a la de inicio",
    path: ["hora_fin"],
  });

export async function crearBloque(input: unknown) {
  const parsed = bloqueSchema.safeParse(input);
  if (!parsed.success) {
    return { error: parsed.error.issues[0].message };
  }

  const supabase = await createClient();
  const { error } = await supabase.from("horario_clases").insert({
    curso_id: parsed.data.curso_id,
    dia: parsed.data.dia,
    hora_inicio: parsed.data.hora_inicio,
    hora_fin: parsed.data.hora_fin,
    materia: parsed.data.materia,
    profesor_id: parsed.data.profesor_id || null,
    es_descanso: parsed.data.es_descanso,
  });
  if (error) return { error: error.message };

  revalidatePath("/dashboard/horario");
  return {};
}

export async function actualizarBloque(id: string, input: unknown) {
  const parsed = bloqueSchema.safeParse(input);
  if (!parsed.success) {
    return { error: parsed.error.issues[0].message };
  }

  const supabase = await createClient();
  const { error } = await supabase
    .from("horario_clases")
    .update({
      curso_id: parsed.data.curso_id,
      dia: parsed.data.dia,
      hora_inicio: parsed.data.hora_inicio,
      hora_fin: parsed.data.hora_fin,
      materia: parsed.data.materia,
      profesor_id: parsed.data.profesor_id || null,
      es_descanso: parsed.data.es_descanso,
    })
    .eq("id", id);
  if (error) return { error: error.message };

  revalidatePath("/dashboard/horario");
  return {};
}

export async function eliminarBloque(id: string) {
  const supabase = await createClient();
  const { error } = await supabase.from("horario_clases").delete().eq("id", id);
  if (error) return { error: error.message };

  revalidatePath("/dashboard/horario");
  return {};
}
