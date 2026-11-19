import { chromium } from "playwright";
import fs from "fs";
import path from "path";

const BASE_URL = "http://localhost:3000";
const OUTPUT_DIR = "C:\\Users\\ThinkPad X1\\Desktop\\Grabaciones_SGA";
const TEMP_DIR = path.resolve("./temp_recordings");

if (!fs.existsSync(OUTPUT_DIR)) {
  fs.mkdirSync(OUTPUT_DIR, { recursive: true });
}
if (!fs.existsSync(TEMP_DIR)) {
  fs.mkdirSync(TEMP_DIR, { recursive: true });
}

async function recordSession(filename, title, actionsFn) {
  console.log(`\n▶ [GRABANDO] ${title} -> ${filename}`);
  const browser = await chromium.launch({ headless: true });
  const context = await browser.newContext({
    recordVideo: {
      dir: TEMP_DIR,
      size: { width: 1280, height: 720 }
    },
    viewport: { width: 1280, height: 720 }
  });

  const page = await context.newPage();

  try {
    await actionsFn(page);
  } catch (err) {
    console.error(`Aviso en grabación de ${title}:`, err.message || err);
  }

  const video = page.video();
  await page.close();
  await context.close();
  await browser.close();

  if (video) {
    const videoPath = await video.path();
    const destPath = path.join(OUTPUT_DIR, filename);
    if (fs.existsSync(destPath)) {
      try { fs.unlinkSync(destPath); } catch (e) {}
    }
    fs.renameSync(videoPath, destPath);
    console.log(`✅ [GUARDADO] Video guardado en: ${destPath}`);
  }
}

async function smoothScroll(page, distance = 350, steps = 10) {
  for (let i = 0; i < steps; i++) {
    await page.mouse.wheel(0, distance / steps);
    await page.waitForTimeout(100);
  }
}

