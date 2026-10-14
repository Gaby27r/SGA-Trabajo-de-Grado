"use client";

import { useMemo, useState } from "react";
import { Plus,Search,Pencil,Save,ClipboardPlus,} from "lucide-react";
import type { Asistencia, Calificacion, Curso, Estudiante, EstadoAsistencia } from "@/lib/types";
import { Button } from "@/components/ui/button";
import { Modal } from "@/components/ui/modal";
import { Field, Select, TextInput } from "@/components/ui/field";
import { Banner } from "@/components/ui/banner";
import { crearEstudiante, actualizarEstudiante } from "../estudiantes/actions";
import { guardarAsistencia, guardarCalificacion } from "./actions";
import { AnotacionForm } from "./anotacion-form";

type Materia = { curso_id: string; materia: string };

export function ProfesorManager({
  estudiantes, notas, asistencias, cursos, materias,
}: {
  estudiantes: Estudiante[];
  notas: Calificacion[];
  asistencias: Asistencia[];
  cursos: Curso[];
  materias: Materia[];
}) {
  const [selectedId, setSelectedId] = useState(estudiantes[0]?.id ?? "");
  const [search, setSearch] = useState("");
  const [periodo, setPeriodo] = useState<1 | 2>(2);
  const [gradeOpen, setGradeOpen] = useState(false);
  const [attendanceOpen, setAttendanceOpen] = useState(false);
  const [anotacionOpen, setAnotacionOpen] = useState(false);
  const [studentOpen, setStudentOpen] = useState(false);
  const [editing, setEditing] = useState<Estudiante | null>(null);

  const lista = useMemo(() => {
  const q = search.toLowerCase().trim();

  return estudiantes.filter(
    (e) =>
      !q ||
      e.nombre_completo.toLowerCase().includes(q)
  );
}, [estudiantes, search]);
  const selected = estudiantes.find((e) => e.id === selectedId) ?? null;
  const selectedGrades = notas.filter((n) => n.estudiante_id === selectedId);
  const selectedAttendance = asistencias.filter((a) => a.estudiante_id === selectedId);
  const avg = (p: number) => {
    const rows = selectedGrades.filter((n) => n.periodo === p);
    return rows.length ? (rows.reduce((s,n) => s + Number(n.nota), 0) / rows.length).toFixed(2) : "—";
  };
  const count = (estado: EstadoAsistencia) => selectedAttendance.filter((a) => a.estado === estado).length;
  const maxConsecutiveAbsences = (() => {
    const days = [...selectedAttendance].filter(a => a.estado === "Falto").sort((a,b) => a.fecha.localeCompare(b.fecha));
    let max=0, run=0, prev="";
    for (const a of days) {
      const d=new Date(`${a.fecha}T00:00:00`);
      const p=prev ? new Date(`${prev}T00:00:00`) : null;
      const consecutive=p ? Math.round((d.getTime()-p.getTime())/86400000)===1 : false;
      run=consecutive ? run+1 : 1; max=Math.max(max,run); prev=a.fecha;
    }
    return max;
  })();

  return (
    <div className="grid gap-5 lg:grid-cols-[310px_1fr]">
      <section className="rounded-sm border border-rule-strong bg-paper-raised">
        <div className="border-b border-rule p-4">
          <div className="flex items-center justify-between">
            <p className="font-display text-lg text-ink">Estudiantes ({estudiantes.length})</p>
            <button className="rounded-sm p-2 hover:bg-rule/30" title="Agregar estudiante" onClick={() => { setEditing(null); setStudentOpen(true); }}><Plus className="h-4 w-4" /></button>
          </div>
          <div className="relative mt-3">
            <Search className="absolute left-2.5 top-2.5 h-4 w-4 text-ink-soft" />
            <TextInput className="pl-8" placeholder="Buscar estudiante..." value={search} onChange={(e) => setSearch(e.target.value)} />
          </div>
        </div>
        <div className="max-h-[620px] overflow-y-auto">
          {lista.map((e) => (
            <button key={e.id} onClick={() => setSelectedId(e.id)} className={`w-full border-b border-rule px-4 py-3 text-left hover:bg-rule/20 ${selectedId===e.id ? "bg-accent/10 border-l-2 border-l-accent" : ""}`}>
              <p className="text-sm font-medium text-ink">{e.nombre_completo}</p>
              <p className="text-xs text-ink-soft">{e.cursos?.nombre ?? "Sin curso"} · {e.documento}</p>
            </button>
          ))}
          {!lista.length && <p className="p-5 text-sm text-ink-soft">No hay estudiantes.</p>}
        </div>
      </section>

      {selected ? (
        <section className="flex flex-col gap-5">
          <div className="rounded-sm border border-rule-strong bg-paper-raised p-5">
            <div className="flex flex-wrap items-start justify-between gap-3">
              <div>
                <h2 className="font-display text-2xl text-ink">{selected.nombre_completo}</h2>
                <p className="mt-1 text-sm text-ink-soft">{selected.cursos?.nombre} · Documento {selected.documento}</p>
              </div>
            <div className="flex flex-wrap gap-2">
              <Button
    onClick={() => setAnotacionOpen(true)}><ClipboardPlus className="h-4 w-4" />
    Agregar anotación
            </Button>
  
  <Button
    variant="ghost"
    onClick={() => {
      setEditing(selected);
      setStudentOpen(true);
    }}
  >
    <Pencil className="h-4 w-4" />
    Editar
  </Button>
</div>
            </div>
            <div className="mt-4 grid gap-3 sm:grid-cols-4">
              <Metric label="Promedio P1" value={avg(1)} />
              <Metric label="Promedio P2" value={avg(2)} />
              <Metric label="Asistencias" value={String(count("Asistio"))} />
              <Metric label="Inasistencias" value={String(count("Falto") + count("Justificacion"))} />
              <Metric label="Máx. faltas consecutivas" value={String(maxConsecutiveAbsences)} />
            </div>
            <div className="mt-3 flex flex-wrap gap-3 text-xs text-ink-soft">
              <span>Retardos: {count("Retardo")}</span>
              <span>Justificadas: {count("Justificacion")}</span>
              <span>Faltas: {count("Falto")}</span>
              <span>Curso: {selected.cursos?.nombre ?? "—"}</span>
            </div>
          </div>

          <div className="rounded-sm border border-rule-strong bg-paper-raised p-5">
            <div className="flex flex-wrap items-center justify-between gap-3">
              <div>
                <h3 className="font-display text-xl text-ink">Notas</h3>
                <p className="text-sm text-ink-soft">Solo puedes registrar las materias que tienes asignadas en el horario.</p>
              </div>
              <div className="flex gap-2">
                <Select className="w-auto" value={periodo} onChange={(e) => setPeriodo(Number(e.target.value) as 1|2)}>
                  <option value="1">Periodo 1</option><option value="2">Periodo 2</option>
                </Select>
                <Button onClick={() => setGradeOpen(true)}><Plus className="h-4 w-4" /> Agregar nota</Button>
              </div>
            </div>
            <div className="mt-4 overflow-x-auto">
              <table className="w-full text-left text-sm"><thead><tr className="border-b border-rule text-ink-soft"><th className="px-3 py-2">Materia</th><th className="px-3 py-2">Nota</th><th className="px-3 py-2">Periodo</th></tr></thead>
              <tbody>{selectedGrades.filter(n=>n.periodo===periodo).map(n=><tr key={n.id} className="border-b border-rule"><td className="px-3 py-2">{n.materia}</td><td className="px-3 py-2 font-medium">{Number(n.nota).toFixed(2)}</td><td className="px-3 py-2">P{n.periodo}</td></tr>)}</tbody></table>
              {!selectedGrades.some(n=>n.periodo===periodo) && <p className="py-5 text-center text-sm text-ink-soft">No hay notas registradas para este periodo.</p>}
            </div>
          </div>

          <div className="rounded-sm border border-rule-strong bg-paper-raised p-5">
            <div className="flex flex-wrap items-center justify-between gap-3">
              <div><h3 className="font-display text-xl text-ink">Asistencia</h3><p className="text-sm text-ink-soft">Registro diario: Asistio, Falto, Justificacion o Retardo.</p></div>
              <Button onClick={() => setAttendanceOpen(true)}><Plus className="h-4 w-4" /> Registrar</Button>
            </div>
            <div className="mt-4 max-h-72 overflow-y-auto">
              <table className="w-full text-left text-sm"><thead><tr className="border-b border-rule text-ink-soft"><th className="px-3 py-2">Fecha</th><th className="px-3 py-2">Estado</th><th className="px-3 py-2">Observación</th></tr></thead>
              <tbody>{selectedAttendance.map(a=><tr key={a.id} className="border-b border-rule"><td className="px-3 py-2">{a.fecha}</td><td className="px-3 py-2">{a.estado}</td><td className="px-3 py-2">{a.observacion ?? "—"}</td></tr>)}</tbody></table>
              {!selectedAttendance.length && <p className="py-5 text-center text-sm text-ink-soft">No hay registros.</p>}
            </div>
          </div>

          <div className="rounded-sm border border-rule-strong bg-paper-raised p-5">
            <h3 className="font-display text-xl text-ink">Información del estudiante</h3>
            <div className="mt-3 grid gap-3 text-sm sm:grid-cols-2">
              <Info label="Dirección" value={selected.direccion} /><Info label="Estrato" value={selected.estrato?.toString()} />
              <Info label="Fecha de nacimiento" value={selected.fecha_nacimiento} /><Info label="Edad actual" value={selected.edad_actual?.toString()} />
              <Info label="Con quien vive" value={selected.con_quien_vive} /><Info label="Año repetido" value={selected.anio_repetido} />
              <Info label="Matriculado" value={selected.matriculado} /><Info label="Reuniones de padres" value={selected.reuniones_padres == null ? null : selected.reuniones_padres ? "SI" : "NO"} />
              <Info label="Anotaciones" value={`${selected.total_anotaciones} (graves: ${selected.graves}, leves: ${selected.leves})`} />
            </div>
          </div>
        </section>
      ) : (
        <div className="rounded-sm border border-rule-strong bg-paper-raised p-10 text-center text-ink-soft">Selecciona un estudiante.</div>
      )}

      <GradeForm open={gradeOpen} onClose={()=>setGradeOpen(false)} estudiante={selected} materias={materias.filter(m=>m.curso_id===selected?.curso_id)} defaultPeriod={periodo} />
      <AttendanceForm open={attendanceOpen} onClose={()=>setAttendanceOpen(false)} estudiante={selected} />
      <StudentForm open={studentOpen} onClose={()=>setStudentOpen(false)} estudiante={editing} cursos={cursos} />
      <AnotacionForm open={anotacionOpen} onClose={() => setAnotacionOpen(false)} estudiante={selected} />
    </div>
  );
}

