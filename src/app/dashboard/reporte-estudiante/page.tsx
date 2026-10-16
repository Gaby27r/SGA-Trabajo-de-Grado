
import { requireRole } from "@/lib/auth";
import { createClient } from "@/lib/supabase/server";
import {
  obtenerDatosEstudiantes,
  encontrar_riesgo,
} from "@/lib/riesgo/proceso";
import ReporteEstudianteClient from "./ReporteEstudianteClient";

type CursoRelacionado =
  | { nombre: string }
  | { nombre: string }[]
  | null;

type EstudianteFila = {
  id: string;
  nombre_completo: string | null;
  curso_id: string | null;
  estrato: number | null;
  anio_repetido: string | number | boolean | null;
  total_anotaciones: number | null;
  graves: number | null;
  leves: number | null;
  cursos: CursoRelacionado;
};

type NotaFila = {
  estudiante_id: string;
  periodo: number | null;
  nota: number | null;
};

type AsistenciaFila = {
  estudiante_id: string;
  fecha: string;
  estado: string | null;
};

type Factor = {
  titulo: string;
  detalle: string;
  nivel: "Alto" | "Medio" | "Informativo";
};

function promedio(valores: number[]): number | null {
  const validos = valores.filter(Number.isFinite);

  if (validos.length === 0) return null;

  return (
    validos.reduce((total, valor) => total + valor, 0) /
    validos.length
  );
}

function normalizarEstado(valor: string | null | undefined): string {
  return (valor ?? "")
    .trim()
    .toLocaleLowerCase("es")
    .normalize("NFD")
    .replace(/[\u0300-\u036f]/g, "");
}

function haRepetidoAnio(
  valor: EstudianteFila["anio_repetido"]
): boolean {
  if (typeof valor === "number") return valor === 1;
  if (typeof valor === "boolean") return valor;

  const texto = normalizarEstado(valor);

  return ["si", "1", "true", "repitente", "repetido", "repetida"].includes(
    texto
  );
}

function obtenerNombreCurso(cursos: CursoRelacionado): string {
  if (Array.isArray(cursos)) {
    return cursos[0]?.nombre ?? "Sin curso";
  }

  return cursos?.nombre ?? "Sin curso";
}

function calcularMaxConsecutivas(fechas: string[]): number {
  const fechasOrdenadas = [...new Set(fechas)].sort();

  let maximo = 0;
  let consecutivas = 0;
  let fechaAnterior: Date | null = null;

  for (const fecha of fechasOrdenadas) {
    const fechaActual = new Date(`${fecha}T00:00:00`);

    const esConsecutiva =
      fechaAnterior !== null &&
      Math.round(
        (fechaActual.getTime() - fechaAnterior.getTime()) /
          86400000
      ) === 1;

    consecutivas = esConsecutiva ? consecutivas + 1 : 1;
    maximo = Math.max(maximo, consecutivas);
    fechaAnterior = fechaActual;
  }

  return maximo;
}

function obtenerFactores(
  estudiante: EstudianteFila,
  promedioP1: number | null,
  promedioP2: number | null,
  faltas: number,
  retardos: number,
  maxConsecutivas: number
): Factor[] {
  const factores: Factor[] = [];

  if (promedioP1 !== null && promedioP1 < 3) {
    factores.push({
      titulo: "Promedio bajo en el periodo 1",
      detalle: `Promedio registrado: ${promedioP1.toFixed(2)}.`,
      nivel: "Alto",
    });
  }

  if (promedioP2 !== null && promedioP2 < 3) {
    factores.push({
      titulo: "Promedio bajo en el periodo 2",
      detalle: `Promedio registrado: ${promedioP2.toFixed(2)}.`,
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

  if (maxConsecutivas >= 2) {
    factores.push({
      titulo: "Ausencias consecutivas",
      detalle: `Se registran hasta ${maxConsecutivas} faltas consecutivas por fecha.`,
      nivel: maxConsecutivas >= 4 ? "Alto" : "Medio",
    });
  }

  if (retardos >= 5) {
    factores.push({
      titulo: "Retardos frecuentes",
      detalle: `Se registran ${retardos} retardos.`,
      nivel: retardos >= 10 ? "Alto" : "Medio",
    });
  }

  const graves = estudiante.graves ?? 0;
  const leves = estudiante.leves ?? 0;
  const anotaciones = estudiante.total_anotaciones ?? 0;

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
      nivel: "Informativo",
    });
  }

  if (anotaciones > 0 && graves === 0 && leves === 0) {
    factores.push({
      titulo: "Anotaciones registradas",
      detalle: `Total de anotaciones: ${anotaciones}.`,
      nivel: "Informativo",
    });
  }

  if (haRepetidoAnio(estudiante.anio_repetido)) {
    factores.push({
      titulo: "Año escolar repetido",
      detalle: "El registro indica que el estudiante ha repetido un año.",
      nivel: "Medio",
    });
  }

  if (estudiante.estrato != null) {
    factores.push({
      titulo: "Información socioeconómica registrada",
      detalle: `Estrato registrado: ${estudiante.estrato}. Este dato por sí solo no determina el riesgo.`,
      nivel: "Informativo",
    });
  }

  return factores;
}

function porcentajeDesdeModelo(
  valor: number | null | undefined
): number | null {
  if (valor == null || !Number.isFinite(valor)) {
    return null;
  }

  const porcentaje = valor * 100;
  return Math.min(100, Math.max(0, porcentaje));
}

