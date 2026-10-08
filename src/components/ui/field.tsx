import {
  InputHTMLAttributes,
  ReactNode,
  SelectHTMLAttributes,
  forwardRef,
} from "react";

export function Field({
  label,
  htmlFor,
  error,
  children,
}: {
  label: string;
  htmlFor: string;
  error?: string;
  children: ReactNode;
}) {
  return (
    <div className="flex flex-col gap-1.5">
      <label htmlFor={htmlFor} className="text-sm font-medium text-ink-soft">
        {label}
      </label>
      {children}
      {error && <p className="text-xs text-danger">{error}</p>}
    </div>
  );
}

const baseControl =
  "w-full rounded-sm border border-rule-strong bg-paper-raised px-3 py-2 text-sm text-ink placeholder:text-ink-soft/60 focus:border-accent transition-colors";

export const TextInput = forwardRef<
  HTMLInputElement,
  InputHTMLAttributes<HTMLInputElement>
>(({ className = "", ...props }, ref) => (
  <input ref={ref} className={`${baseControl} ${className}`} {...props} />
));
TextInput.displayName = "TextInput";

export const Select = forwardRef<
  HTMLSelectElement,
  SelectHTMLAttributes<HTMLSelectElement>
>(({ className = "", children, ...props }, ref) => (
  <select ref={ref} className={`${baseControl} ${className}`} {...props}>
    {children}
  </select>
));
Select.displayName = "Select";
