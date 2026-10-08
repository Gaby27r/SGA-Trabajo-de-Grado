-- ============================================================================
-- Esquema SGA Colegio — ampliado sin cambiar el stack: Next.js + TypeScript +
-- Supabase/PostgreSQL + Tailwind.
-- ============================================================================

create extension if not exists "pgcrypto";

create table if not exists public.cursos (
  id uuid primary key default gen_random_uuid(),
  nombre text not null unique,
  jornada text not null default 'Mañana',
  created_at timestamptz not null default now()
);

create table if not exists public.profesores (
  id uuid primary key default gen_random_uuid(),
  nombre_completo text not null,
  correo text unique,
  telefono text,
  created_at timestamptz not null default now(),
  unique(nombre_completo)
);

create table if not exists public.estudiantes (
  id uuid primary key default gen_random_uuid(),
  nombre_completo text not null,
  documento text unique,
  curso_id uuid references public.cursos(id) on delete set null,
  acudiente text,
  telefono_acudiente text,
  fecha_nacimiento date,
  edad_actual integer,
  direccion text,
  estrato integer check (estrato between 1 and 6),
  con_quien_vive text,
  anio_repetido text,
  matriculado text,
  reuniones_padres boolean,
  total_anotaciones integer not null default 0,
  graves integer not null default 0,
  leves integer not null default 0,
  created_at timestamptz not null default now(),
  unique(nombre_completo, curso_id)
);

do $$
begin
  if not exists (select 1 from pg_type where typname = 'dia_semana') then
    create type public.dia_semana as enum ('Lunes','Martes','Miércoles','Jueves','Viernes');
  end if;
end $$;

create table if not exists public.horario_clases (
  id uuid primary key default gen_random_uuid(),
  curso_id uuid not null references public.cursos(id) on delete cascade,
  dia public.dia_semana not null,
  hora_inicio time not null,
  hora_fin time not null,
  materia text not null,
  profesor_id uuid references public.profesores(id) on delete set null,
  es_descanso boolean not null default false,
  created_at timestamptz not null default now(),
  constraint horario_rango_valido check (hora_fin > hora_inicio)
);
create index if not exists horario_clases_curso_dia_idx
  on public.horario_clases (curso_id, dia, hora_inicio);

do $$
begin
  if not exists (select 1 from pg_type where typname = 'rol_sga') then
    create type public.rol_sga as enum ('coordinador','profesor','estudiante');
  end if;
  if not exists (select 1 from pg_type where typname = 'estado_asistencia') then
    create type public.estado_asistencia as enum ('Asistio','Falto','Justificacion','Retardo');
  end if;
end $$;

-- Perfil de aplicación: une Supabase Auth con el rol y, cuando aplica,
-- con el profesor/estudiante del sistema.
create table if not exists public.perfiles (
  id uuid primary key references auth.users(id) on delete cascade,
  nombre_completo text not null,
  correo text not null,
  rol public.rol_sga not null default 'estudiante',
  profesor_id uuid references public.profesores(id) on delete set null,
  estudiante_id uuid references public.estudiantes(id) on delete set null,
  created_at timestamptz not null default now(),
  constraint perfil_unico_vinculo_profesor unique (profesor_id),
  constraint perfil_unico_vinculo_estudiante unique (estudiante_id)
);

-- Compatibilidad con la versión inicial: mantenemos administradores.
create table if not exists public.administradores (
  id uuid primary key references auth.users(id) on delete cascade,
  nombre_completo text not null,
  correo text not null,
  created_at timestamptz not null default now()
);

create table if not exists public.configuracion_institucional (
  id boolean primary key default true check (id = true),
  nombre text not null default 'Colegio',
  direccion text not null,
  ciudad text not null default 'Soacha',
  updated_at timestamptz not null default now()
);
insert into public.configuracion_institucional (id,nombre,direccion,ciudad)
values (true,'Colegio','Calle 19 #7-12 barrio Lincoln','Soacha')
on conflict (id) do update set direccion=excluded.direccion, ciudad=excluded.ciudad;

