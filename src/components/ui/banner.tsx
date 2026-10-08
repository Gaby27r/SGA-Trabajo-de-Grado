export function Banner({ tone = "error", children }: { tone?: "error" | "info"; children: React.ReactNode }) {
  const classes =
    tone === "error"
      ? "border-danger/30 bg-danger/10 text-danger"
      : "border-accent/30 bg-accent/10 text-accent";
  return (
    <div className={`rounded-sm border px-3 py-2 text-sm ${classes}`}>
      {children}
    </div>
  );
}
