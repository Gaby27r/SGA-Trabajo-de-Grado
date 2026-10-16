
"use client";

import { useState } from "react";

type Estudiante = {
  id: string;
  nombre_completo: string;
  curso: string;
  promedioP1: number | null;
  promedioP2: number | null;
  faltas: number;
  maxConsecutivas: number;
  retardos: number;
  factores: {
    titulo: string;
    detalle: string;
    nivel: "Alto" | "Medio" | "Informativo";
  }[];
  probabilidad: number | null;
  indice: number | null;
};

type Props = {
  estudiantes: Estudiante[];
  rol: string;
  conFactoresAltos: number;
};

function formatoPromedio(valor: number | null): string {
  return valor === null || !Number.isFinite(valor)
    ? "Sin datos"
    : valor.toFixed(2);
}

function formatoPorcentaje(valor: number | null): string | null {
  if (valor === null || !Number.isFinite(valor)) {
    return null;
  }

  const limitado = Math.min(100, Math.max(0, valor));
  return `${limitado.toFixed(1)} %`;
}

function colorNivel(nivel: Estudiante["factores"][number]["nivel"]) {
  switch (nivel) {
    case "Alto":
      return "border-red-200 bg-red-50 text-red-800";
    case "Medio":
      return "border-amber-200 bg-amber-50 text-amber-800";
    default:
      return "border-slate-200 bg-slate-50 text-slate-700";
  }
}

