export interface datos_crudos {
    id_estudiante: string;
    nombre_estudiante: string;
    racha_ausencias: number;
    promedio_notas_P1: number;
    promedio_notas_P2: number;
    repitio_anio: string;
    estrato_estudiante: number;
    edad_estudiante: number;
    grado_actual: string;
    incidentes_disciplinarios_L: number;
    incidentes_disciplinarios_G: number;
    tipo_beca: string;
    tardanzas_estudiante: number;
    ausencias_injustificadas: number;
    ausencias_justificadas: number;
    estructura_familiar_estudiante: string;
    inasistencias_familiares_estudiantes: boolean;
    direccion_estudiante: string;
}

export interface datos_normalizados {
    ausencias_consecutivas: number | null;
    promedio_notas_bajo: number | null;
    repitencia: number | null;
    estrato_vulnerable: number | null;
    extraedad: number | null;
    incidentes_disciplinarios: number | null;
    distancia_colegio: number | null;
    beca_sin_convenio: number | null;
    tardanzas: number | null;
    tipo_ausencia_injust: number | null;
    estructura_familiar: number | null;
    inasistencia_reuniones: number | null;
}

export interface estudiante_normalizado {
    id_estudiante: string;
    nombre_estudiante: string;
    datos: datos_normalizados;
}

export interface riesgo_estudiante {
    id_estudiante: string;
    nombre_estudiante: string;
    indice_de_riesgo: number | null;
    probabilidad_de_desercion: number | null;
}