async function run() {
  console.log("Iniciando grabaciones exhaustivas con todas las funcionalidades solicitadas...");

  // 1. LOGIN Y CONTROL DE ACCESO
  await recordSession("01_Login_Y_Seguridad.webm", "01. Login y Control de Acceso", async (page) => {
    await page.goto(`${BASE_URL}/login`, { waitUntil: "networkidle" });
    await page.waitForTimeout(1500);

    // Demostrar validación de credenciales inválidas
    await page.fill("#email", "usuario.erroneo@colegio.edu.co");
    await page.waitForTimeout(400);
    await page.fill("#password", "ClaveInvalida123*");
    await page.waitForTimeout(600);
    await page.click('button[type="submit"]');
    await page.waitForTimeout(2000);

    // Login correcto como Coordinador
    await page.fill("#email", "coordinador@colegio.edu.co");
    await page.waitForTimeout(400);
    await page.fill("#password", "Coordinador2026*");
    await page.waitForTimeout(600);
    await page.click('button[type="submit"]');
    await page.waitForTimeout(3000);
  });

  // 2. COORDINADOR: DASHBOARD Y CURSOS
  await recordSession("02_Coordinador_Dashboard_Y_Cursos.webm", "02. Coordinador: Dashboard y Cursos", async (page) => {
    await page.goto(`${BASE_URL}/login`, { waitUntil: "networkidle" });
    await page.fill("#email", "coordinador@colegio.edu.co");
    await page.fill("#password", "Coordinador2026*");
    await page.click('button[type="submit"]');
    await page.waitForTimeout(2500);

    // Explorar Dashboard de Métricas
    await smoothScroll(page, 300);
    await page.waitForTimeout(1500);
    await smoothScroll(page, -300);
    await page.waitForTimeout(1000);

    // Ir a Cursos
    await page.goto(`${BASE_URL}/dashboard/cursos`, { waitUntil: "networkidle" });
    await page.waitForTimeout(2000);

    // Abrir modal de nuevo curso
    const nuevoCursoBtn = page.locator('button:has-text("Nuevo"), button:has-text("Agregar")').first();
    if (await nuevoCursoBtn.isVisible()) {
      await nuevoCursoBtn.click();
      await page.waitForTimeout(2000);
      await page.keyboard.press("Escape");
      await page.waitForTimeout(1000);
    }
    await smoothScroll(page, 350);
    await page.waitForTimeout(1500);
  });

  // 3. COORDINADOR: ESTUDIANTES, EDICIÓN Y CLASES ASIGNADAS
  await recordSession("03_Coordinador_Estudiantes_Y_Profesores.webm", "03. Coordinador: Estudiantes, Edición, Clases y Docentes", async (page) => {
    await page.goto(`${BASE_URL}/login`, { waitUntil: "networkidle" });
    await page.fill("#email", "coordinador@colegio.edu.co");
    await page.fill("#password", "Coordinador2026*");
    await page.click('button[type="submit"]');
    await page.waitForTimeout(2500);

    // Estudiantes
    await page.goto(`${BASE_URL}/dashboard/estudiantes`, { waitUntil: "networkidle" });
    await page.waitForTimeout(2500);

    // Demostrar filtro de búsqueda
    const searchInput = page.locator('input[placeholder*="Buscar"], input[type="text"]').first();
    if (await searchInput.isVisible()) {
      await searchInput.fill("E8");
      await page.waitForTimeout(1500);
      await searchInput.clear();
      await page.waitForTimeout(1000);
    }

    // ABRIR EDICIÓN DE UN ESTUDIANTE: Mostrar curso y clases asignadas
    const editBtn = page.locator('button[aria-label^="Editar"]').first();
    if (await editBtn.isVisible()) {
      await editBtn.click();
      await page.waitForTimeout(2500);

      // Scroll interno dentro del formulario modal para ver Curso y Clases Asignadas
      const modalForm = page.locator('form');
      if (await modalForm.isVisible()) {
        await modalForm.evaluate((el) => el.scrollBy({ top: 150, behavior: 'smooth' }));
        await page.waitForTimeout(2000);
        await modalForm.evaluate((el) => el.scrollBy({ top: 250, behavior: 'smooth' }));
        await page.waitForTimeout(3000); // Visualización clara de clases seleccionadas y horarios
        await modalForm.evaluate((el) => el.scrollBy({ top: -400, behavior: 'smooth' }));
        await page.waitForTimeout(1500);
      }

      await page.keyboard.press("Escape");
      await page.waitForTimeout(1000);
    }

    // Modal nuevo estudiante
    const nuevoEstudianteBtn = page.locator('button:has-text("Nuevo"), button:has-text("Agregar")').first();
    if (await nuevoEstudianteBtn.isVisible()) {
      await nuevoEstudianteBtn.click();
      await page.waitForTimeout(2000);
      await page.keyboard.press("Escape");
      await page.waitForTimeout(1000);
    }
    await smoothScroll(page, 400);
    await page.waitForTimeout(1500);

    // Profesores
    await page.goto(`${BASE_URL}/dashboard/profesores`, { waitUntil: "networkidle" });
    await page.waitForTimeout(2000);
    await smoothScroll(page, 350);
    await page.waitForTimeout(1500);
  });

  // 4. COORDINADOR: HORARIOS Y SEGUIMIENTO ACADÉMICO
  await recordSession("04_Coordinador_Horarios_Y_Seguimiento.webm", "04. Coordinador: Horarios y Seguimiento", async (page) => {
    await page.goto(`${BASE_URL}/login`, { waitUntil: "networkidle" });
    await page.fill("#email", "coordinador@colegio.edu.co");
    await page.fill("#password", "Coordinador2026*");
    await page.click('button[type="submit"]');
    await page.waitForTimeout(2500);

    // Horarios
    await page.goto(`${BASE_URL}/dashboard/horario`, { waitUntil: "networkidle" });
    await page.waitForTimeout(2000);

    const selectCurso = page.locator("select").first();
    if (await selectCurso.isVisible()) {
      const options = await selectCurso.locator("option").all();
      if (options.length > 1) {
        await selectCurso.selectOption({ index: 1 });
        await page.waitForTimeout(2000);
      }
    }
    await smoothScroll(page, 300);
    await page.waitForTimeout(1500);

    // Seguimiento Global
    await page.goto(`${BASE_URL}/dashboard/seguimiento`, { waitUntil: "networkidle" });
    await page.waitForTimeout(2500);
    await smoothScroll(page, 400);
    await page.waitForTimeout(2000);
    await smoothScroll(page, -400);
    await page.waitForTimeout(1000);
  });

  // 5. COORDINADOR: REPORTE PREDICTIVO DE RIESGO IA Y BOTÓN "REVISAR REPORTE"
  await recordSession("05_Coordinador_Reporte_Riesgo_IA.webm", "05. Coordinador: Reporte de Riesgo IA y Revisar Detalle", async (page) => {
    await page.goto(`${BASE_URL}/login`, { waitUntil: "networkidle" });
    await page.fill("#email", "coordinador@colegio.edu.co");
    await page.fill("#password", "Coordinador2026*");
    await page.click('button[type="submit"]');
    await page.waitForTimeout(2500);

    // Reporte de estudiante
    await page.goto(`${BASE_URL}/dashboard/reporte-estudiante`, { waitUntil: "networkidle" });
    await page.waitForTimeout(2500);

    // Vista general de semáforo
    await smoothScroll(page, 300);
    await page.waitForTimeout(1500);
    await smoothScroll(page, -300);
    await page.waitForTimeout(1000);

    // CLIC EN EL BOTÓN "REVISAR REPORTE" PARA ABRIR EL INFORME DETALLADO
    const revisarBtn = page.locator('button:has-text("Revisar reporte")').first();
    if (await revisarBtn.isVisible()) {
      await revisarBtn.click();
      await page.waitForTimeout(2500);

      // Recorrer el informe detallado: métricas, probabilidades, faltas consecutivas y factores de preocupación
      await smoothScroll(page, 350);
      await page.waitForTimeout(2500);
      await smoothScroll(page, 400);
      await page.waitForTimeout(3500); // Vista completa de los factores Alto/Medio/Informativo
      await smoothScroll(page, -750);
      await page.waitForTimeout(1500);

      // Volver al listado general
      const volverBtn = page.locator('button:has-text("Volver al listado")').first();
      if (await volverBtn.isVisible()) {
        await volverBtn.click();
        await page.waitForTimeout(2000);
      }
    }
  });

  // 6. PROFESOR: CALIFICACIONES, ASISTENCIA Y OBSERVADOR
  await recordSession("06_Modulo_Profesor_Calificaciones_Asistencia.webm", "06. Docente: Calificaciones y Asistencia", async (page) => {
    await page.goto(`${BASE_URL}/login`, { waitUntil: "networkidle" });
    await page.fill("#email", "pal4@colegio.edu.co");
    await page.fill("#password", "Profesor2026*");
    await page.click('button[type="submit"]');
    await page.waitForTimeout(2500);

    await page.goto(`${BASE_URL}/dashboard/profesor`, { waitUntil: "networkidle" });
    await page.waitForTimeout(2500);

    const selectores = page.locator("select");
    if ((await selectores.count()) > 0) {
      await selectores.first().selectOption({ index: 0 });
      await page.waitForTimeout(1500);
    }

    await smoothScroll(page, 350);
    await page.waitForTimeout(2000);

    const anotacionBtn = page.locator('button:has-text("Anotación"), button:has-text("+ Anotación")').first();
    if (await anotacionBtn.isVisible()) {
      await anotacionBtn.click();
      await page.waitForTimeout(2000);
      await page.keyboard.press("Escape");
      await page.waitForTimeout(1000);
    }
    await smoothScroll(page, -350);
    await page.waitForTimeout(1500);
  });

  // 7. ESTUDIANTE: BOLETÍN DE NOTAS, ASISTENCIA Y HORARIO COMPLETO (SCROLL COMPLETO)
  await recordSession("07_Modulo_Estudiante_Boletin_Y_Horario.webm", "07. Estudiante: Información, Boletín, Horario y Asistencia", async (page) => {
    await page.goto(`${BASE_URL}/login`, { waitUntil: "networkidle" });
    await page.fill("#email", "e815@colegio.edu.co");
    await page.fill("#password", "Estudiante2026*");
    await page.click('button[type="submit"]');
    await page.waitForTimeout(2500);

    await page.goto(`${BASE_URL}/dashboard/estudiante`, { waitUntil: "networkidle" });
    await page.waitForTimeout(2500);

    // 1. Métricas superiores y profesores
    await smoothScroll(page, 350);
    await page.waitForTimeout(2000);

    // 2. Mis notas (Periodos 1 y 2)
    await smoothScroll(page, 450);
    await page.waitForTimeout(2500);

    // 3. MI HORARIO (Bajamos completamente para mostrar la grilla de Lunes a Viernes con horas y materias)
    await smoothScroll(page, 500);
    await page.waitForTimeout(4000);

    // 4. MI ASISTENCIA (Métricas de faltas/asistencias y tabla cronológica)
    await smoothScroll(page, 550);
    await page.waitForTimeout(3500);

    // Regresar suavemente a la parte superior
    await smoothScroll(page, -1850, 15);
    await page.waitForTimeout(2000);
  });

  // Limpiar carpeta temporal
  try {
    fs.rmSync(TEMP_DIR, { recursive: true, force: true });
  } catch (e) {}

  console.log("\n========================================================");
  console.log("🎉 TODAS LAS GRABACIONES HAN SIDO ACTUALIZADAS CON ÉXITO");
  console.log(`📁 Ubicación final en tu Escritorio: ${OUTPUT_DIR}`);
  console.log("========================================================\n");
}

run().catch((e) => {
  console.error("Fallo general en ejecución de grabaciones:", e);
  process.exit(1);
});
