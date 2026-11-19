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

async function smoothScroll(page, distance = 350, steps = 8) {
  for (let i = 0; i < steps; i++) {
    await page.mouse.wheel(0, distance / steps);
    await page.waitForTimeout(80);
  }
}

async function run() {
  console.log("Iniciando grabaciones automáticas de pantalla en alta resolución...");

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

  // 3. COORDINADOR: ESTUDIANTES Y PROFESORES
  await recordSession("03_Coordinador_Estudiantes_Y_Profesores.webm", "03. Coordinador: Estudiantes y Profesores", async (page) => {
    await page.goto(`${BASE_URL}/login`, { waitUntil: "networkidle" });
    await page.fill("#email", "coordinador@colegio.edu.co");
    await page.fill("#password", "Coordinador2026*");
    await page.click('button[type="submit"]');
    await page.waitForTimeout(2500);

    // Estudiantes
    await page.goto(`${BASE_URL}/dashboard/estudiantes`, { waitUntil: "networkidle" });
    await page.waitForTimeout(2000);

    // Demostrar filtro de búsqueda
    const searchInput = page.locator('input[placeholder*="Buscar"], input[type="text"]').first();
    if (await searchInput.isVisible()) {
      await searchInput.fill("E8");
      await page.waitForTimeout(1500);
      await searchInput.clear();
      await page.waitForTimeout(1000);
    }

    // Abrir modal nuevo estudiante y mostrar campos
    const nuevoEstudianteBtn = page.locator('button:has-text("Nuevo"), button:has-text("Agregar")').first();
    if (await nuevoEstudianteBtn.isVisible()) {
      await nuevoEstudianteBtn.click();
      await page.waitForTimeout(2500);
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

  // 5. COORDINADOR: REPORTE PREDICTIVO DE RIESGO IA
  await recordSession("05_Coordinador_Reporte_Riesgo_IA.webm", "05. Coordinador: Reporte de Riesgo IA y Alertas", async (page) => {
    await page.goto(`${BASE_URL}/login`, { waitUntil: "networkidle" });
    await page.fill("#email", "coordinador@colegio.edu.co");
    await page.fill("#password", "Coordinador2026*");
    await page.click('button[type="submit"]');
    await page.waitForTimeout(2500);

    // Reporte de estudiante
    await page.goto(`${BASE_URL}/dashboard/reporte-estudiante`, { waitUntil: "networkidle" });
    await page.waitForTimeout(2500);

    // Explorar semáforo y tarjetas de estudiantes
    const cards = page.locator("button, div.cursor-pointer, [role='button']");
    const count = await cards.count();
    for (let i = 0; i < Math.min(count, 3); i++) {
      const c = cards.nth(i);
      if (await c.isVisible()) {
        try {
          await c.click({ timeout: 1500 });
          await page.waitForTimeout(1000);
        } catch (e) {}
      }
    }
    await smoothScroll(page, 350);
    await page.waitForTimeout(2000);
    await smoothScroll(page, -350);
    await page.waitForTimeout(1500);
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

    // Cambiar selector si está disponible
    const selectores = page.locator("select");
    if ((await selectores.count()) > 0) {
      await selectores.first().selectOption({ index: 0 });
      await page.waitForTimeout(1500);
    }

    // Scroll por la lista de estudiantes
    await smoothScroll(page, 350);
    await page.waitForTimeout(2000);

    // Probar modal de anotación
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

  // 7. ESTUDIANTE: BOLETÍN DE NOTAS Y HORARIO
  await recordSession("07_Modulo_Estudiante_Boletin_Y_Horario.webm", "07. Estudiante: Información y Boletín", async (page) => {
    await page.goto(`${BASE_URL}/login`, { waitUntil: "networkidle" });
    await page.fill("#email", "e815@colegio.edu.co");
    await page.fill("#password", "Estudiante2026*");
    await page.click('button[type="submit"]');
    await page.waitForTimeout(2500);

    await page.goto(`${BASE_URL}/dashboard/estudiante`, { waitUntil: "networkidle" });
    await page.waitForTimeout(2500);

    // Métricas, notas, asistencias y horario
    await smoothScroll(page, 400);
    await page.waitForTimeout(2000);
    await smoothScroll(page, 400);
    await page.waitForTimeout(2000);
    await smoothScroll(page, -800);
    await page.waitForTimeout(2000);
  });

  // Limpiar carpeta temporal
  try {
    fs.rmSync(TEMP_DIR, { recursive: true, force: true });
  } catch (e) {}

  console.log("\n========================================================");
  console.log("🎉 TODAS LAS GRABACIONES FLUIDAS HAN SIDO COMPLETADAS");
  console.log(`📁 Ubicación final en tu Escritorio: ${OUTPUT_DIR}`);
  console.log("========================================================\n");
}

run().catch((e) => {
  console.error("Fallo general en ejecución de grabaciones:", e);
  process.exit(1);
});
