// Crea una cuenta de Supabase Auth y la vincula con el rol del SGA.
//
// Uso:
// node scripts/crear-usuario-rol.mjs correo password coordinador "Nombre"
// node scripts/crear-usuario-rol.mjs correo password profesor "Nombre del profesor"
// node scripts/crear-usuario-rol.mjs correo password estudiante "Codigo del estudiante"
//
// Ejemplo:
// node scripts/crear-usuario-rol.mjs "1A@colegio.edu.co" "1A123*" estudiante "E401"

import { createClient } from "@supabase/supabase-js";

const [, , email, password, rol, referencia] = process.argv;

const roles = ["coordinador", "profesor", "estudiante"];

if (!email || !password || !roles.includes(rol) || !referencia) {
  console.error(
    'Uso: node scripts/crear-usuario-rol.mjs correo password <coordinador|profesor|estudiante> "Nombre profesor | Codigo estudiante"',
  );
  process.exit(1);
}

const url = process.env.NEXT_PUBLIC_SUPABASE_URL;
const serviceRoleKey = process.env.SUPABASE_SERVICE_ROLE_KEY;

if (!url || !serviceRoleKey) {
  console.error(
    "Faltan NEXT_PUBLIC_SUPABASE_URL y SUPABASE_SERVICE_ROLE_KEY.",
  );
  process.exit(1);
}

const supabase = createClient(url, serviceRoleKey, {
  auth: {
    autoRefreshToken: false,
    persistSession: false,
  },
});

// ---------------------------------------------------------
// 1. Crear usuario en Supabase Auth
// ---------------------------------------------------------

const { data, error } = await supabase.auth.admin.createUser({
  email,
  password,
  email_confirm: true,
  user_metadata: {
    nombre_completo: referencia,
  },
});

if (error) {
  console.error("No se pudo crear el usuario:", error.message);
  process.exit(1);
}

const userId = data.user.id;

let profesor_id = null;
let estudiante_id = null;
let nombre = referencia;

// ---------------------------------------------------------
// 2. Si es profesor, buscar por nombre
// ---------------------------------------------------------

if (rol === "profesor") {
  const { data: profesor, error: profesorError } = await supabase
    .from("profesores")
    .select("id,nombre_completo")
    .eq("nombre_completo", referencia)
    .maybeSingle();

  if (profesorError || !profesor) {
    await supabase.auth.admin.deleteUser(userId);

    console.error(
      "No existe un profesor con ese nombre:",
      referencia,
    );

    process.exit(1);
  }

  profesor_id = profesor.id;
  nombre = profesor.nombre_completo;
}

// ---------------------------------------------------------
// 3. Si es estudiante, buscar por codigo
// ---------------------------------------------------------

if (rol === "estudiante") {
  const { data: estudiante, error: estudianteError } = await supabase
    .from("estudiantes")
    .select("id,nombre_completo")
    .eq("nombre_completo", referencia)
    .maybeSingle();

  if (estudianteError || !estudiante) {
    await supabase.auth.admin.deleteUser(userId);

    console.error(
      "No existe un estudiante con ese codigo:",
      referencia,
    );

    process.exit(1);
  }

  estudiante_id = estudiante.id;
  nombre = estudiante.nombre_completo;
}

// ---------------------------------------------------------
// 4. Crear / actualizar el perfil
// ---------------------------------------------------------

const { error: perfilError } = await supabase
  .from("perfiles")
  .upsert(
    {
      id: userId,
      nombre_completo: nombre,
      correo: email,
      rol,
      profesor_id,
      estudiante_id,
    },
    {
      onConflict: "id",
    },
  );

if (perfilError) {
  await supabase.auth.admin.deleteUser(userId);

  console.error(
    "Usuario creado, pero no se pudo crear el perfil:",
    perfilError.message,
  );

  process.exit(1);
}

// ---------------------------------------------------------
// 5. Verificación final
// ---------------------------------------------------------

const { data: perfilFinal, error: verificacionError } = await supabase
  .from("perfiles")
  .select(
    "id,nombre_completo,correo,rol,profesor_id,estudiante_id",
  )
  .eq("id", userId)
  .maybeSingle();

if (verificacionError || !perfilFinal) {
  console.error(
    "El usuario fue creado, pero no se pudo verificar el perfil.",
  );
  process.exit(1);
}

console.log("");
console.log("========================================");
console.log("USUARIO CREADO CORRECTAMENTE");
console.log("========================================");
console.log(`Correo:       ${email}`);
console.log(`Rol:          ${perfilFinal.rol}`);
console.log(`Perfil:       ${perfilFinal.nombre_completo}`);
console.log(`Usuario Auth: ${userId}`);

if (perfilFinal.estudiante_id) {
  console.log(`Estudiante ID: ${perfilFinal.estudiante_id}`);
}

if (perfilFinal.profesor_id) {
  console.log(`Profesor ID:   ${perfilFinal.profesor_id}`);
}

console.log("========================================");