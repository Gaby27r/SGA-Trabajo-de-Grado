// Crea (o resetea la contraseña de) un usuario administrador directamente
// en Supabase Auth, usando la Service Role Key. El perfil en
// `public.administradores` se crea solo, mediante el trigger de la base de
// datos, así que no hace falta ninguna otra acción manual.
//
// Uso:
//   NEXT_PUBLIC_SUPABASE_URL=... SUPABASE_SERVICE_ROLE_KEY=... \
//   node scripts/crear-admin.mjs correo@colegio.edu.co "contraseña123" "Nombre Apellido"

import { createClient } from "@supabase/supabase-js";

const [, , email, password, nombreCompleto] = process.argv;

if (!email || !password) {
  console.error(
    'Uso: node scripts/crear-admin.mjs correo@colegio.edu.co "contraseña" "Nombre Apellido"',
  );
  process.exit(1);
}

const url = process.env.NEXT_PUBLIC_SUPABASE_URL;
const serviceRoleKey = process.env.SUPABASE_SERVICE_ROLE_KEY;

if (!url || !serviceRoleKey) {
  console.error(
    "Faltan variables de entorno: NEXT_PUBLIC_SUPABASE_URL y SUPABASE_SERVICE_ROLE_KEY.",
  );
  process.exit(1);
}

const supabase = createClient(url, serviceRoleKey, {
  auth: { autoRefreshToken: false, persistSession: false },
});

const { data, error } = await supabase.auth.admin.createUser({
  email,
  password,
  email_confirm: true,
  user_metadata: { nombre_completo: nombreCompleto ?? email.split("@")[0] },
});

if (error) {
  console.error("No se pudo crear el usuario:", error.message);
  process.exit(1);
}

const { error: profileError } = await supabase.from("perfiles").upsert({
  id: data.user.id,
  nombre_completo: nombreCompleto ?? email.split("@")[0],
  correo: data.user.email,
  rol: "coordinador",
});
if (profileError) {
  console.error("Usuario creado, pero no se pudo crear el perfil de coordinador:", profileError.message);
  process.exit(1);
}
console.log(`Coordinador creado: ${data.user.email} (id: ${data.user.id})`);
