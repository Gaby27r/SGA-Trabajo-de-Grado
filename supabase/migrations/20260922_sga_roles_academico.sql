-- Migración para instalaciones que ya tenían la versión inicial.
create extension if not exists "pgcrypto";

alter table public.profesores add column if not exists telefono text;
do $$ begin
  if not exists (select 1 from pg_constraint where conname='profesores_nombre_completo_key') then
    alter table public.profesores add constraint profesores_nombre_completo_key unique(nombre_completo);
  end if;
end $$;

alter table public.estudiantes drop constraint if exists estudiantes_documento_key;
alter table public.estudiantes alter column documento drop not null;
alter table public.estudiantes add column if not exists fecha_nacimiento date;
alter table public.estudiantes add column if not exists edad_actual integer;
alter table public.estudiantes add column if not exists direccion text;
alter table public.estudiantes add column if not exists estrato integer;
alter table public.estudiantes add column if not exists con_quien_vive text;
alter table public.estudiantes add column if not exists anio_repetido text;
alter table public.estudiantes add column if not exists matriculado text;
alter table public.estudiantes add column if not exists reuniones_padres boolean;
alter table public.estudiantes add column if not exists total_anotaciones integer not null default 0;
alter table public.estudiantes add column if not exists graves integer not null default 0;
alter table public.estudiantes add column if not exists leves integer not null default 0;
do $$ begin
  if not exists (select 1 from pg_constraint where conname='estudiantes_nombre_completo_curso_id_key') then
    alter table public.estudiantes add constraint estudiantes_nombre_completo_curso_id_key unique(nombre_completo,curso_id);
  end if;
end $$;

do $$ begin
  if not exists (select 1 from pg_type where typname='rol_sga') then
    create type public.rol_sga as enum ('coordinador','profesor','estudiante');
  end if;
  if not exists (select 1 from pg_type where typname='estado_asistencia') then
    create type public.estado_asistencia as enum ('Asistio','Falto','Justificacion','Retardo');
  end if;
end $$;

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
create table if not exists public.configuracion_institucional (
  id boolean primary key default true check(id=true),
  nombre text not null default 'Colegio',
  direccion text not null,
  ciudad text not null default 'Soacha',
  updated_at timestamptz not null default now()
);
insert into public.configuracion_institucional(id,nombre,direccion,ciudad)
values(true,'Colegio','Calle 19 #7-12 barrio Lincoln','Soacha')
on conflict(id) do update set direccion=excluded.direccion,ciudad=excluded.ciudad;

create table if not exists public.calificaciones (
  id uuid primary key default gen_random_uuid(),
  estudiante_id uuid not null references public.estudiantes(id) on delete cascade,
  curso_id uuid not null references public.cursos(id) on delete cascade,
  profesor_id uuid references public.profesores(id) on delete restrict,
  materia text not null,
  periodo smallint not null check(periodo in(1,2)),
  nota numeric(4,2) not null check(nota between 0 and 5),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  unique(estudiante_id,materia,periodo)
);
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
as $$ select exists(select 1 from public.horario_clases h where h.curso_id=p_curso and h.profesor_id=public.current_profesor_id()) $$;
create or replace function public.profesor_dicta_materia(p_curso uuid,p_materia text)
returns boolean language sql stable security definer set search_path=public
as $$ select exists(select 1 from public.horario_clases h where h.curso_id=p_curso and h.profesor_id=public.current_profesor_id() and lower(trim(h.materia))=lower(trim(p_materia))) $$;

alter table public.cursos enable row level security;
alter table public.profesores enable row level security;
alter table public.estudiantes enable row level security;
alter table public.horario_clases enable row level security;
alter table public.perfiles enable row level security;
alter table public.administradores enable row level security;
alter table public.calificaciones enable row level security;
alter table public.asistencias enable row level security;
alter table public.configuracion_institucional enable row level security;

