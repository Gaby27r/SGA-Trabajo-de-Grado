import { describe, it, expect, vi, beforeEach } from "vitest";
import { NextRequest } from "next/server";

// 1. Mocks declarados con vi.mock
const mockGetPerfil = vi.fn();
vi.mock("@/lib/auth", () => ({
  getPerfil: () => mockGetPerfil(),
}));

const mockSendMail = vi.fn().mockResolvedValue({ messageId: "msg-123" });
const mockClose = vi.fn();
vi.mock("nodemailer", () => ({
  default: {
    createTransport: vi.fn(() => ({
      sendMail: mockSendMail,
      close: mockClose,
    })),
  },
  createTransport: vi.fn(() => ({
    sendMail: mockSendMail,
    close: mockClose,
  })),
}));

let mockSupabaseFrom = vi.fn();
vi.mock("@supabase/supabase-js", () => ({
  createClient: vi.fn(() => ({
    from: (table: string) => mockSupabaseFrom(table),
  })),
}));

vi.mock("@/lib/riesgo/proceso", () => ({
  obtenerDatosEstudiantes: vi.fn().mockResolvedValue([]),
  encontrar_riesgo: vi.fn().mockResolvedValue([]),
}));

import { POST } from "./route";

describe("Plan de Pruebas: 6. Pruebas de integración de API y autorización", () => {
  beforeEach(() => {
    vi.clearAllMocks();

    process.env.NEXT_PUBLIC_SUPABASE_URL = "https://mock.supabase.co";
    process.env.SUPABASE_SERVICE_ROLE_KEY = "mock_service_key";
    process.env.GMAIL_USER = "test@colegio.edu.co";
    process.env.GMAIL_APP_PASSWORD = "test password app";

    mockSendMail.mockResolvedValue({ messageId: "msg-123" });
  });

  // API-01: Sin sesión
  it("API-01: Invocar ruta protegida sin autenticación retorna 401 Unauthorized", async () => {
    mockGetPerfil.mockResolvedValue(null);

    const req = new NextRequest("http://localhost:3000/api/alertas-riesgo/manual", {
      method: "POST",
      body: JSON.stringify({ estudianteId: "est-1" }),
    });

    const res = await POST(req);
    const data = await res.json();

    expect(res.status).toBe(401);
    expect(data.error).toContain("Debes iniciar sesión");
    expect(mockSendMail).not.toHaveBeenCalled();
  });

  // API-02: Rol no autorizado
  it("API-02: Acceder con rol sin permiso (ej: estudiante) retorna 403 Forbidden", async () => {
    mockGetPerfil.mockResolvedValue({
      id: "usr-est",
      nombre_completo: "Estudiante Prueba",
      correo: "estudiante@colegio.edu.co",
      rol: "estudiante",
      profesor_id: null,
      estudiante_id: "est-1",
    });

    const req = new NextRequest("http://localhost:3000/api/alertas-riesgo/manual", {
      method: "POST",
      body: JSON.stringify({ estudianteId: "est-1" }),
    });

    const res = await POST(req);
    const data = await res.json();

    expect(res.status).toBe(403);
    expect(data.error).toContain("No tienes permisos");
    expect(mockSendMail).not.toHaveBeenCalled();
  });

  // API-03: Rol autorizado
  it("API-03: Acceder con rol permitido (coordinador) procesa la alerta exitosamente y retorna 200", async () => {
    mockGetPerfil.mockResolvedValue({
      id: "usr-coord",
      nombre_completo: "Coordinadora General",
      correo: "coord@colegio.edu.co",
      rol: "coordinador",
      profesor_id: null,
      estudiante_id: null,
    });

    mockSupabaseFrom.mockImplementation((table: string) => {
      if (table === "estudiantes") {
        return {
          select: () => ({
            eq: () => ({
              maybeSingle: () =>
                Promise.resolve({
                  data: {
                    id: "est-valid-uuid",
                    nombre_completo: "Estudiante Riesgo",
                    curso_id: "curso-101",
                    estrato: 2,
                    anio_repetido: "si",
                    total_anotaciones: 5,
                    graves: 1,
                    leves: 4,
                    cursos: { nombre: "Grado 8A" },
                  },
                  error: null,
                }),
            }),
          }),
        };
      }
      if (table === "perfiles") {
        return {
          select: () => ({
            eq: () => ({
              eq: () => ({
                maybeSingle: () =>
                  Promise.resolve({
                    data: { correo: "acudiente@correo.com" },
                    error: null,
                  }),
              }),
            }),
          }),
        };
      }
      if (table === "calificaciones") {
        return {
          select: () => ({
            eq: () =>
              Promise.resolve({
                data: [
                  { estudiante_id: "est-valid-uuid", periodo: 1, nota: 2.1 },
                  { estudiante_id: "est-valid-uuid", periodo: 2, nota: 2.4 },
                ],
                error: null,
              }),
          }),
        };
      }
      if (table === "asistencias") {
        return {
          select: () => ({
            eq: () =>
              Promise.resolve({
                data: [
                  { estudiante_id: "est-valid-uuid", fecha: "2026-10-01", estado: "Falto" },
                  { estudiante_id: "est-valid-uuid", fecha: "2026-10-02", estado: "Falto" },
                  { estudiante_id: "est-valid-uuid", fecha: "2026-10-03", estado: "Falto" },
                  { estudiante_id: "est-valid-uuid", fecha: "2026-10-04", estado: "Falto" },
                  { estudiante_id: "est-valid-uuid", fecha: "2026-10-05", estado: "Falto" },
                ],
                error: null,
              }),
          }),
        };
      }
      if (table === "alertas_riesgo_email") {
        return {
          delete: () => ({
            eq: () => ({
              gte: () => ({
                lt: () => Promise.resolve({ error: null }),
              }),
            }),
          }),
          insert: () => Promise.resolve({ error: null }),
        };
      }
      return {};
    });

    const req = new NextRequest("http://localhost:3000/api/alertas-riesgo/manual", {
      method: "POST",
      body: JSON.stringify({ estudianteId: "est-valid-uuid" }),
    });

    const res = await POST(req);
    const data = await res.json();

    expect(res.status).toBe(200);
    expect(data.ok).toBe(true);
    expect(mockSendMail).toHaveBeenCalledTimes(1);
  });

  // API-04: Curso asignado
  it("API-04: Profesor con curso asignado puede enviar alerta", async () => {
    mockGetPerfil.mockResolvedValue({
      id: "usr-prof",
      nombre_completo: "Profesor Juan",
      correo: "profesor@colegio.edu.co",
      rol: "profesor",
      profesor_id: "prof-1",
      estudiante_id: null,
    });

    mockSupabaseFrom.mockImplementation((table: string) => {
      if (table === "estudiantes") {
        return {
          select: () => ({
            eq: () => ({
              maybeSingle: () =>
                Promise.resolve({
                  data: {
                    id: "est-prof-uuid",
                    nombre_completo: "Alumno del Profesor",
                    curso_id: "curso-prof",
                    estrato: 1,
                    anio_repetido: "no",
                    total_anotaciones: 2,
                    graves: 1,
                    leves: 1,
                    cursos: { nombre: "Grado 4B" },
                  },
                  error: null,
                }),
            }),
          }),
        };
      }
      if (table === "horario_clases") {
        return {
          select: () => ({
            eq: () => ({
              eq: () => ({
                eq: () => ({
                  limit: () =>
                    Promise.resolve({
                      data: [{ curso_id: "curso-prof" }],
                      error: null,
                    }),
                }),
              }),
            }),
          }),
        };
      }
      if (table === "perfiles") {
        return {
          select: () => ({
            eq: () => ({
              eq: () => ({
                maybeSingle: () =>
                  Promise.resolve({
                    data: { correo: "alumno@correo.com" },
                    error: null,
                  }),
              }),
            }),
          }),
        };
      }
      if (table === "calificaciones") {
        return {
          select: () => ({
            eq: () =>
              Promise.resolve({
                data: [{ estudiante_id: "est-prof-uuid", periodo: 1, nota: 1.5 }],
                error: null,
              }),
          }),
        };
      }
      if (table === "asistencias") {
        return {
          select: () => ({
            eq: () => Promise.resolve({ data: [], error: null }),
          }),
        };
      }
      if (table === "alertas_riesgo_email") {
        return {
          delete: () => ({
            eq: () => ({
              gte: () => ({
                lt: () => Promise.resolve({ error: null }),
              }),
            }),
          }),
          insert: () => Promise.resolve({ error: null }),
        };
      }
      return {};
    });

    const req = new NextRequest("http://localhost:3000/api/alertas-riesgo/manual", {
      method: "POST",
      body: JSON.stringify({ estudianteId: "est-prof-uuid" }),
    });

    const res = await POST(req);
    const data = await res.json();

    expect(res.status).toBe(200);
    expect(data.ok).toBe(true);
  });

  // API-05: Curso ajeno
  it("API-05: Profesor intentando alertar sobre curso no asignado recibe 403 Forbidden", async () => {
    mockGetPerfil.mockResolvedValue({
      id: "usr-prof",
      nombre_completo: "Profesor Juan",
      correo: "profesor@colegio.edu.co",
      rol: "profesor",
      profesor_id: "prof-1",
      estudiante_id: null,
    });

    mockSupabaseFrom.mockImplementation((table: string) => {
      if (table === "estudiantes") {
        return {
          select: () => ({
            eq: () => ({
              maybeSingle: () =>
                Promise.resolve({
                  data: {
                    id: "est-ajeno",
                    nombre_completo: "Alumno Ajeno",
                    curso_id: "curso-ajeno-999",
                    estrato: 1,
                    cursos: { nombre: "Grado 11C" },
                  },
                  error: null,
                }),
            }),
          }),
        };
      }
      if (table === "horario_clases") {
        return {
          select: () => ({
            eq: () => ({
              eq: () => ({
                eq: () => ({
                  limit: () =>
                    Promise.resolve({
                      data: [],
                      error: null,
                    }),
                }),
              }),
            }),
          }),
        };
      }
      return {};
    });

    const req = new NextRequest("http://localhost:3000/api/alertas-riesgo/manual", {
      method: "POST",
      body: JSON.stringify({ estudianteId: "est-ajeno" }),
    });

    const res = await POST(req);
    const data = await res.json();

    expect(res.status).toBe(403);
    expect(data.error).toContain("No tienes permiso para enviar alertas a este estudiante");
    expect(mockSendMail).not.toHaveBeenCalled();
  });

  // API-06: Parámetros inválidos
  it("API-06: Parámetros inválidos (cuerpo vacío o sin estudianteId) retorna 400 Bad Request", async () => {
    mockGetPerfil.mockResolvedValue({
      id: "usr-coord",
      nombre_completo: "Coord",
      correo: "c@colegio.edu.co",
      rol: "coordinador",
      profesor_id: null,
      estudiante_id: null,
    });

    const req = new NextRequest("http://localhost:3000/api/alertas-riesgo/manual", {
      method: "POST",
      body: JSON.stringify({}),
    });

    const res = await POST(req);
    const data = await res.json();

    expect(res.status).toBe(400);
    expect(data.error).toContain("Debes indicar un estudianteId válido");
  });

  // API-07: Error Supabase
  it("API-07: Error en base de datos Supabase retorna 500 controlado sin informar éxito falso", async () => {
    mockGetPerfil.mockResolvedValue({
      id: "usr-coord",
      nombre_completo: "Coord",
      correo: "c@colegio.edu.co",
      rol: "coordinador",
      profesor_id: null,
      estudiante_id: null,
    });

    mockSupabaseFrom.mockImplementation(() => ({
      select: () => ({
        eq: () => ({
          maybeSingle: () =>
            Promise.resolve({
              data: null,
              error: { message: "Conexión rechazada por base de datos" },
            }),
        }),
      }),
    }));

    const req = new NextRequest("http://localhost:3000/api/alertas-riesgo/manual", {
      method: "POST",
      body: JSON.stringify({ estudianteId: "est-123" }),
    });

    const res = await POST(req);
    const data = await res.json();

    expect(res.status).toBe(500);
    expect(data.error).toContain("No se pudo consultar el estudiante");
    expect(mockSendMail).not.toHaveBeenCalled();
  });

  // API-08: Historial
  it("API-08: Consulta de historial con GET en la ruta de alertas manuales", async () => {
    // La especificación requiere consultar historial con filtros y límites.
    // EVALUACIÓN DE DEFECTO: La ruta manual/route.ts SOLO implementa POST. No exporta GET para consultar historial.
    const routeModule = await import("./route");
    const hasGetHandler = typeof (routeModule as any).GET === "function";

    // El criterio del plan exige un endpoint con capacidad de consulta de historial.
    // Si no está implementado, esta prueba falla y evidencia el faltante:
    expect(hasGetHandler).toBe(true);
  });

  // API-09: SMTP fallido
  it("API-09: Fallo en SMTP no marca envío exitoso ni persiste inserción en base de datos", async () => {
    mockGetPerfil.mockResolvedValue({
      id: "usr-coord",
      nombre_completo: "Coord",
      correo: "c@colegio.edu.co",
      rol: "coordinador",
      profesor_id: null,
      estudiante_id: null,
    });

    const mockInsert = vi.fn();

    mockSupabaseFrom.mockImplementation((table: string) => {
      if (table === "estudiantes") {
        return {
          select: () => ({
            eq: () => ({
              maybeSingle: () =>
                Promise.resolve({
                  data: {
                    id: "est-smtp-fail",
                    nombre_completo: "Alumno Smtp",
                    curso_id: "c-1",
                    estrato: 1,
                    graves: 2,
                    cursos: { nombre: "4A" },
                  },
                  error: null,
                }),
            }),
          }),
        };
      }
      if (table === "perfiles") {
        return {
          select: () => ({
            eq: () => ({
              eq: () => ({
                maybeSingle: () =>
                  Promise.resolve({
                    data: { correo: "acudiente@correo.com" },
                    error: null,
                  }),
              }),
            }),
          }),
        };
      }
      if (table === "calificaciones") {
        return {
          select: () => ({
            eq: () => Promise.resolve({ data: [{ periodo: 1, nota: 1.0 }], error: null }),
          }),
        };
      }
      if (table === "asistencias") {
        return {
          select: () => ({
            eq: () => Promise.resolve({ data: [], error: null }),
          }),
        };
      }
      if (table === "alertas_riesgo_email") {
        return {
          delete: () => ({
            eq: () => ({
              gte: () => ({
                lt: () => Promise.resolve({ error: null }),
              }),
            }),
          }),
          insert: mockInsert,
        };
      }
      return {};
    });

    mockSendMail.mockRejectedValueOnce(new Error("SMTP Connection Timeout: 535 Authentication failed"));

    const req = new NextRequest("http://localhost:3000/api/alertas-riesgo/manual", {
      method: "POST",
      body: JSON.stringify({ estudianteId: "est-smtp-fail" }),
    });

    const res = await POST(req);
    const data = await res.json();

    expect(res.status).toBe(500);
    expect(data.error).toContain("No fue posible enviar la alerta");
    expect(mockInsert).not.toHaveBeenCalled();
  });

  // API-10: SMTP exitoso
  it("API-10: Envío SMTP correcto persiste registro con huella y fecha de envío", async () => {
    mockGetPerfil.mockResolvedValue({
      id: "usr-coord",
      nombre_completo: "Coord",
      correo: "c@colegio.edu.co",
      rol: "coordinador",
      profesor_id: null,
      estudiante_id: null,
    });

    const mockInsert = vi.fn().mockResolvedValue({ error: null });

    mockSupabaseFrom.mockImplementation((table: string) => {
      if (table === "estudiantes") {
        return {
          select: () => ({
            eq: () => ({
              maybeSingle: () =>
                Promise.resolve({
                  data: {
                    id: "est-ok",
                    nombre_completo: "Alumno Exitoso",
                    curso_id: "c-1",
                    estrato: 1,
                    graves: 1,
                    cursos: { nombre: "4A" },
                  },
                  error: null,
                }),
            }),
          }),
        };
      }
      if (table === "perfiles") {
        return {
          select: () => ({
            eq: () => ({
              eq: () => ({
                maybeSingle: () =>
                  Promise.resolve({
                    data: { correo: "acudiente@correo.com" },
                    error: null,
                  }),
              }),
            }),
          }),
        };
      }
      if (table === "calificaciones") {
        return {
          select: () => ({
            eq: () => Promise.resolve({ data: [{ periodo: 1, nota: 2.0 }], error: null }),
          }),
        };
      }
      if (table === "asistencias") {
        return {
          select: () => ({
            eq: () => Promise.resolve({ data: [], error: null }),
          }),
        };
      }
      if (table === "alertas_riesgo_email") {
        return {
          delete: () => ({
            eq: () => ({
              gte: () => ({
                lt: () => Promise.resolve({ error: null }),
              }),
            }),
          }),
          insert: mockInsert,
        };
      }
      return {};
    });

    const req = new NextRequest("http://localhost:3000/api/alertas-riesgo/manual", {
      method: "POST",
      body: JSON.stringify({ estudianteId: "est-ok" }),
    });

    const res = await POST(req);
    const data = await res.json();

    expect(res.status).toBe(200);
    expect(data.ok).toBe(true);
    expect(mockInsert).toHaveBeenCalledTimes(1);
    const callArgs = mockInsert.mock.calls[0][0];
    expect(callArgs.estado).toBe("enviado");
    expect(callArgs.huella).toBeDefined();
    expect(callArgs.destinatario).toBe("acudiente@correo.com");
  });

  // API-11: Duplicados en periodo
  it("API-11: Repetición de solicitud en la misma semana reemplaza registros anteriores para evitar duplicados", async () => {
    mockGetPerfil.mockResolvedValue({
      id: "usr-coord",
      nombre_completo: "Coord",
      correo: "c@colegio.edu.co",
      rol: "coordinador",
      profesor_id: null,
      estudiante_id: null,
    });

    const mockDelete = vi.fn().mockReturnValue({
      eq: vi.fn().mockReturnValue({
        gte: vi.fn().mockReturnValue({
          lt: vi.fn().mockResolvedValue({ error: null }),
        }),
      }),
    });

    mockSupabaseFrom.mockImplementation((table: string) => {
      if (table === "estudiantes") {
        return {
          select: () => ({
            eq: () => ({
              maybeSingle: () =>
                Promise.resolve({
                  data: {
                    id: "est-dup",
                    nombre_completo: "Alumno Dup",
                    curso_id: "c-1",
                    graves: 2,
                    cursos: { nombre: "4A" },
                  },
                  error: null,
                }),
            }),
          }),
        };
      }
      if (table === "perfiles") {
        return {
          select: () => ({
            eq: () => ({
              eq: () => ({
                maybeSingle: () =>
                  Promise.resolve({
                    data: { correo: "acudiente@correo.com" },
                    error: null,
                  }),
              }),
            }),
          }),
        };
      }
      if (table === "calificaciones") {
        return {
          select: () => ({
            eq: () => Promise.resolve({ data: [{ periodo: 1, nota: 1.0 }], error: null }),
          }),
        };
      }
      if (table === "asistencias") {
        return {
          select: () => ({
            eq: () => Promise.resolve({ data: [], error: null }),
          }),
        };
      }
      if (table === "alertas_riesgo_email") {
        return {
          delete: mockDelete,
          insert: vi.fn().mockResolvedValue({ error: null }),
        };
      }
      return {};
    });

    const req = new NextRequest("http://localhost:3000/api/alertas-riesgo/manual", {
      method: "POST",
      body: JSON.stringify({ estudianteId: "est-dup" }),
    });

    const res = await POST(req);
    expect(res.status).toBe(200);
    expect(mockDelete).toHaveBeenCalledTimes(1);
  });

  // API-12: Método incorrecto
  it("API-12: Métodos HTTP no soportados (ej. PUT, DELETE) no están exportados en la ruta", async () => {
    const routeModule = await import("./route");

    expect((routeModule as any).PUT).toBeUndefined();
    expect((routeModule as any).DELETE).toBeUndefined();
    expect((routeModule as any).PATCH).toBeUndefined();
  });
});
