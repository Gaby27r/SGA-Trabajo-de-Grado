"use client";

import { useMemo, useState } from "react";
import { Pencil, Plus, Trash2 } from "lucide-react";
import type { BloqueHorario, Curso, DiaSemana, Profesor } from "@/lib/types";
import { DIAS_SEMANA } from "@/lib/types";
import { cursoColor } from "@/lib/curso-color";
import { Button } from "@/components/ui/button";
import { Modal } from "@/components/ui/modal";
import { Field, Select, TextInput } from "@/components/ui/field";
import { Banner } from "@/components/ui/banner";
import { ConfirmDialog } from "@/components/ui/confirm-dialog";
import { crearBloque, actualizarBloque, eliminarBloque } from "./actions";

function formatHora(hora: string) {
  return hora.slice(0, 5);
}

export function HorarioManager({
  cursos,
  profesores,
  horario,
  cursoInicial,
}: {
  cursos: Curso[];
  profesores: Profesor[];
  horario: BloqueHorario[];
  cursoInicial?: string;
}) {
  const [cursoId, setCursoId] = useState(
    cursoInicial && cursos.some((c) => c.id === cursoInicial)
      ? cursoInicial
      : (cursos[0]?.id ?? ""),
  );
  const [formOpen, setFormOpen] = useState(false);
  const [editing, setEditing] = useState<BloqueHorario | null>(null);
  const [nuevoPreset, setNuevoPreset] = useState<{ dia: DiaSemana; hora_inicio: string; hora_fin: string } | null>(null);
  const [deleting, setDeleting] = useState<BloqueHorario | null>(null);

  const bloquesCurso = useMemo(
    () => horario.filter((b) => b.curso_id === cursoId),
    [horario, cursoId],
  );

  const franjas = useMemo(() => {
    const vistos = new Map<string, { hora_inicio: string; hora_fin: string }>();
    for (const b of bloquesCurso) {
      const key = `${b.hora_inicio}-${b.hora_fin}`;
      if (!vistos.has(key)) {
        vistos.set(key, { hora_inicio: b.hora_inicio, hora_fin: b.hora_fin });
      }
    }
    return Array.from(vistos.values()).sort((a, b) =>
      a.hora_inicio.localeCompare(b.hora_inicio),
    );
  }, [bloquesCurso]);

  const grid = useMemo(() => {
    const map = new Map<string, BloqueHorario>();
    for (const b of bloquesCurso) {
      map.set(`${b.dia}-${b.hora_inicio}`, b);
    }
    return map;
  }, [bloquesCurso]);

  function abrirNuevo(dia: DiaSemana, hora_inicio: string, hora_fin: string) {
    setEditing(null);
    setNuevoPreset({ dia, hora_inicio, hora_fin });
    setFormOpen(true);
  }

  return (
    <div className="flex flex-col gap-6">
      <div className="flex flex-wrap items-center gap-2">
        {cursos.map((curso, i) => {
          const color = cursoColor(i);
          const active = curso.id === cursoId;
          return (
            <button
              key={curso.id}
              onClick={() => setCursoId(curso.id)}
              className="rounded-sm border px-3 py-1.5 text-sm font-medium transition-colors"
              style={
                active
                  ? { backgroundColor: color.bg, color: color.fg, borderColor: color.ring }
                  : { backgroundColor: "transparent", color: "var(--ink-soft)", borderColor: "var(--rule-strong)" }
              }
            >
              {curso.nombre}
            </button>
          );
        })}
        {cursos.length === 0 && (
          <p className="text-sm text-ink-soft">Crea un curso primero para poder armar su horario.</p>
        )}
        <div className="grow" />
        {cursoId && (
          <Button
            onClick={() =>
              abrirNuevo(
                "Lunes",
                franjas[0]?.hora_inicio ?? "07:00",
                franjas[0]?.hora_fin ?? "07:50",
              )
            }
          >
            <Plus className="h-4 w-4" />
            Agregar bloque
          </Button>
        )}
      </div>

      {cursoId && (
        <div className="overflow-x-auto rounded-sm border border-rule-strong bg-paper-raised">
          <table className="w-full min-w-[720px] table-fixed text-left text-sm">
            <thead>
              <tr className="border-b border-rule text-ink-soft">
                <th className="w-24 px-3 py-3 font-medium">Hora</th>
                {DIAS_SEMANA.map((dia) => (
                  <th key={dia} className="px-3 py-3 font-medium">
                    {dia}
                  </th>
                ))}
              </tr>
            </thead>
            <tbody>
              {franjas.map((franja) => {
                const bloquesFranja = DIAS_SEMANA.map(
                  (dia) => grid.get(`${dia}-${franja.hora_inicio}`) ?? null,
                );
                const esDescansoCompleto =
                  bloquesFranja.every((b) => b?.es_descanso) &&
                  bloquesFranja.every((b) => b !== null);

                return (
                  <tr key={franja.hora_inicio} className="border-b border-rule last:border-0">
                    <td className="px-3 py-2 align-top text-xs text-ink-soft">
                      {formatHora(franja.hora_inicio)}
                      <br />
                      {formatHora(franja.hora_fin)}
                    </td>
                    {esDescansoCompleto ? (
                      <td colSpan={5} className="bg-rule/20 px-3 py-2 text-center text-xs font-medium tracking-wide text-ink-soft">
                        Descanso
                      </td>
                    ) : (
                      DIAS_SEMANA.map((dia) => {
                        const bloque = grid.get(`${dia}-${franja.hora_inicio}`) ?? null;
                        return (
                          <td key={dia} className="px-2 py-2 align-top">
                            {bloque ? (
                              <BloqueCell
                                bloque={bloque}
                                onEdit={() => {
                                  setEditing(bloque);
                                  setNuevoPreset(null);
                                  setFormOpen(true);
                                }}
                                onDelete={() => setDeleting(bloque)}
                              />
                            ) : (
                              <button
                                onClick={() => abrirNuevo(dia, franja.hora_inicio, franja.hora_fin)}
                                className="flex h-full min-h-14 w-full items-center justify-center rounded-sm border border-dashed border-rule-strong text-ink-soft/50 hover:border-accent hover:text-accent"
                                aria-label={`Agregar clase el ${dia} de ${formatHora(franja.hora_inicio)} a ${formatHora(franja.hora_fin)}`}
                              >
                                <Plus className="h-4 w-4" />
                              </button>
                            )}
                          </td>
                        );
                      })
                    )}
                  </tr>
                );
              })}
              {franjas.length === 0 && (
                <tr>
                  <td colSpan={6} className="px-5 py-8 text-center text-ink-soft">
                    Este curso todavía no tiene bloques de horario.
                  </td>
                </tr>
              )}
            </tbody>
          </table>
        </div>
      )}

      <BloqueForm
        key={editing?.id ?? `${nuevoPreset?.dia}-${nuevoPreset?.hora_inicio}-${formOpen}`}
        open={formOpen}
        onClose={() => setFormOpen(false)}
        bloque={editing}
        cursoId={cursoId}
        preset={nuevoPreset}
        profesores={profesores}
      />

      {deleting && (
        <ConfirmDialog
          open={!!deleting}
          onClose={() => setDeleting(null)}
          title={`Eliminar bloque de ${deleting.materia}`}
          description="Este bloque se quitará del horario del curso. Esta acción no se puede deshacer."
          onConfirm={() => eliminarBloque(deleting.id)}
        />
      )}
    </div>
  );
}