export default async function ReporteEstudiantePage() {
  const perfil = await requireRole(["coordinador", "profesor"]);
  const supabase = await createClient();

  let cursosProfesor: string[] = [];

  if (perfil.rol === "profesor") {
    const { data: horarios, error } = await supabase
      .from("horario_clases")
      .select("curso_id")
      .eq("profesor_id", perfil.profesor_id)
      .eq("es_descanso", false);

    if (error) {
      throw new Error(
        `No se pudieron consultar los cursos del profesor: ${error.message}`
      );
    }

    cursosProfesor = [
      ...new Set(
        (horarios ?? [])
          .map((horario) => horario.curso_id)
          .filter((id): id is string => Boolean(id))
      ),
    ];

    if (cursosProfesor.length === 0) {
      return (
        <ReporteEstudianteClient
          estudiantes={[]}
          rol={perfil.rol}
          conFactoresAltos={0}
        />
      );
    }
  }

  let consultaEstudiantes = supabase
    .from("estudiantes")
    .select(
      "id,nombre_completo,curso_id,estrato,anio_repetido,total_anotaciones,graves,leves,cursos(nombre)"
    );

  if (perfil.rol === "profesor") {
    consultaEstudiantes = consultaEstudiantes.in(
      "curso_id",
      cursosProfesor
    );
  }

  const { data: estudiantesData, error: errorEstudiantes } =
    await consultaEstudiantes;

  if (errorEstudiantes) {
    throw new Error(
      `No se pudieron consultar los estudiantes: ${errorEstudiantes.message}`
    );
  }

  const estudiantes = (estudiantesData ?? []) as EstudianteFila[];
  const idsEstudiantes = estudiantes.map((estudiante) => estudiante.id);

  if (idsEstudiantes.length === 0) {
    return (
      <ReporteEstudianteClient
        estudiantes={[]}
        rol={perfil.rol}
        conFactoresAltos={0}
      />
    );
  }

  const [
    { data: notasData, error: errorNotas },
    { data: asistenciasData, error: errorAsistencias },
  ] = await Promise.all([
    supabase
      .from("calificaciones")
      .select("estudiante_id,periodo,nota")
      .in("estudiante_id", idsEstudiantes),

    supabase
      .from("asistencias")
      .select("estudiante_id,fecha,estado")
      .in("estudiante_id", idsEstudiantes),
  ]);

  if (errorNotas) {
    throw new Error(
      `No se pudieron consultar las calificaciones: ${errorNotas.message}`
    );
  }

  if (errorAsistencias) {
    throw new Error(
      `No se pudieron consultar las asistencias: ${errorAsistencias.message}`
    );
  }

  const notas = (notasData ?? []) as NotaFila[];
  const asistencias = (asistenciasData ?? []) as AsistenciaFila[];

  const crudos = await obtenerDatosEstudiantes();
  const riesgos = await encontrar_riesgo(crudos);

  // Conserva el enlace por nombre del modelo actual.
  // La asociación por ID debe implementarse cuando el modelo
  // también devuelva id_estudiante.
  const riesgoPorNombre = new Map<
    string,
    (typeof riesgos)[number]
  >();

  for (const riesgo of riesgos) {
    const clave = normalizarEstado(riesgo.nombre_estudiante);
    riesgoPorNombre.set(clave, riesgo);
  }

  const reportes = estudiantes.map((estudiante) => {
    const notasEstudiante = notas.filter(
      (nota) => nota.estudiante_id === estudiante.id
    );

    const promedioP1 = promedio(
      notasEstudiante
        .filter((nota) => Number(nota.periodo) === 1)
        .map((nota) => Number(nota.nota))
        .filter(Number.isFinite)
    );

    const promedioP2 = promedio(
      notasEstudiante
        .filter((nota) => Number(nota.periodo) === 2)
        .map((nota) => Number(nota.nota))
        .filter(Number.isFinite)
    );

    const asistenciasEstudiante = asistencias.filter(
      (asistencia) => asistencia.estudiante_id === estudiante.id
    );

    const faltasOrdenadas = asistenciasEstudiante
      .filter((asistencia) => {
        const estado = normalizarEstado(asistencia.estado);
        return estado === "falto" || estado === "falta";
      })
      .sort((a, b) => a.fecha.localeCompare(b.fecha));

    const faltas = faltasOrdenadas.length;

    const retardos = asistenciasEstudiante.filter(
      (asistencia) => normalizarEstado(asistencia.estado) === "retardo"
    ).length;

    const maxConsecutivas = calcularMaxConsecutivas(
      faltasOrdenadas.map((falta) => falta.fecha)
    );

    const claveRiesgo = normalizarEstado(estudiante.nombre_completo);
    const riesgo = riesgoPorNombre.get(claveRiesgo);

    return {
      id: estudiante.id,
      nombre_completo: estudiante.nombre_completo ?? "Sin nombre",
      curso: obtenerNombreCurso(estudiante.cursos),
      promedioP1,
      promedioP2,
      faltas,
      retardos,
      maxConsecutivas,
      factores: obtenerFactores(
        estudiante,
        promedioP1,
        promedioP2,
        faltas,
        retardos,
        maxConsecutivas
      ),
      probabilidad: porcentajeDesdeModelo(
        riesgo?.probabilidad_de_desercion
      ),
      indice: porcentajeDesdeModelo(riesgo?.indice_de_riesgo),
    };
  });

  const conFactoresAltos = reportes.filter((estudiante) =>
    estudiante.factores.some((factor) => factor.nivel === "Alto")
  ).length;

  return (
    <ReporteEstudianteClient
      estudiantes={reportes}
      rol={perfil.rol}
      conFactoresAltos={conFactoresAltos}
    />
  );
}
