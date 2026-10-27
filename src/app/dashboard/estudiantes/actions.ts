
"use server";

import { revalidatePath } from "next/cache";
import { createClient as createSupabaseAdmin } from "@supabase/supabase-js";
import { z } from "zod";
import { createClient } from "@/lib/supabase/server";
import { getPerfil } from "@/lib/auth";

const optionalText = z.string().trim().optional().or(z.literal(""));

const estudianteSchema = z.object({
  nombre_completo: z.string().trim().min(2, "El nombre es obligatorio"),
  curso_id: optionalText,
  clase_ids: z.array(z.string().uuid()).optional().default([]),
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

const crearEstudianteSchema = estudianteSchema.extend({
  correo: z.string().trim().email("Ingresa un correo electrónico válido"),
  contrasena: z
    .string()
    .min(8, "La contraseña debe tener al menos 8 caracteres"),
});

type DatosEstudiante = Omit<
  z.infer<typeof estudianteSchema>,
  "clase_ids"
>;

function clean(data: DatosEstudiante) {
  return {
    nombre_completo: data.nombre_completo,
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

function crearClienteAdmin() {
  const url = process.env.NEXT_PUBLIC_SUPABASE_URL;
  const serviceRoleKey = process.env.SUPABASE_SERVICE_ROLE_KEY;

  if (!url || !serviceRoleKey) {
    throw new Error(
      "Falta configurar SUPABASE_SERVICE_ROLE_KEY en el servidor."
    );
  }

  return createSupabaseAdmin(url, serviceRoleKey, {
    auth: {
      autoRefreshToken: false,
      persistSession: false,
    },
  });
}

async function esCoordinador() {
  const perfil = await getPerfil();
  return perfil?.rol === "coordinador";
}

async function guardarClasesEstudiante(
  admin: ReturnType<typeof crearClienteAdmin>,
  estudianteId: string,
  cursoId: string | null | undefined,
  claseIds: string[]
) {
  const ids = [...new Set(claseIds)];

  if (ids.length && !cursoId) {
    return "Selecciona un curso antes de asignar clases.";
  }

  if (ids.length) {
    const { data: clases, error: clasesError } = await admin
      .from("horario_clases")
      .select("id,curso_id,es_descanso")
      .in("id", ids);

    if (clasesError) return clasesError.message;

    if (
      !clases ||
      clases.length !== ids.length ||
      clases.some(
        (clase) =>
          clase.curso_id !== cursoId || clase.es_descanso
      )
    ) {
      return "Una o más clases no pertenecen al curso seleccionado o son descansos.";
    }
  }

  const { error: borrarError } = await admin
    .from("estudiante_clases")
    .delete()
    .eq("estudiante_id", estudianteId);

  if (borrarError) return borrarError.message;

  if (!ids.length) return null;

  const { error: insertarError } = await admin
    .from("estudiante_clases")
    .insert(
      ids.map((horario_clase_id) => ({
        estudiante_id: estudianteId,
        horario_clase_id,
      }))
    );

  return insertarError?.message ?? null;
}

function traducirError(message: string) {
  if (message.includes("duplicate key")) {
    return "Ya existe un estudiante con esos datos.";
  }

  return message;
}

function traducirErrorCuenta(message: string) {
  const normalizado = message.toLowerCase();

  if (
    normalizado.includes("already registered") ||
    normalizado.includes("already exists") ||
    normalizado.includes("user already")
  ) {
    return "Ya existe una cuenta con ese correo electrónico.";
  }

  return message;
}

export async function crearEstudiante(input: unknown) {
  // La creación de estudiantes y cuentas queda reservada al coordinador.
  if (!(await esCoordinador())) {
    return {
      error: "Solo un coordinador puede crear estudiantes y sus cuentas.",
    };
  }

  const parsed = crearEstudianteSchema.safeParse(input);

  if (!parsed.success) {
    return { error: parsed.error.issues[0].message };
  }

  let admin: ReturnType<typeof crearClienteAdmin>;

  try {
    admin = crearClienteAdmin();
  } catch {
    return {
      error:
        "Falta configurar SUPABASE_SERVICE_ROLE_KEY en las variables de entorno del servidor.",
    };
  }

  const supabase = await createClient();

  const { correo, contrasena, clase_ids, ...datosEstudiante } =
    parsed.data;

  const correoNormalizado = correo.trim().toLowerCase();

  // 1. Crear el registro académico del estudiante.
  const { data: estudiante, error: estudianteError } = await supabase
    .from("estudiantes")
    .insert(clean(datosEstudiante))
    .select("id,nombre_completo")
    .single();

  if (estudianteError || !estudiante) {
    return {
      error: traducirError(
        estudianteError?.message ?? "No se pudo crear el estudiante."
      ),
    };
  }

  // 2. Crear la cuenta de autenticación.
  const { data: authData, error: authError } =
    await admin.auth.admin.createUser({
      email: correoNormalizado,
      password: contrasena,
      email_confirm: true,
      user_metadata: {
        nombre_completo: estudiante.nombre_completo,
      },
    });

  if (authError || !authData.user) {
    await supabase.from("estudiantes").delete().eq("id", estudiante.id);

    return {
      error: authError
        ? traducirErrorCuenta(authError.message)
        : "Supabase no devolvió la cuenta creada. No se guardó el estudiante.",
    };
  }

  // 3. Vincular la cuenta al perfil de estudiante.
  const { error: perfilError } = await admin.from("perfiles").upsert(
    {
      id: authData.user.id,
      nombre_completo: estudiante.nombre_completo,
      correo: correoNormalizado,
      rol: "estudiante",
      profesor_id: null,
      estudiante_id: estudiante.id,
    },
    { onConflict: "id" }
  );

  if (perfilError) {
    await admin.auth.admin.deleteUser(authData.user.id);
    await supabase.from("estudiantes").delete().eq("id", estudiante.id);

    return {
      error:
        "Se creó la cuenta, pero no se pudo vincular al estudiante. La operación se revirtió. " +
        traducirError(perfilError.message),
    };
  }

  // 4. Eliminar la fila de administrador creada por el trigger histórico.
  const { error: limpiezaError } = await admin
    .from("administradores")
    .delete()
    .eq("id", authData.user.id);

  if (limpiezaError) {
    await admin.from("perfiles").delete().eq("id", authData.user.id);
    await admin.auth.admin.deleteUser(authData.user.id);
    await supabase.from("estudiantes").delete().eq("id", estudiante.id);

    return {
      error:
        "No se pudo finalizar la asignación segura del rol. La operación se revirtió.",
    };
  }

  // 5. Guardar las clases asignadas al estudiante.
  const clasesError = await guardarClasesEstudiante(
    admin,
    estudiante.id,
    datosEstudiante.curso_id,
    clase_ids ?? []
  );

  if (clasesError) {
    await admin.from("perfiles").delete().eq("id", authData.user.id);
    await admin.auth.admin.deleteUser(authData.user.id);
    await supabase.from("estudiantes").delete().eq("id", estudiante.id);

    return {
      error: `No se pudieron guardar las clases: ${clasesError}. No se creó el estudiante.`,
    };
  }

  revalidatePath("/dashboard/estudiantes");
  revalidatePath("/dashboard/profesor");
  revalidatePath("/dashboard/estudiante");
  revalidatePath("/dashboard");

  return {};
}

export async function actualizarEstudiante(
  id: string,
  input: unknown
) {
  if (!(await esCoordinador())) {
    return {
      error: "Solo un coordinador puede modificar estudiantes.",
    };
  }

  const parsed = estudianteSchema.safeParse(input);

  if (!parsed.success) {
    return { error: parsed.error.issues[0].message };
  }

  const { clase_ids, ...datosEstudiante } = parsed.data;
  const supabase = await createClient();

  const { error } = await supabase
    .from("estudiantes")
    .update(clean(datosEstudiante))
    .eq("id", id);

  if (error) {
    return { error: traducirError(error.message) };
  }

  let admin: ReturnType<typeof crearClienteAdmin>;

  try {
    admin = crearClienteAdmin();
  } catch {
    return {
      error:
        "Los datos se actualizaron, pero falta configurar SUPABASE_SERVICE_ROLE_KEY para guardar las clases.",
    };
  }

  const clasesError = await guardarClasesEstudiante(
    admin,
    id,
    datosEstudiante.curso_id,
    clase_ids ?? []
  );

  if (clasesError) {
    return {
      error: `Se actualizaron los datos, pero no las clases: ${clasesError}`,
    };
  }

  revalidatePath("/dashboard/estudiantes");
  revalidatePath("/dashboard/profesor");
  revalidatePath("/dashboard/estudiante");
  revalidatePath("/dashboard");

  return {};
}

export async function eliminarEstudiante(id: string) {
  if (!(await esCoordinador())) {
    return {
      error: "Solo un coordinador puede eliminar estudiantes.",
    };
  }

  const supabase = await createClient();

  const { error } = await supabase
    .from("estudiantes")
    .delete()
    .eq("id", id);

  if (error) {
    return { error: traducirError(error.message) };
  }

  revalidatePath("/dashboard/estudiantes");
  revalidatePath("/dashboard/profesor");
  revalidatePath("/dashboard/estudiante");
  revalidatePath("/dashboard");

  return {};
}
