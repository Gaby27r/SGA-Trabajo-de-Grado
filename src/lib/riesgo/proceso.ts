
import { createClient } from "@/lib/supabase/server";
import type {
  datos_crudos,
  datos_normalizados,
  estudiante_normalizado,
  riesgo_estudiante,
} from "@/app/Interfaces";

const direccion_colegio = "Cl. 19 # 7-12, Soacha, Cundinamarca";
const GEOAPIFY_API_KEY = process.env.GEOAPIFY_API_KEY;

// ============================================================
// 1. OBTENER DATOS DE SUPABASE
// ============================================================

export async function obtenerDatosEstudiantes(): Promise<datos_crudos[]> {
  const supabase = await createClient();

  const { data, error } = await supabase
    .from("vista_reporte_estudiantes")
    .select("*");

  if (error) {
    console.error("Error al obtener los datos:", error.message);
    throw new Error("No se pudieron obtener los datos de los estudiantes.");
  }

  // Conservamos todos los campos, incluido id_estudiante.
  return (data ?? []) as unknown as datos_crudos[];
}

// ============================================================
// 2. UTILIDADES
// ============================================================

function limitar(
  valor: number,
  minimo = 0,
  maximo = 1
): number {
  return Math.min(maximo, Math.max(minimo, valor));
}

function numeroValido(valor: unknown): number | null {
  if (
    valor === null ||
    valor === undefined ||
    (typeof valor === "string" && valor.trim() === "")
  ) {
    return null;
  }

  if (typeof valor === "string") {
    // Admite decimales con punto o coma.
    valor = valor.trim().replace(",", ".");
  }

  const numero = Number(valor);

  return Number.isFinite(numero) ? numero : null;
}

function normalizarTexto(valor: unknown): string {
  if (typeof valor !== "string") return "";

  return valor
    .trim()
    .toLocaleLowerCase("es")
    .normalize("NFD")
    .replace(/[\u0300-\u036f]/g, "")
    .replace(/\s+/g, " ");
}

// ============================================================
// 3. NORMALIZACIÓN DE LAS 12 VARIABLES
// ============================================================

