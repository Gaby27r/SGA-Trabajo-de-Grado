"use client";

import { useState } from "react";
import { Pencil, Plus, Trash2 } from "lucide-react";
import type { Curso } from "@/lib/types";
import { cursoColor } from "@/lib/curso-color";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { Modal } from "@/components/ui/modal";
import { Field, TextInput } from "@/components/ui/field";
import { Banner } from "@/components/ui/banner";
import { ConfirmDialog } from "@/components/ui/confirm-dialog";
import { crearCurso, actualizarCurso, eliminarCurso } from "./actions";

export function CursosManager({ cursos }: { cursos: Curso[] }) {
  const [formOpen, setFormOpen] = useState(false);
  const [editing, setEditing] = useState<Curso | null>(null);
  const [deleting, setDeleting] = useState<Curso | null>(null);

  return (
    <div className="flex flex-col gap-6">
      <div className="flex items-center justify-between">
        <p className="text-sm text-ink-soft">
          {cursos.length} {cursos.length === 1 ? "curso" : "cursos"}
        </p>
        <Button
          onClick={() => {
            setEditing(null);
            setFormOpen(true);
          }}
        >
          <Plus className="h-4 w-4" />
          Nuevo curso
        </Button>
      </div>

      <div className="overflow-hidden rounded-sm border border-rule-strong bg-paper-raised">
        <table className="w-full text-left text-sm">
          <thead>
            <tr className="border-b border-rule text-ink-soft">
              <th className="px-5 py-3 font-medium">Curso</th>
              <th className="px-5 py-3 font-medium">Jornada</th>
              <th className="px-5 py-3 font-medium" />
            </tr>
          </thead>
          <tbody>
            {cursos.map((curso, i) => {
              const color = cursoColor(i);
              return (
                <tr key={curso.id} className="border-b border-rule last:border-0">
                  <td className="px-5 py-3">
                    <Badge bg={color.bg} fg={color.fg}>
                      {curso.nombre}
                    </Badge>
                  </td>
                  <td className="px-5 py-3 text-ink-soft">{curso.jornada}</td>
                  <td className="px-5 py-3">
                    <div className="flex justify-end gap-1">
                      <button
                        aria-label={`Editar ${curso.nombre}`}
                        onClick={() => {
                          setEditing(curso);
                          setFormOpen(true);
                        }}
                        className="rounded-sm p-2 text-ink-soft hover:bg-rule/40 hover:text-ink"
                      >
                        <Pencil className="h-4 w-4" />
                      </button>
                      <button
                        aria-label={`Eliminar ${curso.nombre}`}
                        onClick={() => setDeleting(curso)}
                        className="rounded-sm p-2 text-ink-soft hover:bg-danger/10 hover:text-danger"
                      >
                        <Trash2 className="h-4 w-4" />
                      </button>
                    </div>
                  </td>
                </tr>
              );
            })}
            {cursos.length === 0 && (
              <tr>
                <td colSpan={3} className="px-5 py-8 text-center text-ink-soft">
                  Todavía no has creado ningún curso.
                </td>
              </tr>
            )}
          </tbody>
        </table>
      </div>

      <CursoForm
        key={editing?.id ?? "nuevo"}
        open={formOpen}
        onClose={() => setFormOpen(false)}
        curso={editing}
      />

      {deleting && (
        <ConfirmDialog
          open={!!deleting}
          onClose={() => setDeleting(null)}
          title={`Eliminar ${deleting.nombre}`}
          description="Esto también quitará el horario asociado y desvinculará a los estudiantes de este curso. Esta acción no se puede deshacer."
          onConfirm={() => eliminarCurso(deleting.id)}
        />
      )}
    </div>
  );
}

function CursoForm({
  open,
  onClose,
  curso,
}: {
  open: boolean;
  onClose: () => void;
  curso: Curso | null;
}) {
  const [nombre, setNombre] = useState(curso?.nombre ?? "");
  const [jornada, setJornada] = useState(curso?.jornada ?? "Mañana");
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);

  async function handleSubmit(e: React.FormEvent) {
    e.preventDefault();
    setLoading(true);
    setError(null);
    const payload = { nombre, jornada };
    const result = curso
      ? await actualizarCurso(curso.id, payload)
      : await crearCurso(payload);
    setLoading(false);
    if (result.error) {
      setError(result.error);
      return;
    }
    onClose();
  }

  return (
    <Modal
      open={open}
      onClose={onClose}
      title={curso ? `Editar ${curso.nombre}` : "Nuevo curso"}
    >
      <form onSubmit={handleSubmit} className="flex flex-col gap-4">
        {error && <Banner>{error}</Banner>}
        <Field label="Nombre del curso" htmlFor="nombre">
          <TextInput
            id="nombre"
            required
            placeholder="Ej. 4to A"
            value={nombre}
            onChange={(e) => setNombre(e.target.value)}
          />
        </Field>
        <Field label="Jornada" htmlFor="jornada">
          <TextInput
            id="jornada"
            required
            placeholder="Mañana"
            value={jornada}
            onChange={(e) => setJornada(e.target.value)}
          />
        </Field>
        <div className="flex justify-end gap-2 pt-2">
          <Button type="button" variant="ghost" onClick={onClose}>
            Cancelar
          </Button>
          <Button type="submit" loading={loading}>
            {curso ? "Guardar cambios" : "Crear curso"}
          </Button>
        </div>
      </form>
    </Modal>
  );
}
