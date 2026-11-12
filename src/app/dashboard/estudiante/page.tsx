import { requireRole } from "@/lib/auth";
import { createClient } from "@/lib/supabase/server";

export default async function EstudiantePage() {
  const perfil = await requireRole(["estudiante"]);
  const supabase = await createClient();
  const { data: estudiante } = await supabase.from("estudiantes").select("*,cursos(nombre)").eq("id",perfil.estudiante_id).maybeSingle();
  if (!estudiante) return <p className="text-ink-soft">No hay un estudiante vinculado a esta cuenta.</p>;

  const { data: horario } = await supabase.from("horario_clases").select("*,profesores(nombre_completo)").eq("curso_id",estudiante.curso_id).order("hora_inicio");
  const { data: notas } = await supabase.from("calificaciones").select("*,profesores(nombre_completo)").eq("estudiante_id",estudiante.id).order("periodo").order("materia");
  const { data: asistencias } = await supabase.from("asistencias").select("*").eq("estudiante_id",estudiante.id).order("fecha",{ascending:false});

  const materias = [...new Map((horario ?? []).filter(h=>!h.es_descanso).map(h=>[h.materia,{materia:h.materia,profesor:h.profesores?.nombre_completo ?? "Sin asignar"}])).values()];
  const maxConsecutiveAbsences = (() => {
    const days=[...(asistencias??[])].filter(a=>a.estado==="Falto").sort((a,b)=>a.fecha.localeCompare(b.fecha));
    let max=0,run=0,prev="";
    for(const a of days){const d=new Date(`${a.fecha}T00:00:00`);const p=prev?new Date(`${prev}T00:00:00`):null;const consecutive=p?Math.round((d.getTime()-p.getTime())/86400000)===1:false;run=consecutive?run+1:1;max=Math.max(max,run);prev=a.fecha;} return max;
  })();
  const promedio=(p:number)=>{const r=(notas??[]).filter(n=>n.periodo===p);return r.length?(r.reduce((s,n)=>s+Number(n.nota),0)/r.length).toFixed(2):"—";};

  return <div className="flex flex-col gap-6">
    <div><h1 className="font-display text-3xl text-ink">Mi información</h1><p className="mt-1 text-ink-soft">{estudiante.nombre_completo} · {estudiante.cursos?.nombre}</p></div>
    <div className="grid gap-4 sm:grid-cols-4"><Metric label="Promedio periodo 1" value={promedio(1)}/><Metric label="Promedio periodo 2" value={promedio(2)}/><Metric label="Inasistencias" value={String((asistencias??[]).filter(a=>a.estado==="Falto"||a.estado==="Justificacion").length)}/><Metric label="Máx. faltas consecutivas" value={String(maxConsecutiveAbsences)}/></div>

    <section className="rounded-sm border border-rule-strong bg-paper-raised p-5">
      <h2 className="font-display text-xl text-ink">Mis profesores y materias</h2>
      <div className="mt-4 overflow-x-auto"><table className="w-full text-left text-sm"><thead><tr className="border-b border-rule text-ink-soft"><th className="px-3 py-2">Materia</th><th className="px-3 py-2">Profesor</th></tr></thead><tbody>{materias.map(m=><tr key={m.materia} className="border-b border-rule"><td className="px-3 py-2">{m.materia}</td><td className="px-3 py-2">{m.profesor}</td></tr>)}</tbody></table></div>
    </section>

    <section className="rounded-sm border border-rule-strong bg-paper-raised p-5">
      <h2 className="font-display text-xl text-ink">Mis notas</h2>
      <div className="mt-4 grid gap-5 lg:grid-cols-2">{[1,2].map(p=><div key={p}><div className="flex items-center justify-between"><h3 className="font-medium text-ink">Periodo {p}</h3><span className="text-sm text-ink-soft">Promedio: {promedio(p)}</span></div><table className="mt-2 w-full text-left text-sm"><tbody>{(notas??[]).filter(n=>n.periodo===p).map(n=><tr key={n.id} className="border-b border-rule"><td className="px-3 py-2">{n.materia}</td><td className="px-3 py-2 text-right font-medium">{Number(n.nota).toFixed(2)}</td></tr>)}</tbody></table></div>)}</div>
    </section>

    <section className="rounded-sm border border-rule-strong bg-paper-raised p-5">
      <h2 className="font-display text-xl text-ink">Mi horario</h2>
      <div className="mt-4 grid gap-3 sm:grid-cols-2 lg:grid-cols-5">{["Lunes","Martes","Miércoles","Jueves","Viernes"].map(d=><div key={d} className="rounded-sm border border-rule p-3"><h3 className="font-medium text-ink">{d}</h3>{(horario??[]).filter(h=>h.dia===d).map(h=><div key={h.id} className="mt-2 border-t border-rule pt-2 text-xs"><p className="font-medium">{h.hora_inicio.slice(0,5)}–{h.hora_fin.slice(0,5)}</p><p className="text-ink-soft">{h.materia}</p>{!h.es_descanso&&<p className="text-ink-soft">{h.profesores?.nombre_completo}</p>}</div>)}</div>)}</div>
    </section>

    <section className="rounded-sm border border-rule-strong bg-paper-raised p-5">
      <h2 className="font-display text-xl text-ink">Mi asistencia</h2>
      <div className="mt-4 grid gap-3 sm:grid-cols-4"><Metric label="Asistencias" value={String((asistencias??[]).filter(a=>a.estado==="Asistio").length)}/><Metric label="Faltas" value={String((asistencias??[]).filter(a=>a.estado==="Falto").length)}/><Metric label="Justificadas" value={String((asistencias??[]).filter(a=>a.estado==="Justificacion").length)}/><Metric label="Retardos" value={String((asistencias??[]).filter(a=>a.estado==="Retardo").length)}/></div>
      <div className="mt-4 max-h-72 overflow-y-auto"><table className="w-full text-left text-sm"><thead><tr className="border-b border-rule text-ink-soft"><th className="px-3 py-2">Fecha</th><th className="px-3 py-2">Estado</th><th className="px-3 py-2">Observación</th></tr></thead><tbody>{(asistencias??[]).map(a=><tr key={a.id} className="border-b border-rule"><td className="px-3 py-2">{a.fecha}</td><td className="px-3 py-2">{a.estado}</td><td className="px-3 py-2">{a.observacion??"—"}</td></tr>)}</tbody></table></div>
    </section>
  </div>;
}
function Metric({label,value}:{label:string;value:string}){return <div className="rounded-sm border border-rule bg-paper px-4 py-3"><p className="text-xs text-ink-soft">{label}</p><p className="mt-1 font-display text-2xl text-ink">{value}</p></div>}