async function normalizar_crudos(
  usuario_crudo: datos_crudos
): Promise<datos_normalizados> {

  // 1. Ausencias consecutivas.

  const racha = numeroValido(usuario_crudo.racha_ausencias);

  const ausencias_consecutivas =
    racha === null ? null : limitar(Math.max(0, racha) / 8);

  // 2. Promedio de notas bajo.
  // Un promedio alto produce un indicador de riesgo bajo.

  const notaP1 = numeroValido(usuario_crudo.promedio_notas_P1);
  const notaP2 = numeroValido(usuario_crudo.promedio_notas_P2);

  const promedio_notas_bajo =
    notaP1 === null || notaP2 === null
      ? null
      : limitar(
          1 -
            (
              limitar(notaP1, 0, 5) +
              limitar(notaP2, 0, 5)
            ) / 10
        );

  // 3. Repitencia.

  const repitioOriginal = usuario_crudo.repitio_anio;
  const repitioTexto = normalizarTexto(repitioOriginal);

  let repitencia: number | null = null;

  if (
    repitioOriginal !== null &&
    repitioOriginal !== undefined &&
    repitioTexto !== ""
  ) {
    if (
      ["repitente", "si", "1", "true", "repetido", "repetida"].includes(
        repitioTexto
      )
    ) {
      repitencia = 1;
    } else if (
      ["no", "0", "false", "no repitente", "no repetido"].includes(
        repitioTexto
      )
    ) {
      repitencia = 0;
    }
  } else if (
    typeof repitioOriginal === "number" ||
    typeof repitioOriginal === "boolean"
  ) {
    repitencia =
      repitioOriginal === 1 || repitioOriginal === true ? 1 : 0;
  }

  // 4. Estrato socioeconómico.

  const estrato = numeroValido(usuario_crudo.estrato_estudiante);

  const estrato_vulnerable =
    estrato === null
      ? null
      : limitar((6 - limitar(estrato, 1, 6)) / 5);

  // 5. Extraedad.


  const edad = numeroValido(usuario_crudo.edad_estudiante);
  const grado = normalizarTexto(usuario_crudo.grado_actual);

  let extraedad: number | null = null;

  if (edad !== null) {
    if (/^4to(?:\s+[a-z])?$/.test(grado)) {
      if (edad <= 10) extraedad = 0;
      else if (edad === 11) extraedad = 0.5;
      else extraedad = 1;
    } else if (/^8vo(?:\s+[a-z])?$/.test(grado)) {
      if (edad <= 14) extraedad = 0;
      else if (edad === 15) extraedad = 0.5;
      else extraedad = 1;
    }
  }

  // 6. Incidentes disciplinarios.
  // Se convierten los datos numéricos antes de calcular el indicador.
  // Si falta un dato, se mantiene null: no se asume que equivale a cero.

  const leves = numeroValido(
    usuario_crudo.incidentes_disciplinarios_L
  );

  const graves = numeroValido(
    usuario_crudo.incidentes_disciplinarios_G
  );

  const incidentes_disciplinarios =
    leves === null || graves === null
      ? null
      : limitar(
          (
            Math.max(0, leves) / 3 +
            Math.max(0, graves)
          ) / 5
        );

  // 7. Beca.

  const tipoBeca = normalizarTexto(usuario_crudo.tipo_beca);

  let beca_sin_convenio: number | null = null;

  if (tipoBeca === "convenio") {
    beca_sin_convenio = 0;
  } else if (tipoBeca === "matricula") {
    beca_sin_convenio = 1;
  }

  // 8. Distancia al colegio.

  const distancia = await calcularDistanciaConApi(
    usuario_crudo.direccion_estudiante
  );

  const distancia_colegio =
    distancia === null ? null : limitar(distancia / 12);

  // 9. Tardanzas: más de 15 equivale a riesgo 1.

  const cantidadTardanzas = numeroValido(
    usuario_crudo.tardanzas_estudiante
  );

  const tardanzas =
    cantidadTardanzas === null
      ? null
      : cantidadTardanzas > 15
        ? 1
        : 0;

  // 10. Proporción de ausencias injustificadas.

  const injustificadas = numeroValido(
    usuario_crudo.ausencias_injustificadas
  );

  const justificadas = numeroValido(
    usuario_crudo.ausencias_justificadas
  );

  let tipo_ausencia_injust: number | null = null;

  if (injustificadas !== null && justificadas !== null) {
    const injust = Math.max(0, injustificadas);
    const just = Math.max(0, justificadas);
    const total = injust + just;

    tipo_ausencia_injust =
      total === 0 ? 0 : limitar(injust / total);
  }

  // 11. Estructura familiar.

  let estructura_familiar: number | null = null;

  const familia = usuario_crudo.estructura_familiar_estudiante;
  const familiaTexto = normalizarTexto(familia);

  if (familiaTexto === "union libre") {
    estructura_familiar = 1;
  } else if (typeof familia === "string" && familia.trim() !== "") {
    const cantidad = contar_parientes(familia);

    if (cantidad >= 2) estructura_familiar = 0;
    else if (cantidad === 1) estructura_familiar = 0.5;
    else estructura_familiar = 1;
  }

  // 12. Inasistencia a reuniones.
  // Se conserva la interpretación del campo original.

  const inasistencias =
    usuario_crudo.inasistencias_familiares_estudiantes;

  const inasistencia_reuniones =
    inasistencias === null || inasistencias === undefined
      ? null
      : inasistencias
        ? 0
        : 1;

  // Diagnóstico de los dos indicadores que estaban faltando.

  if (promedio_notas_bajo === null) {
    console.warn("[Notas no disponibles]", {
      id_estudiante: usuario_crudo.id_estudiante,
      P1: usuario_crudo.promedio_notas_P1,
      P2: usuario_crudo.promedio_notas_P2,
    });
  }

  if (incidentes_disciplinarios === null) {
    console.warn("[Incidentes no disponibles]", {
      id_estudiante: usuario_crudo.id_estudiante,
      leves: usuario_crudo.incidentes_disciplinarios_L,
      graves: usuario_crudo.incidentes_disciplinarios_G,
    });
  }

  return {
    ausencias_consecutivas,
    promedio_notas_bajo,
    repitencia,
    estrato_vulnerable,
    extraedad,
    incidentes_disciplinarios,
    beca_sin_convenio,
    distancia_colegio,
    tardanzas,
    tipo_ausencia_injust,
    estructura_familiar,
    inasistencia_reuniones,
  };
}

// ============================================================
// 4. ESTRUCTURA FAMILIAR
// ============================================================

function contar_parientes(texto: string): number {
  if (!texto || typeof texto !== "string") return 0;

  return texto
    .toLowerCase()
    .split(/,|\s+y\s+|\s+e\s+/)
    .map((parte) => parte.trim())
    .filter(Boolean).length;
}

// ============================================================
// 5. GEOAPIFY
// ============================================================

type Coordenadas = {
  lat: number;
  lon: number;
};

const cacheCoordenadas = new Map<
  string,
  Promise<Coordenadas | null>
>();

const cacheDistancias = new Map<
  string,
  Promise<number | null>
>();

let coordenadasColegioPromise: Promise<Coordenadas | null> | null = null;

