
"use server";

import { revalidatePath } from "next/cache";
import { z } from "zod";
import { createClient } from "@/lib/supabase/server";

const gradeSchema = z.object({
  estudiante_id: z.string().uuid(),
  curso_id: z.string().uuid(),
  materia: z.string().trim().min(2, "La materia es obligatoria."),
  periodo: z.coerce
    .number()
    .int()
    .refine((value) => value === 1 || value === 2, {
      message: "El periodo debe ser 1 o 2.",
    }),
  nota: z.coerce
    .number()
    .min(0, "La nota mínima es 0.")
    .max(5, "La nota máxima es 5."),
});

async function obtenerPerfilProfesor() {
  const supabase = await createClient();

  const {
    data: { user },
    error: authError,
  } = await supabase.auth.getUser();

  if (authError || !user) {
    return {
      supabase,
      profesorId: null,
      error: "No hay una sesión activa.",
    };
  }

  const { data: perfil, error: perfilError } = await supabase
    .from("perfiles")
    .select("profesor_id,rol")
    .eq("id", user.id)
    .maybeSingle();

  if (perfilError) {
    return {
      supabase,
      profesorId: null,
      error: "No fue posible verificar el perfil del usuario.",
    };
  }

  if (perfil?.rol !== "profesor" || !perfil.profesor_id) {
    return {
      supabase,
      profesorId: null,
      error: "Solo un profesor puede realizar esta operación.",
    };
  }

  return {
    supabase,
    profesorId: perfil.profesor_id,
    error: null,
  };
}

export async function guardarCalificacion(input: unknown) {
  const parsed = gradeSchema.safeParse(input);

  if (!parsed.success) {
    return { error: parsed.error.issues[0].message };
  }

  const {
    supabase,
    profesorId,
    error: perfilError,
  } = await obtenerPerfilProfesor();

  if (perfilError || !profesorId) {
    return {
      error: perfilError ?? "No se pudo identificar al profesor.",
    };
  }

  const { error } = await supabase.from("calificaciones").upsert(
    {
      estudiante_id: parsed.data.estudiante_id,
      curso_id: parsed.data.curso_id,
      profesor_id: profesorId,
      materia: parsed.data.materia,
      periodo: parsed.data.periodo,
      nota: parsed.data.nota,
      updated_at: new Date().toISOString(),
    },
    {
      onConflict: "estudiante_id,materia,periodo",
    }
  );

  if (error) {
    console.error("[guardarCalificacion]", error);
    return { error: error.message };
  }

  revalidatePath("/dashboard/profesor");
  revalidatePath("/dashboard/estudiante");

  return {};
}

const attendanceSchema = z.object({
  estudiante_id: z.string().uuid(),
  curso_id: z.string().uuid(),
  fecha: z
    .string()
    .regex(/^\d{4}-\d{2}-\d{2}$/, "La fecha no es válida.")
    .refine((value) => {
      const date = new Date(`${value}T00:00:00.000Z`);

      return (
        !Number.isNaN(date.getTime()) &&
        date.toISOString().slice(0, 10) === value
      );
    }, "La fecha no es válida."),
  estado: z.enum([
    "Asistio",
    "Falto",
    "Justificacion",
    "Retardo",
  ]),
  observacion: z.string().trim().optional(),
});

export async function guardarAsistencia(input: unknown) {
  const parsed = attendanceSchema.safeParse(input);

  if (!parsed.success) {
    return { error: parsed.error.issues[0].message };
  }

  const {
    supabase,
    profesorId,
    error: perfilError,
  } = await obtenerPerfilProfesor();

  if (perfilError || !profesorId) {
    return {
      error: perfilError ?? "No se pudo identificar al profesor.",
    };
  }

  // Verificar que el estudiante pertenece al curso seleccionado.
  const { data: estudiante, error: estudianteError } = await supabase
    .from("estudiantes")
    .select("id, curso_id")
    .eq("id", parsed.data.estudiante_id)
    .eq("curso_id", parsed.data.curso_id)
    .maybeSingle();

  if (estudianteError) {
    console.error(
      "[guardarAsistencia] Error verificando estudiante:",
      estudianteError
    );

    return {
      error: `No se pudo verificar el estudiante: ${estudianteError.message}`,
    };
  }

  if (!estudiante) {
    return {
      error: "El estudiante no pertenece al curso seleccionado.",
    };
  }

  const datos = {
    estudiante_id: parsed.data.estudiante_id,
    curso_id: parsed.data.curso_id,
    profesor_id: profesorId,
    fecha: parsed.data.fecha,
    estado: parsed.data.estado,
    observacion: parsed.data.observacion || null,
  };

  // Buscar si ya existe una asistencia para el estudiante en esa fecha.
  const { data: existente, error: consultaError } = await supabase
    .from("asistencias")
    .select("id")
    .eq("estudiante_id", parsed.data.estudiante_id)
    .eq("fecha", parsed.data.fecha)
    .maybeSingle();

  if (consultaError) {
    console.error(
      "[guardarAsistencia] Error consultando asistencia:",
      consultaError
    );

    return {
      error: `No se pudo consultar la asistencia existente: ${consultaError.message}`,
    };
  }

  // Actualizar el registro encontrado o crear uno nuevo.
  const resultado = existente
    ? await supabase
        .from("asistencias")
        .update(datos)
        .eq("id", existente.id)
        .select("id")
        .maybeSingle()
    : await supabase
        .from("asistencias")
        .insert(datos)
        .select("id")
        .maybeSingle();

  if (resultado.error) {
    console.error(
      "[guardarAsistencia] Error guardando asistencia:",
      resultado.error
    );

    return {
      error: `No se pudo guardar la asistencia: ${resultado.error.message}`,
    };
  }

  if (!resultado.data) {
    return {
      error:
        "No se confirmó el guardado de la asistencia. Revisa los permisos de Supabase.",
    };
  }

  console.log("[guardarAsistencia] Registro guardado:", {
    id: resultado.data.id,
    estudiante_id: parsed.data.estudiante_id,
    fecha: parsed.data.fecha,
    estado: parsed.data.estado,
  });

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
    return { error: parsed.error.issues[0].message };
  }

  const {
    supabase,
    profesorId,
    error: perfilError,
  } = await obtenerPerfilProfesor();

  if (perfilError || !profesorId) {
    return {
      error: perfilError ?? "No se pudo identificar al profesor.",
    };
  }

  const { error } = await supabase.from("anotaciones").insert({
    estudiante_id: parsed.data.estudiante_id,
    curso_id: parsed.data.curso_id,
    profesor_id: profesorId,
    tipo: parsed.data.tipo,
    observacion: parsed.data.observacion,
    fecha: new Date().toISOString().slice(0, 10),
  });

  if (error) {
    console.error("[guardarAnotacion]", error);
    return { error: error.message };
  }

  revalidatePath("/dashboard/profesor");
  revalidatePath("/dashboard/estudiante");
  revalidatePath("/dashboard/seguimiento");

  return {};
}
