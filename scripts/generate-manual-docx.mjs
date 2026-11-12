/**
 * generate-manual-docx.mjs
 * Genera MANUAL_DE_USUARIO_SGA.docx en la raíz del worktree qa_test_results
 * Ejecutar: node scripts/generate-manual-docx.mjs
 */

import {
  Document,
  Packer,
  Paragraph,
  Table,
  TableRow,
  TableCell,
  TextRun,
  HeadingLevel,
  AlignmentType,
  WidthType,
  ShadingType,
  BorderStyle,
  TableLayoutType,
  VerticalAlign,
} from "docx";
import { writeFileSync } from "fs";
import { fileURLToPath } from "url";
import path from "path";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const OUTPUT = path.resolve(__dirname, "..", "MANUAL_DE_USUARIO_SGA.docx");

// ── Paleta de colores institucionales ─────────────────────────────────────────
const COLOR = {
  TITLE_BG: "1A3A5C",   // azul marino oscuro
  TITLE_FG: "FFFFFF",
  H2_BG: "2E6DA4",      // azul corporativo medio
  H2_FG: "FFFFFF",
  H3_BG: "D9E8F7",      // azul celeste muy suave
  H3_FG: "1A3A5C",
  HEADER_BG: "3B5998",
  HEADER_FG: "FFFFFF",
  NOTE_BG: "FFF9E6",    // amarillo suave para notas/tips
  NOTE_BORDER: "ECC94B",
  ROW_ALT: "F4F8FC",
  ROW_STD: "FFFFFF",
  BORDER: "CBD5E1",
};

// ── Helpers de formato ────────────────────────────────────────────────────────
const bold = (text, color = "000000", size = 21) =>
  new TextRun({ text, bold: true, color, size, font: "Calibri" });

const normal = (text, color = "2D3748", size = 21) =>
  new TextRun({ text, color, size, font: "Calibri" });

const italic = (text, color = "4A5568", size = 20) =>
  new TextRun({ text, italics: true, color, size, font: "Calibri" });

function heading1(text) {
  return new Paragraph({
    heading: HeadingLevel.HEADING_1,
    spacing: { before: 360, after: 160 },
    shading: { type: ShadingType.SOLID, color: COLOR.TITLE_BG, fill: COLOR.TITLE_BG },
    children: [bold(text, COLOR.TITLE_FG, 30)],
  });
}

function heading2(text) {
  return new Paragraph({
    heading: HeadingLevel.HEADING_2,
    spacing: { before: 300, after: 120 },
    shading: { type: ShadingType.SOLID, color: COLOR.H2_BG, fill: COLOR.H2_BG },
    children: [bold(text, COLOR.H2_FG, 24)],
  });
}

function heading3(text) {
  return new Paragraph({
    heading: HeadingLevel.HEADING_3,
    spacing: { before: 220, after: 90 },
    shading: { type: ShadingType.SOLID, color: COLOR.H3_BG, fill: COLOR.H3_BG },
    children: [bold(text, COLOR.H3_FG, 21)],
  });
}

function para(text, { indent = false, spaceAfter = 110 } = {}) {
  return new Paragraph({
    spacing: { after: spaceAfter },
    indent: indent ? { left: 350 } : undefined,
    children: [normal(text)],
  });
}

function bullet(text, level = 0) {
  return new Paragraph({
    bullet: { level },
    spacing: { after: 70 },
    children: [normal(text)],
  });
}

function tipBox(text) {
  return new Paragraph({
    spacing: { before: 120, after: 140 },
    indent: { left: 400, right: 400 },
    border: {
      left: { style: BorderStyle.SINGLE, size: 18, color: COLOR.NOTE_BORDER },
      top: { style: BorderStyle.SINGLE, size: 2, color: COLOR.BORDER },
      bottom: { style: BorderStyle.SINGLE, size: 2, color: COLOR.BORDER },
      right: { style: BorderStyle.SINGLE, size: 2, color: COLOR.BORDER },
    },
    shading: { type: ShadingType.SOLID, color: COLOR.NOTE_BG, fill: COLOR.NOTE_BG },
    children: [bold("💡 Nota útil: "), italic(text)],
  });
}

function labelValue(label, value) {
  return new Paragraph({
    spacing: { after: 90 },
    children: [bold(label + ": "), normal(value)],
  });
}

function spacer() {
  return new Paragraph({ spacing: { after: 80 }, children: [] });
}

function divider() {
  return new Paragraph({
    spacing: { before: 140, after: 140 },
    border: { bottom: { color: COLOR.H2_BG, size: 6, style: BorderStyle.SINGLE } },
    children: [],
  });
}

