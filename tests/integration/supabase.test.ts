import { describe, it, expect, vi } from "vitest";
import { createClient } from "@supabase/supabase-js";

describe("Plan de Pruebas: 7. Pruebas de integración con Supabase", () => {
  const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL || "https://hcwjnjvxzonuwyuvcwyp.supabase.co";
  const anonKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY || "dummy_anon";
  const serviceKey = process.env.SUPABASE_SERVICE_ROLE_KEY || "dummy_service";

  // SUP-01: Lectura
  it("SUP-01: Lectura de catálogo público / autenticado permite consultar cursos", async () => {
    const supabase = createClient(supabaseUrl, serviceKey);
    const { data, error } = await supabase.from("cursos").select("id, nombre, jornada").limit(5);

    expect(error).toBeNull();
    expect(Array.isArray(data)).toBe(true);
  });

  // SUP-02: Inserción
  it("SUP-02: Inserción de registro de prueba controlado y verificación de persistencia", async () => {
    const supabase = createClient(supabaseUrl, serviceKey);
    const testCursoNombre = `Curso_QA_${Date.now()}`;

    // Insertar curso temporal
    const { data: cursoInsertado, error: errorInsert } = await supabase
      .from("cursos")
      .insert({ nombre: testCursoNombre, jornada: "Tarde" })
      .select()
      .single();

    expect(errorInsert).toBeNull();
    expect(cursoInsertado).toBeDefined();
    expect(cursoInsertado.nombre).toBe(testCursoNombre);

    // Limpieza (Rollback/Delete del registro temporal para aislar pruebas)
    const { error: errorDelete } = await supabase
      .from("cursos")
      .delete()
      .eq("id", cursoInsertado.id);

    expect(errorDelete).toBeNull();
  });

  // SUP-03: Restricciones
  it("SUP-03: Restricciones de base de datos rechazan datos inválidos (Check Constraint de estrato 1-6)", async () => {
    const supabase = createClient(supabaseUrl, serviceKey);

    // Intentar insertar estudiante con estrato 9 (infracción de: check (estrato between 1 and 6))
    const { data, error } = await supabase.from("estudiantes").insert({
      nombre_completo: "Estudiante Inválido Estrato",
      estrato: 9, // Inválido: debe ser entre 1 y 6
    });

    expect(error).not.toBeNull();
    expect(error?.message).toMatch(/check|violates|estrato/i);
  });

  // SUP-04: RLS y roles
  it("SUP-04: RLS restringe acceso anónimo o no autorizado a tablas protegidas como perfiles o calificaciones", async () => {
    // Cliente anónimo sin sesión
    const anonClient = createClient(supabaseUrl, anonKey);

    // Intentar leer perfiles de usuarios con cliente anónimo
    const { data: perfilesData, error: perfilesError } = await anonClient
      .from("perfiles")
      .select("*");

    // Con RLS activo, la política sólo permite select a autenticados (id=auth.uid() o coordinador)
    // El cliente anónimo no recibe registros o recibe error de RLS
    expect(perfilesData?.length ?? 0).toBe(0);
  });

  // SUP-05: Relaciones
  it("SUP-05: Consultas con relaciones y vistas agregadas (vista_promedios_periodo o vista_resumen_asistencia)", async () => {
    const supabase = createClient(supabaseUrl, serviceKey);

    const { data, error } = await supabase
      .from("vista_resumen_asistencia")
      .select("*")
      .limit(5);

    expect(error).toBeNull();
    expect(Array.isArray(data)).toBe(true);
  });

  // SUP-06: Fallo de conexión
  it("SUP-06: Simulación de fallo de conexión y manejo controlado sin datos erróneos", async () => {
    // Conectar a URL no existente para simular fallo de red/conexión
    const brokenClient = createClient("https://invalid-non-existent-subdomain.supabase.co", anonKey);

    try {
      const { data, error } = await brokenClient.from("cursos").select("*").limit(1);
      // Debe retornar error o capturarse
      expect(error).not.toBeNull();
      expect(data).toBeNull();
    } catch (err) {
      expect(err).toBeDefined();
    }
  });
});
