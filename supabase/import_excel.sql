-- ============================================================
-- IMPORTACIÓN DEL SGA DESDE DATOS ANONIMIZADOS.xlsx
-- Generado directamente desde el Excel actualizado.
--
-- IMPORTANTE:
-- 1) Reemplaza los datos académicos de 4to A y 8vo A.
-- 2) NO elimina usuarios de Supabase Auth.
-- 3) Los estudiantes quedan con los códigos del Excel (E401... / E801...).
-- 4) Los profesores quedan con los códigos que aparecen en los horarios.
-- 5) Ejecutar schema.sql primero.
-- ============================================================

begin;

-- Desvincular perfiles académicos antes de reemplazar estudiantes/profesores.
delete from public.perfiles
where rol in ('profesor','estudiante');

-- Reemplazar los datos académicos de los dos cursos.
delete from public.calificaciones;
delete from public.asistencias;
delete from public.horario_clases;
delete from public.estudiantes;
delete from public.profesores;
delete from public.cursos;

insert into public.cursos (nombre,jornada)
values ('4to A','Mañana'),('8vo A','Mañana');

-- PROFESORES (códigos tomados del Excel)
insert into public.profesores (nombre_completo) values ('PAG4');
insert into public.profesores (nombre_completo) values ('PAG48');
insert into public.profesores (nombre_completo) values ('PAL4');
insert into public.profesores (nombre_completo) values ('PAMO8');
insert into public.profesores (nombre_completo) values ('PDA8');
insert into public.profesores (nombre_completo) values ('PDB48');
insert into public.profesores (nombre_completo) values ('PKR48');
insert into public.profesores (nombre_completo) values ('PRP48');
insert into public.profesores (nombre_completo) values ('PSC8');
insert into public.profesores (nombre_completo) values ('PSF8');
insert into public.profesores (nombre_completo) values ('PVZ48');
insert into public.profesores (nombre_completo) values ('PWA4');

-- ESTUDIANTES (nombres/códigos tomados del Excel)
insert into public.estudiantes (nombre_completo,curso_id,matriculado,fecha_nacimiento,edad_actual,direccion,estrato,con_quien_vive,anio_repetido,reuniones_padres,acudiente,total_anotaciones,graves,leves)
select 'E401',c.id,'CONVENIO','2017-10-06','8','Carrera 4 este # 30b-51','3','Mama','NO',true,'Mamá','0','0','0'
from public.cursos c where c.nombre='4to A';
insert into public.estudiantes (nombre_completo,curso_id,matriculado,fecha_nacimiento,edad_actual,direccion,estrato,con_quien_vive,anio_repetido,reuniones_padres,acudiente,total_anotaciones,graves,leves)
select 'E402',c.id,'CONVENIO','2016-11-05','9','Calle 10a # 1b-194','3','Papa,mama','NO',false,'Mamá','0','0','0'
from public.cursos c where c.nombre='4to A';
insert into public.estudiantes (nombre_completo,curso_id,matriculado,fecha_nacimiento,edad_actual,direccion,estrato,con_quien_vive,anio_repetido,reuniones_padres,acudiente,total_anotaciones,graves,leves)
select 'E403',c.id,'CONVENIO','2016-06-11','10','Calle 15 # 19a-152','2','Mama, padrastro y hermanos','NO',true,'Mamá','0','0','0'
from public.cursos c where c.nombre='4to A';
insert into public.estudiantes (nombre_completo,curso_id,matriculado,fecha_nacimiento,edad_actual,direccion,estrato,con_quien_vive,anio_repetido,reuniones_padres,acudiente,total_anotaciones,graves,leves)
select 'E404',c.id,'CONVENIO','2016-06-30','10','Calle 12 # 13-51','3','mamá, papá, hermano.','NO',true,'Mamá','1','0','1'
from public.cursos c where c.nombre='4to A';
insert into public.estudiantes (nombre_completo,curso_id,matriculado,fecha_nacimiento,edad_actual,direccion,estrato,con_quien_vive,anio_repetido,reuniones_padres,acudiente,total_anotaciones,graves,leves)
select 'E405',c.id,'MATRICULA','2015-04-16','11','Calle 13a # 18r-17','3','madre y hermano','NO',false,'Mamá','0','0','0'
from public.cursos c where c.nombre='4to A';
insert into public.estudiantes (nombre_completo,curso_id,matriculado,fecha_nacimiento,edad_actual,direccion,estrato,con_quien_vive,anio_repetido,reuniones_padres,acudiente,total_anotaciones,graves,leves)
select 'E406',c.id,'CONVENIO','2016-09-15','9','Carrera 19a # 11a-67','3','Padre y madre','NO',true,'Papá','0','0','0'
from public.cursos c where c.nombre='4to A';
insert into public.estudiantes (nombre_completo,curso_id,matriculado,fecha_nacimiento,edad_actual,direccion,estrato,con_quien_vive,anio_repetido,reuniones_padres,acudiente,total_anotaciones,graves,leves)
select 'E407',c.id,'CONVENIO','2016-03-12','10','Calle # 13-74','3','Abuelos hermano y mamá','NO',false,'Mamá','1','0','1'
from public.cursos c where c.nombre='4to A';
insert into public.estudiantes (nombre_completo,curso_id,matriculado,fecha_nacimiento,edad_actual,direccion,estrato,con_quien_vive,anio_repetido,reuniones_padres,acudiente,total_anotaciones,graves,leves)
select 'E408',c.id,'CONVENIO','2015-03-30','11','Calle 4 # 18 - 178 ','3','madre','NO',false,'Mamá','2','0','2'
from public.cursos c where c.nombre='4to A';
insert into public.estudiantes (nombre_completo,curso_id,matriculado,fecha_nacimiento,edad_actual,direccion,estrato,con_quien_vive,anio_repetido,reuniones_padres,acudiente,total_anotaciones,graves,leves)
select 'E409',c.id,'CONVENIO','2017-05-23','9','Calel 15 # 19 A 159','2','padres y hermana','NO',false,'Mamá','3','0','3'
from public.cursos c where c.nombre='4to A';
insert into public.estudiantes (nombre_completo,curso_id,matriculado,fecha_nacimiento,edad_actual,direccion,estrato,con_quien_vive,anio_repetido,reuniones_padres,acudiente,total_anotaciones,graves,leves)
select 'E410',c.id,'CONVENIO','2015-08-16','10','Calle 15 # 19 A 152','2','Madrastra,hermanastros','NO',true,'Madrastra','1','0','1'
from public.cursos c where c.nombre='4to A';
insert into public.estudiantes (nombre_completo,curso_id,matriculado,fecha_nacimiento,edad_actual,direccion,estrato,con_quien_vive,anio_repetido,reuniones_padres,acudiente,total_anotaciones,graves,leves)
select 'E411',c.id,'CONVENIO','2016-06-17','10','Carrera 18G #16-73','3','Papá, mamá y hermanos','NO',true,'Papá','1','0','1'
from public.cursos c where c.nombre='4to A';
insert into public.estudiantes (nombre_completo,curso_id,matriculado,fecha_nacimiento,edad_actual,direccion,estrato,con_quien_vive,anio_repetido,reuniones_padres,acudiente,total_anotaciones,graves,leves)
select 'E412',c.id,'CONVENIO','2017-05-25','9','Calle 33 # 7 este 36 ','3','Papá, mamá y hermano','NO',true,'Mamá','1','0','1'
from public.cursos c where c.nombre='4to A';
insert into public.estudiantes (nombre_completo,curso_id,matriculado,fecha_nacimiento,edad_actual,direccion,estrato,con_quien_vive,anio_repetido,reuniones_padres,acudiente,total_anotaciones,graves,leves)
select 'E801',c.id,'CONVENIO','2012-05-21','14','Carrera 19 d número 13 -65','3','Papas','NO',false,'Mamá','1','0','1'
from public.cursos c where c.nombre='8vo A';
insert into public.estudiantes (nombre_completo,curso_id,matriculado,fecha_nacimiento,edad_actual,direccion,estrato,con_quien_vive,anio_repetido,reuniones_padres,acudiente,total_anotaciones,graves,leves)
select 'E802',c.id,'CONVENIO','2010-08-22','15','Carrera 2#26-16, Piso 3','2','Papá, Mamá, hermanos, abuelos, tio','REPITENTE',true,'Papá','4','0','4'
from public.cursos c where c.nombre='8vo A';
insert into public.estudiantes (nombre_completo,curso_id,matriculado,fecha_nacimiento,edad_actual,direccion,estrato,con_quien_vive,anio_repetido,reuniones_padres,acudiente,total_anotaciones,graves,leves)
select 'E803',c.id,'MATRICULA','2010-04-15','16','Cra 6 este # 38-197','3','MaMà , hermano y padrastro','NO',false,'Mamá','4','1','3'
from public.cursos c where c.nombre='8vo A';
insert into public.estudiantes (nombre_completo,curso_id,matriculado,fecha_nacimiento,edad_actual,direccion,estrato,con_quien_vive,anio_repetido,reuniones_padres,acudiente,total_anotaciones,graves,leves)
select 'E804',c.id,'CONVENIO','2012-02-06','14','carrera 6 n° 11-51','3','padre','NO',false,'Mamá','9','0','9'
from public.cursos c where c.nombre='8vo A';
insert into public.estudiantes (nombre_completo,curso_id,matriculado,fecha_nacimiento,edad_actual,direccion,estrato,con_quien_vive,anio_repetido,reuniones_padres,acudiente,total_anotaciones,graves,leves)
select 'E805',c.id,'CONVENIO','2012-11-03','13','Calle 15 # 19a-152','2','Mama, padrastro y hermanos','NO',true,'Mamá','3','0','3'
from public.cursos c where c.nombre='8vo A';
insert into public.estudiantes (nombre_completo,curso_id,matriculado,fecha_nacimiento,edad_actual,direccion,estrato,con_quien_vive,anio_repetido,reuniones_padres,acudiente,total_anotaciones,graves,leves)
select 'E806',c.id,'CONVENIO','2012-12-13','13','Calle 8 sur 16 A 152','3','Hermano','NO',false,'Hermano','5','1','4'
from public.cursos c where c.nombre='8vo A';
insert into public.estudiantes (nombre_completo,curso_id,matriculado,fecha_nacimiento,edad_actual,direccion,estrato,con_quien_vive,anio_repetido,reuniones_padres,acudiente,total_anotaciones,graves,leves)
select 'E807',c.id,'CONVENIO','2011-11-12','14','Calle 13 a # 19 a 40','3','Papas , y hermano','NO',true,'Mamá','9','1','8'
from public.cursos c where c.nombre='8vo A';
insert into public.estudiantes (nombre_completo,curso_id,matriculado,fecha_nacimiento,edad_actual,direccion,estrato,con_quien_vive,anio_repetido,reuniones_padres,acudiente,total_anotaciones,graves,leves)
select 'E808',c.id,'CONVENIO','2013-03-21','13','CRA 18G # 16 - 73','2','Padre y madre','NO',true,'Mamá','1','1','0'
from public.cursos c where c.nombre='8vo A';
insert into public.estudiantes (nombre_completo,curso_id,matriculado,fecha_nacimiento,edad_actual,direccion,estrato,con_quien_vive,anio_repetido,reuniones_padres,acudiente,total_anotaciones,graves,leves)
select 'E809',c.id,'CONVENIO','2013-04-18','13','Calle 13 # 1a-41','3','Abuela','NO',false,'Mamá','4','0','4'
from public.cursos c where c.nombre='8vo A';
insert into public.estudiantes (nombre_completo,curso_id,matriculado,fecha_nacimiento,edad_actual,direccion,estrato,con_quien_vive,anio_repetido,reuniones_padres,acudiente,total_anotaciones,graves,leves)
select 'E810',c.id,'CONVENIO','2012-08-22','13','CALLE 4 SUR # 17-64','3','Papa, mama y hermano','NO',false,'Mamá','1','0','1'
from public.cursos c where c.nombre='8vo A';
insert into public.estudiantes (nombre_completo,curso_id,matriculado,fecha_nacimiento,edad_actual,direccion,estrato,con_quien_vive,anio_repetido,reuniones_padres,acudiente,total_anotaciones,graves,leves)
select 'E811',c.id,'CONVENIO','2011-09-23','14','Carrera 31 # 15-119','3','Hermano','NO',true,'Hermano','5','1','4'
from public.cursos c where c.nombre='8vo A';
insert into public.estudiantes (nombre_completo,curso_id,matriculado,fecha_nacimiento,edad_actual,direccion,estrato,con_quien_vive,anio_repetido,reuniones_padres,acudiente,total_anotaciones,graves,leves)
select 'E812',c.id,'CONVENIO','2011-05-01','15','Carrera 18 R #','2','Mama','NO',false,'Mamá','11','3','8'
from public.cursos c where c.nombre='8vo A';
insert into public.estudiantes (nombre_completo,curso_id,matriculado,fecha_nacimiento,edad_actual,direccion,estrato,con_quien_vive,anio_repetido,reuniones_padres,acudiente,total_anotaciones,graves,leves)
select 'E813',c.id,'MATRICULA','2010-06-06','16','Calle 15#19A159 prado Vegas','3','Mamá papá hermana abuelo','NO',true,'Mamá','3','0','3'
from public.cursos c where c.nombre='8vo A';
insert into public.estudiantes (nombre_completo,curso_id,matriculado,fecha_nacimiento,edad_actual,direccion,estrato,con_quien_vive,anio_repetido,reuniones_padres,acudiente,total_anotaciones,graves,leves)
select 'E814',c.id,'CONVENIO','2012-03-25','14','cra 10 8 61 confianza 1 soacha','2','papas y hermana','NO',true,'Mamá','4','0','4'
from public.cursos c where c.nombre='8vo A';
insert into public.estudiantes (nombre_completo,curso_id,matriculado,fecha_nacimiento,edad_actual,direccion,estrato,con_quien_vive,anio_repetido,reuniones_padres,acudiente,total_anotaciones,graves,leves)
select 'E815',c.id,'MATRICULA','2011-07-18','15','Carrera 12 este # 8-13','1','Mama','NO',true,'Mamá','1','1','0'
from public.cursos c where c.nombre='8vo A';