function normalizarDireccion(
  direccionOriginal: string | null | undefined
): string {
  let limpio = (direccionOriginal ?? "").trim();

  if (!limpio) return "";

  limpio = limpio
    .replace(
      /\b(apto|apartamento|torre|tor|bl|bloque|cs|casa|int|interior|conjunto)\b.*$/i,
      ""
    )
    .trim();

  if (!/soacha/i.test(limpio)) {
    limpio += ", Soacha";
  }

  if (!/cundinamarca/i.test(limpio)) {
    limpio += ", Cundinamarca";
  }

  if (!/colombia/i.test(limpio)) {
    limpio += ", Colombia";
  }

  return limpio;
}

async function obtenerCoordenadas(
  direccion: string
): Promise<Coordenadas | null> {
  if (!GEOAPIFY_API_KEY || !direccion.trim()) {
    return null;
  }

  const clave = direccion.trim().toLocaleLowerCase("es");
  const almacenada = cacheCoordenadas.get(clave);

  if (almacenada) return almacenada;

  const consulta = (async (): Promise<Coordenadas | null> => {
    try {
      const url = new URL(
        "https://api.geoapify.com/v1/geocode/search"
      );

      url.searchParams.set("text", direccion);
      url.searchParams.set("apiKey", GEOAPIFY_API_KEY);

      const response = await fetch(url.toString(), {
        signal: AbortSignal.timeout(15000),
        cache: "force-cache",
      });

      if (!response.ok) {
        console.error(
          "Error de geocodificación Geoapify:",
          response.status,
          response.statusText
        );
        return null;
      }

      const data = await response.json();
      const coords = data?.features?.[0]?.geometry?.coordinates;

      if (!Array.isArray(coords) || coords.length < 2) {
        console.warn("No se encontraron coordenadas para la dirección.");
        return null;
      }

      const lon = Number(coords[0]);
      const lat = Number(coords[1]);

      if (
        !Number.isFinite(lat) ||
        !Number.isFinite(lon) ||
        lat < -90 ||
        lat > 90 ||
        lon < -180 ||
        lon > 180
      ) {
        return null;
      }

      return { lat, lon };
    } catch (error) {
      console.error("Error geocodificando dirección:", error);
      return null;
    }
  })();

  cacheCoordenadas.set(clave, consulta);

  const resultado = await consulta;

  if (resultado === null) {
    cacheCoordenadas.delete(clave);
  }

  return resultado;
}

async function obtenerCoordenadasColegio(): Promise<Coordenadas | null> {
  if (!coordenadasColegioPromise) {
    coordenadasColegioPromise = obtenerCoordenadas(direccion_colegio);
  }

  const resultado = await coordenadasColegioPromise;

  if (resultado === null) {
    coordenadasColegioPromise = null;
  }

  return resultado;
}

async function calcularDistanciaConApi(
  direccionEstudiante: string | null | undefined
): Promise<number | null> {
  if (!GEOAPIFY_API_KEY) {
    console.warn("Falta configurar GEOAPIFY_API_KEY.");
    return null;
  }

  const direccion = normalizarDireccion(direccionEstudiante);

  if (!direccion) return null;

  const clave = direccion.toLocaleLowerCase("es");
  const almacenada = cacheDistancias.get(clave);

  if (almacenada) return almacenada;

  const consulta = (async (): Promise<number | null> => {
    try {
      const [estudiante, colegio] = await Promise.all([
        obtenerCoordenadas(direccion),
        obtenerCoordenadasColegio(),
      ]);

      if (!estudiante || !colegio) return null;

      const url = new URL("https://api.geoapify.com/v1/routing");

      url.searchParams.set(
        "waypoints",
        `${colegio.lat},${colegio.lon}|${estudiante.lat},${estudiante.lon}`
      );

      url.searchParams.set("mode", "drive");
      url.searchParams.set("apiKey", GEOAPIFY_API_KEY);

      const response = await fetch(url.toString(), {
        signal: AbortSignal.timeout(15000),
        cache: "force-cache",
      });

      if (!response.ok) {
        console.error(
          "Error al calcular ruta:",
          response.status,
          response.statusText
        );
        return null;
      }

      const data = await response.json();
      const metros = Number(data?.features?.[0]?.properties?.distance);

      if (!Number.isFinite(metros) || metros < 0) {
        console.warn("Geoapify no devolvió una distancia válida.");
        return null;
      }

      return metros / 1000;
    } catch (error) {
      console.error("Error procesando distancia:", error);
      return null;
    }
  })();

  cacheDistancias.set(clave, consulta);

  const resultado = await consulta;

  if (resultado === null) {
    cacheDistancias.delete(clave);
  }

  return resultado;
}

// ============================================================
// 6. PESOS ORIGINALES
// ============================================================

