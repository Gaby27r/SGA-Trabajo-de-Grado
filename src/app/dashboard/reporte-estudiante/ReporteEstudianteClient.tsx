"use client";

import { useMemo, useState } from "react";

type Nivel = "Alto" | "Medio" | "Informativo";
type FiltroCurso = "Todos" | string;

type Factor = {
  titulo: string;
  detalle: string;
  nivel: Nivel;
};

type Estudiante = {
  id: string;
  nombre_completo: string;
  curso: string;
  promedioP1: number | null;
  promedioP2: number | null;
  faltas: number;
  retardos: number;
  maxConsecutivas: number;
  factores: Factor[];
  probabilidad: number | null;
  indice: number | null;
};

type Props = {
  estudiantes: Estudiante[];
  rol: string;
  conFactoresAltos: number;
  cursosProfesor: string[];
};

function formatoPromedio(valor: number | null) {
  if (valor === null || !Number.isFinite(valor)) return "Sin datos";
  return valor.toFixed(2);
}

function formatoPorcentaje(valor: number | null) {
  if (valor === null || !Number.isFinite(valor)) return "Sin datos";
  return `${valor.toFixed(1)} %`;
}

function colorNivel(nivel: Nivel) {
  switch (nivel) {
    case "Alto":
      return "border-red-200 bg-red-100 text-red-800";
    case "Medio":
      return "border-amber-200 bg-amber-100 text-amber-800";
    default:
      return "border-slate-200 bg-slate-100 text-slate-700";
  }
}

function EtiquetaNivel({ nivel }: { nivel: Nivel }) {
  return (
    <span
      className={`inline-flex items-center rounded-full border px-2.5 py-1 text-xs font-semibold ${colorNivel(nivel)}`}
    >
      {nivel}
    </span>
  );
}

function contarFactores(estudiante: Estudiante, nivel: Nivel) {
  return estudiante.factores.filter((factor) => factor.nivel === nivel).length;
}

function tieneFactoresAltos(estudiante: Estudiante) {
  return estudiante.factores.some((factor) => factor.nivel === "Alto");
}

function nivelEstudiante(estudiante: Estudiante): Nivel {
  if (tieneFactoresAltos(estudiante)) return "Alto";
  if (contarFactores(estudiante, "Medio") > 0) return "Medio";
  return "Informativo";
}

function contarAnotacionesLeves(estudiante: Estudiante): number {
  const factor = estudiante.factores.find(
    (item) =>
      item.titulo
        .normalize("NFD")
        .replace(/[\u0300-\u036f]/g, "")
        .toLowerCase() === "anotaciones leves",
  );

  if (!factor) return 0;
  const coincidencia = factor.detalle.match(/\d+/);
  return coincidencia ? Number(coincidencia[0]) : 0;
}

function ordenarFactores(estudiante: Estudiante) {
  const prioridad: Record<Nivel, number> = {
    Alto: 0,
    Medio: 1,
    Informativo: 2,
  };

  return [...estudiante.factores].sort(
    (a, b) => prioridad[a.nivel] - prioridad[b.nivel],
  );
}

function coincideCurso(cursoOriginal: string, filtro: FiltroCurso): boolean {
  if (filtro === "Todos") return true;
  return (
    cursoOriginal.trim().toLocaleLowerCase() ===
    filtro.trim().toLocaleLowerCase()
  );
}

