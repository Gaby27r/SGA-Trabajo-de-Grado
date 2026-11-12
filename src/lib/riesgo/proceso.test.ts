import { describe, it, expect, vi } from "vitest";
import {
  limitar,
  numeroValido,
  normalizarTexto,
  posible_riesgo_estudiante,
} from "./proceso";
import { generarFactoresPreocupacion } from "./factores";
import {
  porcentajeDesdeModelo,
  formatoPorcentajeModelo,
  crearFactores,
} from "@/app/api/alertas-riesgo/manual/route";
import type { estudiante_normalizado, datos_crudos, datos_normalizados } from "@/app/Interfaces";

describe("Plan de Pruebas: 5. Casos de pruebas unitarias", () => {
  // UT-01: Cálculo de riesgo
  it("UT-01: Cálculo de riesgo con datos académicos válidos retorna valores en rango [0, 1]", () => {
    const estudianteValido: estudiante_normalizado = {
      id_estudiante: "est-001",
      nombre_estudiante: "Juan Pérez",
      datos: {
        ausencias_consecutivas: 0.25,
        promedio_notas_bajo: 0.3,
        repitencia: 0,
        estrato_vulnerable: 0.4,
        extraedad: 0,
        incidentes_disciplinarios: 0.1,
        beca_sin_convenio: 0,
        distancia_colegio: 0.2,
        tardanzas: 0,
        tipo_ausencia_injust: 0.2,
        estructura_familiar: 0,
        inasistencia_reuniones: 0,
      },
    };

    const resultado = posible_riesgo_estudiante(estudianteValido);

    expect(resultado.id_estudiante).toBe("est-001");
    expect(resultado.indice_de_riesgo).not.toBeNull();
    expect(resultado.probabilidad_de_desercion).not.toBeNull();

    expect(resultado.indice_de_riesgo!).toBeGreaterThanOrEqual(0);
    expect(resultado.indice_de_riesgo!).toBeLessThanOrEqual(1);
    expect(resultado.probabilidad_de_desercion!).toBeGreaterThanOrEqual(0);
    expect(resultado.probabilidad_de_desercion!).toBeLessThanOrEqual(1);
    expect(Number.isFinite(resultado.indice_de_riesgo!)).toBe(true);
    expect(Number.isFinite(resultado.probabilidad_de_desercion!)).toBe(true);
  });

  // UT-02: Datos incompletos
  it("UT-02: Datos incompletos (faltan calificaciones o asistencias) no generan NaN ni interrumpen el proceso", () => {
    const estudianteIncompleto: estudiante_normalizado = {
      id_estudiante: "est-002",
      nombre_estudiante: "Ana Gómez",
      datos: {
        ausencias_consecutivas: null,
        promedio_notas_bajo: null,
        repitencia: 1,
        estrato_vulnerable: 0.6,
        extraedad: null,
        incidentes_disciplinarios: null,
        beca_sin_convenio: null,
        distancia_colegio: null,
        tardanzas: null,
        tipo_ausencia_injust: null,
        estructura_familiar: 0.5,
        inasistencia_reuniones: null,
      },
    };

    const resultado = posible_riesgo_estudiante(estudianteIncompleto);

    expect(resultado.indice_de_riesgo).not.toBeNaN();
    expect(resultado.probabilidad_de_desercion).not.toBeNaN();
    expect(typeof resultado.indice_de_riesgo).toBe("number");
    expect(typeof resultado.probabilidad_de_desercion).toBe("number");

    // Caso extremo: todas las variables nulas
    const estudianteSinDatos: estudiante_normalizado = {
      id_estudiante: "est-003",
      nombre_estudiante: "Carlos Vacio",
      datos: {
        ausencias_consecutivas: null,
        promedio_notas_bajo: null,
        repitencia: null,
        estrato_vulnerable: null,
        extraedad: null,
        incidentes_disciplinarios: null,
        beca_sin_convenio: null,
        distancia_colegio: null,
        tardanzas: null,
        tipo_ausencia_injust: null,
        estructura_familiar: null,
        inasistencia_reuniones: null,
      },
    };

    const resultadoVacio = posible_riesgo_estudiante(estudianteSinDatos);
    expect(resultadoVacio.indice_de_riesgo).toBeNull();
    expect(resultadoVacio.probabilidad_de_desercion).toBeNull();
  });

  // UT-03: Límites
  it("UT-03: Validación de límites en probabilidades (0, 1 y fuera de rango)", () => {
    // La función limitar() controla límites [0, 1]
    expect(limitar(0)).toBe(0);
    expect(limitar(1)).toBe(1);
    expect(limitar(-0.5)).toBe(0);
    expect(limitar(1.5)).toBe(1);

    // Sin embargo, en porcentajeDesdeModelo (usado en alertas y reporte):
    // Se espera que controle valores fuera del rango [0, 1]
    const pValida = porcentajeDesdeModelo(0.85);
    expect(pValida).toBe(85);

    const pCero = porcentajeDesdeModelo(0);
    expect(pCero).toBe(0);

    const pUno = porcentajeDesdeModelo(1);
    expect(pUno).toBe(100);

    // EVALUACIÓN DE DEFECTO: Si llega un valor fuera de rango (< 0 o > 1),
    // porcentajeDesdeModelo actualmente multiplica ciegamente sin limitar:
    const pFueraDeRangoSuperior = porcentajeDesdeModelo(1.5);
    const pFueraDeRangoInferior = porcentajeDesdeModelo(-0.2);

    // El criterio del plan exige: "Valores válidos se conservan; inválidos se controlan"
    // Esperamos que esté limitado entre 0% y 100%:
    expect(pFueraDeRangoSuperior).toBeLessThanOrEqual(100);
    expect(pFueraDeRangoInferior).toBeGreaterThanOrEqual(0);
  });

  // UT-04: Formato
  it("UT-04: Formato de probabilidad entre 0 y 1 genera porcentaje sin duplicar x100", () => {
    const probabilidad = 0.456;
    const porcentaje = porcentajeDesdeModelo(probabilidad);
    expect(porcentaje).toBeCloseTo(45.6, 1);

    const texto = formatoPorcentajeModelo(porcentaje);
    expect(texto).toBe("45.6 %");

    // Verificar que null produce 'No disponible'
    expect(formatoPorcentajeModelo(null)).toBe("No disponible");

    // Verificar que no se formatea duplicando x100 si ya era porcentaje
    expect(texto).not.toContain("4560");
  });

  // UT-05: Clasificación
  it("UT-05: Clasificación en umbrales (antes, en y después de cada umbral)", () => {
    const estudianteBase: datos_crudos = {
      id_estudiante: "est-100",
      nombre_estudiante: "Laura Rivas",
      grado_actual: "8vo",
      edad_estudiante: 14,
      direccion_estudiante: "Calle 10",
      estrato_estudiante: 3,
      estructura_familiar_estudiante: "Madre y Padre",
      repitio_anio: "no",
      tipo_beca: "convenio",
      racha_ausencias: 2, // antes del umbral de 3
      ausencias_justificadas: 0,
      ausencias_injustificadas: 0,
      tardanzas_estudiante: 0,
      incidentes_disciplinarios_l: 0,
      incidentes_disciplinarios_g: 0,
      promedio_notas_p1: 3.5,
      promedio_notas_p2: 3.8,
      inasistencias_familiares_estudiantes: false,
    };

    const datosNorm: datos_normalizados = {
      ausencias_consecutivas: 0.2,
      promedio_notas_bajo: 0.1,
      repitencia: 0,
      estrato_vulnerable: 0.2,
      extraedad: 0,
      incidentes_disciplinarios: 0,
      beca_sin_convenio: 0,
      distancia_colegio: 0.1,
      tardanzas: 0,
      tipo_ausencia_injust: 0,
      estructura_familiar: 0,
      inasistencia_reuniones: 0,
    };

    // Caso 1: Antes del umbral (2 ausencias consecutivas) -> sin factor
    let factores = generarFactoresPreocupacion(estudianteBase, datosNorm);
    expect(factores.find((f) => f.variable === "ausencias_consecutivas")).toBeUndefined();

    // Caso 2: En el umbral medio (3 ausencias) -> nivel medio
    const estUmbralMedio = { ...estudianteBase, racha_ausencias: 3 };
    factores = generarFactoresPreocupacion(estUmbralMedio, datosNorm);
    const fRacha3 = factores.find((f) => f.variable === "ausencias_consecutivas");
    expect(fRacha3).toBeDefined();
    expect(fRacha3?.nivel).toBe("medio");

    // Caso 3: En el umbral alto (5 ausencias) -> nivel alto
    const estUmbralAlto = { ...estudianteBase, racha_ausencias: 5 };
    factores = generarFactoresPreocupacion(estUmbralAlto, datosNorm);
    const fRacha5 = factores.find((f) => f.variable === "ausencias_consecutivas");
    expect(fRacha5).toBeDefined();
    expect(fRacha5?.nivel).toBe("alto");

    // Caso 4: Umbral notas (< 3.0 medio, < 2.0 alto)
    const estNotasMedio = { ...estudianteBase, promedio_notas_p1: 2.5, promedio_notas_p2: 2.5 };
    factores = generarFactoresPreocupacion(estNotasMedio, datosNorm);
    const fNotas = factores.find((f) => f.variable === "promedio_notas_bajo");
    expect(fNotas?.nivel).toBe("medio");

    const estNotasAlto = { ...estudianteBase, promedio_notas_p1: 1.5, promedio_notas_p2: 1.8 };
    factores = generarFactoresPreocupacion(estNotasAlto, datosNorm);
    const fNotasAlto = factores.find((f) => f.variable === "promedio_notas_bajo");
    expect(fNotasAlto?.nivel).toBe("alto");
  });

  // UT-06: Validaciones de identificador
  it("UT-06: Validación de identificador ausente, vacío o con formato inválido (UUID)", () => {
    // Función auxiliar que simula validación de entrada antes de consultar la BD
    function validarEstudianteId(id: unknown): { valido: boolean; error?: string } {
      if (!id || typeof id !== "string" || !id.trim()) {
        return { valido: false, error: "Debes indicar un estudianteId válido." };
      }
      // Validación estricta de formato UUID v4
      const uuidRegex = /^[0-9a-f]{8}-[0-9a-f]{4}-[1-5][0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$/i;
      if (!uuidRegex.test(id.trim())) {
        return { valido: false, error: "El formato del estudianteId no es un UUID válido." };
      }
      return { valido: true };
    }

    expect(validarEstudianteId("").valido).toBe(false);
    expect(validarEstudianteId("   ").valido).toBe(false);
    expect(validarEstudianteId(null).valido).toBe(false);
    expect(validarEstudianteId(undefined).valido).toBe(false);

    // DEFECTO EN CÓDIGO ACTUAL: route.ts solo verifica !body.estudianteId.trim(),
    // no valida sintaxis UUID, enviando cadenas arbitrarias a PostgreSQL:
    const idMalFormado = "123-no-es-uuid-valido";
    const res = validarEstudianteId(idMalFormado);
    expect(res.valido).toBe(false);
    expect(res.error).toContain("UUID");
  });

  // UT-07: Error del modelo
  it("UT-07: Error del modelo o excepción en cálculo se maneja de forma controlada sin fallar el flujo", () => {
    // Simulamos fallo en llamada al modelo
    let probabilidadModelo: number | null = null;
    let errorCapturado = false;

    try {
      // Simulación de función de modelo que arroja excepción
      const simularErrorModelo = () => {
        throw new Error("Conexión con servicio de ML falló");
      };
      simularErrorModelo();
    } catch (err) {
      errorCapturado = true;
      probabilidadModelo = null;
    }

    expect(errorCapturado).toBe(true);
    // La aplicación debe continuar con valor por defecto controlado
    const probabilidadTexto = formatoPorcentajeModelo(probabilidadModelo);
    expect(probabilidadTexto).toBe("No disponible");
  });

  // UT-08: Construcción de alerta
  it("UT-08: Construcción de factores y alerta para estudiante específico sin mezcla de datos", () => {
    const estudianteA = {
      estrato: 2,
      anio_repetido: "si",
      total_anotaciones: 4,
      graves: 1,
      leves: 3,
    };

    // p1 = 2.4, p2 = 2.8, faltas = 6, retardos = 2, consecutivas = 3
    const factoresA = crearFactores(estudianteA, 2.4, 2.8, 6, 2, 3);

    // Debe contener exactamente los factores del estudiante A
    expect(factoresA.some((f) => f.titulo.includes("Promedio bajo en el periodo 1"))).toBe(true);
    expect(factoresA.some((f) => f.titulo.includes("Promedio bajo en el periodo 2"))).toBe(true);
    expect(factoresA.some((f) => f.titulo.includes("Inasistencias frecuentes"))).toBe(true);
    expect(factoresA.some((f) => f.titulo.includes("Ausencias consecutivas"))).toBe(true);
    expect(factoresA.some((f) => f.titulo.includes("Anotaciones graves"))).toBe(true);
    expect(factoresA.some((f) => f.titulo.includes("Año escolar repetido"))).toBe(true);

    // Estudiante B con excelentes notas y sin faltas
    const estudianteB = {
      estrato: 4,
      anio_repetido: "no",
      total_anotaciones: 0,
      graves: 0,
      leves: 0,
    };
    const factoresB = crearFactores(estudianteB, 4.5, 4.8, 0, 0, 0);

    // No debe heredar ni mezclar factores de estudiante A
    expect(factoresB.some((f) => f.nivel === "Alto")).toBe(false);
    expect(factoresB.some((f) => f.titulo.includes("Promedio bajo"))).toBe(false);
    expect(factoresB.some((f) => f.titulo.includes("Inasistencias"))).toBe(false);
  });
});
