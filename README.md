# Sistema de Gestión Académica - Trabajo de Grado

Panel interno para administrar los cursos de un colegio: **login**, **CRUD**
de cursos, estudiantes y profesores, y el **horario semanal** de cada curso.
Es una versión reducida de un proyecto más grande: solo se conservó la
autenticación, el CRUD y el manejo de base de datos (sin biometría, pagos,
materiales ni calificaciones).

Incluye datos de ejemplo para **4to A** y **8vo A** con las materias, los
profesores y los horarios reales que me compartiste. Puedes agregar más
cursos desde el panel cuando quieras.

## Stack

* Next.js 16 (App Router) + TypeScript + Tailwind CSS 4
* Supabase (Postgres + Auth) vía `@supabase/ssr`
* Formularios controlados simples + `zod` para validar en las server actions

## 1\. Crear el proyecto de Supabase

1. Ve a [supabase.com](https://supabase.com), crea un proyecto nuevo (o usa
uno que ya tengas).
2. En **Project Settings → API** copia:

   * `Project URL` → `NEXT\\\_PUBLIC\\\_SUPABASE\\\_URL`
   * `anon public key` → `NEXT\\\_PUBLIC\\\_SUPABASE\\\_ANON\\\_KEY`
   * `service\\\_role key` → `SUPABASE\\\_SERVICE\\\_ROLE\\\_KEY` (solo se usa en un
script local, nunca se sube al navegador)

## 2\. Cargar la base de datos

En el **SQL Editor** de Supabase, ejecuta en este orden:

1. `supabase/schema.sql` — crea las tablas, el enum de días, el trigger que
crea el perfil de administrador automáticamente, y las políticas de RLS.
2. `supabase/seed.sql` — carga los cursos **4to A** y **8vo A**, los 11
profesores y su horario completo (incluye los bloques de descanso), más
4 estudiantes de ejemplo.

Puedes pegar cada archivo completo en el editor y darle "Run".

## 3\. Configurar el proyecto localmente

```bash
cd sga-colegio
npm install
cp .env.example .env.local
# edita .env.local con tus 3 valores de Supabase
```

## 4\. Crear tu usuario administrador

Como el registro público está desactivado a propósito (es un panel interno),
el primer administrador se crea con un script que usa la `service\\\_role key`:

```bash
NEXT\\\_PUBLIC\\\_SUPABASE\\\_URL=https://tu-proyecto.supabase.co \\\\
SUPABASE\\\_SERVICE\\\_ROLE\\\_KEY=tu-service-role-key \\\\
node scripts/crear-admin.mjs coordinador@colegio.edu.co "unaContraseñaSegura" "Nombre Apellido"
```

Esto crea el usuario ya confirmado en Supabase Auth; el registro en
`public.administradores` se crea solo por el trigger de la base de datos.
Puedes correr el script varias veces con distintos correos para crear más
administradores.

## 5\. Probarlo

```bash
npm run dev
```

Abre `http://localhost:3000`:

1. Te manda a `/login`. Entra con el correo/contraseña que creaste en el
paso 4.
2. **Inicio**: verás los conteos de cursos, estudiantes y profesores.
3. **Cursos**: crea, edita o elimina cursos (ej. agrega "5to A" cuando lo
necesites).
4. **Profesores**: CRUD del cuerpo docente.
5. **Estudiantes**: CRUD de estudiantes, con filtro por curso y asignación
de acudiente.
6. **Horario**: elige un curso arriba (4to A / 8vo A / los que agregues) y
verás la parrilla semanal tal como en tus imágenes, con el bloque de
Descanso resaltado. Pasa el mouse sobre una clase para editarla o
borrarla, o haz clic en un espacio vacío para agregar una nueva.
7. **Cerrar sesión** desde la barra lateral.

## Desplegarlo (opcional)

Funciona igual que cualquier app de Next.js: Vercel o Docker. Recuerda
configurar las mismas variables de entorno (`NEXT\\\_PUBLIC\\\_SUPABASE\\\_URL`,
`NEXT\\\_PUBLIC\\\_SUPABASE\\\_ANON\\\_KEY`) en la plataforma que uses.
`SUPABASE\\\_SERVICE\\\_ROLE\\\_KEY` no hace falta en producción, solo para el script
de creación de administradores.

## Estructura relevante

```
src/
  app/
    login/                    → formulario de acceso
    dashboard/
      layout.tsx               → sidebar + cierre de sesión
      page.tsx                  → resumen con conteos
      cursos/                    → CRUD de cursos
      profesores/                 → CRUD de profesores
      estudiantes/                  → CRUD de estudiantes
      horario/                       → parrilla semanal + CRUD de bloques
  components/ui/               → button, field, modal, badge, confirm-dialog
  lib/supabase/                 → clientes de Supabase (browser/server/middleware)
  lib/types.ts                   → tipos compartidos
  lib/curso-color.ts               → color rotativo por curso
supabase/
  schema.sql                    → tablas, enum, trigger, RLS
  seed.sql                       → 4to A y 8vo A con su horario real
scripts/
  crear-admin.mjs                 → crea el primer usuario administrador
```



## Alcance ampliado — roles y datos del Excel

Se conserva el stack original: **Next.js 16 + React + TypeScript + Tailwind CSS 4 + Supabase/PostgreSQL + Supabase Auth + Zod**.

### Roles

* **Coordinador:** administración global de cursos, profesores, estudiantes, horarios y seguimiento académico.
* **Profesor:** ve únicamente estudiantes de los cursos donde tiene clases; puede agregar/editar estudiantes, registrar notas de las materias que dicta y registrar asistencia, faltas, justificaciones y retardos.
* **Estudiante:** acceso de solo lectura a sus profesores, materias, horario, notas de los periodos 1 y 2, promedios y asistencia.

### Institución

Dirección institucional configurada: `Calle 19 #7-12 barrio Lincoln, Soacha`.

### Variables del documento y Excel

La tabla `estudiantes` incorpora los campos reales documentados: `matriculado`, `fecha\\\_nacimiento`, `edad\\\_actual`, `direccion`, `estrato`, `con\\\_quien\\\_vive`, `anio\\\_repetido`, `reuniones\\\_padres`, `acudiente`, `total\\\_anotaciones`, `graves`, `leves`.

Las notas se normalizan en `calificaciones` por estudiante + materia + periodo (1 o 2), y el registro diario del Excel se normaliza en `asistencias` con los estados `Asistio`, `Falto`, `Justificacion` y `Retardo`.

### Carga del Excel

1. Ejecuta `supabase/schema.sql`.
2. Ejecuta `supabase/import\\\_excel.sql`.
3. Crea las cuentas con `scripts/crear-usuario-rol.mjs`.
4. Para coordinador también puedes usar `scripts/crear-admin.mjs`.

Ejemplos:

```bash
node scripts/crear-usuario-rol.mjs profesor@colegio.edu.co "ClaveSegura" profesor "Alejandra León"
node scripts/crear-usuario-rol.mjs estudiante@colegio.edu.co "ClaveSegura" estudiante "DOCUMENTO"
```

El Excel no contiene documentos ni correos de estudiantes/profesores, por lo que **no se inventan esos datos** durante la importación. `documento` es opcional para los registros importados y puede completarse posteriormente desde el sistema.