drop policy if exists "administradores acceso total" on public.cursos;
drop policy if exists "administradores acceso total" on public.profesores;
drop policy if exists "administradores acceso total" on public.estudiantes;
drop policy if exists "administradores acceso total" on public.horario_clases;
drop policy if exists "cursos_select" on public.cursos;
create policy "cursos_select" on public.cursos for select to authenticated using(true);
drop policy if exists "cursos_write" on public.cursos;
create policy "cursos_write" on public.cursos for all to authenticated using(public.current_role()='coordinador') with check(public.current_role()='coordinador');

drop policy if exists "profesores_select" on public.profesores;
create policy "profesores_select" on public.profesores for select to authenticated using(true);
drop policy if exists "profesores_write" on public.profesores;
create policy "profesores_write" on public.profesores for all to authenticated using(public.current_role()='coordinador') with check(public.current_role()='coordinador');

drop policy if exists "estudiantes_select" on public.estudiantes;
create policy "estudiantes_select" on public.estudiantes for select to authenticated using(public.current_role()='coordinador' or id=public.current_estudiante_id() or (public.current_role()='profesor' and curso_id is not null and public.profesor_dicta_curso(curso_id)));
drop policy if exists "estudiantes_write" on public.estudiantes;
create policy "estudiantes_write" on public.estudiantes for all to authenticated using(public.current_role()='coordinador' or (public.current_role()='profesor' and curso_id is not null and public.profesor_dicta_curso(curso_id))) with check(public.current_role()='coordinador' or (public.current_role()='profesor' and curso_id is not null and public.profesor_dicta_curso(curso_id)));

drop policy if exists "horario_select" on public.horario_clases;
create policy "horario_select" on public.horario_clases for select to authenticated using(true);
drop policy if exists "horario_write" on public.horario_clases;
create policy "horario_write" on public.horario_clases for all to authenticated using(public.current_role()='coordinador') with check(public.current_role()='coordinador');

drop policy if exists "perfiles_select" on public.perfiles;
create policy "perfiles_select" on public.perfiles for select to authenticated using(id=auth.uid() or public.current_role()='coordinador');
drop policy if exists "admin_profile_select" on public.administradores;
create policy "admin_profile_select" on public.administradores for select to authenticated using(id=auth.uid() or public.current_role()='coordinador');

drop policy if exists "calificaciones_select" on public.calificaciones;
create policy "calificaciones_select" on public.calificaciones for select to authenticated using(public.current_role()='coordinador' or estudiante_id=public.current_estudiante_id() or (public.current_role()='profesor' and profesor_id=public.current_profesor_id()));
drop policy if exists "calificaciones_write" on public.calificaciones;
create policy "calificaciones_write" on public.calificaciones for all to authenticated using(public.current_role()='coordinador' or (public.current_role()='profesor' and profesor_id=public.current_profesor_id() and public.profesor_dicta_materia(curso_id,materia))) with check(public.current_role()='coordinador' or (public.current_role()='profesor' and profesor_id=public.current_profesor_id() and public.profesor_dicta_materia(curso_id,materia)));

drop policy if exists "asistencias_select" on public.asistencias;
create policy "asistencias_select" on public.asistencias for select to authenticated using(public.current_role()='coordinador' or estudiante_id=public.current_estudiante_id() or (public.current_role()='profesor' and curso_id is not null and public.profesor_dicta_curso(curso_id)));
drop policy if exists "asistencias_write" on public.asistencias;
create policy "asistencias_write" on public.asistencias for all to authenticated using(public.current_role()='coordinador' or (public.current_role()='profesor' and profesor_id=public.current_profesor_id() and public.profesor_dicta_curso(curso_id))) with check(public.current_role()='coordinador' or (public.current_role()='profesor' and profesor_id=public.current_profesor_id() and public.profesor_dicta_curso(curso_id)));

drop policy if exists "config_select" on public.configuracion_institucional;
create policy "config_select" on public.configuracion_institucional for select to authenticated using(true);
drop policy if exists "config_write" on public.configuracion_institucional;
create policy "config_write" on public.configuracion_institucional for all to authenticated using(public.current_role()='coordinador') with check(public.current_role()='coordinador');

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
