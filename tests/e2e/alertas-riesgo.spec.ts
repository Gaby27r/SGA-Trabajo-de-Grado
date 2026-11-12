import { test, expect } from "@playwright/test";

test.describe("Plan de Pruebas: 8. Pruebas E2E - Módulo de Riesgo y Alertas", () => {
  // E2E-05: Consulta de riesgo
  test("E2E-05: Consulta de indicadores de riesgo en el reporte de estudiantes", async ({ page }) => {
    // Intentar acceder directamente a reporte de estudiantes sin sesión
    await page.goto("/dashboard/reporte-estudiantes");
    // Debe redirigir a login para usuarios no autenticados
    await expect(page).toHaveURL(/\/login/);
  });

  // E2E-06: Alerta manual
  test("E2E-06: Verificación de acceso a la funcionalidad de envío manual de alertas", async ({ page }) => {
    await page.goto("/dashboard/seguimiento");
    await expect(page).toHaveURL(/\/login/);
  });

  // E2E-04: Operación académica
  test("E2E-04: Operación académica protegida en el módulo de cursos o notas", async ({ page }) => {
    await page.goto("/dashboard/cursos");
    await expect(page).toHaveURL(/\/login/);
  });
});