export default function ReporteEstudianteClient({
  estudiantes,
  rol,
  conFactoresAltos,
  cursosProfesor,
}: Props) {
  const esProfesor = rol.toLowerCase() === "profesor";

  const [estudianteSeleccionado, setEstudianteSeleccionado] =
    useState<Estudiante | null>(null);

  const [filtroCurso, setFiltroCurso] = useState<FiltroCurso>("Todos");
  const [enviandoCorreo, setEnviandoCorreo] = useState(false);
  const [mensajeCorreo, setMensajeCorreo] = useState<{
    tipo: "ok" | "error";
    texto: string;
  } | null>(null);

  async function enviarReporteManual(estudianteId: string) {
    if (enviandoCorreo) return;

    const estudiante = estudiantes.find((item) => item.id === estudianteId);
    if (!estudiante) {
      setMensajeCorreo({
        tipo: "error",
        texto: "No se encontró el estudiante seleccionado.",
      });
      return;
    }

    const confirmar = window.confirm(
      `¿Deseas enviar la alerta de seguimiento al correo registrado de ${estudiante.nombre_completo}?`,
    );

    if (!confirmar) return;

    setEnviandoCorreo(true);
    setMensajeCorreo(null);

    try {
      const respuesta = await fetch("/api/alertas-riesgo/manual", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ estudianteId }),
      });

      const resultado: { error?: string; mensaje?: string } =
        await respuesta.json().catch(() => ({}));

      if (!respuesta.ok) {
        throw new Error(
          resultado.error ?? "No fue posible enviar la alerta por correo.",
        );
      }

      setMensajeCorreo({
        tipo: "ok",
        texto:
          resultado.mensaje ??
          "La alerta se procesó correctamente para el envío al correo registrado.",
      });
    } catch (error) {
      setMensajeCorreo({
        tipo: "error",
        texto:
          error instanceof Error
            ? error.message
            : "Ocurrió un error al intentar enviar el correo.",
      });
    } finally {
      setEnviandoCorreo(false);
    }
  }

  const estudiantesOrdenados = useMemo(() => {
    return [...estudiantes].sort((a, b) => {
      const prioridad: Record<Nivel, number> = {
        Alto: 0,
        Medio: 1,
        Informativo: 2,
      };

      const nivelA = nivelEstudiante(a);
      const nivelB = nivelEstudiante(b);

      if (prioridad[nivelA] !== prioridad[nivelB]) {
        return prioridad[nivelA] - prioridad[nivelB];
      }

      const altosA = contarFactores(a, "Alto");
      const altosB = contarFactores(b, "Alto");
      if (altosA !== altosB) return altosB - altosA;

      const mediosA = contarFactores(a, "Medio");
      const mediosB = contarFactores(b, "Medio");
      if (mediosA !== mediosB) return mediosB - mediosA;

      const probA = a.probabilidad ?? -1;
      const probB = b.probabilidad ?? -1;
      if (probA !== probB) return probB - probA;

      return a.nombre_completo.localeCompare(b.nombre_completo);
    });
  }, [estudiantes]);

  const cursosDisponibles = useMemo(
    () =>
      [
        ...new Set(
          estudiantes
            .map((estudiante) => estudiante.curso.trim())
            .filter(Boolean),
        ),
      ].sort((a, b) =>
        a.localeCompare(b, "es", { numeric: true, sensitivity: "base" }),
      ),
    [estudiantes],
  );

  const estudiantesFiltrados = useMemo(() => {
    if (filtroCurso === "Todos") return estudiantesOrdenados;
    return estudiantesOrdenados.filter((estudiante) =>
      coincideCurso(estudiante.curso, filtroCurso),
    );
  }, [estudiantesOrdenados, filtroCurso]);

  const totalConFactoresAltos = conFactoresAltos;

  const altosPorCurso = cursosDisponibles.map((curso) => ({
    curso,
    total: estudiantes.filter(
      (estudiante) =>
        coincideCurso(estudiante.curso, curso) &&
        tieneFactoresAltos(estudiante),
    ).length,
  }));

  // ============================================================
  // REPORTE INDIVIDUAL
  // ============================================================

  if (estudianteSeleccionado) {
    const estudiante = estudianteSeleccionado;
    const nivel = nivelEstudiante(estudiante);
    const factoresOrdenados = ordenarFactores(estudiante);
    const anotacionesLeves = contarAnotacionesLeves(estudiante);

    return (
      <main className="space-y-6">
        <div className="flex flex-wrap items-center justify-between gap-3">
          <button
            type="button"
            onClick={() => {
              setMensajeCorreo(null);
              setEstudianteSeleccionado(null);
            }}
            className="rounded-lg border border-slate-300 px-4 py-2 text-sm font-medium text-slate-700 hover:bg-slate-50"
          >
            ← Volver a la lista
          </button>

          <button
            type="button"
            disabled={enviandoCorreo}
            onClick={() => enviarReporteManual(estudiante.id)}
            className="rounded-lg bg-blue-700 px-4 py-2 text-sm font-semibold text-white transition hover:bg-blue-800 disabled:cursor-not-allowed disabled:opacity-60"
          >
            {enviandoCorreo ? "Enviando..." : "✉ Enviar reporte por correo"}
          </button>
        </div>

        {mensajeCorreo && (
          <div
            role="status"
            aria-live="polite"
            className={`rounded-lg border p-3 text-sm ${
              mensajeCorreo.tipo === "ok"
                ? "border-green-200 bg-green-50 text-green-800"
                : "border-red-200 bg-red-50 text-red-800"
            }`}
          >
            {mensajeCorreo.texto}
          </div>
        )}

        <header>
          <h1 className="text-2xl font-bold text-slate-900">
            Informe del estudiante
          </h1>
          <p className="mt-1 text-sm text-slate-500">
            Consulta individual de {estudiante.nombre_completo}.
          </p>
        </header>

        <section className="space-y-5 rounded-xl border border-[#e5d8c3] bg-white p-5">
          <div className="flex flex-wrap items-start justify-between gap-3">
            <div>
              <div className="mb-2">
                <EtiquetaNivel nivel={nivel} />
              </div>
              <h2 className="text-xl font-bold text-slate-900">
                {estudiante.nombre_completo}
              </h2>
              <p className="mt-1 text-sm text-slate-500">
                Curso: {estudiante.curso}
              </p>
            </div>

            <div className="flex flex-wrap gap-2">
              <span className="rounded-full border border-red-200 bg-red-50 px-3 py-1 text-xs text-red-800">
                {contarFactores(estudiante, "Alto")} altos
              </span>
              <span className="rounded-full border border-amber-200 bg-amber-50 px-3 py-1 text-xs text-amber-800">
                {contarFactores(estudiante, "Medio")} medios
              </span>
              <span className="rounded-full border border-slate-200 bg-slate-50 px-3 py-1 text-xs text-slate-700">
                {contarFactores(estudiante, "Informativo")} informativos
              </span>
            </div>
          </div>

          <div className="grid gap-3 sm:grid-cols-2">
            <div className="rounded border border-[#e5d8c3] p-4">
              <p className="text-sm text-slate-500">
                Probabilidad estimada de deserción
              </p>
              <p className="mt-2 text-xl font-bold text-slate-900">
                {formatoPorcentaje(estudiante.probabilidad)}
              </p>
            </div>
            <div className="rounded border border-[#e5d8c3] p-4">
              <p className="text-sm text-slate-500">Índice de riesgo</p>
              <p className="mt-2 text-xl font-bold text-slate-900">
                {formatoPorcentaje(estudiante.indice)}
              </p>
            </div>
          </div>

          <div className="grid grid-cols-2 gap-3 md:grid-cols-5">
            <div className="rounded bg-slate-50 p-3">
              <p className="text-xs text-slate-500">Promedio periodo 1</p>
              <p className="mt-1 font-bold">
                {formatoPromedio(estudiante.promedioP1)}
              </p>
            </div>
            <div className="rounded bg-slate-50 p-3">
              <p className="text-xs text-slate-500">Promedio periodo 2</p>
              <p className="mt-1 font-bold">
                {formatoPromedio(estudiante.promedioP2)}
              </p>
            </div>
            <div className="rounded bg-slate-50 p-3">
              <p className="text-xs text-slate-500">Faltas registradas</p>
              <p className="mt-1 font-bold">{estudiante.faltas}</p>
            </div>
            <div className="rounded bg-slate-50 p-3">
              <p className="text-xs text-slate-500">
                Máx. faltas consecutivas
              </p>
              <p className="mt-1 font-bold">{estudiante.maxConsecutivas}</p>
            </div>
            <div className="rounded bg-slate-50 p-3">
              <p className="text-xs text-slate-500">Retardos registrados</p>
              <p className="mt-1 font-bold">{estudiante.retardos}</p>
            </div>
          </div>

          {anotacionesLeves > 0 && (
            <div className="rounded-lg border border-slate-200 bg-slate-50 p-4">
              <p className="text-sm text-slate-600">
                Anotaciones leves registradas
              </p>
              <p className="mt-1 text-xl font-bold text-slate-900">
                {anotacionesLeves}
              </p>
            </div>
          )}

          <div>
            <h3 className="mb-3 font-bold text-slate-900">
              Factores de preocupación
            </h3>

            {factoresOrdenados.length === 0 ? (
              <p className="rounded-lg bg-slate-50 p-4 text-sm text-slate-500">
                No hay factores registrados para este estudiante.
              </p>
            ) : (
              <div className="space-y-2">
                {factoresOrdenados.map((factor, index) => (
                  <article
                    key={`${factor.titulo}-${index}`}
                    className={`rounded border p-3 ${
                      factor.nivel === "Alto"
                        ? "border-red-200 bg-red-50 text-red-800"
                        : factor.nivel === "Medio"
                          ? "border-amber-200 bg-amber-50 text-amber-800"
                          : "border-slate-200 bg-slate-50 text-slate-700"
                    }`}
                  >
                    <div className="flex flex-wrap items-center justify-between gap-2">
                      <h4 className="font-semibold">{factor.titulo}</h4>
                      <EtiquetaNivel nivel={factor.nivel} />
                    </div>
                    <p className="mt-1 text-sm">{factor.detalle}</p>
                  </article>
                ))}
              </div>
            )}
          </div>
        </section>
      </main>
    );
  }

  // ============================================================
  // LISTADO GENERAL
  // ============================================================

  return (
    <main className="space-y-6">
      <header>
        <h1 className="text-2xl font-bold text-slate-900">
          Reporte de estudiantes
        </h1>
        <p className="mt-1 text-sm text-slate-500">
          Consulta y revisa los factores de riesgo por estudiante.
        </p>
      </header>

      <section className="rounded-xl border border-[#e5d8c3] bg-white p-4">
        <p className="text-sm text-slate-500">Sesión actual</p>
        <p className="font-semibold capitalize text-slate-800">{rol}</p>
      </section>

      <section className="grid gap-3 sm:grid-cols-2 lg:grid-cols-3">
        <div className="rounded-xl border border-red-200 bg-red-50 p-4">
          <p className="text-sm text-red-800">
            Estudiantes con factores altos
          </p>
          <p className="mt-1 text-3xl font-bold text-red-700">
            {totalConFactoresAltos}
          </p>
          <p className="mt-1 text-xs text-red-700">
            {esProfesor ? "En tus cursos asignados" : "Todos los cursos"}
          </p>
        </div>

        {altosPorCurso.map(({ curso, total }) => (
          <div
            key={curso}
            className="rounded-xl border border-amber-200 bg-amber-50 p-4"
          >
            <p className="text-sm text-amber-800">
              Estudiantes de {curso}
            </p>
            <p className="mt-1 text-3xl font-bold text-amber-700">{total}</p>
            <p className="mt-1 text-xs text-amber-700">
              Con al menos un factor alto
            </p>
          </div>
        ))}
      </section>

      <section className="rounded-xl border border-[#e5d8c3] bg-white p-4">
        <div className="flex flex-wrap items-center justify-between gap-4">
          <div>
            <h2 className="font-semibold text-slate-900">
              Filtrar estudiantes por curso
            </h2>
            <p className="mt-1 text-sm text-slate-500">
              {esProfesor
                ? "Solo aparecen los cursos que tienes asignados."
                : "Selecciona qué grupo deseas visualizar."}
            </p>
          </div>

          <div className="flex flex-wrap gap-2">
            {["Todos", ...cursosDisponibles].map((curso) => (
              <button
                key={curso}
                type="button"
                onClick={() => setFiltroCurso(curso)}
                aria-pressed={filtroCurso === curso}
                className={`rounded-lg border px-4 py-2 text-sm font-semibold transition ${
                  filtroCurso === curso
                    ? "border-slate-900 bg-slate-900 text-white"
                    : "border-slate-300 bg-white text-slate-700 hover:bg-slate-50"
                }`}
              >
                {curso === "Todos" ? "Todos los cursos" : curso}
              </button>
            ))}
          </div>
        </div>

        <div className="mt-4 border-t border-slate-100 pt-3">
          <p className="text-sm text-slate-600">
            Mostrando <strong>{estudiantesFiltrados.length}</strong> de{" "}
            <strong>{estudiantes.length}</strong> estudiantes
            {filtroCurso !== "Todos" && (
              <>
                {" "}del curso <strong>{filtroCurso}</strong>
              </>
            )}
            .
          </p>
        </div>
      </section>

      {estudiantesFiltrados.length === 0 ? (
        <section className="rounded-xl border border-[#e5d8c3] bg-white p-6">
          <p className="font-medium text-slate-800">
            No hay estudiantes para mostrar.
          </p>
          <p className="mt-1 text-sm text-slate-500">
            {esProfesor
              ? "No hay estudiantes registrados en los cursos que tienes asignados."
              : "Prueba con otro curso o selecciona «Todos los cursos»."}
          </p>
        </section>
      ) : (
        <section className="space-y-3">
          {estudiantesFiltrados.map((estudiante, index) => {
            const nivel = nivelEstudiante(estudiante);
            const anotacionesLeves = contarAnotacionesLeves(estudiante);

            return (
              <article
                key={estudiante.id}
                className="flex flex-col justify-between gap-4 rounded-xl border border-[#e5d8c3] bg-white p-4 sm:flex-row sm:items-center"
              >
                <div className="flex items-start gap-3">
                  <span className="pt-1 text-sm font-semibold text-slate-400">
                    #{index + 1}
                  </span>

                  <div>
                    <div className="flex flex-wrap items-center gap-2">
                      <EtiquetaNivel nivel={nivel} />
                      <h2 className="font-bold text-slate-900">
                        {estudiante.nombre_completo}
                      </h2>
                    </div>

                    <p className="mt-1 text-sm text-slate-500">
                      Curso: {estudiante.curso}
                    </p>

                    <div className="mt-2 flex flex-wrap gap-2">
                      <span className="rounded-full bg-red-50 px-2.5 py-1 text-xs text-red-800">
                        {contarFactores(estudiante, "Alto")} altos
                      </span>
                      <span className="rounded-full bg-amber-50 px-2.5 py-1 text-xs text-amber-800">
                        {contarFactores(estudiante, "Medio")} medios
                      </span>
                      <span className="rounded-full bg-slate-100 px-2.5 py-1 text-xs text-slate-700">
                        {contarFactores(estudiante, "Informativo")} informativos
                      </span>

                      {anotacionesLeves > 0 && (
                        <span className="rounded-full bg-slate-100 px-2.5 py-1 text-xs text-slate-700">
                          {anotacionesLeves} anotaciones leves
                        </span>
                      )}
                    </div>

                    <p className="mt-2 text-sm text-slate-500">
                      Probabilidad estimada:{" "}
                      {formatoPorcentaje(estudiante.probabilidad)}
                    </p>
                  </div>
                </div>

                <button
                  type="button"
                  onClick={() => {
                    setMensajeCorreo(null);
                    setEstudianteSeleccionado(estudiante);
                  }}
                  className="shrink-0 rounded-lg bg-slate-900 px-4 py-2 text-sm font-semibold text-white transition hover:bg-slate-700"
                >
                  Revisar reporte
                </button>
              </article>
            );
          })}
        </section>
      )}
    </main>
  );
}