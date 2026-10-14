export type RolSGA = "coordinador" | "profesor" | "estudiante";

export type Curso = {
  id: string;
  nombre: string;
  jornada: string;
  created_at: string;
};

export type Profesor = {
  id: string;
  nombre_completo: string;
  correo: string | null;
  telefono: string | null;
  created_at: string;
};

export type Estudiante = {
  id: string;
  nombre_completo: string;
  documento: string | null;
  curso_id: string | null;
  acudiente: string | null;
  telefono_acudiente: string | null;
  fecha_nacimiento: string | null;
  edad_actual: number | null;
  direccion: string | null;
  estrato: number | null;
  con_quien_vive: string | null;
  anio_repetido: string | null;
  matriculado: string | null;
  reuniones_padres: boolean | null;
  total_anotaciones: number;
  graves: number;
  leves: number;
  created_at: string;
  cursos?: { nombre: string } | null;
};

export type Perfil = {
  id: string;
  nombre_completo: string;
  correo: string;
  rol: RolSGA;
  profesor_id: string | null;
  estudiante_id: string | null;
};

export const DIAS_SEMANA = [
  "Lunes",
  "Martes",
  "Miércoles",
  "Jueves",
  "Viernes",
] as const;

export type DiaSemana = (typeof DIAS_SEMANA)[number];

export type BloqueHorario = {
  id: string;
  curso_id: string;
  dia: DiaSemana;
  hora_inicio: string;
  hora_fin: string;
  materia: string;
  profesor_id: string | null;
  es_descanso: boolean;
  created_at: string;
  profesores?: { nombre_completo: string } | null;
};

export type Calificacion = {
  id: string;
  estudiante_id: string;
  curso_id: string;
  profesor_id: string;
  materia: string;
  periodo: 1 | 2;
  nota: number;
  created_at: string;
  updated_at: string;
};

export type EstadoAsistencia =
  | "Asistio"
  | "Falto"
  | "Justificacion"
  | "Retardo";

export type Asistencia = {
  id: string;
  estudiante_id: string;
  curso_id: string;
  profesor_id: string | null;
  fecha: string;
  estado: EstadoAsistencia;
  observacion: string | null;
};