export default function ReporteEstudianteClient({
  estudiantes,
  rol,
  conFactoresAltos,
}: Props) {
  const [estudianteSeleccionado, setEstudianteSeleccionado] =
    useState<Estudiante | null>(null);

  if (estudianteSeleccionado) {
    const estudiante = estudianteSeleccionado;

    return (
      <div className="flex flex-col gap-6">
        <button
          type="button"
          onClick={() => setEstudianteSeleccionado(null)}
          className="w-fit rounded-sm border border-rule px-4 py-2 text-sm font-medium text-ink hover:bg-slate-50"
        >
          ← Volver a la lista
        </button>

        <header>
          <h1 className="font-display text-3xl text-ink">
            Informe del estudiante
          </h1>
          <p className="mt-1 text-ink-soft">
            Consulta individual de {estudiante.nombre_completo}.
          </p>
        </header>

        <article className="rounded-sm border border-rule bg-white p-5">
          <h2 className="text-xl font-semibold text-ink">
            {estudiante.nombre_completo}
          </h2>

          <p className="mt-1 text-sm text-ink-soft">
            Curso: {estudiante.curso}
          </p>

          <div className="mt-5 grid grid-cols-1 gap-3 sm:grid-cols-2">
            <div className="rounded-sm border border-rule p-4">
              <p className="text-sm text-ink-soft">
                Probabilidad estimada de deserción
              </p>
              <p className="mt-2 text-2xl font-semibold text-ink">
                {formatoPorcentaje(estudiante.probabilidad) ??
                  "Sin datos suficientes"}
              </p>
            </div>

            <div className="rounded-sm border border-rule p-4">
              <p className="text-sm text-ink-soft">Índice de riesgo</p>
              <p className="mt-2 text-2xl font-semibold text-ink">
                {formatoPorcentaje(estudiante.indice) ??
                  "No disponible"}
              </p>
            </div>
          </div>

          <div className="mt-5 grid grid-cols-2 gap-3 sm:grid-cols-5">
            <div className="rounded-sm bg-slate-50 p-3">
              <p className="text-xs text-ink-soft">Promedio periodo 1</p>
              <p className="mt-1 font-semibold text-ink">
                {formatoPromedio(estudiante.promedioP1)}
              </p>
            </div>

            <div className="rounded-sm bg-slate-50 p-3">
              <p className="text-xs text-ink-soft">Promedio periodo 2</p>
              <p className="mt-1 font-semibold text-ink">
                {formatoPromedio(estudiante.promedioP2)}
              </p>
            </div>

            <div className="rounded-sm bg-slate-50 p-3">
              <p className="text-xs text-ink-soft">Faltas registradas</p>
              <p className="mt-1 font-semibold text-ink">
                {estudiante.faltas}
              </p>
            </div>

            <div className="rounded-sm bg-slate-50 p-3">
              <p className="text-xs text-ink-soft">
                Máx. faltas consecutivas
              </p>
              <p className="mt-1 font-semibold text-ink">
                {estudiante.maxConsecutivas}
              </p>
            </div>

            <div className="rounded-sm bg-slate-50 p-3">
              <p className="text-xs text-ink-soft">
                Retardos registrados
              </p>
              <p className="mt-1 font-semibold text-ink">
                {estudiante.retardos}
              </p>
            </div>
          </div>

          <div className="mt-6">
            <h3 className="font-semibold text-ink">
              Factores de preocupación
            </h3>

            {estudiante.factores.length === 0 ? (
              <p className="mt-3 text-sm text-ink-soft">
                No hay factores registrados para este estudiante.
              </p>
            ) : (
              <ul className="mt-3 flex flex-col gap-2">
                {estudiante.factores.map((factor, indice) => (
                  <li
                    key={`${estudiante.id}-${indice}`}
                    className={`rounded-sm border p-3 ${colorNivel(
                      factor.nivel
                    )}`}
                  >
                    <div className="flex flex-wrap items-center justify-between gap-2">
                      <span className="font-medium">{factor.titulo}</span>
                      <span className="text-xs font-semibold">
                        {factor.nivel}
                      </span>
                    </div>
                    <p className="mt-1 text-sm">{factor.detalle}</p>
                  </li>
                ))}
              </ul>
            )}
          </div>
        </article>
      </div>
    );
  }

  return (
    <div className="flex flex-col gap-6">
      <header>
        <h1 className="font-display text-3xl text-ink">
          Reporte de estudiante
        </h1>
        <p className="mt-1 text-ink-soft">
          Selecciona un estudiante para consultar su informe individual.
        </p>
      </header>

      <section className="grid grid-cols-1 gap-4 sm:grid-cols-3">
        <div className="rounded-sm border border-rule p-5">
          <p className="text-sm text-ink-soft">
            Estudiantes consultables
          </p>
          <p className="mt-2 text-3xl font-semibold text-ink">
            {estudiantes.length}
          </p>
        </div>

        <div className="rounded-sm border border-rule p-5">
          <p className="text-sm text-ink-soft">
            Con factores de nivel alto
          </p>
          <p className="mt-2 text-3xl font-semibold text-ink">
            {conFactoresAltos}
          </p>
        </div>

        <div className="rounded-sm border border-rule p-5">
          <p className="text-sm text-ink-soft">Rol de consulta</p>
          <p className="mt-2 text-xl font-semibold capitalize text-ink">
            {rol}
          </p>
        </div>
      </section>

      <section className="flex flex-col gap-3">
        <h2 className="text-xl font-semibold text-ink">
          Lista de estudiantes
        </h2>

        {estudiantes.length === 0 ? (
          <div className="rounded-sm border border-rule p-6 text-ink-soft">
            No hay estudiantes disponibles para mostrar.
          </div>
        ) : (
          estudiantes.map((estudiante) => (
            <article
              key={estudiante.id}
              className="flex flex-col justify-between gap-3 rounded-sm border border-rule bg-white p-4 sm:flex-row sm:items-center"
            >
              <div>
                <h3 className="font-semibold text-ink">
                  {estudiante.nombre_completo}
                </h3>
                <p className="mt-1 text-sm text-ink-soft">
                  Curso: {estudiante.curso}
                </p>
              </div>

              <button
                type="button"
                onClick={() => setEstudianteSeleccionado(estudiante)}
                className="w-fit rounded-sm bg-slate-900 px-5 py-2 text-sm font-medium text-white hover:bg-slate-700"
              >
                Revisar
              </button>
            </article>
          ))
        )}
      </section>
    </div>
  );
}
