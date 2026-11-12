-- Datos base mínimos. Para cargar los 27 estudiantes, notas, asistencia y horario
-- reales del Excel use: supabase/import_excel.sql
insert into public.cursos (nombre,jornada) values ('4to A','Mañana'),('8vo A','Mañana')
on conflict (nombre) do nothing;