const pesosOficiales = {
  ausencias_consecutivas: 0.14,
  promedio_notas_bajo: 0.13,
  repitencia: 0.11,
  estrato_vulnerable: 0.10,
  extraedad: 0.09,
  incidentes_disciplinarios: 0.09,
  beca_sin_convenio: 0.07,
  distancia_colegio: 0.06,
  tardanzas: 0.06,
  tipo_ausencia_injust: 0.05,
  estructura_familiar: 0.05,
  inasistencia_reuniones: 0.05,
} satisfies Record<keyof datos_normalizados, number>;

const sumaPesos = Object.values(pesosOficiales).reduce(
  (suma, peso) => suma + peso,
  0
);

if (Math.abs(sumaPesos - 1) > 1e-9) {
  throw new Error(
    `Los pesos heurísticos deben sumar 1. Suma: ${sumaPesos}`
  );
}

const CENTRO_LOGISTICO = 0.4;
const PENDIENTE_LOGISTICA = 6;

// ============================================================
// 7. CÁLCULO DEL RIESGO
// ============================================================

function posible_riesgo_estudiante(
  estudiante: estudiante_normalizado
): riesgo_estudiante {
  let sumaPonderada = 0;
  let pesoDisponible = 0;
  let variablesDisponibles = 0;

  const variables = Object.keys(pesosOficiales) as Array<
    keyof datos_normalizados
  >;

  for (const variable of variables) {
    const peso = pesosOficiales[variable];
    const valor = estudiante.datos[variable];

    if (valor === null || !Number.isFinite(valor)) continue;

    sumaPonderada += limitar(valor) * peso;
    pesoDisponible += peso;
    variablesDisponibles++;
  }

  const faltantes = variables.filter((variable) => {
    const valor = estudiante.datos[variable];
    return valor === null || !Number.isFinite(valor);
  });

  console.log("[Diagnóstico de parámetros]", {
    id_estudiante: estudiante.id_estudiante,
    estudiante: estudiante.nombre_estudiante,
    disponibles: variablesDisponibles,
    total: variables.length,
    faltantes,
    valores: estudiante.datos,
  });

  if (pesoDisponible === 0) {
    return {
      id_estudiante: estudiante.id_estudiante,
      nombre_estudiante: estudiante.nombre_estudiante,
      indice_de_riesgo: null,
      probabilidad_de_desercion: null,
    };
  }

  const indice = limitar(sumaPonderada / pesoDisponible);

  const z = (indice - CENTRO_LOGISTICO) * PENDIENTE_LOGISTICA;
  const probabilidad = 1 / (1 + Math.exp(-z));

  if (variablesDisponibles < variables.length) {
    console.warn(
      `Riesgo de ${estudiante.nombre_estudiante}: ` +
        `${variablesDisponibles} de ${variables.length} variables disponibles.`
    );
  }

  return {
    id_estudiante: estudiante.id_estudiante,
    nombre_estudiante: estudiante.nombre_estudiante,
    indice_de_riesgo: Number(indice.toFixed(4)),
    probabilidad_de_desercion: Number(probabilidad.toFixed(4)),
  };
}

// ============================================================
// 8. PROCESAMIENTO CONCURRENTE LIMITADO
// ============================================================

async function procesarConLimite<T, R>(
  elementos: T[],
  limiteConcurrente: number,
  procesar: (elemento: T) => Promise<R>
): Promise<R[]> {
  const resultados = new Array<R>(elementos.length);
  let siguiente = 0;

  async function trabajador(): Promise<void> {
    while (true) {
      const indice = siguiente++;

      if (indice >= elementos.length) return;

      resultados[indice] = await procesar(elementos[indice]);
    }
  }

  const cantidadTrabajadores = Math.min(
    Math.max(1, limiteConcurrente),
    elementos.length
  );

  await Promise.all(
    Array.from(
      { length: cantidadTrabajadores },
      () => trabajador()
    )
  );

  return resultados;
}

async function procesar_datos_estudiantes(
  crudos: datos_crudos[]
): Promise<estudiante_normalizado[]> {
  return procesarConLimite(
    crudos,
    3,
    async (crudo): Promise<estudiante_normalizado> => ({
      id_estudiante: crudo.id_estudiante,
      nombre_estudiante: crudo.nombre_estudiante,
      datos: await normalizar_crudos(crudo),
    })
  );
}

// ============================================================
// 9. FUNCIÓN PÚBLICA
// ============================================================

export async function encontrar_riesgo(
  crudos: datos_crudos[]
): Promise<riesgo_estudiante[]> {
  const estudiantesNormalizados =
    await procesar_datos_estudiantes(crudos);

  return estudiantesNormalizados.map(posible_riesgo_estudiante);
}
