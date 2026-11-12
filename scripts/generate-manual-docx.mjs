/**
 * generate-manual-docx.mjs
 * Genera MANUAL_DE_USUARIO_SGA.docx exhaustivo y ultra-detallado
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
  H3_BG: "EAF2F8",      // azul celeste muy suave
  H3_FG: "1A3A5C",
  HEADER_BG: "3B5998",  // encabezados de tablas
  HEADER_FG: "FFFFFF",
  NOTE_BG: "FFF9E6",    // amarillo suave para notas/tips
  NOTE_BORDER: "ECC94B",
  ALERT_BG: "FDF2F2",   // rojo suave para advertencias
  ALERT_BORDER: "F87171",
  ROW_ALT: "F8FAFC",
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
    children: [bold("  " + text + "  ", COLOR.TITLE_FG, 28)],
  });
}

function heading2(text) {
  return new Paragraph({
    heading: HeadingLevel.HEADING_2,
    spacing: { before: 280, after: 120 },
    shading: { type: ShadingType.SOLID, color: COLOR.H2_BG, fill: COLOR.H2_BG },
    children: [bold("  " + text + "  ", COLOR.H2_FG, 23)],
  });
}

function heading3(text) {
  return new Paragraph({
    heading: HeadingLevel.HEADING_3,
    spacing: { before: 200, after: 80 },
    shading: { type: ShadingType.SOLID, color: COLOR.H3_BG, fill: COLOR.H3_BG },
    children: [bold("  " + text + "  ", COLOR.H3_FG, 20)],
  });
}

function para(text, { indent = false, spaceAfter = 100 } = {}) {
  return new Paragraph({
    spacing: { after: spaceAfter },
    indent: indent ? { left: 350 } : undefined,
    children: [normal(text)],
  });
}

function bullet(text, level = 0) {
  return new Paragraph({
    bullet: { level },
    spacing: { after: 60 },
    children: [normal(text)],
  });
}

function tipBox(text, title = "💡 Consejo práctico: ") {
  return new Paragraph({
    spacing: { before: 100, after: 120 },
    indent: { left: 350, right: 350 },
    border: {
      left: { style: BorderStyle.SINGLE, size: 18, color: COLOR.NOTE_BORDER },
      top: { style: BorderStyle.SINGLE, size: 2, color: COLOR.BORDER },
      bottom: { style: BorderStyle.SINGLE, size: 2, color: COLOR.BORDER },
      right: { style: BorderStyle.SINGLE, size: 2, color: COLOR.BORDER },
    },
    shading: { type: ShadingType.SOLID, color: COLOR.NOTE_BG, fill: COLOR.NOTE_BG },
    children: [bold(title), italic(text)],
  });
}

function alertBox(text, title = "⚠️ Atención importante: ") {
  return new Paragraph({
    spacing: { before: 100, after: 120 },
    indent: { left: 350, right: 350 },
    border: {
      left: { style: BorderStyle.SINGLE, size: 18, color: COLOR.ALERT_BORDER },
      top: { style: BorderStyle.SINGLE, size: 2, color: COLOR.BORDER },
      bottom: { style: BorderStyle.SINGLE, size: 2, color: COLOR.BORDER },
      right: { style: BorderStyle.SINGLE, size: 2, color: COLOR.BORDER },
    },
    shading: { type: ShadingType.SOLID, color: COLOR.ALERT_BG, fill: COLOR.ALERT_BG },
    children: [bold(title, "991B1B"), italic(text, "7F1D1D")],
  });
}

function labelValue(label, value) {
  return new Paragraph({
    spacing: { after: 70 },
    children: [bold(label + ": "), normal(value)],
  });
}

function spacer(amount = 80) {
  return new Paragraph({ spacing: { after: amount }, children: [] });
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
        heading1("MANUAL DE USUARIO DETALLADO"),
        heading1("Sistema de Gestión Académica (SGA) — Versión 2.0"),
        spacer(120),
        labelValue("Documento", "Manual Oficial de Operación y Procedimientos para Usuarios Finales"),
        labelValue("Versión", "2.0 (Edición Completa Exhaustiva — Noviembre de 2026)"),
        labelValue("Dirigido a", "Coordinadores Académicos, Personal Docente, Estudiantes y Acudientes"),
        labelValue("Ámbito", "Institución Educativa — Gestión Académica y Alerta Temprana de Deserción"),
        divider(),

        // ── 1. Introducción ─────────────────────────────────────────────────
        heading2("1. Introducción al Sistema"),
        para("El Sistema de Gestión Académica (SGA) es una solución web de última generación concebida para integrar y simplificar todas las operaciones pedagógicas, administrativas y de convivencia de la institución. Su propósito primordial es ofrecer un entorno amigable, intuitivo y colaborativo que no requiere conocimientos técnicos previos, facilitando la toma de decisiones informada gracias a la incorporación de un modelo analítico de inteligencia artificial para la prevención de la deserción escolar."),
        
        para("A continuación se presenta la matriz general de responsabilidades y funcionalidades por rol dentro del sistema:"),
        makeTable(
          ["Funcionalidad / Módulo", "Coordinador", "Profesor", "Estudiante"],
          [
            ["Tablero de Estadísticas Generales (Dashboard)", "Total acceso", "Sin acceso", "Sin acceso"],
            ["Gestión Completa de Cursos (Crear/Editar/Eliminar)", "Total acceso", "Sin acceso", "Sin acceso"],
            ["Gestión de Estudiantes y Matrículas", "Total acceso", "Sin acceso", "Sin acceso"],
            ["Gestión de Docentes y Cuentas de Acceso", "Total acceso", "Sin acceso", "Sin acceso"],
            ["Programación y Asignación de Horarios", "Total acceso", "Sin acceso", "Sin acceso"],
            ["Seguimiento Académico Global Consolidado", "Total acceso", "Sin acceso", "Sin acceso"],
            ["Reporte Inteligente de Riesgo de Deserción (IA)", "Total acceso", "Cursos asignados", "Sin acceso"],
            ["Emisión Manual de Alertas por Correo al Acudiente", "Total acceso", "Cursos asignados", "Sin acceso"],
            ["Registro y Edición de Calificaciones (P1 y P2)", "Supervisión", "Total acceso", "Solo lectura personal"],
            ["Control Diario de Asistencia y Justificaciones", "Supervisión", "Total acceso", "Solo lectura personal"],
            ["Observador Disciplinario (Anotaciones Leves/Graves)", "Supervisión", "Total acceso", "Consulta según política"],
            ["Consulta de Horario Semanal y Profesores", "Total acceso", "Total acceso", "Solo lectura de su curso"]
          ],
          [40, 20, 20, 20]
        ),
        spacer(),
        para("Requisitos técnicos de acceso:"),
        bullet("Dispositivo compatible: Cualquier computador de escritorio, laptop, tableta o smartphone con acceso a Internet."),
        bullet("Navegadores recomendados: Google Chrome 90+, Mozilla Firefox 88+, Microsoft Edge 90+, Safari 14+."),
        bullet("No requiere instalación de software ni descargas de ejecutables; funciona 100% en la nube mediante navegador."),
        divider(),

        // ── 2. Acceso al Sistema ────────────────────────────────────────────
        heading2("2. Acceso al Sistema — Inicio y Cierre de Sesión"),
        para("El control de acceso protege la privacidad y confidencialidad de la información institucional mediante políticas RLS (Row Level Security) y autenticación segura."),
        
        heading3("2.1. Descripción de la Pantalla de Inicio de Sesión (/login)"),
        para("La interfaz de ingreso está organizada en dos paneles armónicos:"),
        bullet("Panel Izquierdo (Identidad Institucional): Ilustración y mensaje institucional de bienvenida con la marca del colegio."),
        bullet("Panel Derecho (Formulario de Ingreso): Campos claros para 'Correo electrónico', 'Contraseña' y el botón de acción 'Iniciar sesión'."),
        
        heading3("2.2. Procedimiento Paso a Paso para Iniciar Sesión"),
        bullet("Paso 1: Abra el navegador e ingrese a la dirección web institucional del SGA (ruta /login)."),
        bullet("Paso 2: En la casilla 'Correo electrónico', escriba su email registrado (ejemplo: coordinador@colegio.edu.co o profesor@colegio.edu.co)."),
        bullet("Paso 3: En la casilla 'Contraseña', digite su clave secreta. Los caracteres se ocultarán automáticamente como puntos por seguridad."),
        bullet("Paso 4: Haga clic sobre el botón azul 'Iniciar sesión'. El sistema validará su identidad en un lapso de 1 a 3 segundos."),
        bullet("Paso 5: El sistema detectará su perfil y lo redirigirá directamente a su módulo correspondiente (Dashboard para coordinador, Mis Estudiantes para docentes o Mi Información para alumnos)."),
        
        tipBox("Si digita erróneamente su contraseña, el sistema desplegará una alerta: 'Correo o contraseña incorrectos'. Verifique que no tenga activada la tecla Bloq Mayús. En caso de olvido definitivo, solicite al coordinador el restablecimiento de su contraseña."),
        
        heading3("2.3. Cierre de Sesión Seguro"),
        para("Para concluir sus labores de manera segura, especialmente en computadores de uso compartido o salas de cómputo:"),
        bullet("Paso 1: Localice en la parte inferior del menú lateral izquierdo su nombre de usuario."),
        bullet("Paso 2: Presione el botón 'Cerrar sesión'."),
        bullet("Paso 3: El sistema destruirá la sesión activa y lo enviará de vuelta a la pantalla de login, impidiendo que terceros visualicen o alteren datos."),
        divider(),

        // ── 3. Módulo Coordinador ───────────────────────────────────────────
        heading2("3. Módulo del Coordinador (Administración Institucional)"),
        para("El rol de Coordinador ostenta la máxima autoridad operativa dentro del SGA, con capacidad de estructurar y supervisar el año académico."),
        
        heading3("3.1. Panel de Inicio (Dashboard - /dashboard)"),
        para("Ofrece una visión ejecutiva inmediata mediante 4 tarjetas de indicadores en tiempo real:"),
        bullet("Total de Estudiantes: Número consolidado de alumnos matriculados en la institución."),
        bullet("Total de Cursos: Cantidad de salones y grupos creados y activos."),
        bullet("Total de Profesores: Docentes vinculados con usuario en el sistema."),
        bullet("Estudiantes en Riesgo: Conteo de alumnos que presentan al menos un factor crítico de deserción según el modelo de IA."),
        para("Debajo de los indicadores, se visualiza la grilla de cursos con sus respectivas jornadas y accesos directos."),

        heading3("3.2. Gestión de Cursos (/dashboard/cursos)"),
        para("Permite organizar los salones de clase. Cada curso agrupa estudiantes y posee un horario propio:"),
        bullet("Crear Curso: Presione '+ Nuevo curso'. Digite el Nombre (ej. '10-A', 'Sexto B') y seleccione la Jornada ('Mañana', 'Tarde', 'Noche' o 'Única'). Presione 'Guardar'."),
        bullet("Validaciones de Curso: El nombre no puede quedar vacío (máx. 50 caracteres). No se permiten nombres duplicados en la misma jornada."),
        bullet("Modificar Curso: Pulse el ícono de lápiz en la fila del curso para renombrarlo o cambiar de jornada."),
        bullet("Eliminar Curso: Pulse la papelera. El sistema solicitará confirmación previa."),
        alertBox("Antes de eliminar un curso, verifique que no tenga alumnos asignados, ya que quedarían sin salón."),

        heading3("3.3. Gestión de Estudiantes y Matrículas (/dashboard/estudiantes)"),
        para("Administra las hojas de vida estudiantiles y variables que alimentan el modelo de IA:"),
        bullet("Matricular Nuevo Alumno: Presione '+ Nuevo estudiante'. Complete los campos requeridos:"),
        bullet("   • Nombre Completo: Nombre y apellidos del estudiante (obligatorio, 2 a 100 caracteres).", 1),
        bullet("   • Curso: Salón al que se adscribe (obligatorio, seleccionado de la lista).", 1),
        bullet("   • Nombre del Acudiente: Familiar o tutor responsable para citaciones (obligatorio).", 1),
        bullet("   • Teléfono del Acudiente: Línea de contacto directo a 10 dígitos (ej. 3001234567).", 1),
        bullet("   • Estrato Socioeconómico: Número entero del 1 al 6 (campo estricto de validación).", 1),
        bullet("   • Año Escolar Repetido: 'Sí' o 'No' (factor histórico para el cálculo de riesgo).", 1),
        bullet("   • Materias Asignadas: Selección de asignaturas inscritas según el horario del curso.", 1),
        bullet("Búsqueda y Filtros: Dispone de un buscador en tiempo real por nombre y filtro por curso específico."),

        heading3("3.4. Gestión de Docentes (/dashboard/profesores)"),
        para("Permite habilitar a los miembros del cuerpo profesoral:"),
        bullet("Registrar Docente: Presione '+ Nuevo profesor'. Digite Nombre completo, Correo institucional (utilizado como usuario de login) y Teléfono de contacto."),
        bullet("Asignación Académica: Tras registrar al profesor, asígnele sus materias en la sección de Horarios para que pueda ver sus salones."),

        heading3("3.5. Programación de Horarios de Clase (/dashboard/horario)"),
        para("Configura la grilla semanal de asignaturas de Lunes a Viernes:"),
        bullet("1. Elija el Curso en el selector superior."),
        bullet("2. En la columna del día deseado, presione '+ Agregar bloque'."),
        bullet("3. Especifique Hora Inicio y Hora Fin (formato 24h, ej. 07:00 a 08:30)."),
        bullet("4. Indique la Materia y el Profesor titular."),
        bullet("5. Casilla 'Es descanso': Márquela para recreos o recesos; no solicitará docente."),

        heading3("3.6. Seguimiento Académico Global (/dashboard/seguimiento)"),
        para("Consolidado analítico en formato de matriz que resume el estado de todos los alumnos de la institución:"),
        makeTable(
          ["Columna", "Contenido", "Criterio de Alerta / Interpretación"],
          [
            ["Estudiante / Curso", "Nombre y salón asignado", "Permite identificar al estudiante de forma unívoca."],
            ["Prom. P1 / Prom. P2", "Promedio numérico (1.0 a 5.0)", "Rojo si es menor a 3.0. Guion (—) si no hay notas ingresadas."],
            ["Faltas Totales", "Suma acumulada de ausencias", "Alerta si supera 5 faltas no justificadas en el periodo."],
            ["Máx. Consecutivas", "Racha más larga de ausencias seguidas", "Indicador de máxima criticidad si supera 3 días consecutivos."],
            ["Retardos", "Total de llegadas tarde", "Mide puntualidad y compromiso escolar."],
            ["Anotaciones (G / L)", "G: Graves | L: Leves", "Alerta inmediata si G >= 1 o si L >= 3 en el periodo."]
          ],
          [25, 35, 40]
        ),

        heading3("3.7. Reporte Inteligente de Riesgo de Deserción (/dashboard/reporte-estudiante)"),
        para("El SGA evalúa 12 variables académicas y de entorno mediante un modelo de IA para calcular la probabilidad porcentual (0% a 100%) de que un alumno deserte:"),
        bullet("🔴 Nivel ALTO (66% a 100%): Requiere intervención urgente y contacto inmediato con la familia."),
        bullet("🟡 Nivel MEDIO (31% a 65%): Alumno con bajo rendimiento o ausencias periódicas; requiere tutoría."),
        bullet("🔵 Nivel INFORMATIVO / BAJO (0% a 30%): Alumno en trayectoria regular y saludable."),
        para("Factores analizados: Promedios de P1 y P2 (<3.0), inasistencias acumuladas (>5), racha de faltas consecutivas (>3), anotaciones disciplinarias graves o leves, condición de año repetido y estrato socioeconómico."),
        para("Emisión de Alertas Preventivas por Correo:"),
        bullet("1. En la tarjeta del estudiante en riesgo, haga clic en '📧 Enviar alerta al acudiente'."),
        bullet("2. Confirme la acción. El sistema generará y despachará un correo electrónico formal con el resumen de factores de riesgo y recomendaciones."),
        tipBox("Control Anti-Saturación: El sistema utiliza un mecanismo de deduplicación semanal SHA-256. Si se actualizan datos del alumno en la misma semana, el sistema actualiza el registro existente en lugar de enviar correos duplicados al acudiente."),
        divider(),

        // ── 4. Módulo Profesor ──────────────────────────────────────────────
        heading2("4. Módulo del Docente ('Mis Estudiantes')"),
        para("El módulo docente (/dashboard/profesor) está optimizado para agilizar el trabajo diario del profesor en el aula."),
        
        heading3("4.1. Selección de Curso y Despliegue de Lista"),
        para("El profesor visualiza únicamente los cursos donde tiene asignación horaria. Al seleccionar el curso y la materia, la lista de alumnos se carga automáticamente con sus datos actualizados."),

        heading3("4.2. Registro y Actualización de Calificaciones"),
        para("El sistema maneja dos periodos académicos formales (P1 y P2):"),
        bullet("Escala numérica oficial: De 1.0 (mínima) a 5.0 (máxima)."),
        bullet("Formato decimal: Use punto decimal (ejemplo: 3.8, 4.5, 2.0)."),
        bullet("Criterio de aprobación: Calificaciones iguales o superiores a 3.0 representan desempeño aprobado; menores a 3.0 se destacan como reprobadas."),
        bullet("Guardado: Ingrese la nota y presione 'Guardar'. Los promedios del curso y de riesgo se actualizarán de inmediato."),

        heading3("4.3. Control Diario de Asistencia"),
        para("La toma de asistencia diaria es vital para la alimentación del semáforo preventivo. Cada alumno debe clasificarse en uno de los 4 estados:"),
        makeTable(
          ["Estado", "Significado Operativo", "Impacto en el Modelo de Riesgo"],
          [
            ["Asistió", "Presente en la totalidad de la jornada de clase.", "Impacto positivo; incrementa porcentaje de permanencia."],
            ["Faltó", "Ausente sin comunicación ni justificación formal.", "Incrementa faltas acumuladas y racha consecutiva de riesgo."],
            ["Justificación", "Ausente con soporte médico o calamidad validada.", "No penaliza el perfil de riesgo; se contabiliza como novedad formal."],
            ["Retardo", "Ingreso al salón con posterioridad al inicio de clase.", "Se acumula en el contador de puntualidad; no computa como falta."]
          ],
          [20, 45, 35]
        ),
        tipBox("Si un alumno inicialmente clasificado como 'Faltó' entrega su excusa médica al día siguiente, el profesor puede ingresar a la fecha y cambiar el estado a 'Justificación' para no perjudicar su historial."),

        heading3("4.4. Observador Disciplinario (+ Anotación)"),
        para("Permite consignar eventos de convivencia y acuerdos formativos:"),
        bullet("1. En la fila del alumno, presione el botón '+ Anotación'."),
        bullet("2. Seleccione el Tipo: 'Leve' (porte inadecuado de uniforme, distracciones reiteradas) o 'Grave' (agresiones físicas/verbales, deshonestidad en evaluaciones, daños a la planta física)."),
        bullet("3. Redacte la Descripción de los hechos de manera objetiva, indicando fecha y contexto."),
        bullet("4. Consigne el Compromiso pedagógico acordado con el alumno."),
        bullet("5. Presione 'Guardar anotación'. Quedará firmada digitalmente con la fecha y nombre del docente."),

        heading3("4.5. Emisión de Alertas desde el Perfil Docente"),
        para("Los profesores tienen la facultad de alertar sobre sus alumnos en riesgo directamente desde la opción 'Reporte de estudiante'."),
        alertBox("Restricción de seguridad: Un docente únicamente puede consultar y emitir alertas para estudiantes matriculados en los cursos que él atiende; cualquier intento de acceso a otros grupos será denegado por el sistema."),
        divider(),

        // ── 5. Módulo Estudiante ────────────────────────────────────────────
        heading2("5. Módulo del Estudiante y Familias ('Mi Información')"),
        para("Ubicado en /dashboard/estudiante, este portal garantiza la transparencia institucional permitiendo a los alumnos y acudientes consultar el progreso académico en cualquier momento."),
        
        heading3("5.1. Naturaleza de Solo Lectura"),
        para("El portal estudiantil es estrictamente de consulta. No permite alterar calificaciones ni registros de asistencia. Ante cualquier discrepancia, el acudiente debe dirigirse al docente de la materia o a coordinación."),

        heading3("5.2. Componentes del Portal Estudiantil"),
        bullet("Ficha del Estudiante: Nombre, curso, acudiente y teléfono registrado."),
        bullet("Tarjetas de Métricas: Promedio P1, Promedio P2, Total de faltas acumuladas, Máxima racha de ausencias seguidas y Número de retardos."),
        bullet("Boletín de Asignaturas: Tabla con el listado de materias, profesor titular y las calificaciones de P1 y P2. Las materias pendientes muestran un guion (—)."),
        bullet("Historial de Asistencia: Cronograma de todas las fechas con su respectivo estado (Asistió, Faltó, Justificación, Retardo) y comentarios docentes."),
        bullet("Horario Semanal de Clases: Horas exactas, materias y salones de Lunes a Viernes."),
        divider(),

        // ── 6. Preguntas Frecuentes (FAQ) ───────────────────────────────────
        heading2("6. Preguntas Frecuentes (FAQ)"),
        
        heading3("Generales y de Acceso"),
        para("P: ¿El sistema funciona en teléfonos móviles?", { indent: true }),
        para("R: Sí, la plataforma está diseñada con interfaz responsiva y se ajusta a computadores, tabletas y teléfonos inteligentes con navegador web.", { indent: true }),
        spacer(),
        para("P: ¿Qué debo hacer si olvido mi contraseña de acceso?", { indent: true }),
        para("R: Por razones de seguridad institucional, contacte a la coordinación académica de su sede para que genere una nueva contraseña en la consola.", { indent: true }),
        spacer(),

        heading3("Para Coordinadores"),
        para("P: ¿Por qué un estudiante aparece con 85% de riesgo en el reporte?", { indent: true }),
        para("R: El modelo de IA detectó una combinación crítica de factores (por ejemplo, promedio menor a 3.0 sumado a más de 4 faltas seguidas). Requiere citación prioritaria.", { indent: true }),
        spacer(),
        para("P: ¿Puedo deshacer la eliminación de un curso o alumno?", { indent: true }),
        para("R: No. La eliminación es permanente para preservar la integridad de la base de datos. Se recomienda verificar dos veces antes de confirmar.", { indent: true }),
        spacer(),

        heading3("Para Docentes"),
        para("P: ¿Por qué no visualizo a un estudiante recién ingresado?", { indent: true }),
        para("R: El coordinador debe asegurarse de haber vinculado al estudiante en el curso respectivo y haber asignado los bloques de clase en el horario.", { indent: true }),
        spacer(),
        para("P: ¿Puedo modificar una nota guardada anteriormente?", { indent: true }),
        para("R: Sí. Mientras el periodo académico esté abierto, el docente puede hacer clic en la casilla de nota, modificar el valor y presionar 'Guardar'.", { indent: true }),
        divider(),

        // ── 7. Solución de Problemas ────────────────────────────────────────
        heading2("7. Solución de Problemas Comunes"),
        makeTable(
          ["Incidencia Detectada", "Causa Probable", "Acción de Solución Recomendada"],
          [
            ["Mensaje 'Error 403: Acceso no autorizado'", "Intento de acceder a un módulo que no corresponde a su rol.", "Regrese al menú lateral y utilice únicamente los enlaces habilitados para su usuario."],
            ["Al presionar 'Guardar' no sucede nada", "Campos obligatorios vacíos o estrato fuera del rango 1-6.", "Revise los campos marcados en rojo en el formulario y verifique que el estrato sea un número entre 1 y 6."],
            ["La tabla no muestra los datos recién guardados", "Caché temporal del navegador.", "Presione la tecla F5 o el botón de recargar del navegador para refrescar la vista."],
            ["El acudiente no recibe el correo de alerta", "Bandeja de correo no deseado (Spam) o email mal escrito.", "Pida al acudiente revisar la carpeta de Spam. Verifique en la ficha del estudiante que el correo esté bien escrito."],
            ["El sistema lo regresa al Login inmediatamente", "Cookies de sesión bloqueadas o sesión caducada.", "Limpie el historial/cookies del navegador o intente ingresar desde una ventana de navegación en incógnito."]
          ],
          [25, 35, 40]
        ),
        divider(),

        // ── 8. Glosario ─────────────────────────────────────────────────────
        heading2("8. Glosario de Términos Institucionales"),
        makeTable(
          ["Término", "Definición Conceptual en el SGA"],
          [
            ["SGA", "Sistema de Gestión Académica: plataforma central de administración escolar."],
            ["Deserción Escolar", "Abandono prematuro del sistema educativo por parte del estudiante antes de culminar sus estudios."],
            ["Modelo Predictivo IA", "Algoritmo estadístico entrenado que estima la probabilidad de pérdida de año o abandono."],
            ["Máx. Consecutivas", "Mayor cantidad ininterrumpida de días en los que el estudiante estuvo ausente sin causa justificada."],
            ["Estrato Socioeconómico", "Clasificación de 1 a 6 que mide las condiciones socioeconómicas del hogar para focalizar apoyos."],
            ["Inasistencia Justificada", "Ausencia respaldada oportunamente con excusa médica o soporte de fuerza mayor."],
            ["Anotación Grave", "Registro formal de falta grave contra el manual de convivencia con citación al acudiente."],
            ["RLS (Row Level Security)", "Mecanismo criptográfico de base de datos que garantiza aislamiento absoluto de datos entre usuarios."]
          ],
          [30, 70]
        ),
        divider(),

        // ── 9. Canales de Soporte ───────────────────────────────────────────
        heading2("9. Canales de Contacto y Soporte Técnico"),
        para("En caso de incidencias de conectividad o soporte técnico avanzado, suministre los siguientes datos al equipo de tecnología del colegio:"),
        bullet("1. Nombre completo y correo electrónico del usuario afectado."),
        bullet("2. Rol asignado (Coordinador, Profesor o Estudiante)."),
        bullet("3. Módulo o URL exacta donde se presenta la dificultad (ej. /dashboard/estudiantes)."),
        bullet("4. Descripción cronológica del procedimiento realizado y captura de pantalla legible del mensaje de error."),
        spacer(),
        tipBox("Para emergencias académicas durante cierres de periodo, comuníquese con la Secretaría Académica de la institución.", "📞 Mesa de Ayuda Institucional: "),
        divider(),

        new Paragraph({
          spacing: { before: 240, after: 100 },
          alignment: AlignmentType.CENTER,
          children: [
            bold("Documento Oficial — Sistema de Gestión Académica (SGA)", COLOR.TITLE_BG, 20),
          ],
        }),
        new Paragraph({
          alignment: AlignmentType.CENTER,
          children: [
            italic("Copia autorizada para uso institucional exclusivo. Versión 2.0 exhaustiva.", "64748B", 18),
          ],
        }),
      ],
    },
  ],
});

// ── Guardar archivo ───────────────────────────────────────────────────────────
const buffer = await Packer.toBuffer(doc);
writeFileSync(OUTPUT, buffer);
console.log(`✅ Manual Word exhaustivo generado exitosamente en: ${OUTPUT}`);
