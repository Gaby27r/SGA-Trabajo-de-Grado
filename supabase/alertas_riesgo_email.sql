create table if not exists public.alertas_riesgo_email (
  id uuid primary key default gen_random_uuid(),

  estudiante_id uuid not null
    references public.estudiantes(id)
    on delete cascade,

  huella text not null,

  nivel text not null
    check (nivel in ('Alto', 'Medio')),

  destinatario text not null,

  estado text not null default 'pendiente'
    check (estado in ('pendiente', 'enviado')),

  creado_at timestamptz not null default now(),

  enviado_at timestamptz,

  unique (estudiante_id, huella)
);

create index if not exists alertas_riesgo_email_estudiante_fecha_idx
  on public.alertas_riesgo_email (
    estudiante_id,
    creado_at desc
  );

alter table public.alertas_riesgo_email
  enable row level security;

notify pgrst, 'reload schema';