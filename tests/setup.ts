// Configuración global para pruebas con Vitest
try {
  process.loadEnvFile(".env.local");
} catch {
  // Ignorar si no existe el archivo o ya fue cargado por el runtime
}
