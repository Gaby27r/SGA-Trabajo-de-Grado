/**
 * generate-docx.mjs
 * Genera PLAN_DE_PRUEBAS_RESULTADOS.docx en la raíz del worktree qa_test_results
 * Ejecutar: node scripts/generate-docx.mjs
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
const OUTPUT = path.resolve(__dirname, "..", "PLAN_DE_PRUEBAS_RESULTADOS.docx");

// ── Paleta de colores ─────────────────────────────────────────────────────────
const COLOR = {
  TITULO_BG: "1A3A5C",   // azul oscuro
  TITULO_FG: "FFFFFF",
  H2_BG: "2E6DA4",
  H2_FG: "FFFFFF",
  H3_BG: "D9E8F7",
  H3_FG: "1A3A5C",
  HEADER_BG: "4472C4",
  HEADER_FG: "FFFFFF",
  PASS_BG: "C6EFCE",
  PASS_FG: "276221",
  FAIL_BG: "FFC7CE",
  FAIL_FG: "9C0006",
  ROW_ALT: "EBF3FB",
  ROW_STD: "FFFFFF",
  BORDER: "B8CCE4",
};

// ── Helpers ───────────────────────────────────────────────────────────────────
const bold = (text, color = "000000", size = 20) =>
  new TextRun({ text, bold: true, color, size });

const normal = (text, color = "000000", size = 20) =>
  new TextRun({ text, color, size });

const italic = (text, color = "555555", size = 18) =>
  new TextRun({ text, italics: true, color, size });

function heading1(text) {
  return new Paragraph({
    heading: HeadingLevel.HEADING_1,
    spacing: { before: 300, after: 150 },
    shading: { type: ShadingType.SOLID, color: COLOR.TITULO_BG, fill: COLOR.TITULO_BG },
    children: [bold(text, COLOR.TITULO_FG, 32)],
  });
}

function heading2(text) {
  return new Paragraph({
    heading: HeadingLevel.HEADING_2,
    spacing: { before: 280, after: 120 },
    shading: { type: ShadingType.SOLID, color: COLOR.H2_BG, fill: COLOR.H2_BG },
    children: [bold(text, COLOR.H2_FG, 26)],
  });
}

function heading3(text) {
  return new Paragraph({
    heading: HeadingLevel.HEADING_3,
    spacing: { before: 200, after: 80 },
    shading: { type: ShadingType.SOLID, color: COLOR.H3_BG, fill: COLOR.H3_BG },
    children: [bold(text, COLOR.H3_FG, 22)],
  });
}

function para(text, { indent = false, spaceAfter = 100 } = {}) {
  return new Paragraph({
    spacing: { after: spaceAfter },
    indent: indent ? { left: 400 } : undefined,
    children: [normal(text)],
  });
}

function bullet(text) {
  return new Paragraph({
    bullet: { level: 0 },
    spacing: { after: 60 },
    children: [normal(text)],
  });
}

function subbullet(text) {
  return new Paragraph({
    bullet: { level: 1 },
    spacing: { after: 50 },
    children: [normal(text)],
  });
}

function labelValue(label, value) {
  return new Paragraph({
    spacing: { after: 80 },
    children: [bold(label + ": "), normal(value)],
  });
}

function spacer() {
  return new Paragraph({ spacing: { after: 60 }, children: [] });
}

function divider() {
  return new Paragraph({
    spacing: { before: 100, after: 100 },
    border: { bottom: { color: COLOR.H2_BG, size: 6, style: BorderStyle.SINGLE } },
    children: [],
  });
}

// ── Helpers de tabla ──────────────────────────────────────────────────────────
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
        children: [bold(text, COLOR.HEADER_FG, 18)],
      }),
    ],
  });
}

function dataCell(text, { alt = false, estado = null, pct = 20 } = {}) {
  let bgColor = alt ? COLOR.ROW_ALT : COLOR.ROW_STD;
  let fgColor = "000000";
  if (estado === "PASÓ") { bgColor = COLOR.PASS_BG; fgColor = COLOR.PASS_FG; }
  if (estado === "NO PASÓ") { bgColor = COLOR.FAIL_BG; fgColor = COLOR.FAIL_FG; }

  const run = estado
    ? bold(text, fgColor, 18)
    : normal(text, "000000", 18);

  return new TableCell({
    width: { size: pct, type: WidthType.PERCENTAGE },
    shading: { type: ShadingType.SOLID, color: bgColor, fill: bgColor },
    borders: cellBorder,
    verticalAlign: VerticalAlign.CENTER,
    children: [new Paragraph({ children: [run] })],
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
          children: row.map((cell, ci) => {
            const isEstado = headers[ci] === "Estado";
            const estado = isEstado ? (cell.includes("PASÓ") && !cell.includes("NO") ? "PASÓ" : "NO PASÓ") : null;
            return dataCell(cell, { alt: ri % 2 === 1, estado, pct: widths[ci] });
          }),
        })
      ),
    ],
  });
}

// ── Tablas de datos actualizadas (37/37 PASARON) ──────────────────────────────
const unitTests = [
  ["UT-01", "Cálculo de riesgo", "Datos académicos válidos.", "Indicadores dentro del rango [0, 1].", "PASÓ"],
  ["UT-02", "Datos incompletos", "Faltan calificaciones o asistencias.", "No genera NaN ni interrumpe el proceso.", "PASÓ"],
  ["UT-03", "Límites", "Probabilidades 0, 1 y fuera del rango.", "Valores acotados estrictamente a [0, 100].", "PASÓ"],
  ["UT-04", "Formato", "Probabilidad entre 0 y 1.", "Porcentaje correcto con un decimal y '%'.", "PASÓ"],
  ["UT-05", "Clasificación", "Valores antes, en y después de cada umbral.", "Categoría correcta (Bajo, Medio, Alto).", "PASÓ"],
  ["UT-06", "Validaciones", "Identificador ausente o en blanco.", "Error controlado (400) sin consultas.", "PASÓ"],
  ["UT-07", "Error del modelo", "Simulación de fallo en predicción.", "Try/catch controlado con fallback.", "PASÓ"],
  ["UT-08", "Construcción de factores", "Estudiante y factores válidos.", "Alerta estructurada sin mezcla de datos.", "PASÓ"],
];

const apiTests = [
  ["API-01", "Sin sesión", "Invocar POST sin autenticación.", "401 Unauthorized sin acceso.", "PASÓ"],
  ["API-02", "Rol no autorizado", "Invocar con rol estudiante.", "403 Forbidden sin ejecución.", "PASÓ"],
  ["API-03", "Rol autorizado", "Invocar con rol coordinador.", "200 OK y confirmación de envío.", "PASÓ"],
  ["API-04", "Curso asignado", "Profesor alerta a su estudiante.", "Envío autorizado (200 OK).", "PASÓ"],
  ["API-05", "Curso ajeno", "Profesor alerta estudiante ajeno.", "403 Forbidden sin filtración.", "PASÓ"],
  ["API-06", "Parámetros inválidos", "Cuerpo vacío o sin estudianteId.", "400 Bad Request controlado.", "PASÓ"],
  ["API-07", "Error Supabase", "Simular caída de base de datos.", "500 controlado sin falsos éxitos.", "PASÓ"],
  ["API-08", "Historial de alertas", "Solicitud GET a la ruta.", "200 OK con registros y filtros.", "PASÓ"],
  ["API-09", "SMTP fallido", "Simular fallo de conexión Gmail.", "500 sin marcar envío falso en BD.", "PASÓ"],
  ["API-10", "SMTP exitoso", "Simular envío exitoso.", "Inserta registro con huella SHA-256.", "PASÓ"],
  ["API-11", "Duplicados", "Reintento en misma semana.", "Reemplaza registro semanal previo.", "PASÓ"],
  ["API-12", "Método incorrecto", "Solicitar PUT, DELETE o PATCH.", "405 Method Not Allowed.", "PASÓ"],
];

const supTests = [
  ["SUP-01", "Lectura", "Consultar catálogo de cursos.", "Consulta exitosa retornando datos.", "PASÓ"],
  ["SUP-02", "Inserción", "Insertar curso de prueba con rollback.", "Inserción confirmada y eliminada.", "PASÓ"],
  ["SUP-03", "Restricciones", "Insertar estudiante estrato 9 (rango 1-6).", "PostgreSQL Check Constraint rechaza.", "PASÓ"],
  ["SUP-04", "RLS y roles", "Consultar perfiles con anonKey.", "RLS bloquea lectura indebida ([]).", "PASÓ"],
  ["SUP-05", "Relaciones", "Consultar vista_resumen_asistencia.", "Datos consolidados y agregados.", "PASÓ"],
  ["SUP-06", "Fallo de conexión", "Conectar a subdominio inexistente.", "Error de red capturado sin crasheo.", "PASÓ"],
];

const e2eTests = [
  ["E2E-01", "Inicio de sesión", "Login con coordinador@colegio.edu.co.", "Autenticación y redirección a /dashboard.", "PASÓ"],
  ["E2E-02", "Credenciales inválidas", "Login con clave incorrecta.", "Mensaje controlado; permanece en /login.", "PASÓ"],
  ["E2E-03", "Navegación por rol", "Acceso a /dashboard sin sesión.", "Middleware redirige a /login.", "PASÓ"],
  ["E2E-04", "Operación académica", "Acceso a /dashboard/cursos sin sesión.", "Ruta protegida redirige a /login.", "PASÓ"],
  ["E2E-05", "Consulta de riesgo", "Acceso a reporte-estudiantes sin sesión.", "Ruta protegida redirige a /login.", "PASÓ"],
  ["E2E-06", "Alerta manual", "Acceso a /dashboard/seguimiento sin sesión.", "Ruta protegida redirige a /login.", "PASÓ"],
  ["E2E-07", "Ruta restringida", "URL de pantalla interna sin sesión.", "Redirección inmediata a /login.", "PASÓ"],
];

const perfTests = [
  ["PERF-01", "1 VU / 20 req.", "Media: 20.66 ms | p95: 293.72 ms | Errores: 0%", "p95 < 2,000 ms y 0% errores", "PASÓ"],
  ["PERF-02", "5 VUs / 50 req.", "Media: 15.96 ms | p95: 22.28 ms | Errores: 0%", "p95 < 2,000 ms y errores < 1%", "PASÓ"],
  ["PERF-03", "Rampa 1-10 VUs / 25 req.", "Media: 18.73 ms | p95: 27.36 ms | Errores: 0%", "Sin degradación; p95 < 2,000 ms", "PASÓ"],
  ["PERF-04", "Solo lectura / 15 req.", "Media: 4.09 ms | p95: 5.64 ms | Errores: 0%", "Consistencia y p95 < 2,000 ms", "PASÓ"],
];

// ── Bloque de explicación de resultado ───────────────────────────────────────
function explanationSection() {
  return [
    heading2("15. Explicación de resultado"),
    para("Esta sección detalla los resultados obtenidos y los ajustes aplicados para garantizar el cumplimiento de cada prueba:"),

    // A - Unitarias
    heading3("A. Casos de Pruebas Unitarias"),
    para("UT-01 (Cálculo de riesgo): PASÓ."),
    new Paragraph({ spacing: { after: 80 }, indent: { left: 300 }, children: [italic("Resultado: El algoritmo calcula el riesgo de deserción en escala normalizada entre 0 y 1 a partir de las 12 variables académicas.")] }),

    para("UT-02 (Datos incompletos): PASÓ."),
    new Paragraph({ spacing: { after: 80 }, indent: { left: 300 }, children: [italic("Resultado: Con variables nulas en asistencias o notas, el algoritmo calcula el riesgo con las variables disponibles sin emitir excepciones NaN.")] }),

    new Paragraph({ spacing: { after: 20 }, children: [bold("UT-03 (Límites): PASÓ (Corregido).", COLOR.PASS_FG, 20)] }),
    new Paragraph({ spacing: { after: 60 }, indent: { left: 300 }, children: [italic("Resultado inicial: Fallaba porque porcentajeDesdeModelo multiplicaba ciegamente por 100 sin limitar el rango.")] }),
    new Paragraph({ spacing: { after: 80 }, indent: { left: 300 }, children: [
      bold("Ajuste aplicado: ", "276221", 18),
      normal("Se implementó Math.min(100, Math.max(0, valor * 100)) en helpers.ts. Valores anómalos (<0 o >1) se acotan estrictamente entre 0% y 100%.", "000000", 18),
    ] }),

    para("UT-04 (Formato): PASÓ."),
    new Paragraph({ spacing: { after: 80 }, indent: { left: 300 }, children: [italic("Resultado: Las probabilidades se formatean con un decimal y sufijo ' %' (ej. 0.456 → '45.6 %'), y valores null devuelven 'No disponible'.")] }),

    para("UT-05 (Clasificación): PASÓ."),
    new Paragraph({ spacing: { after: 80 }, indent: { left: 300 }, children: [italic("Resultado: La función categoriza con exactitud los niveles Bajo, Medio y Alto evaluando notas y faltas consecutivas.")] }),

    para("UT-06 (Validaciones de identificador): PASÓ."),
    new Paragraph({ spacing: { after: 80 }, indent: { left: 300 }, children: [italic("Resultado: Se rechazan IDs vacíos o nulos en las peticiones con código 400 antes de consultar la base de datos.")] }),

    para("UT-07 (Error del modelo): PASÓ."),
    new Paragraph({ spacing: { after: 80 }, indent: { left: 300 }, children: [italic("Resultado: Al presentarse un fallo o excepción en el modelo predictivo, el bloque try/catch rescata el flujo asignando 'No disponible' sin interrumpir el envío.")] }),

    para("UT-08 (Construcción de factores): PASÓ."),
    new Paragraph({ spacing: { after: 80 }, indent: { left: 300 }, children: [italic("Resultado: La función crearFactores extrae exclusivamente los factores del estudiante indicado sin mezclar datos entre estudiantes.")] }),

    spacer(),

    // B - API
    heading3("B. Pruebas de Integración de API y Autorización"),
    para("API-01 a API-07: PASARON."),
    new Paragraph({ spacing: { after: 80 }, indent: { left: 300 }, children: [italic("Resultado: Cobertura total de autenticación (401), autorización por rol (403), validación de parámetros (400) y manejo de errores de BD (500).")] }),

    new Paragraph({ spacing: { after: 20 }, children: [bold("API-08 (Historial de alertas con GET): PASÓ (Implementado).", COLOR.PASS_FG, 20)] }),
    new Paragraph({ spacing: { after: 60 }, indent: { left: 300 }, children: [italic("Resultado inicial: La ruta solo implementaba POST, rechazando consultas de historial.")] }),
    new Paragraph({ spacing: { after: 80 }, indent: { left: 300 }, children: [
      bold("Ajuste aplicado: ", "276221", 18),
      normal("Se implementó el manejador GET en route.ts que valida permisos de coordinador/profesor, consulta alertas_riesgo_email en orden descendente y soporta filtros por estudianteId y límite de paginación.", "000000", 18),
    ] }),

    para("API-09 a API-12: PASARON."),
    new Paragraph({ spacing: { after: 80 }, indent: { left: 300 }, children: [italic("Resultado: Manejo controlado ante caídas de servidor SMTP, generación de huellas SHA-256 para auditoría, eliminación de duplicados en la semana y rechazo de verbos HTTP no soportados (405).")] }),

    spacer(),

    // C - Supabase
    heading3("C. Pruebas de Integración con Supabase"),
    new Paragraph({ spacing: { after: 20 }, children: [bold("SUP-01 a SUP-06: PASARON (100%).", COLOR.PASS_FG, 20)] }),
    new Paragraph({ spacing: { after: 60 }, indent: { left: 300 }, children: [italic("Resultado inicial: Fallaban por rechazo 'Invalid API key' al no cargarse las variables en el proceso de Vitest.")] }),
    new Paragraph({ spacing: { after: 80 }, indent: { left: 300 }, children: [
      bold("Ajuste aplicado: ", "276221", 18),
      normal("Se creó tests/setup.ts cargando .env.local con las claves válidas provistas. Con esto, SUP-01 (lectura de cursos), SUP-02 (inserción y rollback), SUP-03 (restricción Check Constraint de estrato 1-6), SUP-04 (seguridad RLS), SUP-05 (vistas SQL) y SUP-06 (manejo de caída de red) pasaron al 100%.", "000000", 18),
    ] }),

    spacer(),

    // D - E2E
    heading3("D. Pruebas E2E con Playwright"),
    new Paragraph({ spacing: { after: 20 }, children: [bold("E2E-01 a E2E-07: PASARON (100%).", COLOR.PASS_FG, 20)] }),
    new Paragraph({ spacing: { after: 60 }, indent: { left: 300 }, children: [italic("Resultado inicial: El middleware fallaba por credenciales no inicializadas y el usuario de prueba no tenía sincronizada su contraseña.")] }),
    new Paragraph({ spacing: { after: 80 }, indent: { left: 300 }, children: [
      bold("Ajuste aplicado: ", "276221", 18),
      normal("Se sincronizó la contraseña del coordinador en Supabase Auth y se configuró el servidor dev con webpack. Todas las pruebas de login válido, login inválido, navegación protegida y redirecciones a /login pasaron exitosamente.", "000000", 18),
    ] }),

    spacer(),

    // E - Rendimiento
    heading3("E. Pruebas de Rendimiento"),
    new Paragraph({ spacing: { after: 20 }, children: [bold("PERF-01 a PERF-04: PASARON (100%).", COLOR.PASS_FG, 20)] }),
    new Paragraph({ spacing: { after: 60 }, indent: { left: 300 }, children: [italic("Resultado inicial: En modo dev, la compilación JIT elevaba el p95 a >3,000 ms.")] }),
    new Paragraph({ spacing: { after: 80 }, indent: { left: 300 }, children: [
      bold("Ajuste aplicado: ", "276221", 18),
      normal("Se generó la compilación optimizada de producción (next build --webpack) y se ejecutó la suite de carga contra el servidor productivo. PERF-01 (p95: 293.72 ms), PERF-02 (p95: 22.28 ms), PERF-03 (p95: 27.36 ms) y PERF-04 (p95: 5.64 ms) cumplieron con creces el criterio propuesto (p95 < 2,000 ms) y registraron 0% de errores.", "000000", 18),
    ] }),
  ];
}

// ── Construcción del documento ────────────────────────────────────────────────
const doc = new Document({
  styles: {
    paragraphStyles: [
      {
        id: "Normal",
        name: "Normal",
        run: { font: "Calibri", size: 20 },
      },
    ],
  },
  sections: [
    {
      children: [
        // ── Encabezado ──────────────────────────────────────────────────────
        heading1("PLAN DE PRUEBAS DE SOFTWARE"),
        heading1("Sistema de Gestión Académica (SGA)"),
        spacer(),
        labelValue("Rama de ejecución", "Qa"),
        labelValue("Entorno", "Node.js v22.14.0 · Next.js 16.4.3 · Vitest 5.1.0 · Playwright 1.65.0"),
        labelValue("Fecha de consolidación", "12 de Noviembre de 2026"),
        divider(),

        // ── 1. Propósito ────────────────────────────────────────────────────
        heading2("1. Propósito"),
        para("Definir y documentar los resultados finales de las pruebas técnicas y funcionales implementadas y ejecutadas sobre el Sistema de Gestión Académica (SGA), tras la resolución de defectos de código, integración de rutas, ajuste de credenciales de Supabase en el entorno local y medición de rendimiento en modo optimizado de producción."),
        divider(),

        // ── 2. Contexto ─────────────────────────────────────────────────────
        heading2("2. Contexto y alcance"),
        makeTable(
          ["Aspecto", "Condición considerada"],
          [
            ["Aplicación", "Desarrollada con Next.js (versión 16.4.3) con App Router y arquitectura server/client."],
            ["Ejecución", "Suite automatizada ejecutada en la rama Qa con Vitest, Playwright y runner de rendimiento."],
            ["Persistencia", "Supabase en la nube (https://hcwjnjvxzonuwyuvcwyp.supabase.co) con base de datos PostgreSQL y Auth."],
            ["Perfiles", "Tres roles validados: coordinador, profesor y estudiante."],
            ["Módulos evaluados", "Control de acceso, gestión académica, cálculo de riesgo de deserción y emisión de alertas de seguimiento."],
            ["Seguridad de datos", "Pruebas de integración con rollback inmediato y sin operaciones destructivas en Supabase."],
          ],
          [30, 70]
        ),
        divider(),

        // ── 3. Estrategia ───────────────────────────────────────────────────
        heading2("3. Estrategia de pruebas"),
        makeTable(
          ["Nivel", "Herramienta", "Qué verifica", "Aislamiento"],
          [
            ["Unitarias", "Vitest", "Algoritmos de riesgo, control de límites, umbrales y consistencia.", "Lógica pura aislada sin red."],
            ["Integración API", "Vitest + Mocks", "Métodos HTTP, validaciones, códigos de estado, RLS y permisos.", "Mocks controlados de sesión y servicios."],
            ["Integración Supabase", "Vitest + Supabase SDK", "Lectura/escritura real, check constraints, RLS y vistas SQL.", "Conexión a base de datos de desarrollo."],
            ["E2E", "Playwright (Chromium)", "Flujos reales de usuario: login, protección de rutas y formularios.", "Servidor Next.js local contra Supabase."],
            ["Rendimiento", "Runner HTTP / k6", "Latencia media, percentil 95 (p95 < 2s) y tasa de errores bajo carga.", "Servidor Next.js en compilación de producción."],
          ],
          [18, 20, 36, 26]
        ),
        divider(),

        // ── 4. Preparación ──────────────────────────────────────────────────
        heading2("4. Preparación del entorno"),
        bullet("Creación de la rama Qa a partir de la rama de trabajo."),
        bullet("Configuración y verificación de .env.local con las credenciales activas de Supabase."),
        bullet("Creación de tests/setup.ts para carga automática de variables de entorno en Vitest."),
        bullet("Modularización de utilidades en src/app/api/alertas-riesgo/manual/helpers.ts para cumplir con la especificación de App Router de Next.js 16."),
        bullet("Corrección de límites en porcentajeDesdeModelo y adición de método GET para historial de alertas."),
        bullet("Aprovisionamiento de credenciales de prueba en Supabase Auth (coordinador@colegio.edu.co)."),
        divider(),

        // ── 5. Pruebas unitarias ────────────────────────────────────────────
        heading2("5. Casos de pruebas unitarias"),
        makeTable(
          ["ID", "Componente", "Entrada / acción", "Resultado esperado", "Estado"],
          unitTests,
          [8, 15, 25, 35, 17]
        ),
        divider(),

        // ── 6. API ──────────────────────────────────────────────────────────
        heading2("6. Pruebas de integración de API y autorización"),
        makeTable(
          ["ID", "Escenario", "Acción", "Resultado esperado", "Estado"],
          apiTests,
          [8, 15, 30, 30, 17]
        ),
        divider(),

        // ── 7. Supabase ─────────────────────────────────────────────────────
        heading2("7. Pruebas de integración con Supabase"),
        makeTable(
          ["ID", "Escenario", "Acción", "Resultado esperado", "Estado"],
          supTests,
          [8, 15, 30, 30, 17]
        ),
        divider(),

        // ── 8. E2E ──────────────────────────────────────────────────────────
        heading2("8. Pruebas E2E con Playwright"),
        makeTable(
          ["ID", "Escenario", "Acción", "Resultado esperado", "Estado"],
          e2eTests,
          [8, 18, 28, 29, 17]
        ),
        divider(),

        // ── 9. Rendimiento ──────────────────────────────────────────────────
        heading2("9. Pruebas de rendimiento (Compilación de Producción)"),
        makeTable(
          ["ID", "Carga inicial", "Métricas obtenidas", "Criterio propuesto", "Estado"],
          perfTests,
          [8, 20, 32, 25, 15]
        ),
        divider(),

        // ── 10. Organización ────────────────────────────────────────────────
        heading2("10. Organización de archivos de prueba"),
        bullet("src/lib/riesgo/proceso.test.ts  →  Pruebas Unitarias UT-01 a UT-08 (8 pruebas)"),
        bullet("src/app/api/alertas-riesgo/manual/route.test.ts  →  Pruebas de Integración API-01 a API-12 (12 pruebas)"),
        bullet("src/app/api/alertas-riesgo/manual/helpers.ts  →  Funciones auxiliares desacopladas de route.ts"),
        bullet("tests/setup.ts  →  Carga automática de .env.local para Vitest"),
        bullet("tests/integration/supabase.test.ts  →  Pruebas de Integración Supabase SUP-01 a SUP-06 (6 pruebas)"),
        bullet("tests/e2e/acceso.spec.ts  →  Pruebas E2E de acceso E2E-01, 02, 03, 07"),
        bullet("tests/e2e/alertas-riesgo.spec.ts  →  Pruebas E2E de módulos protegidos E2E-04, 05, 06"),
        bullet("tests/performance/api-smoke.js  →  Script k6 oficial"),
        bullet("tests/performance/run-perf.mjs  →  Runner de benchmarking de rendimiento"),
        bullet("vitest.config.ts  →  Configuración Vitest con setupFiles y exclusión de tests/e2e"),
        bullet("playwright.config.ts  →  Configuración Playwright con servidor dev webpack"),
        divider(),

        // ── 11. Comandos ────────────────────────────────────────────────────
        heading2("11. Comandos ejecutados"),
        makeTable(
          ["Actividad", "Comando", "Resultado"],
          [
            ["Pruebas Unitarias + API + Supabase", "npm test (vitest run)", "26 ejecutadas: 26 PASARON (100%)."],
            ["Pruebas E2E", "npx playwright test", "7 ejecutadas: 7 PASARON (100%)."],
            ["Compilación de Producción", "npx next build --webpack", "Compilación optimizada exitosa (0 errores)."],
            ["Pruebas de Rendimiento", "node tests/performance/run-perf.mjs", "4 escenarios ejecutados: 4 PASARON (p95 < 300 ms)."],
          ],
          [22, 38, 40]
        ),
        divider(),

        // ── 12. Criterios ───────────────────────────────────────────────────
        heading2("12. Criterios de entrada y salida"),
        bullet("Criterios de entrada: Cumplidos. Entorno configurado, rama Qa creada, credenciales activas y suites implementadas."),
        bullet("Criterios de salida: Cumplidos al 100%. Todos los casos planificados aprobados satisfactoriamente."),
        divider(),

        // ── 13. Resumen ─────────────────────────────────────────────────────
        heading2("13. Resumen consolidado de ejecución"),
        labelValue("Pruebas Totales Planificadas", "37"),
        labelValue("Pruebas Aprobadas (PASÓ)", "37  (100.0 %)"),
        labelValue("Pruebas No Aprobadas / Fallidas (NO PASÓ)", "0  (0.0 %)"),
        labelValue("Tasa de Éxito Global", "100.0 %"),
        spacer(),
        bullet("Pruebas Unitarias: 8 de 8 PASARON (100%)"),
        bullet("Pruebas de Integración de API: 12 de 12 PASARON (100%)"),
        bullet("Pruebas de Integración con Supabase: 6 de 6 PASARON (100%)"),
        bullet("Pruebas E2E con Playwright: 7 de 7 PASARON (100%)"),
        bullet("Pruebas de Rendimiento: 4 de 4 PASARON (100%)"),
        divider(),

        // ── 14. Evidencias ──────────────────────────────────────────────────
        heading2("14. Evidencias para entregar"),
        bullet("Consola Vitest Unitarias (proceso.test.ts): 8 pruebas PASARON."),
        bullet("Consola Vitest API (route.test.ts): 12 pruebas PASARON."),
        bullet("Consola Vitest Supabase (supabase.test.ts): 6 pruebas PASARON contra base de datos real."),
        bullet("Consola Playwright (acceso.spec.ts, alertas-riesgo.spec.ts): 7 pruebas PASARON en Chromium headless."),
        bullet("Consola de Rendimiento (run-perf.mjs): 110 transacciones con p95 de 293.72 ms (PERF-01), 22.28 ms (PERF-02), 27.36 ms (PERF-03) y 5.64 ms (PERF-04), todas con 0% de errores."),
        divider(),

        // ── 15. Explicación de resultado ────────────────────────────────────
        ...explanationSection(),

        divider(),
        new Paragraph({
          spacing: { before: 200, after: 100 },
          alignment: AlignmentType.CENTER,
          children: [
            italic("Documento final generado y consolidado en la rama Qa — Sistema de Gestión Académica (SGA)", "2E6DA4", 18),
          ],
        }),
      ],
    },
  ],
});

// ── Serializar y guardar ──────────────────────────────────────────────────────
const buffer = await Packer.toBuffer(doc);
writeFileSync(OUTPUT, buffer);
console.log(`✅ Documento generado: ${OUTPUT}`);
