"use client";

import { useState } from "react";
import { Modal } from "./modal";
import { Button } from "./button";
import { Banner } from "./banner";

export function ConfirmDialog({
  open,
  onClose,
  title,
  description,
  onConfirm,
}: {
  open: boolean;
  onClose: () => void;
  title: string;
  description: string;
  onConfirm: () => Promise<{ error?: string } | void>;
}) {
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);

  async function handleConfirm() {
    setLoading(true);
    setError(null);
    const result = await onConfirm();
    setLoading(false);
    if (result?.error) {
      setError(result.error);
      return;
    }
    onClose();
  }

  return (
    <Modal open={open} onClose={onClose} title={title}>
      <div className="flex flex-col gap-4">
        {error && <Banner>{error}</Banner>}
        <p className="text-sm text-ink-soft">{description}</p>
        <div className="flex justify-end gap-2 pt-2">
          <Button variant="ghost" onClick={onClose} type="button">
            Cancelar
          </Button>
          <Button variant="danger" onClick={handleConfirm} loading={loading} type="button">
            Eliminar
          </Button>
        </div>
      </div>
    </Modal>
  );
}
