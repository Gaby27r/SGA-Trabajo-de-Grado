
import type {
    datos_crudos,
    datos_normalizados,
} from "@/app/Interfaces";

export type NivelFactor = "bajo" | "medio" | "alto";

export interface FactorPreocupacion {
    variable: string;
    titulo: string;
    valorObservado: string;
    explicacion: string;
    nivel: NivelFactor;
}

export function generarFactoresPreocupacion(
    estudiante: datos_crudos,
    datos: datos_normalizados
): FactorPreocupacion[] {
    const factores: FactorPreocupacion[] = [];

    // Inasistencias consecutivas
    if (estudiante.racha_ausencias >= 3) {
        factores.push({
            variable: "ausencias_consecutivas",
            titulo: "Inasistencias consecutivas",
            valorObservado:
                `${estudiante.racha_ausencias} inasistencias consecutivas`,
            explicacion:
                "La continuidad de las inasistencias requiere revisar " +
                "si existe una dificultad de asistencia o una situación " +
                "que esté afectando la continuidad escolar.",
            nivel:
                estudiante.racha_ausencias >= 5
                    ? "alto"
                    : "medio",
        });
    }

    // Rendimiento académico
    const notas = [
        estudiante.promedio_notas_p1,
        estudiante.promedio_notas_p2,
    ];

    if (notas.every(Number.isFinite)) {
        const promedio =
            (estudiante.promedio_notas_p1 +
                estudiante.promedio_notas_p2) / 2;

        if (promedio < 3) {
            factores.push({
                variable: "promedio_notas_bajo",
                titulo: "Rendimiento académico bajo",
                valorObservado: `Promedio: ${promedio.toFixed(2)}`,
                explicacion:
                    "El promedio está por debajo de 3.0. Conviene revisar " +
                    "las asignaturas con dificultades y la evolución " +
                    "de las calificaciones.",
                nivel: promedio < 2 ? "alto" : "medio",
            });
        }
    }

    // Retardos
    if (
        Number.isFinite(estudiante.tardanzas_estudiante) &&
        estudiante.tardanzas_estudiante > 0
    ) {
        factores.push({
            variable: "tardanzas",
            titulo: "Retardos registrados",
            valorObservado:
                `${estudiante.tardanzas_estudiante} retardos`,
            explicacion:
                "Se han registrado retardos. Es conveniente revisar " +
                "su frecuencia y determinar si se repiten en ciertos días.",
            nivel:
                estudiante.tardanzas_estudiante > 15
                    ? "alto"
                    : estudiante.tardanzas_estudiante >= 6
                        ? "medio"
                        : "bajo",
        });
    }

    // Ausencias injustificadas
    if (
        Number.isFinite(estudiante.ausencias_injustificadas) &&
        estudiante.ausencias_injustificadas > 0
    ) {
        factores.push({
            variable: "tipo_ausencia_injust",
            titulo: "Ausencias injustificadas",
            valorObservado:
                `${estudiante.ausencias_injustificadas} ausencias`,
            explicacion:
                "Hay ausencias sin justificación registrada. Se recomienda " +
                "verificar los soportes y conversar con el estudiante " +
                "o su acudiente cuando corresponda.",
            nivel:
                estudiante.ausencias_injustificadas >= 5
                    ? "alto"
                    : estudiante.ausencias_injustificadas >= 3
                        ? "medio"
                        : "bajo",
        });
    }

    // Incidentes disciplinarios
    const leves = estudiante.incidentes_disciplinarios_l;
    const graves = estudiante.incidentes_disciplinarios_g;

    if (
        Number.isFinite(leves) &&
        Number.isFinite(graves) &&
        (leves > 0 || graves > 0)
    ) {
        factores.push({
            variable: "incidentes_disciplinarios",
            titulo: "Incidentes registrados",
            valorObservado: `${leves} leves y ${graves} graves`,
            explicacion:
                "Existen incidentes registrados que requieren revisión " +
                "del contexto y seguimiento por parte del personal autorizado.",
            nivel:
                graves > 0
                    ? "alto"
                    : leves >= 5
                        ? "alto"
                        : leves >= 3
                            ? "medio"
                            : "bajo",
        });
    }

    // Solo mostrar factores válidos para el cálculo.
    // Los valores normalizados nulos no se interpretan como cero.
    const variablesDisponibles = Object.values(datos).filter(
        (valor) => valor !== null && Number.isFinite(valor)
    ).length;

    if (variablesDisponibles === 0) {
        return [];
    }

    return factores;
}