function Metric({label,value}:{label:string;value:string}) {
  return <div className="rounded-sm border border-rule bg-paper px-3 py-3"><p className="text-xs text-ink-soft">{label}</p><p className="mt-1 font-display text-2xl text-ink">{value}</p></div>;
}
function Info({label,value}:{label:string;value:string|null|undefined}) {
  return <div><span className="text-xs text-ink-soft">{label}</span><p className="text-ink">{value || "—"}</p></div>;
}

function GradeForm({open,onClose,estudiante,materias,defaultPeriod}:{open:boolean;onClose:()=>void;estudiante:Estudiante|null;materias:Materia[];defaultPeriod:1|2}) {
  const [materia,setMateria]=useState(materias[0]?.materia??"");
  const [periodo,setPeriodo]=useState<1|2>(defaultPeriod);
  const [nota,setNota]=useState("");
  const [error,setError]=useState<string|null>(null);
  const [loading,setLoading]=useState(false);
  async function submit(e:React.FormEvent){e.preventDefault();if(!estudiante || !estudiante.curso_id)return;setLoading(true);setError(null);const m=materias.find(x=>x.materia===materia);const r=await guardarCalificacion({estudiante_id:estudiante.id,curso_id:estudiante.curso_id,materia,periodo,nota});setLoading(false);if(r.error)setError(r.error);else{setNota("");onClose();}}
  return <Modal open={open} onClose={onClose} title="Registrar nota"><form onSubmit={submit} className="flex flex-col gap-4">{error&&<Banner>{error}</Banner>}<Field label="Materia" htmlFor="g-materia"><Select id="g-materia" value={materia} onChange={e=>setMateria(e.target.value)}>{materias.map(m=><option key={m.materia}>{m.materia}</option>)}</Select></Field><Field label="Periodo" htmlFor="g-periodo"><Select id="g-periodo" value={periodo} onChange={e=>setPeriodo(Number(e.target.value) as 1|2)}><option value="1">1</option><option value="2">2</option></Select></Field><Field label="Nota (0 a 5)" htmlFor="g-nota"><TextInput id="g-nota" type="number" min="0" max="5" step="0.01" required value={nota} onChange={e=>setNota(e.target.value)} /></Field><div className="flex justify-end"><Button type="submit" loading={loading}><Save className="h-4 w-4"/>Guardar</Button></div></form></Modal>;
}

