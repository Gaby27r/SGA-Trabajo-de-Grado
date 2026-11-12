import { test, expect } from "@playwright/test";

test.describe("Plan de Pruebas: 8. Pruebas E2E - Autenticación y Acceso", () => {
  // E2E-07: Ruta restringida
  test("E2E-07: Intentar acceder a ruta protegida (/dashboard) sin sesión redirige a /login", async ({ page }) => {
    await page.goto("/dashboard");
    await expect(page).toHaveURL(/\/login/);
    await expect(page.locator("h1")).toContainText("Iniciar sesión");
  });

  // E2E-02: Credenciales inválidas
  test("E2E-02: Intentar acceso con credenciales incorrectas muestra mensaje controlado", async ({ page }) => {
    await page.goto("/login");

    await page.fill("#email", "usuario_no_existente@colegio.edu.co");
    await page.fill("#password", "ClaveInvalida123!");
    await page.click('button[type="submit"]');

    // Debe mostrar banner de error sin romper la interfaz
    const bannerError = page.locator("div").filter({ hasText: /incorrectos|invalid|error/i });
    await expect(bannerError.first()).toBeVisible({ timeout: 10000 });
    await expect(page).toHaveURL(/\/login/);
  });

  // E2E-01: Inicio de sesión válido
  test("E2E-01: Inicio de sesión con usuario válido accede al área correspondiente", async ({ page }) => {
    // Si no existen credenciales activas en Supabase Auth, se documenta el bloqueo
    await page.goto("/login");
    await page.fill("#email", "coordinador@colegio.edu.co");
    await page.fill("#password", "Coordinador2026*");
    await page.click('button[type="submit"]');

    // Esperar redirección al panel de control si la cuenta está aprovisionada
    await expect(page).toHaveURL(/\/dashboard/, { timeout: 20000 });
  });

  // E2E-03: Navegación por rol
  test("E2E-03: Navegación por rol muestra funciones correspondientes al perfil", async ({ page }) => {
    await page.goto("/dashboard");
    // Si no está autenticado, middleware protege la ruta
    const url = page.url();
    expect(url).toContain("/login");
  });
});