-- HORARIOS
insert into public.horario_clases (curso_id,dia,hora_inicio,hora_fin,materia,profesor_id,es_descanso)
select c.id,'Lunes'::public.dia_semana,'07:00'::time,'07:50'::time,'ARITMÉTICA',(select id from public.profesores where nombre_completo='PAL4'),false
from public.cursos c where c.nombre='4to A';
insert into public.horario_clases (curso_id,dia,hora_inicio,hora_fin,materia,profesor_id,es_descanso)
select c.id,'Martes'::public.dia_semana,'07:00'::time,'07:50'::time,'BIOLOGÍA',(select id from public.profesores where nombre_completo='PAG4'),false
from public.cursos c where c.nombre='4to A';
insert into public.horario_clases (curso_id,dia,hora_inicio,hora_fin,materia,profesor_id,es_descanso)
select c.id,'Miércoles'::public.dia_semana,'07:00'::time,'07:50'::time,'ESTADÍSTICA',(select id from public.profesores where nombre_completo='PAL4'),false
from public.cursos c where c.nombre='4to A';
insert into public.horario_clases (curso_id,dia,hora_inicio,hora_fin,materia,profesor_id,es_descanso)
select c.id,'Jueves'::public.dia_semana,'07:00'::time,'07:50'::time,'ROBÓTICA Y PROGRAMACIÓN DE VIDEOJUEGOS',(select id from public.profesores where nombre_completo='PKR48'),false
from public.cursos c where c.nombre='4to A';
insert into public.horario_clases (curso_id,dia,hora_inicio,hora_fin,materia,profesor_id,es_descanso)
select c.id,'Viernes'::public.dia_semana,'07:00'::time,'07:50'::time,'BIOLOGÍA',(select id from public.profesores where nombre_completo='PAG48'),false
from public.cursos c where c.nombre='4to A';
insert into public.horario_clases (curso_id,dia,hora_inicio,hora_fin,materia,profesor_id,es_descanso)
select c.id,'Lunes'::public.dia_semana,'07:50'::time,'08:40'::time,'ARITMÉTICA',(select id from public.profesores where nombre_completo='PAL4'),false
from public.cursos c where c.nombre='4to A';
insert into public.horario_clases (curso_id,dia,hora_inicio,hora_fin,materia,profesor_id,es_descanso)
select c.id,'Martes'::public.dia_semana,'07:50'::time,'08:40'::time,'BIOLOGÍA',(select id from public.profesores where nombre_completo='PAG48'),false
from public.cursos c where c.nombre='4to A';
insert into public.horario_clases (curso_id,dia,hora_inicio,hora_fin,materia,profesor_id,es_descanso)
select c.id,'Miércoles'::public.dia_semana,'07:50'::time,'08:40'::time,'CULTURAS RELIGIOSAS Y ESPIRITUALIDAD',(select id from public.profesores where nombre_completo='PWA4'),false
from public.cursos c where c.nombre='4to A';
insert into public.horario_clases (curso_id,dia,hora_inicio,hora_fin,materia,profesor_id,es_descanso)
select c.id,'Jueves'::public.dia_semana,'07:50'::time,'08:40'::time,'ROBÓTICA Y PROGRAMACIÓN DE VIDEOJUEGOS',(select id from public.profesores where nombre_completo='PKR48'),false
from public.cursos c where c.nombre='4to A';
insert into public.horario_clases (curso_id,dia,hora_inicio,hora_fin,materia,profesor_id,es_descanso)
select c.id,'Viernes'::public.dia_semana,'07:50'::time,'08:40'::time,'HISTORIA',(select id from public.profesores where nombre_completo='PAG48'),false
from public.cursos c where c.nombre='4to A';
insert into public.horario_clases (curso_id,dia,hora_inicio,hora_fin,materia,profesor_id,es_descanso)
select c.id,'Lunes'::public.dia_semana,'08:40'::time,'09:30'::time,'GEOMETRÍA',(select id from public.profesores where nombre_completo='PAL4'),false
from public.cursos c where c.nombre='4to A';
insert into public.horario_clases (curso_id,dia,hora_inicio,hora_fin,materia,profesor_id,es_descanso)
select c.id,'Martes'::public.dia_semana,'08:40'::time,'09:30'::time,'DEMOCRACIA',(select id from public.profesores where nombre_completo='PAG48'),false
from public.cursos c where c.nombre='4to A';
insert into public.horario_clases (curso_id,dia,hora_inicio,hora_fin,materia,profesor_id,es_descanso)
select c.id,'Miércoles'::public.dia_semana,'08:40'::time,'09:30'::time,'LENGUA EXTRANJERA',(select id from public.profesores where nombre_completo='PDB48'),false
from public.cursos c where c.nombre='4to A';
insert into public.horario_clases (curso_id,dia,hora_inicio,hora_fin,materia,profesor_id,es_descanso)
select c.id,'Jueves'::public.dia_semana,'08:40'::time,'09:30'::time,'FORMACIÓN ÉTICA Y CIUDADANA',(select id from public.profesores where nombre_completo='PAG48'),false
from public.cursos c where c.nombre='4to A';
insert into public.horario_clases (curso_id,dia,hora_inicio,hora_fin,materia,profesor_id,es_descanso)
select c.id,'Viernes'::public.dia_semana,'08:40'::time,'09:30'::time,'LENGUA EXTRANJERA',(select id from public.profesores where nombre_completo='PDB48'),false
from public.cursos c where c.nombre='4to A';
insert into public.horario_clases (curso_id,dia,hora_inicio,hora_fin,materia,profesor_id,es_descanso)
select c.id,'Lunes'::public.dia_semana,'09:30'::time,'10:20'::time,'DESCANSO',null,true
from public.cursos c where c.nombre='4to A';
insert into public.horario_clases (curso_id,dia,hora_inicio,hora_fin,materia,profesor_id,es_descanso)
select c.id,'Martes'::public.dia_semana,'09:30'::time,'10:20'::time,'DESCANSO',null,true
from public.cursos c where c.nombre='4to A';
insert into public.horario_clases (curso_id,dia,hora_inicio,hora_fin,materia,profesor_id,es_descanso)
select c.id,'Miércoles'::public.dia_semana,'09:30'::time,'10:20'::time,'DESCANSO',null,true
from public.cursos c where c.nombre='4to A';
insert into public.horario_clases (curso_id,dia,hora_inicio,hora_fin,materia,profesor_id,es_descanso)
select c.id,'Jueves'::public.dia_semana,'09:30'::time,'10:20'::time,'DESCANSO',null,true
from public.cursos c where c.nombre='4to A';
insert into public.horario_clases (curso_id,dia,hora_inicio,hora_fin,materia,profesor_id,es_descanso)
select c.id,'Viernes'::public.dia_semana,'09:30'::time,'10:20'::time,'DESCANSO',null,true
from public.cursos c where c.nombre='4to A';
insert into public.horario_clases (curso_id,dia,hora_inicio,hora_fin,materia,profesor_id,es_descanso)
select c.id,'Lunes'::public.dia_semana,'10:20'::time,'11:10'::time,'PLAN LECTOR',(select id from public.profesores where nombre_completo='PAL4'),false
from public.cursos c where c.nombre='4to A';
insert into public.horario_clases (curso_id,dia,hora_inicio,hora_fin,materia,profesor_id,es_descanso)
select c.id,'Martes'::public.dia_semana,'10:20'::time,'11:10'::time,'LENGUA EXTRANJERA',(select id from public.profesores where nombre_completo='PDB48'),false
from public.cursos c where c.nombre='4to A';
insert into public.horario_clases (curso_id,dia,hora_inicio,hora_fin,materia,profesor_id,es_descanso)
select c.id,'Miércoles'::public.dia_semana,'10:20'::time,'11:10'::time,'EDUCACIÓN FÍSICA',(select id from public.profesores where nombre_completo='PRP48'),false
from public.cursos c where c.nombre='4to A';
insert into public.horario_clases (curso_id,dia,hora_inicio,hora_fin,materia,profesor_id,es_descanso)
select c.id,'Jueves'::public.dia_semana,'10:20'::time,'11:10'::time,'LENGUA CASTELLANA',(select id from public.profesores where nombre_completo='PVZ48'),false
from public.cursos c where c.nombre='4to A';
insert into public.horario_clases (curso_id,dia,hora_inicio,hora_fin,materia,profesor_id,es_descanso)
select c.id,'Viernes'::public.dia_semana,'10:20'::time,'11:10'::time,'INTELIGENCIA EMOCIONAL',(select id from public.profesores where nombre_completo='PAG48'),false
from public.cursos c where c.nombre='4to A';
insert into public.horario_clases (curso_id,dia,hora_inicio,hora_fin,materia,profesor_id,es_descanso)
select c.id,'Lunes'::public.dia_semana,'11:10'::time,'12:00'::time,'LENGUA CASTELLANA',(select id from public.profesores where nombre_completo='PVZ48'),false
from public.cursos c where c.nombre='4to A';
insert into public.horario_clases (curso_id,dia,hora_inicio,hora_fin,materia,profesor_id,es_descanso)
select c.id,'Martes'::public.dia_semana,'11:10'::time,'12:00'::time,'GEOGRAFÍA',(select id from public.profesores where nombre_completo='PAG48'),false
from public.cursos c where c.nombre='4to A';
insert into public.horario_clases (curso_id,dia,hora_inicio,hora_fin,materia,profesor_id,es_descanso)
select c.id,'Miércoles'::public.dia_semana,'11:10'::time,'12:00'::time,'EDUCACIÓN FÍSICA',(select id from public.profesores where nombre_completo='PRP48'),false
from public.cursos c where c.nombre='4to A';
insert into public.horario_clases (curso_id,dia,hora_inicio,hora_fin,materia,profesor_id,es_descanso)
select c.id,'Jueves'::public.dia_semana,'11:10'::time,'12:00'::time,'LENGUA CASTELLANA',(select id from public.profesores where nombre_completo='PVZ48'),false
from public.cursos c where c.nombre='4to A';
insert into public.horario_clases (curso_id,dia,hora_inicio,hora_fin,materia,profesor_id,es_descanso)
select c.id,'Viernes'::public.dia_semana,'11:10'::time,'12:00'::time,'ARTES',(select id from public.profesores where nombre_completo='PAG48'),false
from public.cursos c where c.nombre='4to A';
insert into public.horario_clases (curso_id,dia,hora_inicio,hora_fin,materia,profesor_id,es_descanso)
select c.id,'Lunes'::public.dia_semana,'12:00'::time,'12:50'::time,'LENGUA CASTELLANA',(select id from public.profesores where nombre_completo='PVZ48'),false
from public.cursos c where c.nombre='4to A';
insert into public.horario_clases (curso_id,dia,hora_inicio,hora_fin,materia,profesor_id,es_descanso)
select c.id,'Martes'::public.dia_semana,'12:00'::time,'12:50'::time,'GEOGRAFÍA',(select id from public.profesores where nombre_completo='PAG48'),false
from public.cursos c where c.nombre='4to A';
insert into public.horario_clases (curso_id,dia,hora_inicio,hora_fin,materia,profesor_id,es_descanso)
select c.id,'Miércoles'::public.dia_semana,'12:00'::time,'12:50'::time,'BIOLOGÍA',(select id from public.profesores where nombre_completo='PAG48'),false
from public.cursos c where c.nombre='4to A';
insert into public.horario_clases (curso_id,dia,hora_inicio,hora_fin,materia,profesor_id,es_descanso)
select c.id,'Jueves'::public.dia_semana,'12:00'::time,'12:50'::time,'LENGUA EXTRANJERA',(select id from public.profesores where nombre_completo='PDB48'),false
from public.cursos c where c.nombre='4to A';
insert into public.horario_clases (curso_id,dia,hora_inicio,hora_fin,materia,profesor_id,es_descanso)
select c.id,'Viernes'::public.dia_semana,'12:00'::time,'12:50'::time,'ARTES',(select id from public.profesores where nombre_completo='PAG48'),false
from public.cursos c where c.nombre='4to A';
insert into public.horario_clases (curso_id,dia,hora_inicio,hora_fin,materia,profesor_id,es_descanso)
select c.id,'Lunes'::public.dia_semana,'07:00'::time,'07:50'::time,'PLAN LECTOR',(select id from public.profesores where nombre_completo='PSC8'),false
from public.cursos c where c.nombre='8vo A';
insert into public.horario_clases (curso_id,dia,hora_inicio,hora_fin,materia,profesor_id,es_descanso)
select c.id,'Martes'::public.dia_semana,'07:00'::time,'07:50'::time,'LENGUA CASTELLANA',(select id from public.profesores where nombre_completo='PVZ48'),false
from public.cursos c where c.nombre='8vo A';
insert into public.horario_clases (curso_id,dia,hora_inicio,hora_fin,materia,profesor_id,es_descanso)
select c.id,'Miércoles'::public.dia_semana,'07:00'::time,'07:50'::time,'INTELIGENCIA EMOCIONAL',(select id from public.profesores where nombre_completo='PDA8'),false
from public.cursos c where c.nombre='8vo A';
insert into public.horario_clases (curso_id,dia,hora_inicio,hora_fin,materia,profesor_id,es_descanso)
select c.id,'Jueves'::public.dia_semana,'07:00'::time,'07:50'::time,'FORMACIÓN ÉTICA Y CIUDADANA',(select id from public.profesores where nombre_completo='PDA8'),false
from public.cursos c where c.nombre='8vo A';
insert into public.horario_clases (curso_id,dia,hora_inicio,hora_fin,materia,profesor_id,es_descanso)
select c.id,'Viernes'::public.dia_semana,'07:00'::time,'07:50'::time,'ARITMÉTICA',(select id from public.profesores where nombre_completo='PDA8'),false
from public.cursos c where c.nombre='8vo A';
insert into public.horario_clases (curso_id,dia,hora_inicio,hora_fin,materia,profesor_id,es_descanso)
select c.id,'Lunes'::public.dia_semana,'07:50'::time,'08:40'::time,'BIOLOGÍA',(select id from public.profesores where nombre_completo='PSC8'),false
from public.cursos c where c.nombre='8vo A';
insert into public.horario_clases (curso_id,dia,hora_inicio,hora_fin,materia,profesor_id,es_descanso)
select c.id,'Martes'::public.dia_semana,'07:50'::time,'08:40'::time,'LENGUA CASTELLANA',(select id from public.profesores where nombre_completo='PVZ48'),false
from public.cursos c where c.nombre='8vo A';
insert into public.horario_clases (curso_id,dia,hora_inicio,hora_fin,materia,profesor_id,es_descanso)
select c.id,'Miércoles'::public.dia_semana,'07:50'::time,'08:40'::time,'PROYECTO DE VIDA',(select id from public.profesores where nombre_completo='PDB48'),false
from public.cursos c where c.nombre='8vo A';
insert into public.horario_clases (curso_id,dia,hora_inicio,hora_fin,materia,profesor_id,es_descanso)
select c.id,'Jueves'::public.dia_semana,'07:50'::time,'08:40'::time,'CULTURAS RELIGIOSAS Y ESPIRITUALIDAD',(select id from public.profesores where nombre_completo='PDB48'),false
from public.cursos c where c.nombre='8vo A';
insert into public.horario_clases (curso_id,dia,hora_inicio,hora_fin,materia,profesor_id,es_descanso)
select c.id,'Viernes'::public.dia_semana,'07:50'::time,'08:40'::time,'ARITMÉTICA',(select id from public.profesores where nombre_completo='PDA8'),false
from public.cursos c where c.nombre='8vo A';
insert into public.horario_clases (curso_id,dia,hora_inicio,hora_fin,materia,profesor_id,es_descanso)
select c.id,'Lunes'::public.dia_semana,'08:40'::time,'09:30'::time,'GEOGRAFÍA',(select id from public.profesores where nombre_completo='PSF8'),false
from public.cursos c where c.nombre='8vo A';
insert into public.horario_clases (curso_id,dia,hora_inicio,hora_fin,materia,profesor_id,es_descanso)
select c.id,'Martes'::public.dia_semana,'08:40'::time,'09:30'::time,'BIOLOGÍA',(select id from public.profesores where nombre_completo='PSC8'),false
from public.cursos c where c.nombre='8vo A';
insert into public.horario_clases (curso_id,dia,hora_inicio,hora_fin,materia,profesor_id,es_descanso)
select c.id,'Miércoles'::public.dia_semana,'08:40'::time,'09:30'::time,'EDUCACIÓN FÍSICA',(select id from public.profesores where nombre_completo='PRP48'),false
from public.cursos c where c.nombre='8vo A';
insert into public.horario_clases (curso_id,dia,hora_inicio,hora_fin,materia,profesor_id,es_descanso)
select c.id,'Jueves'::public.dia_semana,'08:40'::time,'09:30'::time,'ROBÓTICA Y PROGRAMACIÓN DE VIDEOJUEGOS',(select id from public.profesores where nombre_completo='PKR48'),false
from public.cursos c where c.nombre='8vo A';
insert into public.horario_clases (curso_id,dia,hora_inicio,hora_fin,materia,profesor_id,es_descanso)
select c.id,'Viernes'::public.dia_semana,'08:40'::time,'09:30'::time,'LENGUA EXTRANJERA',(select id from public.profesores where nombre_completo='PAMO8'),false
from public.cursos c where c.nombre='8vo A';
insert into public.horario_clases (curso_id,dia,hora_inicio,hora_fin,materia,profesor_id,es_descanso)
select c.id,'Lunes'::public.dia_semana,'09:30'::time,'10:20'::time,'GEOGRAFÍA',(select id from public.profesores where nombre_completo='PSF8'),false
from public.cursos c where c.nombre='8vo A';
insert into public.horario_clases (curso_id,dia,hora_inicio,hora_fin,materia,profesor_id,es_descanso)
select c.id,'Martes'::public.dia_semana,'09:30'::time,'10:20'::time,'BIOLOGÍA',(select id from public.profesores where nombre_completo='PSC8'),false
from public.cursos c where c.nombre='8vo A';
insert into public.horario_clases (curso_id,dia,hora_inicio,hora_fin,materia,profesor_id,es_descanso)
select c.id,'Miércoles'::public.dia_semana,'09:30'::time,'10:20'::time,'EDUCACIÓN FÍSICA',(select id from public.profesores where nombre_completo='PRP48'),false
from public.cursos c where c.nombre='8vo A';
insert into public.horario_clases (curso_id,dia,hora_inicio,hora_fin,materia,profesor_id,es_descanso)
select c.id,'Jueves'::public.dia_semana,'09:30'::time,'10:20'::time,'ROBÓTICA Y PROGRAMACIÓN DE VIDEOJUEGOS',(select id from public.profesores where nombre_completo='PKR48'),false
from public.cursos c where c.nombre='8vo A';
insert into public.horario_clases (curso_id,dia,hora_inicio,hora_fin,materia,profesor_id,es_descanso)
select c.id,'Viernes'::public.dia_semana,'09:30'::time,'10:20'::time,'LENGUA EXTRANJERA',(select id from public.profesores where nombre_completo='PAMO8'),false
from public.cursos c where c.nombre='8vo A';
insert into public.horario_clases (curso_id,dia,hora_inicio,hora_fin,materia,profesor_id,es_descanso)
select c.id,'Lunes'::public.dia_semana,'10:20'::time,'11:10'::time,'DESCANSO',null,true
from public.cursos c where c.nombre='8vo A';
insert into public.horario_clases (curso_id,dia,hora_inicio,hora_fin,materia,profesor_id,es_descanso)
select c.id,'Martes'::public.dia_semana,'10:20'::time,'11:10'::time,'DESCANSO',null,true
from public.cursos c where c.nombre='8vo A';
insert into public.horario_clases (curso_id,dia,hora_inicio,hora_fin,materia,profesor_id,es_descanso)
select c.id,'Miércoles'::public.dia_semana,'10:20'::time,'11:10'::time,'DESCANSO',null,true
from public.cursos c where c.nombre='8vo A';
insert into public.horario_clases (curso_id,dia,hora_inicio,hora_fin,materia,profesor_id,es_descanso)
select c.id,'Jueves'::public.dia_semana,'10:20'::time,'11:10'::time,'DESCANSO',null,true
from public.cursos c where c.nombre='8vo A';
insert into public.horario_clases (curso_id,dia,hora_inicio,hora_fin,materia,profesor_id,es_descanso)
select c.id,'Viernes'::public.dia_semana,'10:20'::time,'11:10'::time,'DESCANSO',null,true
from public.cursos c where c.nombre='8vo A';
insert into public.horario_clases (curso_id,dia,hora_inicio,hora_fin,materia,profesor_id,es_descanso)
select c.id,'Lunes'::public.dia_semana,'11:10'::time,'12:00'::time,'LENGUA EXTRANJERA',(select id from public.profesores where nombre_completo='PAMO8'),false
from public.cursos c where c.nombre='8vo A';
insert into public.horario_clases (curso_id,dia,hora_inicio,hora_fin,materia,profesor_id,es_descanso)
select c.id,'Martes'::public.dia_semana,'11:10'::time,'12:00'::time,'QUÍMICA',(select id from public.profesores where nombre_completo='PSC8'),false
from public.cursos c where c.nombre='8vo A';
insert into public.horario_clases (curso_id,dia,hora_inicio,hora_fin,materia,profesor_id,es_descanso)
select c.id,'Miércoles'::public.dia_semana,'11:10'::time,'12:00'::time,'HISTORIA',(select id from public.profesores where nombre_completo='PSF8'),false
from public.cursos c where c.nombre='8vo A';
insert into public.horario_clases (curso_id,dia,hora_inicio,hora_fin,materia,profesor_id,es_descanso)
select c.id,'Jueves'::public.dia_semana,'11:10'::time,'12:00'::time,'GEOMETRÍA',(select id from public.profesores where nombre_completo='PDA8'),false
from public.cursos c where c.nombre='8vo A';
insert into public.horario_clases (curso_id,dia,hora_inicio,hora_fin,materia,profesor_id,es_descanso)
select c.id,'Viernes'::public.dia_semana,'11:10'::time,'12:00'::time,'CÁTEDRA DE PAZ',(select id from public.profesores where nombre_completo='PSF8'),false
from public.cursos c where c.nombre='8vo A';
insert into public.horario_clases (curso_id,dia,hora_inicio,hora_fin,materia,profesor_id,es_descanso)
select c.id,'Lunes'::public.dia_semana,'12:00'::time,'12:50'::time,'ARTES',(select id from public.profesores where nombre_completo='PAG48'),false
from public.cursos c where c.nombre='8vo A';
insert into public.horario_clases (curso_id,dia,hora_inicio,hora_fin,materia,profesor_id,es_descanso)
select c.id,'Martes'::public.dia_semana,'12:00'::time,'12:50'::time,'LENGUA EXTRANJERA',(select id from public.profesores where nombre_completo='PAMO8'),false
from public.cursos c where c.nombre='8vo A';
insert into public.horario_clases (curso_id,dia,hora_inicio,hora_fin,materia,profesor_id,es_descanso)
select c.id,'Miércoles'::public.dia_semana,'12:00'::time,'12:50'::time,'HISTORIA',(select id from public.profesores where nombre_completo='PSF8'),false
from public.cursos c where c.nombre='8vo A';
insert into public.horario_clases (curso_id,dia,hora_inicio,hora_fin,materia,profesor_id,es_descanso)
select c.id,'Jueves'::public.dia_semana,'12:00'::time,'12:50'::time,'DEMOCRACIA',(select id from public.profesores where nombre_completo='PSF8'),false
from public.cursos c where c.nombre='8vo A';
insert into public.horario_clases (curso_id,dia,hora_inicio,hora_fin,materia,profesor_id,es_descanso)
select c.id,'Viernes'::public.dia_semana,'12:00'::time,'12:50'::time,'LENGUA CASTELLANA',(select id from public.profesores where nombre_completo='PVZ48'),false
from public.cursos c where c.nombre='8vo A';
insert into public.horario_clases (curso_id,dia,hora_inicio,hora_fin,materia,profesor_id,es_descanso)
select c.id,'Lunes'::public.dia_semana,'12:50'::time,'13:30'::time,'ARTES',(select id from public.profesores where nombre_completo='PAG48'),false
from public.cursos c where c.nombre='8vo A';
insert into public.horario_clases (curso_id,dia,hora_inicio,hora_fin,materia,profesor_id,es_descanso)
select c.id,'Martes'::public.dia_semana,'12:50'::time,'13:30'::time,'LENGUA EXTRANJERA',(select id from public.profesores where nombre_completo='PAMO8'),false
from public.cursos c where c.nombre='8vo A';
insert into public.horario_clases (curso_id,dia,hora_inicio,hora_fin,materia,profesor_id,es_descanso)
select c.id,'Miércoles'::public.dia_semana,'12:50'::time,'13:30'::time,'ÁLGEBRA',(select id from public.profesores where nombre_completo='PDA8'),false
from public.cursos c where c.nombre='8vo A';
insert into public.horario_clases (curso_id,dia,hora_inicio,hora_fin,materia,profesor_id,es_descanso)
select c.id,'Jueves'::public.dia_semana,'12:50'::time,'13:30'::time,'ESTADÍSTICA',(select id from public.profesores where nombre_completo='PDA8'),false
from public.cursos c where c.nombre='8vo A';
insert into public.horario_clases (curso_id,dia,hora_inicio,hora_fin,materia,profesor_id,es_descanso)
select c.id,'Viernes'::public.dia_semana,'12:50'::time,'13:30'::time,'LENGUA CASTELLANA',(select id from public.profesores where nombre_completo='PVZ48'),false
from public.cursos c where c.nombre='8vo A';

