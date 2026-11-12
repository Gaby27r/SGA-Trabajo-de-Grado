"use client";

import { useState } from "react";
import { Pencil, Plus, Trash2 } from "lucide-react";
import type { Profesor } from "@/lib/types";
import { Button } from "@/components/ui/button";
import { Modal } from "@/components/ui/modal";
import { Field, TextInput } from "@/components/ui/field";
import { Banner } from "@/components/ui/banner";
import { ConfirmDialog } from "@/components/ui/confirm-dialog";
import { crearProfesor, actualizarProfesor, eliminarProfesor } from "./actions";

export function ProfesoresManager({ profesores }: { profesores: Profesor[] }) {
  const [formOpen, setFormOpen] = useState(false);
  const [editing, setEditing] = useState<Profesor | null>(null);
  const [deleting, setDeleting] = useState<Profesor | null>(null);

  return (
    <div className="flex flex-col gap-6">
      <div className="flex items-center justify-between">
        <p className="text-sm text-ink-soft">
          {profesores.length} {profesores.length === 1 ? "profesor" : "profesores"}
        </p>
        <Button
          onClick={() => {
            setEditing(null);
            setFormOpen(true);
          }}
        >
          <Plus className="h-4 w-4" />
          Nuevo profesor
        </Button>
      </div>

      <div className="overflow-hidden rounded-sm border border-rule-strong bg-paper-raised">
        <table className="w-full text-left text-sm">
          <thead>
            <tr className="border-b border-rule text-ink-soft">
              <th className="px-5 py-3 font-medium">Nombre</th>
              <th className="px-5 py-3 font-medium">Correo</th>
              <th className="px-5 py-3 font-medium">Teléfono</th>
              <th className="px-5 py-3 font-medium" />
            </tr>
          </thead>
          <tbody>
            {profesores.map((profesor) => (
              <tr key={profesor.id} className="border-b border-rule last:border-0">
                <td className="px-5 py-3 text-ink">{profesor.nombre_completo}</td>
                <td className="px-5 py-3 text-ink-soft">{profesor.correo ?? "—"}</td>
                <td className="px-5 py-3 text-ink-soft">{profesor.telefono ?? "—"}</td>
                <td className="px-5 py-3">
                  <div className="flex justify-end gap-1">
                    <button
                      aria-label={`Editar ${profesor.nombre_completo}`}
                      onClick={() => {
                        setEditing(profesor);
                        setFormOpen(true);
                      }}
                      className="rounded-sm p-2 text-ink-soft hover:bg-rule/40 hover:text-ink"
                    >
                      <Pencil className="h-4 w-4" />
                    </button>
                    <button
                      aria-label={`Eliminar ${profesor.nombre_completo}`}
                      onClick={() => setDeleting(profesor)}
                      className="rounded-sm p-2 text-ink-soft hover:bg-danger/10 hover:text-danger"
                    >
                      <Trash2 className="h-4 w-4" />
                    </button>
                  </div>
                </td>
              </tr>
            ))}
            {profesores.length === 0 && (
              <tr>
                <td colSpan={4} className="px-5 py-8 text-center text-ink-soft">
                  Todavía no has registrado profesores.
                </td>
              </tr>
            )}
          </tbody>
        </table>
      </div>

      <ProfesorForm
        key={editing?.id ?? "nuevo"}
        open={formOpen}
        onClose={() => setFormOpen(false)}
        profesor={editing}
      />

      {deleting && (
        <ConfirmDialog
          open={!!deleting}
          onClose={() => setDeleting(null)}
          title={`Eliminar ${deleting.nombre_completo}`}
          description="Los bloques de horario que dictaba este profesor quedarán sin profesor asignado. Esta acción no se puede deshacer."
          onConfirm={() => eliminarProfesor(deleting.id)}
        />
      )}
    </div>
  );
}

function ProfesorForm({
  open,
  onClose,
  profesor,
}: {
  open: boolean;
  onClose: () => void;
  profesor: Profesor | null;
}) {
  const [nombre, setNombre] = useState(profesor?.nombre_completo ?? "");
  const [correo, setCorreo] = useState(profesor?.correo ?? "");
  const [telefono, setTelefono] = useState(profesor?.telefono ?? "");
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);

  async function handleSubmit(e: React.FormEvent) {
    e.preventDefault();
    setLoading(true);
    setError(null);
    const payload = { nombre_completo: nombre, correo, telefono };
    const result = profesor
      ? await actualizarProfesor(profesor.id, payload)
      : await crearProfesor(payload);
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
      title={profesor ? `Editar ${profesor.nombre_completo}` : "Nuevo profesor"}
    >
      <form onSubmit={handleSubmit} className="flex flex-col gap-4">
        {error && <Banner>{error}</Banner>}
        <Field label="Nombre completo" htmlFor="nombre_completo">
          <TextInput
            id="nombre_completo"
            required
            placeholder="Ej. Alejandra León"
            value={nombre}
            onChange={(e) => setNombre(e.target.value)}
          />
        </Field>
        <Field label="Correo" htmlFor="correo">
          <TextInput
            id="correo"
            type="email"
            placeholder="nombre@colegio.edu.co"
            value={correo}
            onChange={(e) => setCorreo(e.target.value)}
          />
        </Field>
        <Field label="Teléfono" htmlFor="telefono">
          <TextInput
            id="telefono"
            placeholder="300 000 0000"
            value={telefono}
            onChange={(e) => setTelefono(e.target.value)}
          />
        </Field>
        <div className="flex justify-end gap-2 pt-2">
          <Button type="button" variant="ghost" onClick={onClose}>
            Cancelar
          </Button>
          <Button type="submit" loading={loading}>
            {profesor ? "Guardar cambios" : "Crear profesor"}
          </Button>
        </div>
      </form>
    </Modal>
  );
}
