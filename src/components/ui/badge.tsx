export function Badge({
  children,
  bg,
  fg,
}: {
  children: React.ReactNode;
  bg?: string;
  fg?: string;
}) {
  return (
    <span
      className="inline-flex items-center rounded-sm px-2 py-0.5 text-xs font-medium"
      style={{ backgroundColor: bg ?? "#EAF1EC", color: fg ?? "#2F5C4C" }}
    >
      {children}
    </span>
  );
}