// ── Helpers de tablas ─────────────────────────────────────────────────────────
const cellBorder = {
  top: { style: BorderStyle.SINGLE, size: 2, color: COLOR.BORDER },
  bottom: { style: BorderStyle.SINGLE, size: 2, color: COLOR.BORDER },
  left: { style: BorderStyle.SINGLE, size: 2, color: COLOR.BORDER },
  right: { style: BorderStyle.SINGLE, size: 2, color: COLOR.BORDER },
};

function headerCell(text, widthPct) {
  return new TableCell({
    width: { size: widthPct, type: WidthType.PERCENTAGE },
    shading: { type: ShadingType.SOLID, color: COLOR.HEADER_BG, fill: COLOR.HEADER_BG },
    borders: cellBorder,
    verticalAlign: VerticalAlign.CENTER,
    children: [
      new Paragraph({
        alignment: AlignmentType.CENTER,
        children: [bold(text, COLOR.HEADER_FG, 19)],
      }),
    ],
  });
}

function dataCell(text, widthPct, alt = false, isBold = false) {
  const bg = alt ? COLOR.ROW_ALT : COLOR.ROW_STD;
  return new TableCell({
    width: { size: widthPct, type: WidthType.PERCENTAGE },
    shading: { type: ShadingType.SOLID, color: bg, fill: bg },
    borders: cellBorder,
    verticalAlign: VerticalAlign.CENTER,
    children: [
      new Paragraph({
        children: [isBold ? bold(text, "000000", 19) : normal(text, "2D3748", 19)],
      }),
    ],
  });
}

function makeTable(headers, rows, widths) {
  return new Table({
    layout: TableLayoutType.FIXED,
    width: { size: 100, type: WidthType.PERCENTAGE },
    rows: [
      new TableRow({
        tableHeader: true,
        children: headers.map((h, i) => headerCell(h, widths[i])),
      }),
      ...rows.map((row, ri) =>
        new TableRow({
          children: row.map((cell, ci) => dataCell(cell, widths[ci], ri % 2 === 1, ci === 0)),
        })
      ),
    ],
  });
}

