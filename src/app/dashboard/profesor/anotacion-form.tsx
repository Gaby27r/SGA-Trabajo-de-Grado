"use client";

import { useState } from "react";
import { Save } from "lucide-react";

import type { Estudiante } from "@/lib/types";

import { Button } from "@/components/ui/button";
import { Modal } from "@/components/ui/modal";
import { Field, Select, TextInput } from "@/components/ui/field";
import { Banner } from "@/components/ui/banner";

import { guardarAnotacion } from "./actions";

type Props = {
  open: boolean;
  onClose: () => void;
  estudiante: Estudiante | null;
};

export function AnotacionForm({
  open,
  onClose,
  estudiante,
}: Props) {
  const [tipo, setTipo] = useState<"grave" | "leve">("leve");
  const [observacion, setObservacion] = useState("");
  const [error, setError] = useState<string | null>(null);
  const [loading, setLoading] = useState(false);

  async function submit(e: React.FormEvent) {
    e.preventDefault();

    if (!estudiante || !estudiante.curso_id) {
      setError("El estudiante no tiene un curso asignado.");
      return;
    }

    setLoading(true);
    setError(null);

    const result = await guardarAnotacion({
      estudiante_id: estudiante.id,
      curso_id: estudiante.curso_id,
      tipo,
      observacion,
    });

    setLoading(false);

    if (result.error) {
      setError(result.error);
      return;
    }

    setTipo("leve");
    setObservacion("");
    onClose();
  }

  return (
    <Modal
      open={open}
      onClose={onClose}
      title="Registrar anotación"
    >
      <form
        onSubmit={submit}
        className="flex flex-col gap-4"
      >
        {error && <Banner>{error}</Banner>}

        <div className="rounded-sm border border-rule bg-paper px-4 py-3">
          <p className="text-xs text-ink-soft">
            Estudiante
          </p>

          <p className="mt-1 font-medium text-ink">
            {estudiante?.nombre_completo ?? "—"}
          </p>

          <p className="text-xs text-ink-soft">
            {estudiante?.cursos?.nombre ?? "Sin curso"}
          </p>
        </div>

        <Field
          label="Tipo de anotación"
          htmlFor="anotacion-tipo"
        >
          <Select
            id="anotacion-tipo"
            value={tipo}
            onChange={(e) =>
              setTipo(
                e.target.value as "grave" | "leve"
              )
            }
          >
            <option value="leve">
              Leve
            </option>

            <option value="grave">
              Grave
            </option>
          </Select>
        </Field>

        <Field
          label="Observación"
          htmlFor="anotacion-observacion"
        >
          <TextInput
            id="anotacion-observacion"
            required
            value={observacion}
            onChange={(e) =>
              setObservacion(e.target.value)
            }
            placeholder="Escriba la observación..."
          />
        </Field>

        <div className="flex justify-end gap-2">
          <Button
            type="button"
            variant="ghost"
            onClick={onClose}
          >
            Cancelar
          </Button>

          <Button
            type="submit"
            loading={loading}
          >
            <Save className="h-4 w-4" />
            Guardar anotación
          </Button>
        </div>
      </form>
    </Modal>
  );
}