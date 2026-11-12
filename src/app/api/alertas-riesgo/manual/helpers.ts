// Funciones auxiliares para el procesamiento y formateo de alertas manuales de riesgo

type Nivel = "Alto" | "Medio" | "Informativo";

export type Factor = {
  titulo: string;
  detalle: string;
  nivel: Nivel;
};

export function normalizar(valor: unknown): string {
  return String(valor ?? "")
    .trim()
    .toLocaleLowerCase("es")
    .normalize("NFD")
    .replace(/[\u0300-\u036f]/g, "")
    .replace(/\s+/g, " ");
}

export function promedio(notas: number[]): number | null {
  const validas = notas.filter(Number.isFinite);
  if (!validas.length) return null;
  return validas.reduce((total, nota) => total + nota, 0) / validas.length;
}

export function maxConsecutivas(fechas: string[]): number {
  const ordenadas = [...new Set(fechas)].sort();
  let maximo = 0;
  let consecutivas = 0;
  let anterior: Date | null = null;

  for (const fecha of ordenadas) {
    const actual = new Date(`${fecha}T00:00:00Z`);

    if (
      anterior &&
      Math.round(
        (actual.getTime() - anterior.getTime()) / 86400000,
      ) === 1
    ) {
      consecutivas++;
    } else {
      consecutivas = 1;
    }

    maximo = Math.max(maximo, consecutivas);
    anterior = actual;
  }

  return maximo;
}

export function semanaColombia(): { inicio: string; fin: string } {
  const partes = new Intl.DateTimeFormat("en-CA", {
    timeZone: "America/Bogota",
    year: "numeric",
    month: "2-digit",
    day: "2-digit",
  }).formatToParts(new Date());

  const anio = parseInt(partes.find((p) => p.type === "year")?.value ?? "0", 10);
  const mes = parseInt(partes.find((p) => p.type === "month")?.value ?? "1", 10) - 1;
  const dia = parseInt(partes.find((p) => p.type === "day")?.value ?? "1", 10);

  const hoy = new Date(Date.UTC(anio, mes, dia));
  const diaSemana = hoy.getUTCDay();
  const distanciaLunes = (diaSemana + 6) % 7;

  const lunes = new Date(hoy);
  lunes.setUTCDate(hoy.getUTCDate() - distanciaLunes);

  const domingo = new Date(lunes);
  domingo.setUTCDate(lunes.getUTCDate() + 6);

  const formatoIso = (d: Date) => d.toISOString().slice(0, 10);

  return {
    inicio: `${formatoIso(lunes)}T00:00:00.000Z`,
    fin: `${formatoIso(domingo)}T23:59:59.999Z`,
  };
}

export function escaparHtml(valor: unknown): string {
  return String(valor ?? "").replace(/[&<>"']/g, (caracter) => {
    const entidades: Record<string, string> = {
      "&": "&amp;",
      "<": "&lt;",
      ">": "&gt;",
      '"': "&quot;",
      "'": "&#39;",
    };

    return entidades[caracter];
  });
}

export function formatoPromedio(valor: number | null): string {
  return valor === null ? "Sin datos" : valor.toFixed(2);
}

export function porcentajeDesdeModelo(
  valor: number | null | undefined,
): number | null {
  if (
    valor === null ||
    valor === undefined ||
    !Number.isFinite(valor)
  ) {
    return null;
  }

  // El modelo entrega la probabilidad en escala de 0 a 1.
  // Se convierte a porcentaje para mostrarla igual que en el informe y se limita al rango [0, 100].
  return Math.min(100, Math.max(0, valor * 100));
}

export function formatoPorcentajeModelo(valor: number | null): string {
  return valor === null ? "No disponible" : `${valor.toFixed(1)} %`;
}

export function crearFactores(
  estudiante: {
    estrato: number | null;
    anio_repetido: string | number | boolean | null;
    total_anotaciones: number | null;
    graves: number | null;
    leves: number | null;
  },
  p1: number | null,
  p2: number | null,
  faltas: number,
  retardos: number,
  consecutivas: number,
): Factor[] {
  const factores: Factor[] = [];

  if (p1 !== null && p1 < 3) {
    factores.push({
      titulo: "Promedio bajo en el periodo 1",
      detalle: `Promedio registrado: ${p1.toFixed(2)}.`,
      nivel: "Alto",
    });
  }

  if (p2 !== null && p2 < 3) {
    factores.push({
      titulo: "Promedio bajo en el periodo 2",
      detalle: `Promedio registrado: ${p2.toFixed(2)}.`,
      nivel: "Alto",
    });
  }

  if (faltas >= 5) {
    factores.push({
      titulo: "Inasistencias frecuentes",
      detalle: `Se registran ${faltas} faltas.`,
      nivel: faltas >= 10 ? "Alto" : "Medio",
    });
  }

  if (consecutivas >= 2) {
    factores.push({
      titulo: "Ausencias consecutivas",
      detalle: `Se registran hasta ${consecutivas} faltas consecutivas.`,
      nivel: consecutivas >= 4 ? "Alto" : "Medio",
    });
  }

  if (retardos >= 5) {
    factores.push({
      titulo: "Retardos frecuentes",
      detalle: `Se registran ${retardos} retardos.`,
      nivel: retardos >= 10 ? "Alto" : "Medio",
    });
  }

  const graves = Math.max(0, estudiante.graves ?? 0);
  const leves = Math.max(0, estudiante.leves ?? 0);
  const total = Math.max(0, estudiante.total_anotaciones ?? 0);

  if (graves > 0) {
    factores.push({
      titulo: "Anotaciones graves",
      detalle: `Se registran ${graves} anotaciones graves.`,
      nivel: "Alto",
    });
  }

  if (leves > 0) {
    factores.push({
      titulo: "Anotaciones leves",
      detalle: `Se registran ${leves} anotaciones leves.`,
      nivel: leves >= 5 ? "Alto" : leves >= 3 ? "Medio" : "Informativo",
    });
  }

  if (total > 0 && graves === 0 && leves === 0) {
    factores.push({
      titulo: "Anotaciones registradas",
      detalle: `Total de anotaciones: ${total}.`,
      nivel: "Informativo",
    });
  }

  const repetido = estudiante.anio_repetido;

  const repitio =
    typeof repetido === "boolean"
      ? repetido
      : typeof repetido === "number"
        ? repetido === 1
        : ["si", "1", "true", "repitente", "repetido", "repetida"].includes(
            normalizar(repetido),
          );

  if (repitio) {
    factores.push({
      titulo: "Año escolar repetido",
      detalle: "El registro indica que el estudiante ha repetido un año.",
      nivel: "Medio",
    });
  }

  if (estudiante.estrato !== null) {
    factores.push({
      titulo: "Información socioeconómica registrada",
      detalle: `Estrato registrado: ${estudiante.estrato}. Este dato por sí solo no determina el riesgo.`,
      nivel: "Informativo",
    });
  }

  return factores;
}