function BloqueCell({
  bloque,
  onEdit,
  onDelete,
}: {
  bloque: BloqueHorario;
  onEdit: () => void;
  onDelete: () => void;
}) {
  return (
    <div className="group relative rounded-sm border border-rule-strong bg-paper px-2.5 py-2">
      <p className="text-xs font-medium leading-snug text-ink">{bloque.materia}</p>
      {bloque.profesores?.nombre_completo && (
        <p className="mt-0.5 text-[11px] leading-snug text-ink-soft">
          {bloque.profesores.nombre_completo}
        </p>
      )}
      <div className="absolute right-1 top-1 hidden gap-0.5 group-hover:flex">
        <button
          aria-label="Editar bloque"
          onClick={onEdit}
          className="rounded-sm bg-paper-raised p-1 text-ink-soft hover:text-ink"
        >
          <Pencil className="h-3 w-3" />
        </button>
        <button
          aria-label="Eliminar bloque"
          onClick={onDelete}
          className="rounded-sm bg-paper-raised p-1 text-ink-soft hover:text-danger"
        >
          <Trash2 className="h-3 w-3" />
        </button>
      </div>
    </div>
  );
}

function BloqueForm({
  open,
  onClose,
  bloque,
  cursoId,
  preset,
  profesores,
}: {
  open: boolean;
  onClose: () => void;
  bloque: BloqueHorario | null;
  cursoId: string;
  preset: { dia: DiaSemana; hora_inicio: string; hora_fin: string } | null;
  profesores: Profesor[];
}) {
  const [dia, setDia] = useState<DiaSemana>(bloque?.dia ?? preset?.dia ?? "Lunes");
  const [horaInicio, setHoraInicio] = useState(bloque?.hora_inicio.slice(0, 5) ?? preset?.hora_inicio ?? "07:00");
  const [horaFin, setHoraFin] = useState(bloque?.hora_fin.slice(0, 5) ?? preset?.hora_fin ?? "07:50");
  const [materia, setMateria] = useState(bloque?.materia ?? "");
  const [profesorId, setProfesorId] = useState(bloque?.profesor_id ?? "");
  const [esDescanso, setEsDescanso] = useState(bloque?.es_descanso ?? false);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);

  async function handleSubmit(e: React.FormEvent) {
    e.preventDefault();
    setLoading(true);
    setError(null);
    const payload = {
      curso_id: cursoId,
      dia,
      hora_inicio: horaInicio,
      hora_fin: horaFin,
      materia: esDescanso ? "Descanso" : materia,
      profesor_id: esDescanso ? "" : profesorId,
      es_descanso: esDescanso,
    };
    const result = bloque
      ? await actualizarBloque(bloque.id, payload)
      : await crearBloque(payload);
    setLoading(false);
    if (result.error) {
      setError(result.error);
      return;
    }
    onClose();
  }

  return (
    <Modal open={open} onClose={onClose} title={bloque ? "Editar bloque" : "Nuevo bloque"}>
      <form onSubmit={handleSubmit} className="flex flex-col gap-4">
        {error && <Banner>{error}</Banner>}

        <Field label="Día" htmlFor="dia">
          <Select id="dia" value={dia} onChange={(e) => setDia(e.target.value as DiaSemana)}>
            {DIAS_SEMANA.map((d) => (
              <option key={d} value={d}>
                {d}
              </option>
            ))}
          </Select>
        </Field>

        <div className="grid grid-cols-2 gap-4">
          <Field label="Hora de inicio" htmlFor="hora_inicio">
            <TextInput
              id="hora_inicio"
              type="time"
              required
              value={horaInicio}
              onChange={(e) => setHoraInicio(e.target.value)}
            />
          </Field>
          <Field label="Hora de fin" htmlFor="hora_fin">
            <TextInput
              id="hora_fin"
              type="time"
              required
              value={horaFin}
              onChange={(e) => setHoraFin(e.target.value)}
            />
          </Field>
        </div>

        <label className="flex items-center gap-2 text-sm text-ink-soft">
          <input
            type="checkbox"
            checked={esDescanso}
            onChange={(e) => setEsDescanso(e.target.checked)}
            className="h-4 w-4 rounded-sm border-rule-strong accent-[var(--accent)]"
          />
          Este bloque es un descanso
        </label>

        {!esDescanso && (
          <>
            <Field label="Materia" htmlFor="materia">
              <TextInput
                id="materia"
                required={!esDescanso}
                placeholder="Ej. Biología"
                value={materia}
                onChange={(e) => setMateria(e.target.value)}
              />
            </Field>
            <Field label="Profesor" htmlFor="profesor_id">
              <Select
                id="profesor_id"
                value={profesorId ?? ""}
                onChange={(e) => setProfesorId(e.target.value)}
              >
                <option value="">Sin asignar</option>
                {profesores.map((p) => (
                  <option key={p.id} value={p.id}>
                    {p.nombre_completo}
                  </option>
                ))}
              </Select>
            </Field>
          </>
        )}

        <div className="flex justify-end gap-2 pt-2">
          <Button type="button" variant="ghost" onClick={onClose}>
            Cancelar
          </Button>
          <Button type="submit" loading={loading}>
            {bloque ? "Guardar cambios" : "Crear bloque"}
          </Button>
        </div>
      </form>
    </Modal>
  );
}