// ── Documento completo ────────────────────────────────────────────────────────
const doc = new Document({
  styles: {
    paragraphStyles: [
      {
        id: "Normal",
        name: "Normal",
        run: { font: "Calibri", size: 21 },
      },
    ],
  },
  sections: [
    {
      children: [
        // ── Portada / Encabezado ────────────────────────────────────────────
        heading1("MANUAL DE USUARIO"),
        heading1("Sistema de Gestión Académica (SGA)"),
        spacer(),
        labelValue("Plataforma", "Sistema de Gestión Académica y Prevención de Deserción Escolar"),
        labelValue("Versión", "1.0 (Noviembre de 2026)"),
        labelValue("Destinatarios", "Coordinadores, Docentes, Estudiantes y Acudientes"),
        divider(),

        // ── 1. Introducción ─────────────────────────────────────────────────
        heading2("1. Introducción y Bienvenida"),
        para("El Sistema de Gestión Académica (SGA) es una plataforma integral desarrollada para modernizar y simplificar el seguimiento escolar diario. Su diseño combina facilidad de uso en computadores y dispositivos móviles con analítica de datos avanzada para anticipar y evitar la reprobación y la deserción escolar."),
        bullet("Para Coordinadores: Centraliza matrículas, gestión de salones, cuerpo docente, horarios y semáforo preventivo con inteligencia analítica."),
        bullet("Para Profesores: Brinda una herramienta rápida para tomar lista, ingresar notas por periodo y registrar anotaciones del observador del alumno."),
        bullet("Para Estudiantes y Familias: Ofrece un portal transparente para consultar calificaciones actualizadas, historial de asistencia y horarios."),
        divider(),

        // ── 2. Roles y Permisos ─────────────────────────────────────────────
        heading2("2. Roles de Usuario y Permisos"),
        para("El sistema reconoce automáticamente quién está ingresando y adapta las opciones del menú para mostrar únicamente lo que cada usuario necesita:"),
        makeTable(
          ["Rol", "Destinatarios", "Principales Funcionalidades"],
          [
            ["Coordinador", "Rectoría, coordinaciones y secretaría académica.", "Administración total de cursos, estudiantes, profesores, horarios, reportes predictivos de deserción y envío de alertas por correo."],
            ["Profesor", "Cuerpo docente de todas las áreas.", "Registro de notas (P1 y P2), toma diaria de lista de asistencia con justificaciones/retardos y observador disciplinario."],
            ["Estudiante", "Alumnos matriculados y sus acudientes.", "Consulta personal de notas por periodo, horario semanal de clases e historial detallado de asistencia."],
          ],
          [20, 30, 50]
        ),
        divider(),

        // ── 3. Acceso y Seguridad ───────────────────────────────────────────
        heading2("3. Módulo de Acceso, Autenticación y Seguridad"),
        heading3("3.1. Inicio de Sesión (/login)"),
        para("Para acceder a la plataforma:"),
        bullet("1. Abra su navegador web e ingrese a la dirección web institucional del colegio."),
        bullet("2. En la pantalla de ingreso escriba su Correo Institucional (ejemplo: coordinador@colegio.edu.co o profesor@colegio.edu.co)."),
        bullet("3. Digite su Contraseña confidencial."),
        bullet("4. Presione el botón 'Entrar'."),
        tipBox("Si ingresa credenciales incorrectas, el sistema mostrará un recuadro rojo: 'Correo o contraseña incorrectos'. Si olvida su contraseña, acérquese a coordinación para su restablecimiento."),
        heading3("3.2. Cierre de Sesión Seguro"),
        para("Al finalizar sus actividades, ubique en la parte inferior del menú lateral izquierdo su nombre de usuario y presione el botón 'Cerrar sesión' para proteger la confidencialidad de la información."),
        divider(),

        // ── 4. Módulo Coordinador ───────────────────────────────────────────
        heading2("4. Módulo del Coordinador (Administración General)"),
        para("El coordinador cuenta con acceso integral a toda la gestión institucional."),
        
        heading3("4.1. Panel Principal de Control (/dashboard)"),
        para("Al ingresar, encontrará tarjetas con estadísticas en tiempo real: número de cursos activos, estudiantes matriculados y docentes vinculados. También visualizará la cuadrícula de cursos con acceso directo a sus horarios."),

        heading3("4.2. Gestión de Cursos y Grados (/dashboard/cursos)"),
        para("Permite organizar los salones y grados de la institución:"),
        bullet("Crear Curso: Presione '+ Nuevo curso', ingrese el nombre (ej. '10mo A') y seleccione la jornada ('Mañana', 'Tarde' o 'Única'). Presione 'Guardar'."),
        bullet("Editar Curso: Haga clic en el ícono del Lápiz en la fila del curso para modificar su jornada o nombre."),
        bullet("Eliminar Curso: Haga clic en el ícono de Papelera. El sistema solicitará confirmación antes de borrarlo."),

        heading3("4.3. Gestión de Estudiantes y Matrículas (/dashboard/estudiantes)"),
        para("Permite administrar la base de datos de los alumnos del colegio:"),
        bullet("Matricular Estudiante: Presione '+ Nuevo estudiante'. Complete: Nombre completo, Curso asignado, Nombre y Teléfono del acudiente, Estrato socioeconómico (del 1 al 6), y condición de repitencia ('Año repetido')."),
        bullet("Filtro Rápido: Utilice el menú superior para ver todos los estudiantes o filtrar por un curso específico."),

        heading3("4.4. Gestión de Docentes (/dashboard/profesores)"),
        para("Permite dar de alta a los profesores:"),
        bullet("Presione '+ Nuevo profesor'."),
        bullet("Ingrese el nombre completo, correo institucional (para su login) y teléfono de contacto."),

        heading3("4.5. Programación de Horarios (/dashboard/horario)"),
        para("Estructure la carga académica semanal de cada curso:"),
        bullet("1. Seleccione el curso en el selector superior."),
        bullet("2. En el día deseado (Lunes a Viernes), presione '+ Agregar bloque'."),
        bullet("3. Defina la Materia, el Profesor encargado, la Hora de inicio y de fin."),
        bullet("4. Para descansos o recreos, marque la casilla 'Es descanso' (no requerirá profesor)."),

        heading3("4.6. Seguimiento Académico Global (/dashboard/seguimiento)"),
        para("Presenta una tabla consolidada con el desempeño de todos los estudiantes: promedios de notas del Periodo 1 y 2, total de inasistencias, mayor número de faltas consecutivas, retardos y conteo de anotaciones del observador."),

        heading3("4.7. Reporte Predictivo de Deserción y Emisión de Alertas (/dashboard/reporte-estudiante)"),
        para("Módulo de prevención temprana con analítica inteligente:"),
        bullet("Semáforo Rojo (Alto Riesgo): Promedios menores a 2.0, más de 5 faltas o faltas consecutivas críticas."),
        bullet("Semáforo Amarillo (Riesgo Medio): Promedios entre 2.0 y 2.99 o ausencias frecuentes."),
        bullet("Semáforo Gris/Verde (Informativo / Normal): Desempeño regular sin factores de alarma."),
        para("Envío de Alertas por Correo:"),
        bullet("1. Ubique al alumno en riesgo y presione el botón de sobre 'Enviar alerta manual'."),
        bullet("2. Confirme el envío en la ventana emergente."),
        bullet("3. El sistema enviará un correo estructurado al acudiente con copia a coordinación detallando las áreas que requieren apoyo inmediato."),
        tipBox("El sistema previene la saturación: si se reenvía una alerta al mismo estudiante en la misma semana, actualiza el registro sin duplicar envíos molestos."),
        divider(),

        // ── 5. Módulo Profesor ──────────────────────────────────────────────
        heading2("5. Módulo del Docente ('Mis Estudiantes')"),
        para("Ubicado en /dashboard/profesor, este portal está optimizado para la labor en el aula:"),

        heading3("5.1. Selección de Curso y Materia"),
        para("En la barra superior, el profesor selecciona el curso y la asignatura que va a atender. La lista de estudiantes asignados se desplegará de forma inmediata."),

        heading3("5.2. Calificaciones (Periodos 1 y 2)"),
        bullet("1. En la columna de notas del periodo respectivo, escriba la calificación numérica (ej. 4.2 o 2.5)."),
        bullet("2. Presione 'Guardar notas'. El sistema recalculará los promedios en tiempo real."),

        heading3("5.3. Toma Diaria de Asistencia"),
        bullet("1. Seleccione la fecha de la clase (por defecto carga el día actual)."),
        bullet("2. Seleccione el estado para cada alumno: Asistió, Faltó, Justificación o Retardo."),
        bullet("3. Agregue notas en la columna Observación si el alumno trajo excusa médica o llegó con demora."),
        bullet("4. Presione 'Guardar asistencia'."),

        heading3("5.4. Observador Disciplinario (+ Anotación)"),
        bullet("1. Presione el botón '+ Anotación' en la fila del estudiante."),
        bullet("2. Elija la gravedad: Leve (porte de uniforme, distracción) o Grave (agresiones, fraude)."),
        bullet("3. Redacte los hechos y compromisos, y presione 'Guardar anotación'."),
        divider(),

        // ── 6. Módulo Estudiante ────────────────────────────────────────────
        heading2("6. Módulo del Estudiante ('Mi Información')"),
        para("Ubicado en /dashboard/estudiante, permite al alumno y a sus padres hacer seguimiento continuo:"),
        bullet("Métricas Principales: Tarjetas con promedio del Periodo 1, promedio del Periodo 2, total de inasistencias y racha máxima de faltas seguidas."),
        bullet("Mis Profesores y Materias: Listado claro de las asignaturas inscritas y el nombre del profesor titular."),
        bullet("Boletín de Notas: Desglose por materia de cada periodo para detectar a tiempo notas menores a 3.0."),
        bullet("Horario Semanal: Grilla de Lunes a Viernes con horas exactas y aulas correspondientes."),
        bullet("Auditoría de Asistencia: Tabla cronológica con cada fecha, si asistió o faltó, y las observaciones que dejó el docente."),
        divider(),

        // ── 7. FAQ ──────────────────────────────────────────────────────────
        heading2("7. Preguntas Frecuentes (FAQ)"),
        para("¿Qué hago si no recuerdo mi contraseña?", { indent: true }),
        para("Solicite al coordinador o administrador que restablezca su acceso desde la consola institucional.", { indent: true }),
        spacer(),
        para("¿Por qué un docente no ve a un estudiante en su lista?", { indent: true }),
        para("El coordinador debe asegurarse de que el estudiante esté asignado al curso y tenga los bloques de clase vinculados en el horario.", { indent: true }),
        spacer(),
        para("¿Cómo sabe el sistema cuándo enviar una alerta por correo?", { indent: true }),
        para("El coordinador o profesor puede emitirla manualmente con el botón de sobre, o el sistema puede evaluar automáticamente los factores de riesgo semanales mediante el modelo de inteligencia predictiva.", { indent: true }),
        divider(),

        // ── 8. Glosario ─────────────────────────────────────────────────────
        heading2("8. Glosario de Términos"),
        makeTable(
          ["Término", "Definición"],
          [
            ["SGA", "Sistema de Gestión Académica."],
            ["Semáforo de Riesgo", "Herramienta visual analítica que clasifica en Alto, Medio e Informativo el riesgo de deserción o pérdida escolar."],
            ["Inasistencia Justificada", "Falta que cuenta con soporte formal (médico o calamidad) presentado por el acudiente."],
            ["Anotación Grave", "Registro formal en el observador escolar por faltas disciplinarias de alta trascendencia."],
            ["RLS (Row Level Security)", "Protección de seguridad que asegura que cada estudiante solo pueda consultar sus propias notas y ningún dato de terceros."],
          ],
          [25, 75]
        ),
        divider(),
        new Paragraph({
          spacing: { before: 200, after: 100 },
          alignment: AlignmentType.CENTER,
          children: [
            italic("Manual de Usuario Oficial — Sistema de Gestión Académica (SGA)", "2E6DA4", 19),
          ],
        }),
      ],
    },
  ],
});

// ── Guardar archivo ───────────────────────────────────────────────────────────
const buffer = await Packer.toBuffer(doc);
writeFileSync(OUTPUT, buffer);
console.log(`✅ Manual Word generado: ${OUTPUT}`);
