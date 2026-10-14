"use client";

import { FormEvent, useState } from "react";
import { useRouter } from "next/navigation";
import { GraduationCap, Loader2 } from "lucide-react";
import { createClient } from "@/lib/supabase/client";
import { Field, TextInput } from "@/components/ui/field";
import { Banner } from "@/components/ui/banner";

const ERROR_MESSAGES: Record<string, string> = {
  "Invalid login credentials": "Correo o contraseña incorrectos.",
  "Email not confirmed": "El correo aún no ha sido confirmado.",
};

export default function LoginPage() {
  const router = useRouter();
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);

  async function handleSubmit(e: FormEvent) {
    e.preventDefault();
    setLoading(true);
    setError(null);

    const supabase = createClient();
    const { error: signInError } = await supabase.auth.signInWithPassword({
      email,
      password,
    });

    if (signInError) {
      setError(ERROR_MESSAGES[signInError.message] ?? signInError.message);
      setLoading(false);
      return;
    }

    const { data: perfil } = await supabase
      .from("perfiles")
      .select("rol")
      .eq("id", (await supabase.auth.getUser()).data.user?.id ?? "")
      .maybeSingle();

    if (perfil?.rol === "profesor") router.push("/dashboard/profesor");
    else if (perfil?.rol === "estudiante") router.push("/dashboard/estudiante");
    else router.push("/dashboard");
    router.refresh();
  }

  return (
    <main className="flex min-h-screen items-center justify-center bg-paper px-4">
      <div className="grid w-full max-w-4xl overflow-hidden rounded-sm border border-rule-strong bg-paper-raised shadow-[0_16px_0_-8px_rgba(29,42,53,0.08)] md:grid-cols-5">
        {/* Left panel — identity */}
        <div className="ruled relative hidden flex-col justify-between bg-ink px-8 py-10 text-paper md:col-span-2 md:flex">
          <div className="flex items-center gap-2">
            <GraduationCap className="h-6 w-6" />
            <span className="text-sm tracking-wide text-paper/80">
              Panel interno
            </span>
          </div>
          <div>
            <p className="font-display text-3xl leading-tight italic">
              Gestión
              <br />
              Académica
            </p>
            <p className="mt-4 max-w-[26ch] text-sm text-paper/70">
              Cursos, estudiantes, profesores y horario en un solo lugar.
            </p>
          </div>
          <p className="text-xs text-paper/50">Acceso para coordinadores, profesores y estudiantes</p>
        </div>

        {/* Right panel — form */}
        <div className="px-8 py-10 md:col-span-3 md:px-12">
          <h1 className="font-display text-2xl text-ink">Iniciar sesión</h1>
          <p className="mt-1 text-sm text-ink-soft">
            Ingresa con tu correo y contraseña institucional.
          </p>

          <form onSubmit={handleSubmit} className="mt-8 flex flex-col gap-4">
            {error && <Banner>{error}</Banner>}

            <Field label="Correo electrónico" htmlFor="email">
              <TextInput
                id="email"
                type="email"
                autoComplete="email"
                required
                value={email}
                onChange={(e) => setEmail(e.target.value)}
                placeholder="coordinador@colegio.edu.co"
              />
            </Field>

            <Field label="Contraseña" htmlFor="password">
              <TextInput
                id="password"
                type="password"
                autoComplete="current-password"
                required
                value={password}
                onChange={(e) => setPassword(e.target.value)}
                placeholder="••••••••"
              />
            </Field>

            <button
              type="submit"
              disabled={loading}
              className="mt-2 inline-flex items-center justify-center gap-2 rounded-sm border border-ink bg-ink px-4 py-2.5 text-sm font-medium text-paper transition-colors hover:bg-accent hover:border-accent disabled:opacity-50"
            >
              {loading && <Loader2 className="h-4 w-4 animate-spin" />}
              Entrar
            </button>
          </form>

          <p className="mt-6 text-xs text-ink-soft">
            ¿No tienes una cuenta? Pídele a otro administrador que te cree una,
            o créala desde el script <code>scripts/crear-admin.mjs</code>.
          </p>
        </div>
      </div>
    </main>
  );
}