-- CALIFICACIONES (periodos 1 y 2)
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAL4'),'ARITMÉTICA',1,4.80
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E401' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'HISTORIA',1,4.80
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E401' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PVZ48'),'LENGUA CASTELLANA',1,4.60
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E401' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PKR48'),'ROBÓTICA Y PROGRAMACIÓN DE VIDEOJUEGOS',1,4.50
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E401' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PRP48'),'EDUCACIÓN FISICA',1,4.70
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E401' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAL4'),'GEOMETRÍA',1,5.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E401' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAL4'),'ESTADISTICA',1,4.90
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E401' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDB48'),'LENGUA EXTRAJERA',1,4.70
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E401' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAL4'),'PLAN LECTOR',1,4.60
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E401' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'BIOLOGIA',1,4.50
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E401' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'GEOGRAFÍA',1,4.80
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E401' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'DEMOCRACIA',1,4.30
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E401' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'INTELIGENCIA EMOCIONAL',1,5.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E401' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'FORMACION ETICA Y CIUDADANA',1,5.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E401' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PWA4'),'CULTURAS RELIGIOSAS Y ESPIRITUALIDAD',1,4.90
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E401' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'ARTES',1,5.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E401' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,null,'CONVIVENCIA',1,4.90
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E401' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAL4'),'ARITMÉTICA',1,4.70
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E402' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'HISTORIA',1,4.70
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E402' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PVZ48'),'LENGUA CASTELLANA',1,4.40
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E402' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PKR48'),'ROBÓTICA Y PROGRAMACIÓN DE VIDEOJUEGOS',1,4.60
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E402' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PRP48'),'EDUCACIÓN FISICA',1,4.20
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E402' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAL4'),'GEOMETRÍA',1,4.90
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E402' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAL4'),'ESTADISTICA',1,4.90
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E402' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDB48'),'LENGUA EXTRAJERA',1,4.20
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E402' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAL4'),'PLAN LECTOR',1,4.30
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E402' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'BIOLOGIA',1,4.70
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E402' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'GEOGRAFÍA',1,4.70
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E402' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'DEMOCRACIA',1,4.80
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E402' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'INTELIGENCIA EMOCIONAL',1,5.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E402' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'FORMACION ETICA Y CIUDADANA',1,4.90
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E402' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PWA4'),'CULTURAS RELIGIOSAS Y ESPIRITUALIDAD',1,4.50
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E402' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'ARTES',1,4.90
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E402' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,null,'CONVIVENCIA',1,5.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E402' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAL4'),'ARITMÉTICA',1,4.10
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E403' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'HISTORIA',1,4.70
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E403' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PVZ48'),'LENGUA CASTELLANA',1,4.20
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E403' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PKR48'),'ROBÓTICA Y PROGRAMACIÓN DE VIDEOJUEGOS',1,4.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E403' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PRP48'),'EDUCACIÓN FISICA',1,4.30
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E403' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAL4'),'GEOMETRÍA',1,4.50
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E403' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAL4'),'ESTADISTICA',1,4.50
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E403' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDB48'),'LENGUA EXTRAJERA',1,4.10
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E403' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAL4'),'PLAN LECTOR',1,4.30
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E403' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'BIOLOGIA',1,4.60
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E403' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'GEOGRAFÍA',1,4.10
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E403' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'DEMOCRACIA',1,4.60
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E403' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'INTELIGENCIA EMOCIONAL',1,5.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E403' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'FORMACION ETICA Y CIUDADANA',1,4.80
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E403' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PWA4'),'CULTURAS RELIGIOSAS Y ESPIRITUALIDAD',1,4.50
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E403' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'ARTES',1,4.10
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E403' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,null,'CONVIVENCIA',1,4.90
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E403' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAL4'),'ARITMÉTICA',1,4.30
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E404' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'HISTORIA',1,4.50
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E404' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PVZ48'),'LENGUA CASTELLANA',1,4.40
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E404' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PKR48'),'ROBÓTICA Y PROGRAMACIÓN DE VIDEOJUEGOS',1,3.50
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E404' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PRP48'),'EDUCACIÓN FISICA',1,4.60
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E404' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAL4'),'GEOMETRÍA',1,4.50
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E404' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAL4'),'ESTADISTICA',1,4.40
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E404' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDB48'),'LENGUA EXTRAJERA',1,4.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E404' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAL4'),'PLAN LECTOR',1,3.80
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E404' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'BIOLOGIA',1,4.30
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E404' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'GEOGRAFÍA',1,4.20
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E404' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'DEMOCRACIA',1,4.40
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E404' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'INTELIGENCIA EMOCIONAL',1,4.40
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E404' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'FORMACION ETICA Y CIUDADANA',1,5.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E404' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PWA4'),'CULTURAS RELIGIOSAS Y ESPIRITUALIDAD',1,4.10
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E404' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'ARTES',1,4.10
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E404' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,null,'CONVIVENCIA',1,4.50
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E404' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAL4'),'ARITMÉTICA',1,4.50
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E405' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'HISTORIA',1,3.90
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E405' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PVZ48'),'LENGUA CASTELLANA',1,4.30
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E405' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PKR48'),'ROBÓTICA Y PROGRAMACIÓN DE VIDEOJUEGOS',1,4.20
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E405' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PRP48'),'EDUCACIÓN FISICA',1,4.20
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E405' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAL4'),'GEOMETRÍA',1,4.70
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E405' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAL4'),'ESTADISTICA',1,4.80
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E405' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDB48'),'LENGUA EXTRAJERA',1,4.10
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E405' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAL4'),'PLAN LECTOR',1,3.70
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E405' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'BIOLOGIA',1,4.60
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E405' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'GEOGRAFÍA',1,4.70
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E405' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'DEMOCRACIA',1,3.60
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E405' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'INTELIGENCIA EMOCIONAL',1,4.60
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E405' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'FORMACION ETICA Y CIUDADANA',1,4.10
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E405' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PWA4'),'CULTURAS RELIGIOSAS Y ESPIRITUALIDAD',1,4.40
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E405' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'ARTES',1,3.90
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E405' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,null,'CONVIVENCIA',1,5.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E405' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAL4'),'ARITMÉTICA',1,4.50
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E406' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'HISTORIA',1,5.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E406' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PVZ48'),'LENGUA CASTELLANA',1,4.30
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E406' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PKR48'),'ROBÓTICA Y PROGRAMACIÓN DE VIDEOJUEGOS',1,4.50
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E406' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PRP48'),'EDUCACIÓN FISICA',1,4.50
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E406' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAL4'),'GEOMETRÍA',1,4.80
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E406' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAL4'),'ESTADISTICA',1,4.50
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E406' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDB48'),'LENGUA EXTRAJERA',1,4.70
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E406' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAL4'),'PLAN LECTOR',1,4.50
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E406' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'BIOLOGIA',1,4.90
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E406' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'GEOGRAFÍA',1,5.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E406' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'DEMOCRACIA',1,5.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E406' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'INTELIGENCIA EMOCIONAL',1,5.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E406' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'FORMACION ETICA Y CIUDADANA',1,5.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E406' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PWA4'),'CULTURAS RELIGIOSAS Y ESPIRITUALIDAD',1,4.90
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E406' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'ARTES',1,5.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E406' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,null,'CONVIVENCIA',1,5.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E406' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAL4'),'ARITMÉTICA',1,4.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E407' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'HISTORIA',1,4.20
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E407' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PVZ48'),'LENGUA CASTELLANA',1,4.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E407' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PKR48'),'ROBÓTICA Y PROGRAMACIÓN DE VIDEOJUEGOS',1,3.90
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E407' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PRP48'),'EDUCACIÓN FISICA',1,4.60
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E407' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAL4'),'GEOMETRÍA',1,4.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E407' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAL4'),'ESTADISTICA',1,4.20
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E407' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDB48'),'LENGUA EXTRAJERA',1,4.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E407' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAL4'),'PLAN LECTOR',1,4.30
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E407' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'BIOLOGIA',1,3.90
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E407' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'GEOGRAFÍA',1,4.30
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E407' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'DEMOCRACIA',1,3.50
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E407' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'INTELIGENCIA EMOCIONAL',1,4.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E407' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'FORMACION ETICA Y CIUDADANA',1,3.50
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E407' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PWA4'),'CULTURAS RELIGIOSAS Y ESPIRITUALIDAD',1,4.50
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E407' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'ARTES',1,4.20
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E407' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,null,'CONVIVENCIA',1,4.20
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E407' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAL4'),'ARITMÉTICA',1,3.80
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E408' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'HISTORIA',1,2.50
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E408' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PVZ48'),'LENGUA CASTELLANA',1,3.40
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E408' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PKR48'),'ROBÓTICA Y PROGRAMACIÓN DE VIDEOJUEGOS',1,4.40
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E408' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PRP48'),'EDUCACIÓN FISICA',1,4.60
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E408' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAL4'),'GEOMETRÍA',1,4.60
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E408' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAL4'),'ESTADISTICA',1,4.30
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E408' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDB48'),'LENGUA EXTRAJERA',1,3.40
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E408' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAL4'),'PLAN LECTOR',1,3.70
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E408' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'BIOLOGIA',1,2.60
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E408' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'GEOGRAFÍA',1,3.60
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E408' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'DEMOCRACIA',1,2.60
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E408' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'INTELIGENCIA EMOCIONAL',1,4.40
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E408' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'FORMACION ETICA Y CIUDADANA',1,3.50
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E408' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PWA4'),'CULTURAS RELIGIOSAS Y ESPIRITUALIDAD',1,3.70
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E408' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'ARTES',1,2.70
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E408' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,null,'CONVIVENCIA',1,4.20
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E408' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAL4'),'ARITMÉTICA',1,4.40
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E409' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'HISTORIA',1,4.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E409' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PVZ48'),'LENGUA CASTELLANA',1,4.10
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E409' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PKR48'),'ROBÓTICA Y PROGRAMACIÓN DE VIDEOJUEGOS',1,4.50
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E409' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PRP48'),'EDUCACIÓN FISICA',1,4.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E409' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAL4'),'GEOMETRÍA',1,4.70
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E409' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAL4'),'ESTADISTICA',1,4.70
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E409' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDB48'),'LENGUA EXTRAJERA',1,4.50
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E409' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAL4'),'PLAN LECTOR',1,4.30
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E409' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'BIOLOGIA',1,4.30
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E409' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'GEOGRAFÍA',1,4.10
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E409' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'DEMOCRACIA',1,4.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E409' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'INTELIGENCIA EMOCIONAL',1,5.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E409' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'FORMACION ETICA Y CIUDADANA',1,4.60
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E409' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PWA4'),'CULTURAS RELIGIOSAS Y ESPIRITUALIDAD',1,3.90
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E409' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'ARTES',1,3.60
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E409' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,null,'CONVIVENCIA',1,4.50
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E409' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAL4'),'ARITMÉTICA',1,4.30
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E410' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'HISTORIA',1,4.70
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E410' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PVZ48'),'LENGUA CASTELLANA',1,4.40
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E410' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PKR48'),'ROBÓTICA Y PROGRAMACIÓN DE VIDEOJUEGOS',1,4.20
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E410' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PRP48'),'EDUCACIÓN FISICA',1,4.60
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E410' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAL4'),'GEOMETRÍA',1,4.50
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E410' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAL4'),'ESTADISTICA',1,4.30
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E410' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDB48'),'LENGUA EXTRAJERA',1,4.20
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E410' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAL4'),'PLAN LECTOR',1,4.20
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E410' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'BIOLOGIA',1,4.50
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E410' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'GEOGRAFÍA',1,4.70
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E410' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'DEMOCRACIA',1,4.70
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E410' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'INTELIGENCIA EMOCIONAL',1,5.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E410' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'FORMACION ETICA Y CIUDADANA',1,5.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E410' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PWA4'),'CULTURAS RELIGIOSAS Y ESPIRITUALIDAD',1,4.30
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E410' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'ARTES',1,4.90
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E410' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,null,'CONVIVENCIA',1,5.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E410' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAL4'),'ARITMÉTICA',1,4.50
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E411' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'HISTORIA',1,3.60
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E411' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PVZ48'),'LENGUA CASTELLANA',1,4.40
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E411' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PKR48'),'ROBÓTICA Y PROGRAMACIÓN DE VIDEOJUEGOS',1,4.50
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E411' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PRP48'),'EDUCACIÓN FISICA',1,4.40
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E411' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAL4'),'GEOMETRÍA',1,4.80
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E411' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAL4'),'ESTADISTICA',1,4.90
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E411' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDB48'),'LENGUA EXTRAJERA',1,4.30
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E411' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAL4'),'PLAN LECTOR',1,4.40
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E411' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'BIOLOGIA',1,3.90
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E411' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'GEOGRAFÍA',1,4.20
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E411' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'DEMOCRACIA',1,3.70
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E411' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'INTELIGENCIA EMOCIONAL',1,5.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E411' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'FORMACION ETICA Y CIUDADANA',1,4.30
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E411' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PWA4'),'CULTURAS RELIGIOSAS Y ESPIRITUALIDAD',1,5.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E411' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'ARTES',1,3.90
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E411' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,null,'CONVIVENCIA',1,4.50
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E411' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAL4'),'ARITMÉTICA',1,4.40
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E412' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'HISTORIA',1,4.60
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E412' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PVZ48'),'LENGUA CASTELLANA',1,4.60
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E412' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PKR48'),'ROBÓTICA Y PROGRAMACIÓN DE VIDEOJUEGOS',1,4.50
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E412' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PRP48'),'EDUCACIÓN FISICA',1,4.60
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E412' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAL4'),'GEOMETRÍA',1,4.90
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E412' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAL4'),'ESTADISTICA',1,4.40
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E412' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDB48'),'LENGUA EXTRAJERA',1,4.30
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E412' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAL4'),'PLAN LECTOR',1,4.30
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E412' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'BIOLOGIA',1,4.30
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E412' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'GEOGRAFÍA',1,4.90
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E412' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'DEMOCRACIA',1,4.50
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E412' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'INTELIGENCIA EMOCIONAL',1,4.40
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E412' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'FORMACION ETICA Y CIUDADANA',1,4.80
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E412' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PWA4'),'CULTURAS RELIGIOSAS Y ESPIRITUALIDAD',1,4.70
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E412' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'ARTES',1,3.80
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E412' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,null,'CONVIVENCIA',1,5.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E412' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAL4'),'ARITMETICA',2,4.50
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E401' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'HISTORIA',2,3.80
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E401' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PVZ48'),'LENGUA CASTELLANA',2,4.80
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E401' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PKR48'),'ROBOTICA Y PROGRAMACION DE VIDEOJUEGOS',2,4.10
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E401' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PRP48'),'EDUCACION FISICA',2,4.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E401' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAL4'),'GEOMETRIA',2,4.80
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E401' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAL4'),'ESTADISTICA',2,4.70
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E401' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDB48'),'LENGUA EXTRAJERA',2,4.60
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E401' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAL4'),'PLAN LECTOR',2,4.50
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E401' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'BIOLOGIA',2,4.70
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E401' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'GEOGRAFIA',2,4.60
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E401' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'DEMOCRACIA',2,4.50
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E401' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'INTELIGENCIA EMOCIONAL',2,5.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E401' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'FORMACION ETICA Y CIUDADANA',2,4.80
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E401' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PWA4'),'CULTURAS RELIGIOSAS Y ESPIRITUALIDAD',2,4.90
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E401' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'ARTES',2,5.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E401' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,null,'CONVIVENCIA',2,4.80
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E401' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAL4'),'ARITMETICA',2,4.50
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E402' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'HISTORIA',2,5.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E402' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PVZ48'),'LENGUA CASTELLANA',2,4.40
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E402' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PKR48'),'ROBOTICA Y PROGRAMACION DE VIDEOJUEGOS',2,4.30
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E402' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PRP48'),'EDUCACION FISICA',2,4.50
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E402' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAL4'),'GEOMETRIA',2,4.50
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E402' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAL4'),'ESTADISTICA',2,4.40
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E402' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDB48'),'LENGUA EXTRAJERA',2,4.30
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E402' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAL4'),'PLAN LECTOR',2,4.50
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E402' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'BIOLOGIA',2,4.60
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E402' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'GEOGRAFIA',2,4.30
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E402' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'DEMOCRACIA',2,4.70
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E402' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'INTELIGENCIA EMOCIONAL',2,5.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E402' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'FORMACION ETICA Y CIUDADANA',2,4.90
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E402' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PWA4'),'CULTURAS RELIGIOSAS Y ESPIRITUALIDAD',2,4.90
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E402' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'ARTES',2,4.90
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E402' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,null,'CONVIVENCIA',2,5.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E402' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAL4'),'ARITMETICA',2,4.10
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E403' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'HISTORIA',2,4.70
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E403' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PVZ48'),'LENGUA CASTELLANA',2,4.40
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E403' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PKR48'),'ROBOTICA Y PROGRAMACION DE VIDEOJUEGOS',2,4.40
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E403' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PRP48'),'EDUCACION FISICA',2,4.10
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E403' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAL4'),'GEOMETRIA',2,4.20
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E403' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAL4'),'ESTADISTICA',2,4.20
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E403' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDB48'),'LENGUA EXTRAJERA',2,3.50
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E403' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAL4'),'PLAN LECTOR',2,4.40
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E403' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'BIOLOGIA',2,4.50
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E403' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'GEOGRAFIA',2,3.50
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E403' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'DEMOCRACIA',2,3.90
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E403' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'INTELIGENCIA EMOCIONAL',2,5.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E403' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'FORMACION ETICA Y CIUDADANA',2,4.50
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E403' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PWA4'),'CULTURAS RELIGIOSAS Y ESPIRITUALIDAD',2,4.90
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E403' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'ARTES',2,4.90
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E403' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,null,'CONVIVENCIA',2,5.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E403' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAL4'),'ARITMETICA',2,4.30
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E404' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'HISTORIA',2,4.90
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E404' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PVZ48'),'LENGUA CASTELLANA',2,4.50
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E404' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PKR48'),'ROBOTICA Y PROGRAMACION DE VIDEOJUEGOS',2,3.90
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E404' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PRP48'),'EDUCACION FISICA',2,4.20
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E404' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAL4'),'GEOMETRIA',2,4.40
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E404' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAL4'),'ESTADISTICA',2,4.30
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E404' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDB48'),'LENGUA EXTRAJERA',2,4.20
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E404' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAL4'),'PLAN LECTOR',2,4.50
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E404' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'BIOLOGIA',2,4.20
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E404' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'GEOGRAFIA',2,4.60
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E404' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'DEMOCRACIA',2,4.60
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E404' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'INTELIGENCIA EMOCIONAL',2,5.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E404' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'FORMACION ETICA Y CIUDADANA',2,4.20
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E404' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PWA4'),'CULTURAS RELIGIOSAS Y ESPIRITUALIDAD',2,4.90
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E404' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'ARTES',2,4.70
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E404' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,null,'CONVIVENCIA',2,4.90
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E404' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAL4'),'ARITMETICA',2,3.90
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E405' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'HISTORIA',2,3.80
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E405' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PVZ48'),'LENGUA CASTELLANA',2,3.90
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E405' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PKR48'),'ROBOTICA Y PROGRAMACION DE VIDEOJUEGOS',2,3.60
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E405' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PRP48'),'EDUCACION FISICA',2,4.10
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E405' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAL4'),'GEOMETRIA',2,4.10
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E405' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAL4'),'ESTADISTICA',2,3.90
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E405' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDB48'),'LENGUA EXTRAJERA',2,4.10
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E405' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAL4'),'PLAN LECTOR',2,4.10
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E405' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'BIOLOGIA',2,4.10
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E405' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'GEOGRAFIA',2,3.90
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E405' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'DEMOCRACIA',2,4.10
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E405' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'INTELIGENCIA EMOCIONAL',2,5.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E405' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'FORMACION ETICA Y CIUDADANA',2,3.80
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E405' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PWA4'),'CULTURAS RELIGIOSAS Y ESPIRITUALIDAD',2,4.60
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E405' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'ARTES',2,4.40
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E405' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,null,'CONVIVENCIA',2,4.80
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E405' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAL4'),'ARITMETICA',2,4.10
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E406' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'HISTORIA',2,4.80
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E406' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PVZ48'),'LENGUA CASTELLANA',2,4.80
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E406' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PKR48'),'ROBOTICA Y PROGRAMACION DE VIDEOJUEGOS',2,4.20
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E406' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PRP48'),'EDUCACION FISICA',2,4.10
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E406' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAL4'),'GEOMETRIA',2,4.10
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E406' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAL4'),'ESTADISTICA',2,4.10
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E406' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDB48'),'LENGUA EXTRAJERA',2,4.70
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E406' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAL4'),'PLAN LECTOR',2,4.10
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E406' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'BIOLOGIA',2,5.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E406' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'GEOGRAFIA',2,4.80
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E406' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'DEMOCRACIA',2,4.80
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E406' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'INTELIGENCIA EMOCIONAL',2,5.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E406' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'FORMACION ETICA Y CIUDADANA',2,5.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E406' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PWA4'),'CULTURAS RELIGIOSAS Y ESPIRITUALIDAD',2,5.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E406' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'ARTES',2,4.90
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E406' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,null,'CONVIVENCIA',2,5.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E406' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAL4'),'ARITMETICA',2,3.70
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E407' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'HISTORIA',2,4.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E407' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PVZ48'),'LENGUA CASTELLANA',2,3.90
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E407' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PKR48'),'ROBOTICA Y PROGRAMACION DE VIDEOJUEGOS',2,4.30
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E407' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PRP48'),'EDUCACION FISICA',2,4.30
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E407' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAL4'),'GEOMETRIA',2,4.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E407' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAL4'),'ESTADISTICA',2,3.80
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E407' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDB48'),'LENGUA EXTRAJERA',2,3.50
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E407' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAL4'),'PLAN LECTOR',2,4.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E407' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'BIOLOGIA',2,4.10
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E407' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'GEOGRAFIA',2,4.10
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E407' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'DEMOCRACIA',2,4.10
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E407' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'INTELIGENCIA EMOCIONAL',2,5.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E407' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'FORMACION ETICA Y CIUDADANA',2,1.40
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E407' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PWA4'),'CULTURAS RELIGIOSAS Y ESPIRITUALIDAD',2,4.10
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E407' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'ARTES',2,4.30
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E407' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,null,'CONVIVENCIA',2,4.20
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E407' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAL4'),'ARITMETICA',2,3.40
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E408' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'HISTORIA',2,4.30
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E408' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PVZ48'),'LENGUA CASTELLANA',2,4.30
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E408' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PKR48'),'ROBOTICA Y PROGRAMACION DE VIDEOJUEGOS',2,4.50
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E408' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PRP48'),'EDUCACION FISICA',2,4.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E408' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAL4'),'GEOMETRIA',2,3.70
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E408' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAL4'),'ESTADISTICA',2,4.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E408' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDB48'),'LENGUA EXTRAJERA',2,3.50
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E408' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAL4'),'PLAN LECTOR',2,4.10
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E408' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'BIOLOGIA',2,3.70
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E408' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'GEOGRAFIA',2,3.90
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E408' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'DEMOCRACIA',2,4.10
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E408' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'INTELIGENCIA EMOCIONAL',2,5.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E408' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'FORMACION ETICA Y CIUDADANA',2,4.20
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E408' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PWA4'),'CULTURAS RELIGIOSAS Y ESPIRITUALIDAD',2,4.20
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E408' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'ARTES',2,4.60
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E408' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,null,'CONVIVENCIA',2,4.80
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E408' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAL4'),'ARITMETICA',2,4.40
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E409' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'HISTORIA',2,4.60
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E409' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PVZ48'),'LENGUA CASTELLANA',2,4.60
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E409' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PKR48'),'ROBOTICA Y PROGRAMACION DE VIDEOJUEGOS',2,3.50
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E409' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PRP48'),'EDUCACION FISICA',2,4.10
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E409' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAL4'),'GEOMETRIA',2,3.50
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E409' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAL4'),'ESTADISTICA',2,4.50
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E409' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDB48'),'LENGUA EXTRAJERA',2,4.50
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E409' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAL4'),'PLAN LECTOR',2,4.20
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E409' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'BIOLOGIA',2,4.50
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E409' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'GEOGRAFIA',2,4.60
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E409' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'DEMOCRACIA',2,4.70
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E409' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'INTELIGENCIA EMOCIONAL',2,5.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E409' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'FORMACION ETICA Y CIUDADANA',2,3.60
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E409' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PWA4'),'CULTURAS RELIGIOSAS Y ESPIRITUALIDAD',2,3.90
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E409' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'ARTES',2,3.90
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E409' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,null,'CONVIVENCIA',2,4.20
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E409' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAL4'),'ARITMETICA',2,4.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E410' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'HISTORIA',2,4.90
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E410' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PVZ48'),'LENGUA CASTELLANA',2,4.50
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E410' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PKR48'),'ROBOTICA Y PROGRAMACION DE VIDEOJUEGOS',2,4.30
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E410' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PRP48'),'EDUCACION FISICA',2,4.70
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E410' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAL4'),'GEOMETRIA',2,4.20
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E410' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAL4'),'ESTADISTICA',2,4.10
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E410' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDB48'),'LENGUA EXTRAJERA',2,3.90
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E410' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAL4'),'PLAN LECTOR',2,4.10
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E410' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'BIOLOGIA',2,4.80
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E410' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'GEOGRAFIA',2,4.60
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E410' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'DEMOCRACIA',2,4.90
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E410' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'INTELIGENCIA EMOCIONAL',2,5.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E410' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'FORMACION ETICA Y CIUDADANA',2,5.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E410' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PWA4'),'CULTURAS RELIGIOSAS Y ESPIRITUALIDAD',2,4.70
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E410' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'ARTES',2,4.60
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E410' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,null,'CONVIVENCIA',2,4.60
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E410' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAL4'),'ARITMETICA',2,4.50
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E411' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'HISTORIA',2,4.80
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E411' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PVZ48'),'LENGUA CASTELLANA',2,4.70
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E411' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PKR48'),'ROBOTICA Y PROGRAMACION DE VIDEOJUEGOS',2,4.20
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E411' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PRP48'),'EDUCACION FISICA',2,4.30
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E411' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAL4'),'GEOMETRIA',2,4.40
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E411' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAL4'),'ESTADISTICA',2,4.50
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E411' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDB48'),'LENGUA EXTRAJERA',2,4.30
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E411' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAL4'),'PLAN LECTOR',2,4.50
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E411' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'BIOLOGIA',2,3.70
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E411' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'GEOGRAFIA',2,4.40
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E411' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'DEMOCRACIA',2,4.50
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E411' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'INTELIGENCIA EMOCIONAL',2,4.40
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E411' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'FORMACION ETICA Y CIUDADANA',2,4.40
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E411' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PWA4'),'CULTURAS RELIGIOSAS Y ESPIRITUALIDAD',2,3.90
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E411' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'ARTES',2,4.70
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E411' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,null,'CONVIVENCIA',2,3.70
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E411' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAL4'),'ARITMETICA',2,3.80
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E412' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'HISTORIA',2,4.80
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E412' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PVZ48'),'LENGUA CASTELLANA',2,4.50
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E412' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PKR48'),'ROBOTICA Y PROGRAMACION DE VIDEOJUEGOS',2,4.40
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E412' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PRP48'),'EDUCACION FISICA',2,4.50
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E412' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAL4'),'GEOMETRIA',2,3.90
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E412' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAL4'),'ESTADISTICA',2,4.10
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E412' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDB48'),'LENGUA EXTRAJERA',2,4.70
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E412' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAL4'),'PLAN LECTOR',2,4.20
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E412' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'BIOLOGIA',2,4.70
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E412' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'GEOGRAFIA',2,4.90
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E412' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'DEMOCRACIA',2,4.80
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E412' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'INTELIGENCIA EMOCIONAL',2,5.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E412' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'FORMACION ETICA Y CIUDADANA',2,5.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E412' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PWA4'),'CULTURAS RELIGIOSAS Y ESPIRITUALIDAD',2,4.90
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E412' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'ARTES',2,4.10
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E412' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,null,'CONVIVENCIA',2,4.20
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E412' and c.nombre='4to A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PRP48'),'EDUCACIÓN FISICA',1,4.30
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E801' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'ARITMETICA',1,4.50
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E801' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSF8'),'HISTORIA',1,4.40
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E801' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PVZ48'),'LENGUA CASTELLANA',1,4.30
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E801' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PKR48'),'ROBOTICA Y PROGRAMACION DE VIDEOJUEGOS',1,4.80
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E801' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'GEOMETRIA',1,4.70
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E801' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'ESTADISTICA',1,4.70
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E801' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAMO8'),'LENGUA EXTRAJERA',1,4.40
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E801' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSC8'),'PLAN LECTOR',1,4.70
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E801' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSC8'),'BIOLOGIA',1,4.70
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E801' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSC8'),'QUIMICA',1,4.30
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E801' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSF8'),'GEOGRAFIA',1,4.50
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E801' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSF8'),'DEMOCRACIA',1,4.80
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E801' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSF8'),'CATEDRA DE PAZ',1,4.80
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E801' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'INTELIGENCIA EMOCIONAL',1,4.80
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E801' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'FORMACION ETICA Y CIUDADANA',1,4.30
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E801' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDB48'),'CULTURAS RELIGIOSAS Y ESPIRITUALIDAD',1,4.50
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E801' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDB48'),'PROYECTO DE VIDA',1,4.90
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E801' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,null,'ÃLGEBRA',1,4.40
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E801' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'ARTES',1,4.10
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E801' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,null,'CONVIVENCIA',1,4.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E801' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PRP48'),'EDUCACIÓN FISICA',1,3.80
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E802' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'ARITMETICA',1,3.90
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E802' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSF8'),'HISTORIA',1,3.60
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E802' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PVZ48'),'LENGUA CASTELLANA',1,4.40
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E802' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PKR48'),'ROBOTICA Y PROGRAMACION DE VIDEOJUEGOS',1,3.50
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E802' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'GEOMETRIA',1,4.30
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E802' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'ESTADISTICA',1,4.30
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E802' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAMO8'),'LENGUA EXTRAJERA',1,4.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E802' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSC8'),'PLAN LECTOR',1,4.80
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E802' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSC8'),'BIOLOGIA',1,4.80
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E802' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSC8'),'QUIMICA',1,4.50
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E802' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSF8'),'GEOGRAFIA',1,4.20
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E802' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSF8'),'DEMOCRACIA',1,4.50
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E802' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSF8'),'CATEDRA DE PAZ',1,3.70
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E802' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'INTELIGENCIA EMOCIONAL',1,4.70
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E802' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'FORMACION ETICA Y CIUDADANA',1,4.10
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E802' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDB48'),'CULTURAS RELIGIOSAS Y ESPIRITUALIDAD',1,2.80
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E802' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDB48'),'PROYECTO DE VIDA',1,2.90
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E802' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,null,'ÃLGEBRA',1,4.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E802' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'ARTES',1,3.60
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E802' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,null,'CONVIVENCIA',1,4.20
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E802' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PRP48'),'EDUCACIÓN FISICA',1,0.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E803' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'ARITMETICA',1,0.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E803' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSF8'),'HISTORIA',1,0.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E803' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PVZ48'),'LENGUA CASTELLANA',1,0.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E803' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PKR48'),'ROBOTICA Y PROGRAMACION DE VIDEOJUEGOS',1,4.20
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E803' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'GEOMETRIA',1,0.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E803' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'ESTADISTICA',1,0.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E803' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAMO8'),'LENGUA EXTRAJERA',1,0.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E803' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSC8'),'PLAN LECTOR',1,0.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E803' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSC8'),'BIOLOGIA',1,0.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E803' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSC8'),'QUIMICA',1,0.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E803' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSF8'),'GEOGRAFIA',1,0.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E803' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSF8'),'DEMOCRACIA',1,0.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E803' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSF8'),'CATEDRA DE PAZ',1,0.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E803' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'INTELIGENCIA EMOCIONAL',1,0.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E803' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'FORMACION ETICA Y CIUDADANA',1,0.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E803' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDB48'),'CULTURAS RELIGIOSAS Y ESPIRITUALIDAD',1,0.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E803' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDB48'),'PROYECTO DE VIDA',1,0.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E803' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,null,'ÃLGEBRA',1,0.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E803' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'ARTES',1,0.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E803' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,null,'CONVIVENCIA',1,0.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E803' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PRP48'),'EDUCACIÓN FISICA',1,4.10
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E804' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'ARITMETICA',1,4.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E804' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSF8'),'HISTORIA',1,3.70
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E804' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PVZ48'),'LENGUA CASTELLANA',1,4.10
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E804' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PKR48'),'ROBOTICA Y PROGRAMACION DE VIDEOJUEGOS',1,4.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E804' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'GEOMETRIA',1,3.90
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E804' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'ESTADISTICA',1,4.10
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E804' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAMO8'),'LENGUA EXTRAJERA',1,4.10
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E804' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSC8'),'PLAN LECTOR',1,4.40
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E804' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSC8'),'BIOLOGIA',1,4.30
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E804' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSC8'),'QUIMICA',1,4.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E804' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSF8'),'GEOGRAFIA',1,3.50
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E804' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSF8'),'DEMOCRACIA',1,3.80
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E804' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSF8'),'CATEDRA DE PAZ',1,4.10
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E804' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'INTELIGENCIA EMOCIONAL',1,4.10
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E804' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'FORMACION ETICA Y CIUDADANA',1,4.20
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E804' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDB48'),'CULTURAS RELIGIOSAS Y ESPIRITUALIDAD',1,4.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E804' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDB48'),'PROYECTO DE VIDA',1,4.10
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E804' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,null,'ÃLGEBRA',1,4.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E804' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'ARTES',1,4.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E804' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,null,'CONVIVENCIA',1,3.80
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E804' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PRP48'),'EDUCACIÓN FISICA',1,4.10
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E805' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'ARITMETICA',1,3.80
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E805' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSF8'),'HISTORIA',1,3.50
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E805' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PVZ48'),'LENGUA CASTELLANA',1,3.80
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E805' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PKR48'),'ROBOTICA Y PROGRAMACION DE VIDEOJUEGOS',1,3.70
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E805' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'GEOMETRIA',1,4.20
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E805' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'ESTADISTICA',1,4.60
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E805' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAMO8'),'LENGUA EXTRAJERA',1,3.80
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E805' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSC8'),'PLAN LECTOR',1,4.80
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E805' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSC8'),'BIOLOGIA',1,3.80
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E805' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSC8'),'QUIMICA',1,4.20
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E805' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSF8'),'GEOGRAFIA',1,2.90
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E805' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSF8'),'DEMOCRACIA',1,3.60
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E805' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSF8'),'CATEDRA DE PAZ',1,4.10
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E805' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'INTELIGENCIA EMOCIONAL',1,4.30
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E805' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'FORMACION ETICA Y CIUDADANA',1,4.20
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E805' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDB48'),'CULTURAS RELIGIOSAS Y ESPIRITUALIDAD',1,3.90
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E805' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDB48'),'PROYECTO DE VIDA',1,4.30
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E805' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,null,'ÃLGEBRA',1,3.80
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E805' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'ARTES',1,3.50
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E805' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,null,'CONVIVENCIA',1,4.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E805' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PRP48'),'EDUCACIÓN FISICA',1,4.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E806' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'ARITMETICA',1,4.60
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E806' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSF8'),'HISTORIA',1,4.90
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E806' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PVZ48'),'LENGUA CASTELLANA',1,4.10
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E806' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PKR48'),'ROBOTICA Y PROGRAMACION DE VIDEOJUEGOS',1,4.60
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E806' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'GEOMETRIA',1,4.80
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E806' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'ESTADISTICA',1,5.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E806' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAMO8'),'LENGUA EXTRAJERA',1,4.80
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E806' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSC8'),'PLAN LECTOR',1,5.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E806' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSC8'),'BIOLOGIA',1,4.70
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E806' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSC8'),'QUIMICA',1,4.70
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E806' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSF8'),'GEOGRAFIA',1,4.90
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E806' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSF8'),'DEMOCRACIA',1,4.90
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E806' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSF8'),'CATEDRA DE PAZ',1,4.90
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E806' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'INTELIGENCIA EMOCIONAL',1,4.70
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E806' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'FORMACION ETICA Y CIUDADANA',1,4.40
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E806' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDB48'),'CULTURAS RELIGIOSAS Y ESPIRITUALIDAD',1,5.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E806' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDB48'),'PROYECTO DE VIDA',1,4.80
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E806' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,null,'ÃLGEBRA',1,4.80
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E806' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'ARTES',1,4.10
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E806' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,null,'CONVIVENCIA',1,3.90
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E806' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PRP48'),'EDUCACIÓN FISICA',1,5.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E807' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'ARITMETICA',1,3.80
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E807' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSF8'),'HISTORIA',1,3.50
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E807' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PVZ48'),'LENGUA CASTELLANA',1,3.60
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E807' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PKR48'),'ROBOTICA Y PROGRAMACION DE VIDEOJUEGOS',1,3.80
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E807' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'GEOMETRIA',1,4.20
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E807' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'ESTADISTICA',1,4.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E807' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAMO8'),'LENGUA EXTRAJERA',1,3.50
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E807' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSC8'),'PLAN LECTOR',1,3.60
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E807' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSC8'),'BIOLOGIA',1,4.20
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E807' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSC8'),'QUIMICA',1,3.90
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E807' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSF8'),'GEOGRAFIA',1,3.50
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E807' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSF8'),'DEMOCRACIA',1,3.90
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E807' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSF8'),'CATEDRA DE PAZ',1,3.50
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E807' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'INTELIGENCIA EMOCIONAL',1,4.40
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E807' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'FORMACION ETICA Y CIUDADANA',1,3.90
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E807' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDB48'),'CULTURAS RELIGIOSAS Y ESPIRITUALIDAD',1,3.80
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E807' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDB48'),'PROYECTO DE VIDA',1,4.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E807' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,null,'ÃLGEBRA',1,3.80
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E807' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'ARTES',1,3.50
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E807' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,null,'CONVIVENCIA',1,2.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E807' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PRP48'),'EDUCACIÓN FISICA',1,3.50
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E808' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'ARITMETICA',1,4.20
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E808' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSF8'),'HISTORIA',1,4.80
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E808' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PVZ48'),'LENGUA CASTELLANA',1,4.40
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E808' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PKR48'),'ROBOTICA Y PROGRAMACION DE VIDEOJUEGOS',1,4.80
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E808' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'GEOMETRIA',1,4.50
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E808' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'ESTADISTICA',1,4.70
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E808' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAMO8'),'LENGUA EXTRAJERA',1,4.20
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E808' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSC8'),'PLAN LECTOR',1,5.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E808' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSC8'),'BIOLOGIA',1,4.50
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E808' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSC8'),'QUIMICA',1,4.40
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E808' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSF8'),'GEOGRAFIA',1,4.80
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E808' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSF8'),'DEMOCRACIA',1,4.80
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E808' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSF8'),'CATEDRA DE PAZ',1,4.80
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E808' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'INTELIGENCIA EMOCIONAL',1,4.50
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E808' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'FORMACION ETICA Y CIUDADANA',1,4.60
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E808' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDB48'),'CULTURAS RELIGIOSAS Y ESPIRITUALIDAD',1,4.50
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E808' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDB48'),'PROYECTO DE VIDA',1,4.70
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E808' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,null,'ÃLGEBRA',1,4.30
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E808' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'ARTES',1,4.60
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E808' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,null,'CONVIVENCIA',1,4.70
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E808' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PRP48'),'EDUCACIÓN FISICA',1,4.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E809' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'ARITMETICA',1,4.10
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E809' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSF8'),'HISTORIA',1,4.10
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E809' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PVZ48'),'LENGUA CASTELLANA',1,4.20
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E809' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PKR48'),'ROBOTICA Y PROGRAMACION DE VIDEOJUEGOS',1,4.50
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E809' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'GEOMETRIA',1,4.80
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E809' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'ESTADISTICA',1,4.90
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E809' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAMO8'),'LENGUA EXTRAJERA',1,4.20
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E809' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSC8'),'PLAN LECTOR',1,4.40
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E809' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSC8'),'BIOLOGIA',1,4.70
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E809' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSC8'),'QUIMICA',1,4.10
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E809' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSF8'),'GEOGRAFIA',1,4.50
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E809' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSF8'),'DEMOCRACIA',1,4.70
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E809' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSF8'),'CATEDRA DE PAZ',1,4.70
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E809' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'INTELIGENCIA EMOCIONAL',1,4.10
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E809' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'FORMACION ETICA Y CIUDADANA',1,4.70
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E809' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDB48'),'CULTURAS RELIGIOSAS Y ESPIRITUALIDAD',1,4.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E809' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDB48'),'PROYECTO DE VIDA',1,4.30
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E809' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,null,'ÃLGEBRA',1,4.70
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E809' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'ARTES',1,3.70
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E809' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,null,'CONVIVENCIA',1,4.90
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E809' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PRP48'),'EDUCACIÓN FISICA',1,4.10
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E810' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'ARITMETICA',1,4.30
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E810' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSF8'),'HISTORIA',1,4.30
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E810' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PVZ48'),'LENGUA CASTELLANA',1,4.30
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E810' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PKR48'),'ROBOTICA Y PROGRAMACION DE VIDEOJUEGOS',1,4.70
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E810' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'GEOMETRIA',1,4.70
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E810' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'ESTADISTICA',1,4.90
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E810' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAMO8'),'LENGUA EXTRAJERA',1,4.20
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E810' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSC8'),'PLAN LECTOR',1,5.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E810' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSC8'),'BIOLOGIA',1,4.30
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E810' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSC8'),'QUIMICA',1,4.80
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E810' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSF8'),'GEOGRAFIA',1,3.80
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E810' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSF8'),'DEMOCRACIA',1,4.80
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E810' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSF8'),'CATEDRA DE PAZ',1,4.80
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E810' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'INTELIGENCIA EMOCIONAL',1,4.90
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E810' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'FORMACION ETICA Y CIUDADANA',1,4.60
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E810' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDB48'),'CULTURAS RELIGIOSAS Y ESPIRITUALIDAD',1,4.80
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E810' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDB48'),'PROYECTO DE VIDA',1,4.80
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E810' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,null,'ÃLGEBRA',1,4.50
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E810' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'ARTES',1,4.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E810' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,null,'CONVIVENCIA',1,4.80
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E810' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PRP48'),'EDUCACIÓN FISICA',1,4.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E811' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'ARITMETICA',1,4.60
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E811' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSF8'),'HISTORIA',1,4.20
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E811' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PVZ48'),'LENGUA CASTELLANA',1,4.10
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E811' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PKR48'),'ROBOTICA Y PROGRAMACION DE VIDEOJUEGOS',1,4.20
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E811' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'GEOMETRIA',1,4.90
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E811' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'ESTADISTICA',1,5.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E811' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAMO8'),'LENGUA EXTRAJERA',1,4.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E811' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSC8'),'PLAN LECTOR',1,4.50
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E811' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSC8'),'BIOLOGIA',1,3.90
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E811' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSC8'),'QUIMICA',1,4.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E811' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSF8'),'GEOGRAFIA',1,4.30
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E811' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSF8'),'DEMOCRACIA',1,4.70
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E811' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSF8'),'CATEDRA DE PAZ',1,4.70
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E811' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'INTELIGENCIA EMOCIONAL',1,4.70
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E811' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'FORMACION ETICA Y CIUDADANA',1,4.70
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E811' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDB48'),'CULTURAS RELIGIOSAS Y ESPIRITUALIDAD',1,5.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E811' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDB48'),'PROYECTO DE VIDA',1,4.60
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E811' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,null,'ÃLGEBRA',1,4.60
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E811' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'ARTES',1,4.20
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E811' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,null,'CONVIVENCIA',1,3.90
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E811' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PRP48'),'EDUCACIÓN FISICA',1,3.80
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E812' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'ARITMETICA',1,3.70
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E812' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSF8'),'HISTORIA',1,3.70
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E812' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PVZ48'),'LENGUA CASTELLANA',1,3.70
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E812' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PKR48'),'ROBOTICA Y PROGRAMACION DE VIDEOJUEGOS',1,4.10
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E812' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'GEOMETRIA',1,4.80
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E812' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'ESTADISTICA',1,4.80
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E812' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAMO8'),'LENGUA EXTRAJERA',1,3.60
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E812' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSC8'),'PLAN LECTOR',1,3.80
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E812' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSC8'),'BIOLOGIA',1,4.10
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E812' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSC8'),'QUIMICA',1,4.20
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E812' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSF8'),'GEOGRAFIA',1,3.70
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E812' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSF8'),'DEMOCRACIA',1,4.30
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E812' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSF8'),'CATEDRA DE PAZ',1,3.70
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E812' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'INTELIGENCIA EMOCIONAL',1,4.80
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E812' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'FORMACION ETICA Y CIUDADANA',1,4.30
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E812' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDB48'),'CULTURAS RELIGIOSAS Y ESPIRITUALIDAD',1,5.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E812' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDB48'),'PROYECTO DE VIDA',1,4.90
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E812' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,null,'ÃLGEBRA',1,3.90
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E812' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'ARTES',1,3.70
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E812' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,null,'CONVIVENCIA',1,3.50
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E812' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PRP48'),'EDUCACIÓN FISICA',1,3.70
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E813' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'ARITMETICA',1,4.30
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E813' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSF8'),'HISTORIA',1,4.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E813' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PVZ48'),'LENGUA CASTELLANA',1,3.80
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E813' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PKR48'),'ROBOTICA Y PROGRAMACION DE VIDEOJUEGOS',1,4.20
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E813' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'GEOMETRIA',1,4.30
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E813' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'ESTADISTICA',1,4.20
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E813' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAMO8'),'LENGUA EXTRAJERA',1,4.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E813' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSC8'),'PLAN LECTOR',1,4.90
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E813' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSC8'),'BIOLOGIA',1,4.30
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E813' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSC8'),'QUIMICA',1,4.40
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E813' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSF8'),'GEOGRAFIA',1,4.30
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E813' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSF8'),'DEMOCRACIA',1,4.10
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E813' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSF8'),'CATEDRA DE PAZ',1,4.60
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E813' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'INTELIGENCIA EMOCIONAL',1,4.60
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E813' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'FORMACION ETICA Y CIUDADANA',1,4.40
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E813' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDB48'),'CULTURAS RELIGIOSAS Y ESPIRITUALIDAD',1,3.80
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E813' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDB48'),'PROYECTO DE VIDA',1,3.50
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E813' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,null,'ÃLGEBRA',1,3.90
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E813' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'ARTES',1,3.50
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E813' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,null,'CONVIVENCIA',1,4.10
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E813' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PRP48'),'EDUCACIÓN FISICA',1,4.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E814' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'ARITMETICA',1,3.90
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E814' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSF8'),'HISTORIA',1,4.50
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E814' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PVZ48'),'LENGUA CASTELLANA',1,3.80
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E814' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PKR48'),'ROBOTICA Y PROGRAMACION DE VIDEOJUEGOS',1,4.10
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E814' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'GEOMETRIA',1,4.30
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E814' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'ESTADISTICA',1,4.60
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E814' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAMO8'),'LENGUA EXTRAJERA',1,4.30
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E814' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSC8'),'PLAN LECTOR',1,4.20
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E814' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSC8'),'BIOLOGIA',1,4.70
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E814' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSC8'),'QUIMICA',1,4.40
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E814' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSF8'),'GEOGRAFIA',1,4.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E814' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSF8'),'DEMOCRACIA',1,4.70
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E814' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSF8'),'CATEDRA DE PAZ',1,4.70
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E814' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'INTELIGENCIA EMOCIONAL',1,4.70
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E814' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'FORMACION ETICA Y CIUDADANA',1,4.40
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E814' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDB48'),'CULTURAS RELIGIOSAS Y ESPIRITUALIDAD',1,4.30
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E814' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDB48'),'PROYECTO DE VIDA',1,3.80
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E814' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,null,'ÃLGEBRA',1,3.60
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E814' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'ARTES',1,4.10
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E814' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,null,'CONVIVENCIA',1,4.50
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E814' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PRP48'),'EDUCACIÓN FISICA',1,4.10
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E815' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'ARITMETICA',1,4.60
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E815' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSF8'),'HISTORIA',1,4.70
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E815' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PVZ48'),'LENGUA CASTELLANA',1,4.60
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E815' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PKR48'),'ROBOTICA Y PROGRAMACION DE VIDEOJUEGOS',1,4.30
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E815' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'GEOMETRIA',1,4.90
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E815' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'ESTADISTICA',1,5.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E815' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAMO8'),'LENGUA EXTRAJERA',1,4.10
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E815' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSC8'),'PLAN LECTOR',1,4.90
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E815' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSC8'),'BIOLOGIA',1,4.50
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E815' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSC8'),'QUIMICA',1,4.30
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E815' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSF8'),'GEOGRAFIA',1,4.70
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E815' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSF8'),'DEMOCRACIA',1,4.70
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E815' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSF8'),'CATEDRA DE PAZ',1,4.70
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E815' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'INTELIGENCIA EMOCIONAL',1,4.70
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E815' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'FORMACION ETICA Y CIUDADANA',1,4.80
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E815' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDB48'),'CULTURAS RELIGIOSAS Y ESPIRITUALIDAD',1,5.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E815' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDB48'),'PROYECTO DE VIDA',1,4.90
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E815' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,null,'ÃLGEBRA',1,4.90
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E815' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'ARTES',1,4.80
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E815' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,null,'CONVIVENCIA',1,4.80
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E815' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PRP48'),'EDUCACION FISICA',2,4.50
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E801' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'ARITMETICA',2,4.60
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E801' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSF8'),'HISTORIA',2,5.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E801' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PVZ48'),'LENGUA CASTELLANA',2,4.60
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E801' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PKR48'),'ROBOTICA Y PROGRAMACION DE VIDEOJUEGOS',2,4.80
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E801' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'GEOMETRIA',2,4.80
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E801' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'ESTADISTICA',2,4.40
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E801' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAMO8'),'LENGUA EXTRAJERA',2,4.60
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E801' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSC8'),'PLAN LECTOR',2,5.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E801' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSC8'),'BIOLOGIA',2,4.20
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E801' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSC8'),'QUIMICA',2,4.60
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E801' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSF8'),'GEOGRAFIA',2,5.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E801' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSF8'),'DEMOCRACIA',2,5.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E801' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSF8'),'CATEDRA DE PAZ',2,5.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E801' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'INTELIGENCIA EMOCIONAL',2,5.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E801' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'FORMACION ETICA Y CIUDADANA',2,4.90
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E801' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDB48'),'CULTURAS RELIGIOSAS Y ESPIRITUALIDAD',2,3.90
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E801' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDB48'),'PROYECTO DE VIDA',2,4.20
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E801' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'ÁLGEBRA',2,4.70
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E801' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'ARTES',2,4.40
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E801' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,null,'CONVIVENCIA',2,5.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E801' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PRP48'),'EDUCACION FISICA',2,4.10
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E802' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'ARITMETICA',2,4.20
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E802' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSF8'),'HISTORIA',2,4.20
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E802' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PVZ48'),'LENGUA CASTELLANA',2,3.50
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E802' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PKR48'),'ROBOTICA Y PROGRAMACION DE VIDEOJUEGOS',2,3.60
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E802' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'GEOMETRIA',2,4.30
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E802' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'ESTADISTICA',2,4.70
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E802' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAMO8'),'LENGUA EXTRAJERA',2,3.50
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E802' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSC8'),'PLAN LECTOR',2,4.60
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E802' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSC8'),'BIOLOGIA',2,4.10
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E802' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSC8'),'QUIMICA',2,4.10
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E802' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSF8'),'GEOGRAFIA',2,3.70
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E802' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSF8'),'DEMOCRACIA',2,3.60
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E802' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSF8'),'CATEDRA DE PAZ',2,4.20
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E802' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'INTELIGENCIA EMOCIONAL',2,4.10
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E802' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'FORMACION ETICA Y CIUDADANA',2,4.90
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E802' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDB48'),'CULTURAS RELIGIOSAS Y ESPIRITUALIDAD',2,3.10
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E802' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDB48'),'PROYECTO DE VIDA',2,3.50
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E802' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'ÁLGEBRA',2,4.10
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E802' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'ARTES',2,2.40
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E802' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,null,'CONVIVENCIA',2,3.90
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E802' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PRP48'),'EDUCACION FISICA',2,3.80
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E803' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'ARITMETICA',2,4.40
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E803' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSF8'),'HISTORIA',2,4.90
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E803' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PVZ48'),'LENGUA CASTELLANA',2,4.20
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E803' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PKR48'),'ROBOTICA Y PROGRAMACION DE VIDEOJUEGOS',2,4.20
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E803' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'GEOMETRIA',2,4.50
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E803' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'ESTADISTICA',2,4.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E803' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAMO8'),'LENGUA EXTRAJERA',2,4.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E803' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSC8'),'PLAN LECTOR',2,4.50
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E803' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSC8'),'BIOLOGIA',2,4.10
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E803' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSC8'),'QUIMICA',2,4.60
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E803' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSF8'),'GEOGRAFIA',2,4.90
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E803' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSF8'),'DEMOCRACIA',2,4.90
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E803' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSF8'),'CATEDRA DE PAZ',2,4.90
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E803' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'INTELIGENCIA EMOCIONAL',2,4.70
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E803' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'FORMACION ETICA Y CIUDADANA',2,4.60
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E803' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDB48'),'CULTURAS RELIGIOSAS Y ESPIRITUALIDAD',2,3.80
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E803' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDB48'),'PROYECTO DE VIDA',2,3.90
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E803' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'ÁLGEBRA',2,4.30
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E803' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'ARTES',2,3.60
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E803' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,null,'CONVIVENCIA',2,4.50
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E803' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PRP48'),'EDUCACION FISICA',2,3.80
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E804' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'ARITMETICA',2,4.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E804' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSF8'),'HISTORIA',2,4.40
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E804' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PVZ48'),'LENGUA CASTELLANA',2,3.90
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E804' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PKR48'),'ROBOTICA Y PROGRAMACION DE VIDEOJUEGOS',2,3.90
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E804' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'GEOMETRIA',2,4.70
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E804' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'ESTADISTICA',2,4.60
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E804' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAMO8'),'LENGUA EXTRAJERA',2,3.90
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E804' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSC8'),'PLAN LECTOR',2,3.60
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E804' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSC8'),'BIOLOGIA',2,3.70
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E804' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSC8'),'QUIMICA',2,4.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E804' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSF8'),'GEOGRAFIA',2,3.60
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E804' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSF8'),'DEMOCRACIA',2,4.70
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E804' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSF8'),'CATEDRA DE PAZ',2,3.60
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E804' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'INTELIGENCIA EMOCIONAL',2,4.80
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E804' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'FORMACION ETICA Y CIUDADANA',2,4.90
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E804' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDB48'),'CULTURAS RELIGIOSAS Y ESPIRITUALIDAD',2,3.90
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E804' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDB48'),'PROYECTO DE VIDA',2,4.10
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E804' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'ÁLGEBRA',2,4.60
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E804' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'ARTES',2,3.50
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E804' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,null,'CONVIVENCIA',2,2.50
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E804' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PRP48'),'EDUCACION FISICA',2,4.20
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E805' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'ARITMETICA',2,4.40
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E805' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSF8'),'HISTORIA',2,4.50
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E805' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PVZ48'),'LENGUA CASTELLANA',2,3.90
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E805' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PKR48'),'ROBOTICA Y PROGRAMACION DE VIDEOJUEGOS',2,3.90
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E805' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'GEOMETRIA',2,4.50
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E805' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'ESTADISTICA',2,4.10
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E805' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAMO8'),'LENGUA EXTRAJERA',2,3.80
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E805' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSC8'),'PLAN LECTOR',2,5.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E805' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSC8'),'BIOLOGIA',2,4.10
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E805' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSC8'),'QUIMICA',2,4.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E805' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSF8'),'GEOGRAFIA',2,4.10
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E805' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSF8'),'DEMOCRACIA',2,4.50
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E805' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSF8'),'CATEDRA DE PAZ',2,4.50
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E805' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'INTELIGENCIA EMOCIONAL',2,4.70
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E805' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'FORMACION ETICA Y CIUDADANA',2,4.90
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E805' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDB48'),'CULTURAS RELIGIOSAS Y ESPIRITUALIDAD',2,4.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E805' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDB48'),'PROYECTO DE VIDA',2,4.20
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E805' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'ÁLGEBRA',2,4.30
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E805' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'ARTES',2,3.10
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E805' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,null,'CONVIVENCIA',2,3.90
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E805' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PRP48'),'EDUCACION FISICA',2,3.80
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E806' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'ARITMETICA',2,4.60
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E806' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSF8'),'HISTORIA',2,4.80
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E806' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PVZ48'),'LENGUA CASTELLANA',2,4.50
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E806' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PKR48'),'ROBOTICA Y PROGRAMACION DE VIDEOJUEGOS',2,4.70
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E806' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'GEOMETRIA',2,5.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E806' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'ESTADISTICA',2,4.90
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E806' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAMO8'),'LENGUA EXTRAJERA',2,4.60
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E806' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSC8'),'PLAN LECTOR',2,4.90
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E806' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSC8'),'BIOLOGIA',2,4.50
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E806' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSC8'),'QUIMICA',2,4.50
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E806' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSF8'),'GEOGRAFIA',2,4.60
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E806' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSF8'),'DEMOCRACIA',2,4.80
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E806' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSF8'),'CATEDRA DE PAZ',2,4.50
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E806' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'INTELIGENCIA EMOCIONAL',2,4.60
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E806' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'FORMACION ETICA Y CIUDADANA',2,4.90
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E806' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDB48'),'CULTURAS RELIGIOSAS Y ESPIRITUALIDAD',2,4.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E806' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDB48'),'PROYECTO DE VIDA',2,4.50
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E806' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'ÁLGEBRA',2,4.60
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E806' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'ARTES',2,4.40
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E806' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,null,'CONVIVENCIA',2,5.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E806' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PRP48'),'EDUCACION FISICA',2,3.70
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E807' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'ARITMETICA',2,3.90
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E807' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSF8'),'HISTORIA',2,4.20
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E807' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PVZ48'),'LENGUA CASTELLANA',2,3.90
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E807' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PKR48'),'ROBOTICA Y PROGRAMACION DE VIDEOJUEGOS',2,4.10
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E807' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'GEOMETRIA',2,3.90
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E807' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'ESTADISTICA',2,4.60
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E807' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAMO8'),'LENGUA EXTRAJERA',2,3.80
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E807' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSC8'),'PLAN LECTOR',2,3.70
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E807' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSC8'),'BIOLOGIA',2,3.90
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E807' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSC8'),'QUIMICA',2,3.90
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E807' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSF8'),'GEOGRAFIA',2,4.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E807' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSF8'),'DEMOCRACIA',2,4.50
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E807' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSF8'),'CATEDRA DE PAZ',2,3.80
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E807' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'INTELIGENCIA EMOCIONAL',2,4.30
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E807' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'FORMACION ETICA Y CIUDADANA',2,4.40
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E807' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDB48'),'CULTURAS RELIGIOSAS Y ESPIRITUALIDAD',2,4.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E807' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDB48'),'PROYECTO DE VIDA',2,4.20
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E807' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'ÁLGEBRA',2,4.40
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E807' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'ARTES',2,3.60
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E807' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,null,'CONVIVENCIA',2,3.80
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E807' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PRP48'),'EDUCACION FISICA',2,4.10
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E808' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'ARITMETICA',2,4.50
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E808' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSF8'),'HISTORIA',2,4.70
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E808' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PVZ48'),'LENGUA CASTELLANA',2,4.70
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E808' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PKR48'),'ROBOTICA Y PROGRAMACION DE VIDEOJUEGOS',2,4.80
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E808' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'GEOMETRIA',2,4.80
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E808' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'ESTADISTICA',2,4.70
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E808' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAMO8'),'LENGUA EXTRAJERA',2,4.20
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E808' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSC8'),'PLAN LECTOR',2,4.80
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E808' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSC8'),'BIOLOGIA',2,4.70
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E808' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSC8'),'QUIMICA',2,4.60
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E808' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSF8'),'GEOGRAFIA',2,4.70
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E808' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSF8'),'DEMOCRACIA',2,4.70
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E808' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSF8'),'CATEDRA DE PAZ',2,4.70
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E808' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'INTELIGENCIA EMOCIONAL',2,5.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E808' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'FORMACION ETICA Y CIUDADANA',2,5.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E808' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDB48'),'CULTURAS RELIGIOSAS Y ESPIRITUALIDAD',2,4.60
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E808' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDB48'),'PROYECTO DE VIDA',2,4.50
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E808' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'ÁLGEBRA',2,4.40
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E808' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'ARTES',2,4.70
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E808' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,null,'CONVIVENCIA',2,5.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E808' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PRP48'),'EDUCACION FISICA',2,5.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E809' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'ARITMETICA',2,4.40
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E809' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSF8'),'HISTORIA',2,4.60
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E809' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PVZ48'),'LENGUA CASTELLANA',2,3.70
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E809' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PKR48'),'ROBOTICA Y PROGRAMACION DE VIDEOJUEGOS',2,4.30
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E809' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'GEOMETRIA',2,4.60
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E809' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'ESTADISTICA',2,4.10
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E809' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAMO8'),'LENGUA EXTRAJERA',2,3.80
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E809' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSC8'),'PLAN LECTOR',2,4.80
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E809' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSC8'),'BIOLOGIA',2,3.60
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E809' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSC8'),'QUIMICA',2,3.90
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E809' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSF8'),'GEOGRAFIA',2,4.90
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E809' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSF8'),'DEMOCRACIA',2,4.90
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E809' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSF8'),'CATEDRA DE PAZ',2,4.60
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E809' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'INTELIGENCIA EMOCIONAL',2,4.60
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E809' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'FORMACION ETICA Y CIUDADANA',2,4.90
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E809' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDB48'),'CULTURAS RELIGIOSAS Y ESPIRITUALIDAD',2,3.80
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E809' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDB48'),'PROYECTO DE VIDA',2,4.10
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E809' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'ÁLGEBRA',2,4.60
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E809' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'ARTES',2,3.80
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E809' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,null,'CONVIVENCIA',2,5.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E809' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PRP48'),'EDUCACION FISICA',2,4.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E810' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'ARITMETICA',2,4.40
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E810' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSF8'),'HISTORIA',2,5.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E810' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PVZ48'),'LENGUA CASTELLANA',2,4.70
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E810' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PKR48'),'ROBOTICA Y PROGRAMACION DE VIDEOJUEGOS',2,4.80
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E810' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'GEOMETRIA',2,4.80
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E810' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'ESTADISTICA',2,4.70
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E810' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAMO8'),'LENGUA EXTRAJERA',2,4.20
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E810' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSC8'),'PLAN LECTOR',2,4.40
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E810' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSC8'),'BIOLOGIA',2,4.30
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E810' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSC8'),'QUIMICA',2,3.90
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E810' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSF8'),'GEOGRAFIA',2,4.90
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E810' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSF8'),'DEMOCRACIA',2,5.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E810' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSF8'),'CATEDRA DE PAZ',2,5.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E810' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'INTELIGENCIA EMOCIONAL',2,4.90
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E810' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'FORMACION ETICA Y CIUDADANA',2,4.90
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E810' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDB48'),'CULTURAS RELIGIOSAS Y ESPIRITUALIDAD',2,4.80
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E810' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDB48'),'PROYECTO DE VIDA',2,4.80
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E810' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'ÁLGEBRA',2,4.40
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E810' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'ARTES',2,3.90
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E810' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,null,'CONVIVENCIA',2,5.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E810' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PRP48'),'EDUCACION FISICA',2,3.80
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E811' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'ARITMETICA',2,4.70
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E811' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSF8'),'HISTORIA',2,4.90
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E811' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PVZ48'),'LENGUA CASTELLANA',2,4.80
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E811' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PKR48'),'ROBOTICA Y PROGRAMACION DE VIDEOJUEGOS',2,4.70
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E811' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'GEOMETRIA',2,4.70
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E811' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'ESTADISTICA',2,3.60
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E811' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAMO8'),'LENGUA EXTRAJERA',2,4.50
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E811' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSC8'),'PLAN LECTOR',2,4.80
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E811' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSC8'),'BIOLOGIA',2,4.30
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E811' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSC8'),'QUIMICA',2,4.20
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E811' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSF8'),'GEOGRAFIA',2,4.90
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E811' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSF8'),'DEMOCRACIA',2,4.90
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E811' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSF8'),'CATEDRA DE PAZ',2,4.90
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E811' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'INTELIGENCIA EMOCIONAL',2,4.70
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E811' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'FORMACION ETICA Y CIUDADANA',2,4.90
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E811' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDB48'),'CULTURAS RELIGIOSAS Y ESPIRITUALIDAD',2,4.30
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E811' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDB48'),'PROYECTO DE VIDA',2,4.40
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E811' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'ÁLGEBRA',2,4.60
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E811' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'ARTES',2,4.40
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E811' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,null,'CONVIVENCIA',2,4.50
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E811' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PRP48'),'EDUCACION FISICA',2,3.80
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E812' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'ARITMETICA',2,3.80
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E812' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSF8'),'HISTORIA',2,4.60
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E812' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PVZ48'),'LENGUA CASTELLANA',2,4.40
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E812' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PKR48'),'ROBOTICA Y PROGRAMACION DE VIDEOJUEGOS',2,4.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E812' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'GEOMETRIA',2,4.60
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E812' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'ESTADISTICA',2,4.40
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E812' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAMO8'),'LENGUA EXTRAJERA',2,4.10
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E812' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSC8'),'PLAN LECTOR',2,3.70
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E812' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSC8'),'BIOLOGIA',2,4.40
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E812' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSC8'),'QUIMICA',2,4.30
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E812' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSF8'),'GEOGRAFIA',2,4.40
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E812' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSF8'),'DEMOCRACIA',2,4.70
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E812' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSF8'),'CATEDRA DE PAZ',2,4.30
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E812' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'INTELIGENCIA EMOCIONAL',2,4.80
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E812' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'FORMACION ETICA Y CIUDADANA',2,4.40
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E812' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDB48'),'CULTURAS RELIGIOSAS Y ESPIRITUALIDAD',2,4.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E812' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDB48'),'PROYECTO DE VIDA',2,4.30
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E812' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'ÁLGEBRA',2,4.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E812' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'ARTES',2,3.90
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E812' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,null,'CONVIVENCIA',2,2.50
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E812' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PRP48'),'EDUCACION FISICA',2,3.70
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E813' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'ARITMETICA',2,4.50
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E813' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSF8'),'HISTORIA',2,4.10
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E813' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PVZ48'),'LENGUA CASTELLANA',2,3.70
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E813' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PKR48'),'ROBOTICA Y PROGRAMACION DE VIDEOJUEGOS',2,4.10
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E813' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'GEOMETRIA',2,4.70
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E813' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'ESTADISTICA',2,4.70
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E813' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAMO8'),'LENGUA EXTRAJERA',2,3.50
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E813' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSC8'),'PLAN LECTOR',2,5.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E813' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSC8'),'BIOLOGIA',2,3.90
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E813' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSC8'),'QUIMICA',2,4.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E813' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSF8'),'GEOGRAFIA',2,4.50
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E813' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSF8'),'DEMOCRACIA',2,4.30
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E813' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSF8'),'CATEDRA DE PAZ',2,4.90
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E813' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'INTELIGENCIA EMOCIONAL',2,4.70
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E813' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'FORMACION ETICA Y CIUDADANA',2,4.90
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E813' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDB48'),'CULTURAS RELIGIOSAS Y ESPIRITUALIDAD',2,3.80
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E813' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDB48'),'PROYECTO DE VIDA',2,4.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E813' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'ÁLGEBRA',2,4.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E813' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'ARTES',2,2.50
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E813' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,null,'CONVIVENCIA',2,5.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E813' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PRP48'),'EDUCACION FISICA',2,4.90
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E814' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'ARITMETICA',2,4.40
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E814' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSF8'),'HISTORIA',2,4.80
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E814' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PVZ48'),'LENGUA CASTELLANA',2,4.30
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E814' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PKR48'),'ROBOTICA Y PROGRAMACION DE VIDEOJUEGOS',2,4.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E814' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'GEOMETRIA',2,4.80
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E814' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'ESTADISTICA',2,4.70
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E814' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAMO8'),'LENGUA EXTRAJERA',2,4.20
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E814' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSC8'),'PLAN LECTOR',2,4.80
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E814' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSC8'),'BIOLOGIA',2,4.20
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E814' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSC8'),'QUIMICA',2,4.50
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E814' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSF8'),'GEOGRAFIA',2,4.70
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E814' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSF8'),'DEMOCRACIA',2,4.90
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E814' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSF8'),'CATEDRA DE PAZ',2,4.40
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E814' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'INTELIGENCIA EMOCIONAL',2,4.60
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E814' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'FORMACION ETICA Y CIUDADANA',2,4.90
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E814' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDB48'),'CULTURAS RELIGIOSAS Y ESPIRITUALIDAD',2,4.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E814' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDB48'),'PROYECTO DE VIDA',2,4.20
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E814' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'ÁLGEBRA',2,4.70
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E814' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'ARTES',2,4.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E814' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,null,'CONVIVENCIA',2,4.50
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E814' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PRP48'),'EDUCACION FISICA',2,4.60
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E815' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'ARITMETICA',2,4.80
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E815' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSF8'),'HISTORIA',2,4.80
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E815' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PVZ48'),'LENGUA CASTELLANA',2,4.80
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E815' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PKR48'),'ROBOTICA Y PROGRAMACION DE VIDEOJUEGOS',2,4.80
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E815' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'GEOMETRIA',2,4.80
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E815' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'ESTADISTICA',2,4.70
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E815' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAMO8'),'LENGUA EXTRAJERA',2,4.70
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E815' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSC8'),'PLAN LECTOR',2,4.50
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E815' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSC8'),'BIOLOGIA',2,4.70
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E815' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSC8'),'QUIMICA',2,4.60
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E815' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSF8'),'GEOGRAFIA',2,4.90
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E815' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSF8'),'DEMOCRACIA',2,4.90
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E815' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PSF8'),'CATEDRA DE PAZ',2,4.90
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E815' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'INTELIGENCIA EMOCIONAL',2,5.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E815' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'FORMACION ETICA Y CIUDADANA',2,5.00
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E815' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDB48'),'CULTURAS RELIGIOSAS Y ESPIRITUALIDAD',2,4.60
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E815' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDB48'),'PROYECTO DE VIDA',2,4.60
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E815' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PDA8'),'ÁLGEBRA',2,4.60
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E815' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,(select id from public.profesores where nombre_completo='PAG48'),'ARTES',2,4.60
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E815' and c.nombre='8vo A';
insert into public.calificaciones (estudiante_id,curso_id,profesor_id,materia,periodo,nota)
select e.id,c.id,null,'CONVIVENCIA',2,4.50
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E815' and c.nombre='8vo A';