create table if not exists public.calificaciones (
  id uuid primary key default gen_random_uuid(),
  estudiante_id uuid not null references public.estudiantes(id) on delete cascade,
  curso_id uuid not null references public.cursos(id) on delete cascade,
  profesor_id uuid references public.profesores(id) on delete restrict,
  materia text not null,
  periodo smallint not null check (periodo in (1,2)),
  nota numeric(4,2) not null check (nota between 0 and 5),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  unique(estudiante_id,materia,periodo)
);
create index if not exists calificaciones_estudiante_idx on public.calificaciones(estudiante_id,periodo);
create index if not exists calificaciones_profesor_idx on public.calificaciones(profesor_id,curso_id,materia);

create table if not exists public.asistencias (
  id uuid primary key default gen_random_uuid(),
  estudiante_id uuid not null references public.estudiantes(id) on delete cascade,
  curso_id uuid not null references public.cursos(id) on delete cascade,
  profesor_id uuid references public.profesores(id) on delete set null,
  fecha date not null,
  estado public.estado_asistencia not null,
  observacion text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  unique(estudiante_id,fecha)
);
create index if not exists asistencias_estudiante_fecha_idx on public.asistencias(estudiante_id,fecha);
create index if not exists asistencias_profesor_idx on public.asistencias(profesor_id,curso_id,fecha);

create or replace function public.crear_perfil_administrador()
returns trigger
language plpgsql
security definer set search_path = public
as $$
begin
  insert into public.administradores (id,nombre_completo,correo)
  values (
    new.id,
    coalesce(new.raw_user_meta_data ->> 'nombre_completo', split_part(new.email,'@',1)),
    new.email
  )
  on conflict (id) do nothing;
  return new;
end;
$$;

drop trigger if exists on_auth_user_created on auth.users;
create trigger on_auth_user_created
after insert on auth.users for each row execute function public.crear_perfil_administrador();

create or replace function public.current_role()
returns public.rol_sga language sql stable security definer set search_path=public
as $$ select coalesce(
  (select rol from public.perfiles where id=auth.uid() limit 1),
  case when exists(select 1 from public.administradores where id=auth.uid()) then 'coordinador'::public.rol_sga end
) $$;

create or replace function public.current_profesor_id()
returns uuid language sql stable security definer set search_path=public
as $$ select profesor_id from public.perfiles where id=auth.uid() limit 1 $$;

create or replace function public.current_estudiante_id()
returns uuid language sql stable security definer set search_path=public
as $$ select estudiante_id from public.perfiles where id=auth.uid() limit 1 $$;

create or replace function public.profesor_dicta_curso(p_curso uuid)
returns boolean language sql stable security definer set search_path=public
as $$ select exists (
  select 1 from public.horario_clases h
  where h.curso_id=p_curso and h.profesor_id=public.current_profesor_id()
) $$;

create or replace function public.profesor_dicta_materia(p_curso uuid,p_materia text)
returns boolean language sql stable security definer set search_path=public
as $$ select exists (
  select 1 from public.horario_clases h
  where h.curso_id=p_curso and h.profesor_id=public.current_profesor_id()
    and lower(trim(h.materia))=lower(trim(p_materia))
) $$;

alter table public.cursos enable row level security;
alter table public.profesores enable row level security;
alter table public.estudiantes enable row level security;
alter table public.horario_clases enable row level security;
alter table public.perfiles enable row level security;
alter table public.administradores enable row level security;
alter table public.calificaciones enable row level security;
alter table public.asistencias enable row level security;
alter table public.configuracion_institucional enable row level security;

drop policy if exists "cursos_select" on public.cursos;
create policy "cursos_select" on public.cursos for select to authenticated using (true);
drop policy if exists "cursos_write" on public.cursos;
create policy "cursos_write" on public.cursos for all to authenticated
using (public.current_role()='coordinador') with check (public.current_role()='coordinador');

drop policy if exists "profesores_select" on public.profesores;
create policy "profesores_select" on public.profesores for select to authenticated using (true);
drop policy if exists "profesores_write" on public.profesores;
create policy "profesores_write" on public.profesores for all to authenticated
using (public.current_role()='coordinador') with check (public.current_role()='coordinador');