function AttendanceForm({open,onClose,estudiante}:{open:boolean;onClose:()=>void;estudiante:Estudiante|null}) {
  const [fecha,setFecha]=useState(new Date().toISOString().slice(0,10));
  const [estado,setEstado]=useState<EstadoAsistencia>("Asistio");
  const [obs,setObs]=useState(""); const [error,setError]=useState<string|null>(null); const [loading,setLoading]=useState(false);
  async function submit(e:React.FormEvent){e.preventDefault();if(!estudiante || !estudiante.curso_id)return;setLoading(true);setError(null);const r=await guardarAsistencia({estudiante_id:estudiante.id,curso_id:estudiante.curso_id,fecha,estado,observacion:obs});setLoading(false);if(r.error)setError(r.error);else{setObs("");onClose();}}
  return <Modal open={open} onClose={onClose} title="Registrar asistencia"><form onSubmit={submit} className="flex flex-col gap-4">{error&&<Banner>{error}</Banner>}<Field label="Fecha" htmlFor="a-fecha"><TextInput id="a-fecha" type="date" required value={fecha} onChange={e=>setFecha(e.target.value)}/></Field><Field label="Estado" htmlFor="a-estado"><Select id="a-estado" value={estado} onChange={e=>setEstado(e.target.value as EstadoAsistencia)}><option value="Asistio">Asistió</option><option value="Falto">Faltó</option><option value="Justificacion">Justificación</option><option value="Retardo">Retardo</option></Select></Field><Field label="Observación" htmlFor="a-obs"><TextInput id="a-obs" value={obs} onChange={e=>setObs(e.target.value)} /></Field><div className="flex justify-end"><Button type="submit" loading={loading}>Guardar</Button></div></form></Modal>;
}