-- ASISTENCIAS (el Excel no identifica profesor por registro; se conserva profesor_id=NULL)
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-05'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E401' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-06'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E401' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-09'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E401' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-10'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E401' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-11'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E401' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-16'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E401' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-17'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E401' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-18'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E401' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-20'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E401' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-23'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E401' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-24'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E401' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-25'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E401' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-26'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E401' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-27'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E401' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-02'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E401' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-03'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E401' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-04'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E401' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-05'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E401' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-09'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E401' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-10'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E401' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-11'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E401' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-12'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E401' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-16'::date,'Retardo'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E401' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-17'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E401' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-18'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E401' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-19'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E401' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-20'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E401' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-24'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E401' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-25'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E401' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-26'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E401' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-27'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E401' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-06'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E401' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-07'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E401' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-08'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E401' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-09'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E401' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-10'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E401' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-13'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E401' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-14'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E401' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-16'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E401' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-17'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E401' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-20'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E401' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-21'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E401' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-22'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E401' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-23'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E401' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-27'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E401' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-28'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E401' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-29'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E401' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-04'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E401' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-06'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E401' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-07'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E401' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-11'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E401' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-12'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E401' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-13'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E401' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-14'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E401' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-19'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E401' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-20'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E401' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-21'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E401' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-22'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E401' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-25'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E401' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-27'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E401' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-28'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E401' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-29'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E401' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-01'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E401' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-02'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E401' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-03'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E401' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-04'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E401' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-10'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E401' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-11'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E401' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-14'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E401' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-15'::date,'Retardo'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E401' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-16'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E401' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-17'::date,'Retardo'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E401' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-21'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E401' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-22'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E401' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-23'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E401' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-27'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E401' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-28'::date,'Retardo'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E401' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-30'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E401' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-31'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E401' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-04'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E401' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-05'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E401' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-06'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E401' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-10'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E401' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-11'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E401' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-13'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E401' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-14'::date,'Retardo'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E401' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-05'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E402' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-06'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E402' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-09'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E402' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-10'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E402' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-11'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E402' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-16'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E402' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-17'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E402' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-18'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E402' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-20'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E402' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-23'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E402' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-24'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E402' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-25'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E402' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-26'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E402' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-27'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E402' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-02'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E402' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-03'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E402' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-04'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E402' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-05'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E402' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-09'::date,'Justificacion'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E402' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-10'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E402' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-11'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E402' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-12'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E402' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-16'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E402' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-17'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E402' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-18'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E402' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-19'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E402' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-20'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E402' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-24'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E402' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-25'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E402' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-26'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E402' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-27'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E402' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-06'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E402' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-07'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E402' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-08'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E402' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-09'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E402' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-10'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E402' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-13'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E402' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-14'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E402' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-16'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E402' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-17'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E402' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-20'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E402' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-21'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E402' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-22'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E402' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-23'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E402' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-27'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E402' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-28'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E402' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-29'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E402' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-04'::date,'Justificacion'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E402' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-06'::date,'Justificacion'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E402' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-07'::date,'Justificacion'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E402' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-11'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E402' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-12'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E402' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-13'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E402' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-14'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E402' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-19'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E402' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-20'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E402' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-21'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E402' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-22'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E402' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-25'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E402' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-27'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E402' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-28'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E402' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-29'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E402' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-01'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E402' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-02'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E402' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-03'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E402' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-04'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E402' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-10'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E402' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-11'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E402' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-14'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E402' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-15'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E402' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-16'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E402' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-17'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E402' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-21'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E402' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-22'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E402' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-23'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E402' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-27'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E402' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-28'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E402' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-30'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E402' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-31'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E402' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-04'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E402' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-05'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E402' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-06'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E402' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-10'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E402' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-11'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E402' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-13'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E402' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-14'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E402' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-05'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E403' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-06'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E403' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-09'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E403' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-10'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E403' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-11'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E403' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-16'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E403' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-17'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E403' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-18'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E403' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-20'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E403' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-23'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E403' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-24'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E403' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-25'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E403' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-26'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E403' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-27'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E403' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-02'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E403' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-03'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E403' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-04'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E403' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-05'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E403' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-09'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E403' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-10'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E403' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-11'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E403' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-12'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E403' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-16'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E403' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-17'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E403' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-18'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E403' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-19'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E403' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-20'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E403' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-24'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E403' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-25'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E403' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-26'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E403' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-27'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E403' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-06'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E403' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-07'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E403' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-08'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E403' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-09'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E403' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-10'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E403' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-13'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E403' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-14'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E403' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-16'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E403' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-17'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E403' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-20'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E403' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-21'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E403' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-22'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E403' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-23'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E403' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-27'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E403' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-28'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E403' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-29'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E403' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-04'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E403' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-06'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E403' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-07'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E403' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-11'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E403' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-12'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E403' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-13'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E403' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-14'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E403' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-19'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E403' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-20'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E403' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-21'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E403' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-22'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E403' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-25'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E403' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-27'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E403' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-28'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E403' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-29'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E403' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-01'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E403' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-02'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E403' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-03'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E403' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-04'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E403' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-10'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E403' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-11'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E403' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-14'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E403' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-15'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E403' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-16'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E403' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-17'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E403' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-21'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E403' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-22'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E403' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-23'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E403' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-27'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E403' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-28'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E403' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-30'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E403' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-31'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E403' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-04'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E403' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-05'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E403' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-06'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E403' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-10'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E403' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-11'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E403' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-13'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E403' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-14'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E403' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-05'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E404' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-06'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E404' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-09'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E404' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-10'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E404' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-11'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E404' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-16'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E404' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-17'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E404' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-18'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E404' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-20'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E404' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-23'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E404' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-24'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E404' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-25'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E404' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-26'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E404' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-27'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E404' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-02'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E404' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-03'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E404' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-04'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E404' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-05'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E404' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-09'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E404' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-10'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E404' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-11'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E404' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-12'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E404' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-16'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E404' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-17'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E404' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-18'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E404' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-19'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E404' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-20'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E404' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-24'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E404' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-25'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E404' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-26'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E404' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-27'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E404' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-06'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E404' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-07'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E404' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-08'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E404' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-09'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E404' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-10'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E404' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-13'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E404' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-14'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E404' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-16'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E404' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-17'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E404' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-20'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E404' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-21'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E404' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-22'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E404' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-23'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E404' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-27'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E404' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-28'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E404' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-29'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E404' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-04'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E404' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-06'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E404' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-07'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E404' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-11'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E404' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-12'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E404' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-13'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E404' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-14'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E404' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-19'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E404' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-20'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E404' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-21'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E404' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-22'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E404' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-25'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E404' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-27'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E404' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-28'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E404' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-29'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E404' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-01'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E404' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-02'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E404' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-03'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E404' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-04'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E404' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-10'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E404' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-11'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E404' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-14'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E404' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-15'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E404' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-16'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E404' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-17'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E404' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-21'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E404' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-22'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E404' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-23'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E404' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-27'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E404' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-28'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E404' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-30'::date,'Justificacion'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E404' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-31'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E404' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-04'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E404' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-05'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E404' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-06'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E404' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-10'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E404' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-11'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E404' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-13'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E404' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-14'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E404' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-05'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E405' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-06'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E405' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-09'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E405' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-10'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E405' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-11'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E405' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-16'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E405' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-17'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E405' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-18'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E405' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-20'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E405' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-23'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E405' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-24'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E405' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-25'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E405' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-26'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E405' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-27'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E405' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-02'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E405' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-03'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E405' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-04'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E405' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-05'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E405' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-09'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E405' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-10'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E405' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-11'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E405' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-12'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E405' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-16'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E405' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-17'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E405' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-18'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E405' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-19'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E405' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-20'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E405' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-24'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E405' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-25'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E405' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-26'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E405' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-27'::date,'Retardo'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E405' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-06'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E405' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-07'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E405' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-08'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E405' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-09'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E405' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-10'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E405' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-13'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E405' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-14'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E405' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-16'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E405' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-17'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E405' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-20'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E405' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-21'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E405' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-22'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E405' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-23'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E405' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-27'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E405' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-28'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E405' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-29'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E405' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-04'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E405' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-06'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E405' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-07'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E405' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-11'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E405' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-12'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E405' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-13'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E405' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-14'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E405' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-19'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E405' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-20'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E405' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-21'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E405' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-22'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E405' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-25'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E405' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-27'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E405' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-28'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E405' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-29'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E405' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-01'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E405' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-02'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E405' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-03'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E405' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-04'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E405' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-10'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E405' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-11'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E405' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-14'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E405' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-15'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E405' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-16'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E405' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-17'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E405' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-21'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E405' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-22'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E405' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-23'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E405' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-27'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E405' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-28'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E405' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-30'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E405' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-31'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E405' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-04'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E405' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-05'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E405' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-06'::date,'Retardo'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E405' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-10'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E405' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-11'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E405' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-13'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E405' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-14'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E405' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-05'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E406' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-06'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E406' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-09'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E406' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-10'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E406' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-11'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E406' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-16'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E406' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-17'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E406' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-18'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E406' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-20'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E406' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-23'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E406' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-24'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E406' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-25'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E406' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-26'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E406' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-27'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E406' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-02'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E406' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-03'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E406' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-04'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E406' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-05'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E406' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-09'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E406' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-10'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E406' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-11'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E406' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-12'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E406' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-16'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E406' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-17'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E406' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-18'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E406' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-19'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E406' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-20'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E406' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-24'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E406' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-25'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E406' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-26'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E406' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-27'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E406' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-06'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E406' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-07'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E406' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-08'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E406' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-09'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E406' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-10'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E406' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-13'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E406' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-14'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E406' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-16'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E406' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-17'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E406' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-20'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E406' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-21'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E406' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-22'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E406' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-23'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E406' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-27'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E406' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-28'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E406' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-29'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E406' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-04'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E406' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-06'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E406' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-07'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E406' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-11'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E406' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-12'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E406' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-13'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E406' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-14'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E406' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-19'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E406' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-20'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E406' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-21'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E406' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-22'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E406' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-25'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E406' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-27'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E406' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-28'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E406' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-29'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E406' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-01'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E406' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-02'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E406' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-03'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E406' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-04'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E406' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-10'::date,'Retardo'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E406' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-11'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E406' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-14'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E406' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-15'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E406' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-16'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E406' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-17'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E406' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-21'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E406' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-22'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E406' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-23'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E406' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-27'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E406' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-28'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E406' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-30'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E406' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-31'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E406' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-04'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E406' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-05'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E406' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-06'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E406' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-10'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E406' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-11'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E406' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-13'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E406' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-14'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E406' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-05'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E407' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-06'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E407' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-09'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E407' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-10'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E407' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-11'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E407' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-16'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E407' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-17'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E407' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-18'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E407' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-20'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E407' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-23'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E407' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-24'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E407' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-25'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E407' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-26'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E407' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-27'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E407' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-02'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E407' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-03'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E407' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-04'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E407' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-05'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E407' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-09'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E407' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-10'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E407' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-11'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E407' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-12'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E407' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-16'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E407' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-17'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E407' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-18'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E407' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-19'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E407' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-20'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E407' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-24'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E407' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-25'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E407' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-26'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E407' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-27'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E407' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-06'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E407' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-07'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E407' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-08'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E407' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-09'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E407' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-10'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E407' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-13'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E407' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-14'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E407' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-16'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E407' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-17'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E407' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-20'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E407' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-21'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E407' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-22'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E407' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-23'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E407' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-27'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E407' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-28'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E407' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-29'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E407' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-04'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E407' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-06'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E407' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-07'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E407' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-11'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E407' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-12'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E407' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-13'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E407' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-14'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E407' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-19'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E407' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-20'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E407' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-21'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E407' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-22'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E407' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-25'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E407' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-27'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E407' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-28'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E407' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-29'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E407' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-01'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E407' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-02'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E407' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-03'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E407' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-04'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E407' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-10'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E407' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-11'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E407' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-14'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E407' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-15'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E407' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-16'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E407' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-17'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E407' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-21'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E407' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-22'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E407' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-23'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E407' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-27'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E407' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-28'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E407' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-30'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E407' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-31'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E407' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-04'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E407' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-05'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E407' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-06'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E407' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-10'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E407' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-11'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E407' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-13'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E407' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-14'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E407' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-05'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E408' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-06'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E408' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-09'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E408' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-10'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E408' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-11'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E408' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-16'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E408' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-17'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E408' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-18'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E408' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-20'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E408' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-23'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E408' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-24'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E408' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-25'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E408' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-26'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E408' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-27'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E408' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-02'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E408' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-03'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E408' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-04'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E408' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-05'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E408' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-09'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E408' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-10'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E408' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-11'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E408' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-12'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E408' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-16'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E408' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-17'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E408' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-18'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E408' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-19'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E408' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-20'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E408' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-24'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E408' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-25'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E408' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-26'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E408' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-27'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E408' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-06'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E408' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-07'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E408' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-08'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E408' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-09'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E408' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-10'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E408' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-13'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E408' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-14'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E408' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-16'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E408' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-17'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E408' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-20'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E408' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-21'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E408' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-22'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E408' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-23'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E408' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-27'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E408' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-28'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E408' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-29'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E408' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-04'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E408' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-06'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E408' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-07'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E408' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-11'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E408' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-12'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E408' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-13'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E408' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-14'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E408' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-19'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E408' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-20'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E408' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-21'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E408' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-22'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E408' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-25'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E408' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-27'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E408' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-28'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E408' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-29'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E408' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-01'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E408' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-02'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E408' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-03'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E408' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-04'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E408' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-10'::date,'Retardo'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E408' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-11'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E408' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-14'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E408' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-15'::date,'Retardo'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E408' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-16'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E408' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-17'::date,'Retardo'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E408' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-21'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E408' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-22'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E408' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-23'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E408' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-27'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E408' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-28'::date,'Retardo'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E408' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-30'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E408' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-31'::date,'Retardo'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E408' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-04'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E408' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-05'::date,'Retardo'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E408' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-06'::date,'Retardo'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E408' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-10'::date,'Retardo'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E408' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-11'::date,'Retardo'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E408' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-13'::date,'Retardo'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E408' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-14'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E408' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-05'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E409' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-06'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E409' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-09'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E409' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-10'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E409' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-11'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E409' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-16'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E409' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-17'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E409' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-18'::date,'Retardo'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E409' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-20'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E409' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-23'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E409' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-24'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E409' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-25'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E409' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-26'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E409' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-27'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E409' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-02'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E409' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-03'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E409' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-04'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E409' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-05'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E409' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-09'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E409' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-10'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E409' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-11'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E409' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-12'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E409' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-16'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E409' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-17'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E409' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-18'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E409' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-19'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E409' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-20'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E409' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-24'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E409' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-25'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E409' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-26'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E409' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-27'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E409' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-06'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E409' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-07'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E409' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-08'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E409' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-09'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E409' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-10'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E409' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-13'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E409' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-14'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E409' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-16'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E409' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-17'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E409' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-20'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E409' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-21'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E409' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-22'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E409' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-23'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E409' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-27'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E409' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-28'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E409' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-29'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E409' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-04'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E409' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-06'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E409' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-07'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E409' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-11'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E409' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-12'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E409' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-13'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E409' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-14'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E409' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-19'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E409' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-20'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E409' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-21'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E409' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-22'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E409' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-25'::date,'Justificacion'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E409' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-27'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E409' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-28'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E409' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-29'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E409' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-01'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E409' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-02'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E409' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-03'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E409' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-04'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E409' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-10'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E409' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-11'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E409' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-14'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E409' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-15'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E409' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-16'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E409' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-17'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E409' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-21'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E409' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-22'::date,'Retardo'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E409' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-23'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E409' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-27'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E409' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-28'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E409' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-30'::date,'Retardo'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E409' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-31'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E409' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-04'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E409' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-05'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E409' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-06'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E409' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-10'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E409' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-11'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E409' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-13'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E409' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-14'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E409' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-05'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E410' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-06'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E410' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-09'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E410' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-10'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E410' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-11'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E410' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-16'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E410' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-17'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E410' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-18'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E410' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-20'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E410' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-23'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E410' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-24'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E410' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-25'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E410' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-26'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E410' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-27'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E410' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-02'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E410' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-03'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E410' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-04'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E410' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-05'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E410' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-09'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E410' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-10'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E410' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-11'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E410' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-12'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E410' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-16'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E410' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-17'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E410' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-18'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E410' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-19'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E410' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-20'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E410' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-24'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E410' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-25'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E410' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-26'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E410' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-27'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E410' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-06'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E410' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-07'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E410' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-08'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E410' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-09'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E410' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-10'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E410' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-13'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E410' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-14'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E410' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-16'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E410' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-17'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E410' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-20'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E410' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-21'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E410' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-22'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E410' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-23'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E410' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-27'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E410' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-28'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E410' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-29'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E410' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-04'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E410' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-06'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E410' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-07'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E410' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-11'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E410' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-12'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E410' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-13'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E410' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-14'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E410' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-19'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E410' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-20'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E410' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-21'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E410' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-22'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E410' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-25'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E410' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-27'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E410' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-28'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E410' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-29'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E410' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-01'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E410' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-02'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E410' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-03'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E410' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-04'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E410' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-10'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E410' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-11'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E410' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-14'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E410' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-15'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E410' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-16'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E410' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-17'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E410' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-21'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E410' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-22'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E410' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-23'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E410' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-27'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E410' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-28'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E410' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-30'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E410' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-31'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E410' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-04'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E410' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-05'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E410' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-06'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E410' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-10'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E410' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-11'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E410' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-13'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E410' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-14'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E410' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-05'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E411' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-06'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E411' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-09'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E411' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-10'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E411' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-11'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E411' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-16'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E411' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-17'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E411' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-18'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E411' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-20'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E411' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-23'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E411' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-24'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E411' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-25'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E411' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-26'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E411' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-27'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E411' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-02'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E411' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-03'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E411' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-04'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E411' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-05'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E411' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-09'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E411' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-10'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E411' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-11'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E411' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-12'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E411' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-16'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E411' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-17'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E411' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-18'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E411' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-19'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E411' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-20'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E411' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-24'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E411' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-25'::date,'Justificacion'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E411' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-26'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E411' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-27'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E411' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-06'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E411' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-07'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E411' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-08'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E411' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-09'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E411' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-10'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E411' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-13'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E411' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-14'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E411' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-16'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E411' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-17'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E411' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-20'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E411' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-21'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E411' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-22'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E411' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-23'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E411' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-27'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E411' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-28'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E411' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-29'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E411' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-04'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E411' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-06'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E411' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-07'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E411' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-11'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E411' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-12'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E411' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-13'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E411' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-14'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E411' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-19'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E411' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-20'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E411' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-21'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E411' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-22'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E411' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-25'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E411' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-27'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E411' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-28'::date,'Justificacion'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E411' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-29'::date,'Justificacion'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E411' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-01'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E411' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-02'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E411' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-03'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E411' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-04'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E411' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-10'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E411' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-11'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E411' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-14'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E411' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-15'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E411' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-16'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E411' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-17'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E411' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-21'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E411' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-22'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E411' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-23'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E411' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-27'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E411' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-28'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E411' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-30'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E411' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-31'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E411' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-04'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E411' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-05'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E411' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-06'::date,'Retardo'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E411' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-10'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E411' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-11'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E411' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-13'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E411' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-14'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E411' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-05'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E412' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-06'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E412' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-09'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E412' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-10'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E412' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-11'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E412' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-16'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E412' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-17'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E412' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-18'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E412' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-20'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E412' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-23'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E412' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-24'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E412' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-25'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E412' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-26'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E412' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-27'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E412' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-02'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E412' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-03'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E412' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-04'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E412' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-05'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E412' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-09'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E412' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-10'::date,'Justificacion'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E412' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-11'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E412' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-12'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E412' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-16'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E412' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-17'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E412' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-18'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E412' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-19'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E412' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-20'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E412' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-24'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E412' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-25'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E412' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-26'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E412' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-27'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E412' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-06'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E412' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-07'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E412' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-08'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E412' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-09'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E412' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-10'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E412' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-13'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E412' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-14'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E412' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-16'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E412' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-17'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E412' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-20'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E412' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-21'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E412' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-22'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E412' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-23'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E412' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-27'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E412' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-28'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E412' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-29'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E412' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-04'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E412' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-06'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E412' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-07'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E412' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-11'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E412' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-12'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E412' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-13'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E412' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-14'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E412' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-19'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E412' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-20'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E412' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-21'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E412' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-22'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E412' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-25'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E412' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-27'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E412' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-28'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E412' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-29'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E412' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-01'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E412' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-02'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E412' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-03'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E412' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-04'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E412' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-10'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E412' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-11'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E412' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-14'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E412' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-15'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E412' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-16'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E412' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-17'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E412' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-21'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E412' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-22'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E412' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-23'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E412' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-27'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E412' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-28'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E412' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-30'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E412' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-31'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E412' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-04'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E412' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-05'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E412' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-06'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E412' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-10'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E412' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-11'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E412' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-13'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E412' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-14'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E412' and c.nombre='4to A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-09'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E801' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-10'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E801' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-11'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E801' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-12'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E801' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-13'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E801' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-17'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E801' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-18'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E801' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-20'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E801' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-24'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E801' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-25'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E801' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-26'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E801' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-27'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E801' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-02'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E801' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-03'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E801' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-06'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E801' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-09'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E801' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-12'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E801' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-13'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E801' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-16'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E801' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-17'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E801' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-18'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E801' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-19'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E801' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-20'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E801' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-24'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E801' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-25'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E801' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-26'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E801' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-07'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E801' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-08'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E801' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-09'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E801' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-10'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E801' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-13'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E801' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-14'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E801' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-17'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E801' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-20'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E801' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-21'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E801' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-22'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E801' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-23'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E801' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-24'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E801' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-27'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E801' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-28'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E801' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-29'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E801' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-04'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E801' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-05'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E801' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-07'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E801' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-08'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E801' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-11'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E801' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-12'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E801' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-13'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E801' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-14'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E801' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-19'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E801' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-22'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E801' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-25'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E801' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-26'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E801' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-27'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E801' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-29'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E801' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-01'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E801' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-02'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E801' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-03'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E801' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-04'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E801' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-05'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E801' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-09'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E801' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-10'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E801' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-16'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E801' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-14'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E801' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-15'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E801' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-16'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E801' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-17'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E801' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-22'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E801' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-23'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E801' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-24'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E801' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-27'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E801' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-31'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E801' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-03'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E801' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-06'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E801' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-10'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E801' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-12'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E801' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-13'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E801' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-14'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E801' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-09'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E802' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-10'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E802' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-11'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E802' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-12'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E802' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-13'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E802' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-17'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E802' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-18'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E802' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-20'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E802' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-24'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E802' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-25'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E802' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-26'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E802' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-27'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E802' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-02'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E802' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-03'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E802' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-06'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E802' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-09'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E802' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-12'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E802' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-13'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E802' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-16'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E802' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-17'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E802' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-18'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E802' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-19'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E802' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-20'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E802' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-24'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E802' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-25'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E802' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-26'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E802' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-07'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E802' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-08'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E802' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-09'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E802' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-10'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E802' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-13'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E802' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-14'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E802' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-17'::date,'Justificacion'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E802' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-20'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E802' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-21'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E802' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-22'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E802' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-23'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E802' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-24'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E802' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-27'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E802' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-28'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E802' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-29'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E802' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-04'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E802' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-05'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E802' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-07'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E802' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-08'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E802' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-11'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E802' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-12'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E802' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-13'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E802' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-14'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E802' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-19'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E802' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-22'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E802' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-25'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E802' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-26'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E802' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-27'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E802' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-29'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E802' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-01'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E802' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-02'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E802' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-03'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E802' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-04'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E802' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-05'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E802' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-09'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E802' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-10'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E802' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-16'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E802' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-14'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E802' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-15'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E802' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-16'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E802' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-17'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E802' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-22'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E802' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-23'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E802' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-24'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E802' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-27'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E802' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-31'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E802' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-03'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E802' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-06'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E802' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-10'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E802' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-12'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E802' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-13'::date,'Retardo'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E802' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-14'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E802' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-09'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E803' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-10'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E803' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-11'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E803' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-12'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E803' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-13'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E803' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-17'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E803' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-18'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E803' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-20'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E803' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-24'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E803' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-25'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E803' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-26'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E803' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-27'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E803' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-02'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E803' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-03'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E803' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-06'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E803' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-09'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E803' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-12'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E803' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-13'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E803' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-16'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E803' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-17'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E803' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-18'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E803' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-19'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E803' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-20'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E803' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-24'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E803' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-25'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E803' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-26'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E803' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-07'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E803' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-08'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E803' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-09'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E803' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-10'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E803' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-13'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E803' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-14'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E803' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-17'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E803' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-20'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E803' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-21'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E803' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-22'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E803' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-23'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E803' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-24'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E803' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-27'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E803' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-28'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E803' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-29'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E803' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-04'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E803' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-05'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E803' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-07'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E803' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-08'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E803' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-11'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E803' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-12'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E803' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-13'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E803' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-14'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E803' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-19'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E803' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-22'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E803' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-25'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E803' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-26'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E803' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-27'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E803' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-29'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E803' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-01'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E803' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-02'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E803' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-03'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E803' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-04'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E803' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-05'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E803' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-09'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E803' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-10'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E803' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-16'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E803' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-14'::date,'Justificacion'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E803' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-15'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E803' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-16'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E803' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-17'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E803' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-22'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E803' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-23'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E803' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-24'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E803' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-27'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E803' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-31'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E803' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-03'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E803' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-06'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E803' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-10'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E803' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-12'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E803' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-13'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E803' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-14'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E803' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-09'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E804' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-10'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E804' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-11'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E804' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-12'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E804' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-13'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E804' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-17'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E804' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-18'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E804' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-20'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E804' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-24'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E804' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-25'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E804' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-26'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E804' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-27'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E804' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-02'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E804' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-03'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E804' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-06'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E804' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-09'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E804' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-12'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E804' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-13'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E804' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-16'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E804' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-17'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E804' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-18'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E804' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-19'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E804' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-20'::date,'Retardo'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E804' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-24'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E804' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-25'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E804' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-26'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E804' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-07'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E804' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-08'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E804' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-09'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E804' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-10'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E804' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-13'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E804' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-14'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E804' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-17'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E804' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-20'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E804' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-21'::date,'Retardo'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E804' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-22'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E804' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-23'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E804' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-24'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E804' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-27'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E804' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-28'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E804' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-29'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E804' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-04'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E804' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-05'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E804' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-07'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E804' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-08'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E804' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-11'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E804' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-12'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E804' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-13'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E804' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-14'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E804' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-19'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E804' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-22'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E804' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-25'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E804' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-26'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E804' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-27'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E804' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-29'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E804' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-01'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E804' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-02'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E804' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-03'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E804' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-04'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E804' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-05'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E804' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-09'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E804' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-10'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E804' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-16'::date,'Retardo'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E804' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-14'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E804' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-15'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E804' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-16'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E804' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-17'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E804' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-22'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E804' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-23'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E804' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-24'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E804' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-27'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E804' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-31'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E804' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-03'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E804' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-06'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E804' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-10'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E804' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-12'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E804' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-13'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E804' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-14'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E804' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-09'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E805' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-10'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E805' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-11'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E805' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-12'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E805' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-13'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E805' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-17'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E805' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-18'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E805' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-20'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E805' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-24'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E805' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-25'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E805' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-26'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E805' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-27'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E805' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-02'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E805' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-03'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E805' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-06'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E805' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-09'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E805' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-12'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E805' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-13'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E805' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-16'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E805' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-17'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E805' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-18'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E805' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-19'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E805' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-20'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E805' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-24'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E805' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-25'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E805' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-26'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E805' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-07'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E805' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-08'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E805' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-09'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E805' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-10'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E805' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-13'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E805' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-14'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E805' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-17'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E805' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-20'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E805' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-21'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E805' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-22'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E805' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-23'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E805' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-24'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E805' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-27'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E805' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-28'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E805' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-29'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E805' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-04'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E805' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-05'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E805' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-07'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E805' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-08'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E805' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-11'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E805' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-12'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E805' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-13'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E805' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-14'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E805' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-19'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E805' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-22'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E805' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-25'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E805' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-26'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E805' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-27'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E805' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-29'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E805' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-01'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E805' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-02'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E805' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-03'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E805' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-04'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E805' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-05'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E805' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-09'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E805' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-10'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E805' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-16'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E805' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-14'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E805' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-15'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E805' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-16'::date,'Retardo'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E805' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-17'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E805' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-22'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E805' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-23'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E805' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-24'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E805' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-27'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E805' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-31'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E805' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-03'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E805' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-06'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E805' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-10'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E805' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-12'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E805' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-13'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E805' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-14'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E805' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-09'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E806' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-10'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E806' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-11'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E806' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-12'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E806' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-13'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E806' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-17'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E806' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-18'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E806' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-20'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E806' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-24'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E806' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-25'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E806' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-26'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E806' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-27'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E806' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-02'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E806' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-03'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E806' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-06'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E806' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-09'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E806' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-12'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E806' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-13'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E806' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-16'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E806' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-17'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E806' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-18'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E806' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-19'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E806' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-20'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E806' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-24'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E806' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-25'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E806' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-26'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E806' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-07'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E806' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-08'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E806' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-09'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E806' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-10'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E806' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-13'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E806' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-14'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E806' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-17'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E806' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-20'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E806' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-21'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E806' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-22'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E806' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-23'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E806' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-24'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E806' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-27'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E806' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-28'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E806' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-29'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E806' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-04'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E806' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-05'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E806' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-07'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E806' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-08'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E806' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-11'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E806' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-12'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E806' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-13'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E806' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-14'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E806' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-19'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E806' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-22'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E806' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-25'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E806' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-26'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E806' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-27'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E806' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-29'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E806' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-01'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E806' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-02'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E806' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-03'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E806' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-04'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E806' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-05'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E806' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-09'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E806' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-10'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E806' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-16'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E806' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-14'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E806' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-15'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E806' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-16'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E806' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-17'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E806' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-22'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E806' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-23'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E806' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-24'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E806' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-27'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E806' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-31'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E806' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-03'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E806' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-06'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E806' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-10'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E806' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-12'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E806' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-13'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E806' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-14'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E806' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-09'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E807' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-10'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E807' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-11'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E807' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-12'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E807' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-13'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E807' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-17'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E807' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-18'::date,'Retardo'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E807' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-20'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E807' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-24'::date,'Retardo'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E807' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-25'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E807' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-26'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E807' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-27'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E807' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-02'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E807' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-03'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E807' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-06'::date,'Retardo'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E807' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-09'::date,'Retardo'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E807' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-12'::date,'Retardo'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E807' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-13'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E807' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-16'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E807' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-17'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E807' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-18'::date,'Justificacion'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E807' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-19'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E807' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-20'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E807' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-24'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E807' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-25'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E807' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-26'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E807' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-07'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E807' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-08'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E807' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-09'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E807' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-10'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E807' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-13'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E807' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-14'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E807' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-17'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E807' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-20'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E807' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-21'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E807' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-22'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E807' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-23'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E807' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-24'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E807' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-27'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E807' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-28'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E807' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-29'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E807' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-04'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E807' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-05'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E807' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-07'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E807' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-08'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E807' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-11'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E807' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-12'::date,'Retardo'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E807' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-13'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E807' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-14'::date,'Justificacion'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E807' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-19'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E807' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-22'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E807' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-25'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E807' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-26'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E807' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-27'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E807' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-29'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E807' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-01'::date,'Retardo'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E807' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-02'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E807' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-03'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E807' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-04'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E807' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-05'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E807' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-09'::date,'Retardo'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E807' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-10'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E807' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-16'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E807' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-14'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E807' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-15'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E807' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-16'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E807' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-17'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E807' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-22'::date,'Retardo'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E807' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-23'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E807' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-24'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E807' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-27'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E807' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-31'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E807' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-03'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E807' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-06'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E807' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-10'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E807' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-12'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E807' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-13'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E807' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-14'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E807' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-09'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E808' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-10'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E808' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-11'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E808' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-12'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E808' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-13'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E808' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-17'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E808' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-18'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E808' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-20'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E808' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-24'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E808' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-25'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E808' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-26'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E808' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-27'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E808' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-02'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E808' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-03'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E808' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-06'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E808' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-09'::date,'Retardo'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E808' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-12'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E808' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-13'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E808' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-16'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E808' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-17'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E808' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-18'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E808' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-19'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E808' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-20'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E808' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-24'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E808' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-25'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E808' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-26'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E808' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-07'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E808' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-08'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E808' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-09'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E808' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-10'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E808' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-13'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E808' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-14'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E808' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-17'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E808' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-20'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E808' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-21'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E808' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-22'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E808' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-23'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E808' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-24'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E808' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-27'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E808' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-28'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E808' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-29'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E808' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-04'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E808' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-05'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E808' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-07'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E808' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-08'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E808' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-11'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E808' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-12'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E808' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-13'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E808' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-14'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E808' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-19'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E808' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-22'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E808' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-25'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E808' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-26'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E808' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-27'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E808' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-29'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E808' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-01'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E808' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-02'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E808' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-03'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E808' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-04'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E808' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-05'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E808' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-09'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E808' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-10'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E808' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-16'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E808' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-14'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E808' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-15'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E808' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-16'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E808' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-17'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E808' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-22'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E808' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-23'::date,'Retardo'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E808' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-24'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E808' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-27'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E808' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-31'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E808' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-03'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E808' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-06'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E808' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-10'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E808' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-12'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E808' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-13'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E808' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-14'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E808' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-09'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E809' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-10'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E809' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-11'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E809' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-12'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E809' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-13'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E809' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-17'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E809' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-18'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E809' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-20'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E809' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-24'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E809' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-25'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E809' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-26'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E809' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-27'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E809' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-02'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E809' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-03'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E809' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-06'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E809' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-09'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E809' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-12'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E809' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-13'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E809' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-16'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E809' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-17'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E809' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-18'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E809' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-19'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E809' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-20'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E809' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-24'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E809' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-25'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E809' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-26'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E809' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-07'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E809' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-08'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E809' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-09'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E809' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-10'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E809' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-13'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E809' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-14'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E809' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-17'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E809' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-20'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E809' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-21'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E809' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-22'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E809' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-23'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E809' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-24'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E809' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-27'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E809' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-28'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E809' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-29'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E809' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-04'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E809' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-05'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E809' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-07'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E809' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-08'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E809' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-11'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E809' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-12'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E809' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-13'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E809' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-14'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E809' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-19'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E809' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-22'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E809' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-25'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E809' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-26'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E809' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-27'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E809' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-29'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E809' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-01'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E809' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-02'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E809' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-03'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E809' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-04'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E809' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-05'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E809' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-09'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E809' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-10'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E809' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-16'::date,'Retardo'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E809' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-14'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E809' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-15'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E809' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-16'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E809' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-17'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E809' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-22'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E809' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-23'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E809' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-24'::date,'Retardo'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E809' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-27'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E809' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-31'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E809' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-03'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E809' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-06'::date,'Retardo'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E809' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-10'::date,'Retardo'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E809' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-12'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E809' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-13'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E809' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-14'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E809' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-09'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E810' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-10'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E810' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-11'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E810' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-12'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E810' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-13'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E810' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-17'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E810' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-18'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E810' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-20'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E810' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-24'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E810' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-25'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E810' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-26'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E810' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-27'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E810' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-02'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E810' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-03'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E810' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-06'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E810' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-09'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E810' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-12'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E810' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-13'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E810' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-16'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E810' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-17'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E810' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-18'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E810' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-19'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E810' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-20'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E810' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-24'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E810' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-25'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E810' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-26'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E810' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-07'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E810' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-08'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E810' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-09'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E810' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-10'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E810' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-13'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E810' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-14'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E810' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-17'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E810' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-20'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E810' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-21'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E810' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-22'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E810' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-23'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E810' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-24'::date,'Justificacion'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E810' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-27'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E810' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-28'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E810' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-29'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E810' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-04'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E810' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-05'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E810' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-07'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E810' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-08'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E810' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-11'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E810' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-12'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E810' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-13'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E810' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-14'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E810' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-19'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E810' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-22'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E810' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-25'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E810' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-26'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E810' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-27'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E810' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-29'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E810' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-01'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E810' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-02'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E810' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-03'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E810' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-04'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E810' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-05'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E810' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-09'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E810' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-10'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E810' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-16'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E810' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-14'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E810' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-15'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E810' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-16'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E810' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-17'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E810' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-22'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E810' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-23'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E810' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-24'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E810' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-27'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E810' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-31'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E810' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-03'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E810' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-06'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E810' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-10'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E810' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-12'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E810' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-13'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E810' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-14'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E810' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-09'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E811' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-10'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E811' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-11'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E811' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-12'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E811' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-13'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E811' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-17'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E811' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-18'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E811' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-20'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E811' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-24'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E811' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-25'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E811' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-26'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E811' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-27'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E811' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-02'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E811' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-03'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E811' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-06'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E811' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-09'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E811' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-12'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E811' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-13'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E811' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-16'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E811' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-17'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E811' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-18'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E811' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-19'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E811' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-20'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E811' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-24'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E811' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-25'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E811' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-26'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E811' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-07'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E811' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-08'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E811' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-09'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E811' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-10'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E811' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-13'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E811' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-14'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E811' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-17'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E811' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-20'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E811' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-21'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E811' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-22'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E811' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-23'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E811' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-24'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E811' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-27'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E811' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-28'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E811' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-29'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E811' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-04'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E811' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-05'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E811' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-07'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E811' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-08'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E811' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-11'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E811' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-12'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E811' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-13'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E811' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-14'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E811' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-19'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E811' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-22'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E811' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-25'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E811' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-26'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E811' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-27'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E811' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-29'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E811' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-01'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E811' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-02'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E811' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-03'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E811' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-04'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E811' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-05'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E811' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-09'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E811' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-10'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E811' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-16'::date,'Retardo'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E811' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-14'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E811' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-15'::date,'Retardo'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E811' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-16'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E811' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-17'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E811' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-22'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E811' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-23'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E811' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-24'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E811' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-27'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E811' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-31'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E811' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-03'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E811' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-06'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E811' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-10'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E811' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-12'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E811' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-13'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E811' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-14'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E811' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-09'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E812' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-10'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E812' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-11'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E812' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-12'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E812' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-13'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E812' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-17'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E812' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-18'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E812' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-20'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E812' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-24'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E812' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-25'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E812' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-26'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E812' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-27'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E812' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-02'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E812' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-03'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E812' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-06'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E812' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-09'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E812' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-12'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E812' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-13'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E812' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-16'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E812' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-17'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E812' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-18'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E812' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-19'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E812' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-20'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E812' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-24'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E812' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-25'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E812' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-26'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E812' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-07'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E812' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-08'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E812' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-09'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E812' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-10'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E812' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-13'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E812' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-14'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E812' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-17'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E812' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-20'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E812' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-21'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E812' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-22'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E812' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-23'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E812' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-24'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E812' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-27'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E812' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-28'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E812' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-29'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E812' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-04'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E812' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-05'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E812' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-07'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E812' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-08'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E812' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-11'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E812' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-12'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E812' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-13'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E812' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-14'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E812' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-19'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E812' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-22'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E812' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-25'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E812' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-26'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E812' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-27'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E812' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-29'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E812' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-01'::date,'Retardo'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E812' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-02'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E812' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-03'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E812' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-04'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E812' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-05'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E812' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-09'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E812' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-10'::date,'Retardo'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E812' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-16'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E812' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-14'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E812' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-15'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E812' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-16'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E812' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-17'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E812' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-22'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E812' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-23'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E812' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-24'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E812' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-27'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E812' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-31'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E812' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-03'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E812' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-06'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E812' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-10'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E812' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-12'::date,'Retardo'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E812' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-13'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E812' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-14'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E812' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-09'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E813' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-10'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E813' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-11'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E813' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-12'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E813' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-13'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E813' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-17'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E813' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-18'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E813' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-20'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E813' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-24'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E813' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-25'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E813' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-26'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E813' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-27'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E813' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-02'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E813' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-03'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E813' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-06'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E813' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-09'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E813' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-12'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E813' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-13'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E813' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-16'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E813' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-17'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E813' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-18'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E813' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-19'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E813' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-20'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E813' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-24'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E813' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-25'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E813' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-26'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E813' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-07'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E813' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-08'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E813' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-09'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E813' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-10'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E813' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-13'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E813' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-14'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E813' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-17'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E813' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-20'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E813' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-21'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E813' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-22'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E813' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-23'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E813' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-24'::date,'Justificacion'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E813' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-27'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E813' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-28'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E813' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-29'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E813' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-04'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E813' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-05'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E813' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-07'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E813' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-08'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E813' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-11'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E813' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-12'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E813' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-13'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E813' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-14'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E813' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-19'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E813' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-22'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E813' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-25'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E813' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-26'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E813' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-27'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E813' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-29'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E813' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-01'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E813' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-02'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E813' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-03'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E813' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-04'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E813' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-05'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E813' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-09'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E813' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-10'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E813' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-16'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E813' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-14'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E813' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-15'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E813' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-16'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E813' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-17'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E813' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-22'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E813' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-23'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E813' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-24'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E813' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-27'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E813' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-31'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E813' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-03'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E813' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-06'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E813' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-10'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E813' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-12'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E813' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-13'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E813' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-14'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E813' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-09'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E814' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-10'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E814' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-11'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E814' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-12'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E814' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-13'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E814' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-17'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E814' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-18'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E814' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-20'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E814' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-24'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E814' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-25'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E814' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-26'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E814' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-27'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E814' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-02'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E814' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-03'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E814' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-06'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E814' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-09'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E814' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-12'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E814' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-13'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E814' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-16'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E814' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-17'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E814' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-18'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E814' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-19'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E814' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-20'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E814' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-24'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E814' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-25'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E814' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-26'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E814' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-07'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E814' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-08'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E814' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-09'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E814' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-10'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E814' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-13'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E814' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-14'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E814' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-17'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E814' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-20'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E814' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-21'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E814' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-22'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E814' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-23'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E814' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-24'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E814' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-27'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E814' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-28'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E814' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-29'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E814' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-04'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E814' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-05'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E814' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-07'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E814' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-08'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E814' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-11'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E814' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-12'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E814' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-13'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E814' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-14'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E814' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-19'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E814' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-22'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E814' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-25'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E814' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-26'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E814' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-27'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E814' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-29'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E814' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-01'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E814' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-02'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E814' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-03'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E814' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-04'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E814' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-05'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E814' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-09'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E814' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-10'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E814' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-16'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E814' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-14'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E814' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-15'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E814' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-16'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E814' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-17'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E814' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-22'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E814' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-23'::date,'Retardo'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E814' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-24'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E814' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-27'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E814' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-31'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E814' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-03'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E814' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-06'::date,'Retardo'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E814' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-10'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E814' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-12'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E814' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-13'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E814' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-14'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E814' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-09'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E815' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-10'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E815' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-11'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E815' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-12'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E815' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-13'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E815' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-17'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E815' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-18'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E815' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-20'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E815' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-24'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E815' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-25'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E815' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-26'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E815' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-02-27'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E815' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-02'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E815' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-03'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E815' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-06'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E815' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-09'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E815' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-12'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E815' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-13'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E815' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-16'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E815' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-17'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E815' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-18'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E815' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-19'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E815' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-20'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E815' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-24'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E815' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-25'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E815' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-03-26'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E815' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-07'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E815' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-08'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E815' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-09'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E815' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-10'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E815' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-13'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E815' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-14'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E815' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-17'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E815' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-20'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E815' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-21'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E815' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-22'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E815' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-23'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E815' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-24'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E815' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-27'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E815' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-28'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E815' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-04-29'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E815' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-04'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E815' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-05'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E815' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-07'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E815' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-08'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E815' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-11'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E815' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-12'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E815' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-13'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E815' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-14'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E815' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-19'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E815' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-22'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E815' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-25'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E815' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-26'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E815' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-27'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E815' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-05-29'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E815' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-01'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E815' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-02'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E815' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-03'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E815' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-04'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E815' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-05'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E815' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-09'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E815' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-10'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E815' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-06-16'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E815' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-14'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E815' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-15'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E815' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-16'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E815' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-17'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E815' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-22'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E815' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-23'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E815' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-24'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E815' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-27'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E815' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-07-31'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E815' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-03'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E815' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-06'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E815' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-10'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E815' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-12'::date,'Falto'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E815' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-13'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E815' and c.nombre='8vo A';
insert into public.asistencias (estudiante_id,curso_id,profesor_id,fecha,estado)
select e.id,c.id,null,'2026-08-14'::date,'Asistio'::public.estado_asistencia
from public.estudiantes e join public.cursos c on c.id=e.curso_id
where e.nombre_completo='E815' and c.nombre='8vo A';

commit;

-- ============================================================
-- VERIFICACIÓN
-- ============================================================
select c.nombre as curso, count(e.id) as estudiantes
from public.cursos c
left join public.estudiantes e on e.curso_id=c.id
where c.nombre in ('4to A','8vo A')
group by c.nombre
order by c.nombre;

select count(*) as profesores from public.profesores;
select count(*) as calificaciones from public.calificaciones;
select count(*) as asistencias from public.asistencias;
select count(*) as horarios from public.horario_clases;

select rol, count(*) as perfiles
from public.perfiles
group by rol
order by rol;