drop policy if exists "estudiantes_select" on public.estudiantes;
create policy "estudiantes_select" on public.estudiantes for select to authenticated
using (
  public.current_role()='coordinador'
  or id=public.current_estudiante_id()
  or (public.current_role()='profesor' and curso_id is not null and public.profesor_dicta_curso(curso_id))
);
drop policy if exists "estudiantes_write" on public.estudiantes;
create policy "estudiantes_write" on public.estudiantes for all to authenticated
using (
  public.current_role()='coordinador'
  or (public.current_role()='profesor' and curso_id is not null and public.profesor_dicta_curso(curso_id))
)
with check (
  public.current_role()='coordinador'
  or (public.current_role()='profesor' and curso_id is not null and public.profesor_dicta_curso(curso_id))
);

drop policy if exists "horario_select" on public.horario_clases;
create policy "horario_select" on public.horario_clases for select to authenticated using (true);
drop policy if exists "horario_write" on public.horario_clases;
create policy "horario_write" on public.horario_clases for all to authenticated
using (public.current_role()='coordinador') with check (public.current_role()='coordinador');

drop policy if exists "perfiles_select" on public.perfiles;
create policy "perfiles_select" on public.perfiles for select to authenticated
using (id=auth.uid() or public.current_role()='coordinador');

drop policy if exists "admin_profile_select" on public.administradores;
create policy "admin_profile_select" on public.administradores for select to authenticated
using (id=auth.uid() or public.current_role()='coordinador');

drop policy if exists "calificaciones_select" on public.calificaciones;
create policy "calificaciones_select" on public.calificaciones for select to authenticated
using (
  public.current_role()='coordinador'
  or estudiante_id=public.current_estudiante_id()
  or (public.current_role()='profesor' and profesor_id=public.current_profesor_id())
);
drop policy if exists "calificaciones_write" on public.calificaciones;
create policy "calificaciones_write" on public.calificaciones for all to authenticated
using (
  public.current_role()='coordinador'
  or (
    public.current_role()='profesor'
    and profesor_id=public.current_profesor_id()
    and public.profesor_dicta_materia(curso_id,materia)
  )
)
with check (
  public.current_role()='coordinador'
  or (
    public.current_role()='profesor'
    and profesor_id=public.current_profesor_id()
    and public.profesor_dicta_materia(curso_id,materia)
  )
);

drop policy if exists "asistencias_select" on public.asistencias;
create policy "asistencias_select" on public.asistencias for select to authenticated
using (
  public.current_role()='coordinador'
  or estudiante_id=public.current_estudiante_id()
  or (public.current_role()='profesor' and curso_id is not null and public.profesor_dicta_curso(curso_id))
);
drop policy if exists "asistencias_write" on public.asistencias;
create policy "asistencias_write" on public.asistencias for all to authenticated
using (
  public.current_role()='coordinador'
  or (
    public.current_role()='profesor'
    and profesor_id=public.current_profesor_id()
    and public.profesor_dicta_curso(curso_id)
  )
)
with check (
  public.current_role()='coordinador'
  or (
    public.current_role()='profesor'
    and profesor_id=public.current_profesor_id()
    and public.profesor_dicta_curso(curso_id)
  )
);

drop policy if exists "config_select" on public.configuracion_institucional;
create policy "config_select" on public.configuracion_institucional for select to authenticated using (true);
drop policy if exists "config_write" on public.configuracion_institucional;
create policy "config_write" on public.configuracion_institucional for all to authenticated
using (public.current_role()='coordinador') with check (public.current_role()='coordinador');

create or replace view public.vista_promedios_periodo as
select estudiante_id, curso_id, periodo, round(avg(nota),2) as promedio
from public.calificaciones
group by estudiante_id,curso_id,periodo;

create or replace view public.vista_resumen_asistencia as
select
  estudiante_id,
  curso_id,
  count(*) filter (where estado='Asistio') as asistencias,
  count(*) filter (where estado='Falto') as inasistencias,
  count(*) filter (where estado='Justificacion') as justificadas,
  count(*) filter (where estado='Retardo') as retardos
from public.asistencias
group by estudiante_id,curso_id;