function StudentForm({open,onClose,estudiante,cursos}:{open:boolean;onClose:()=>void;estudiante:Estudiante|null;cursos:Curso[]}) {
  const [nombre,setNombre]=useState(estudiante?.nombre_completo??"");const [documento,setDocumento]=useState(estudiante?.documento??"");const [curso,setCurso]=useState(estudiante?.curso_id??cursos[0]?.id??"");const [direccion,setDireccion]=useState(estudiante?.direccion??"");const [estrato,setEstrato]=useState(estudiante?.estrato?.toString()??"");const [acudiente,setAcudiente]=useState(estudiante?.acudiente??"");const [tel,setTel]=useState(estudiante?.telefono_acudiente??"");const [nacimiento,setNacimiento]=useState(estudiante?.fecha_nacimiento??"");const [vive,setVive]=useState(estudiante?.con_quien_vive??"");const [repite,setRepite]=useState(estudiante?.anio_repetido??"NO");const [matriculado,setMatriculado]=useState(estudiante?.matriculado??"MATRICULA");const [reuniones,setReuniones]=useState(estudiante?.reuniones_padres??false);const [error,setError]=useState<string|null>(null);const [loading,setLoading]=useState(false);
  async function submit(e:React.FormEvent){e.preventDefault();setLoading(true);setError(null);const r=estudiante?await actualizarEstudiante(estudiante.id,{nombre_completo:nombre,documento,curso_id:curso,direccion,estrato,acudiente,telefono_acudiente:tel,fecha_nacimiento:nacimiento,con_quien_vive:vive,anio_repetido:repite,matriculado,reuniones_padres:reuniones}):await crearEstudiante({nombre_completo:nombre,documento,curso_id:curso,direccion,estrato,acudiente,telefono_acudiente:tel,fecha_nacimiento:nacimiento,con_quien_vive:vive,anio_repetido:repite,matriculado,reuniones_padres:reuniones});setLoading(false);if(r.error)setError(r.error);else onClose();}
  return <Modal open={open} onClose={onClose} title={estudiante?"Editar estudiante":"Agregar estudiante"}><form onSubmit={submit} className="grid gap-4 sm:grid-cols-2 max-h-[75vh] overflow-y-auto pr-1">{error&&<div className="sm:col-span-2"><Banner>{error}</Banner></div>}<Field label="Nombre completo" htmlFor="s-nombre"><TextInput id="s-nombre" required value={nombre} onChange={e=>setNombre(e.target.value)}/></Field><Field label="Documento" htmlFor="s-doc"><TextInput id="s-doc" value={documento} onChange={e=>setDocumento(e.target.value)}/></Field><Field label="Curso" htmlFor="s-curso"><Select id="s-curso" value={curso} onChange={e=>setCurso(e.target.value)}>{cursos.map(c=><option key={c.id} value={c.id}>{c.nombre}</option>)}</Select></Field><Field label="Fecha de nacimiento" htmlFor="s-nac"><TextInput id="s-nac" type="date" value={nacimiento} onChange={e=>setNacimiento(e.target.value)}/></Field><Field label="Dirección" htmlFor="s-dir"><TextInput id="s-dir" value={direccion} onChange={e=>setDireccion(e.target.value)}/></Field><Field label="Estrato" htmlFor="s-estrato"><TextInput id="s-estrato" type="number" min="1" max="6" value={estrato} onChange={e=>setEstrato(e.target.value)}/></Field><Field label="Acudiente" htmlFor="s-acu"><TextInput id="s-acu" value={acudiente} onChange={e=>setAcudiente(e.target.value)}/></Field><Field label="Teléfono acudiente" htmlFor="s-tel"><TextInput id="s-tel" value={tel} onChange={e=>setTel(e.target.value)}/></Field><Field label="Con quien vive" htmlFor="s-vive"><TextInput id="s-vive" value={vive} onChange={e=>setVive(e.target.value)}/></Field><Field label="Año repetido" htmlFor="s-rep"><Select id="s-rep" value={repite} onChange={e=>setRepite(e.target.value)}><option>NO</option><option>REPITENTE</option></Select></Field><Field label="Matriculado" htmlFor="s-mat"><Select id="s-mat" value={matriculado} onChange={e=>setMatriculado(e.target.value)}><option>MATRICULA</option><option>CONVENIO</option></Select></Field><label className="flex items-center gap-2 text-sm text-ink-soft sm:col-span-2"><input type="checkbox" checked={reuniones} onChange={e=>setReuniones(e.target.checked)}/> Reuniones de padres: SI</label><div className="flex justify-end gap-2 sm:col-span-2"><Button type="button" variant="ghost" onClick={onClose}>Cancelar</Button><Button type="submit" loading={loading}>Guardar</Button></div></form></Modal>;
}
