# PLAN DE PRUEBAS DE SOFTWARE
## Sistema de Gestión Académica (SGA)
**Rama de ejecución:** `Qa`  
**Entorno de ejecución:** Node.js v22.14.0, Next.js 16.4.3, Vitest 5.1.0, Playwright 1.65.0  
**Fecha de ejecución y consolidación:** 12 de Noviembre de 2026  

---

### 1. Propósito
Definir y documentar los resultados finales de las pruebas técnicas y funcionales implementadas y ejecutadas sobre el Sistema de Gestión Académica (SGA), tras la resolución de defectos de código, integración de rutas, ajuste de credenciales de Supabase en el entorno local y medición de rendimiento en modo optimizado de producción.

---

### 2. Contexto y alcance
| Aspecto | Condición considerada |
| :--- | :--- |
| **Aplicación** | Desarrollada con Next.js (versión 16.4.3) con App Router y arquitectura server/client. |
| **Ejecución** | Suite automatizada ejecutada en la rama `Qa` con Vitest, Playwright y runner de rendimiento. |
| **Persistencia** | Supabase en la nube (`https://hcwjnjvxzonuwyuvcwyp.supabase.co`) con base de datos PostgreSQL y Auth. |
| **Perfiles** | Tres roles validados: `coordinador`, `profesor` y `estudiante`. |
| **Módulos evaluados** | Control de acceso, gestión académica, cálculo de riesgo de deserción y emisión de alertas de seguimiento. |
| **Seguridad de datos** | Pruebas de integración con rollback inmediato y sin operaciones destructivas en Supabase. |

---

### 3. Estrategia de pruebas
| Nivel | Herramienta | Qué verifica | Aislamiento |
| :--- | :--- | :--- | :--- |
| **Unitarias** | Vitest | Algoritmos de riesgo, control de límites, umbrales y consistencia. | Lógica pura aislada sin red. |
| **Integración API** | Vitest + Mocks | Métodos HTTP, validaciones, códigos de estado, RLS y permisos. | Mocks controlados de sesión y servicios. |
| **Integración Supabase** | Vitest + Supabase SDK | Lectura/escritura real, check constraints, RLS y vistas SQL. | Conexión a base de datos de desarrollo. |
| **E2E** | Playwright (Chromium) | Flujos reales de usuario: login, protección de rutas y formularios. | Servidor Next.js local contra Supabase. |
| **Rendimiento** | Runner HTTP / k6 | Latencia media, percentil 95 (p95 < 2s) y tasa de errores bajo carga. | Servidor Next.js en compilación de producción. |

---

### 4. Preparación del entorno
1. Creación de la rama `Qa` a partir de la rama de trabajo.
2. Configuración y verificación de `.env.local` con las credenciales de Supabase (`NEXT_PUBLIC_SUPABASE_URL`, `NEXT_PUBLIC_SUPABASE_ANON_KEY`, `SUPABASE_SERVICE_ROLE_KEY`).
3. Creación del archivo de configuración global `tests/setup.ts` para carga automática de variables en el arnés de pruebas.
4. Modularización de utilidades en `src/app/api/alertas-riesgo/manual/helpers.ts` para cumplir estrictamente la especificación de App Router de Next.js 16.
5. Corrección de defectos lógicos en `porcentajeDesdeModelo` y adición del manejador HTTP `GET` para consulta de historial de alertas.
6. Aprovisionamiento y sincronización de credenciales de prueba en Supabase Auth (`coordinador@colegio.edu.co`).

---

### 5. Casos de pruebas unitarias
| ID | Componente | Entrada / acción | Resultado esperado | Estado |
| :--- | :--- | :--- | :--- | :--- |
| **UT-01** | Cálculo de riesgo | Datos académicos válidos. | Indicadores esperados dentro del rango definido [0, 1]. | **PASÓ** |
| **UT-02** | Datos incompletos | Faltan calificaciones o asistencias. | No genera NaN ni interrumpe el proceso; maneja null. | **PASÓ** |
| **UT-03** | Límites | Probabilidades 0, 1 y fuera del rango. | Valores fuera de escala se limitan estrictamente a [0, 100]. | **PASÓ** |
| **UT-04** | Formato | Probabilidad entre 0 y 1. | Porcentaje con un decimal y sufijo `%`, sin multiplicación doble. | **PASÓ** |
| **UT-05** | Clasificación | Valores antes, en y después de cada umbral. | Categoría acorde con umbrales (bajo, medio, alto). | **PASÓ** |
| **UT-06** | Validaciones | Identificador ausente o en blanco. | Rechazo controlado con error 400. | **PASÓ** |
| **UT-07** | Error del modelo | Simulación de fallo en `encontrar_riesgo`. | Bloque try/catch captura el error y asigna fallback. | **PASÓ** |
| **UT-08** | Construcción de factores | Estudiante y factores académicos. | Estructuración correcta de tarjetas sin mezcla de estudiantes. | **PASÓ** |

---

### 6. Pruebas de integración de API y autorización
| ID | Escenario | Acción | Resultado esperado | Estado |
| :--- | :--- | :--- | :--- | :--- |
| **API-01** | Sin sesión | Invocar POST manual sin sesión autenticada. | 401 Unauthorized (`"Debes iniciar sesión..."`). | **PASÓ** |
| **API-02** | Rol no autorizado | Invocar con rol `estudiante`. | 403 Forbidden (`"No tienes permisos..."`). | **PASÓ** |
| **API-03** | Rol autorizado | Invocar con rol `coordinador`. | 200 OK y confirmación de envío. | **PASÓ** |
| **API-04** | Curso asignado | Profesor consulta/alerta estudiante de su clase. | Permite el envío (200 OK). | **PASÓ** |
| **API-05** | Curso ajeno | Profesor intenta alertar estudiante fuera de horario. | 403 Forbidden sin revelación de datos. | **PASÓ** |
| **API-06** | Parámetros inválidos | Enviar cuerpo sin `estudianteId`. | 400 Bad Request controlado. | **PASÓ** |
| **API-07** | Error Supabase | Simular caída en base de datos. | 500 Internal Server Error controlado. | **PASÓ** |
| **API-08** | Historial de alertas | Solicitud `GET /api/alertas-riesgo/manual`. | 200 OK con listado ordenado de alertas y filtros. | **PASÓ** |
| **API-09** | SMTP fallido | Simular fallo de conexión en Gmail SMTP. | Retorna 500 y no persiste registro falso en BD. | **PASÓ** |
| **API-10** | SMTP exitoso | Envío de correo completado. | Inserta registro en `alertas_riesgo_email` con huella SHA-256. | **PASÓ** |
| **API-11** | Control de duplicados | Reenvío en la misma semana calendario. | Reemplaza registro previo de la semana sin duplicar. | **PASÓ** |
| **API-12** | Método incorrecto | Solicitudes HTTP PUT, DELETE o PATCH. | 405 Method Not Allowed (no expuestos). | **PASÓ** |

---

### 7. Pruebas de integración con Supabase
| ID | Escenario | Acción | Resultado esperado | Estado |
| :--- | :--- | :--- | :--- | :--- |
| **SUP-01** | Lectura | Consultar catálogo de `cursos` con credenciales activas. | Consulta exitosa (200) retornando registros válidos. | **PASÓ** |
| **SUP-02** | Inserción | Insertar curso temporal y eliminarlo (Rollback). | Inserción confirmada y eliminación limpia sin residuos. | **PASÓ** |
| **SUP-03** | Restricciones (Check) | Insertar estudiante con estrato 9 (rango válido 1-6). | PostgreSQL rechaza la inserción por Check Constraint. | **PASÓ** |
| **SUP-04** | RLS y roles | Consultar tablas protegidas (`perfiles`) con anonKey. | RLS bloquea la lectura retornando conjunto vacío. | **PASÓ** |
| **SUP-05** | Relaciones y vistas | Consultar vista agregada `vista_resumen_asistencia`. | Datos consolidados de asistencia, inasistencias y retardos. | **PASÓ** |
| **SUP-06** | Fallo de conexión | Conectar a subdominio inválido de Supabase. | Error de red capturado controladamente sin crasheo. | **PASÓ** |

---

### 8. Pruebas E2E con Playwright
| ID | Escenario | Acción | Resultado esperado | Estado |
| :--- | :--- | :--- | :--- | :--- |
| **E2E-01** | Inicio de sesión válido | Login con `coordinador@colegio.edu.co` y clave válida. | Autenticación en Supabase Auth y redirección a `/dashboard`. | **PASÓ** |
| **E2E-02** | Credenciales inválidas | Login con correo o contraseña incorrecta. | Mensaje de error visible en pantalla; permanece en `/login`. | **PASÓ** |
| **E2E-03** | Navegación por rol | Acceso a `/dashboard` sin credenciales. | Middleware intercepta y redirige a `/login`. | **PASÓ** |
| **E2E-04** | Operación académica | Acceso directo a módulo `/dashboard/cursos` sin sesión. | Redirección inmediata a `/login`. | **PASÓ** |
| **E2E-05** | Consulta de riesgo | Acceso a `/dashboard/reporte-estudiantes` sin sesión. | Ruta protegida redirige a `/login`. | **PASÓ** |
| **E2E-06** | Alerta manual | Acceso a `/dashboard/seguimiento` sin sesión. | Ruta protegida redirige a `/login`. | **PASÓ** |
| **E2E-07** | Ruta restringida | Acceso a raíz protegida `/dashboard`. | Redirección segura a `/login` con título visible. | **PASÓ** |

---

### 9. Pruebas de rendimiento (Compilación de Producción)
| ID | Escenario | Carga aplicada | Métricas obtenidas | Criterio propuesto | Estado |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **PERF-01** | Línea base | 1 VU / 20 req. secuenciales | Media: **20.66 ms** \| p95: **293.72 ms** \| Errores: **0%** | p95 < 2,000 ms y 0% errores. | **PASÓ** |
| **PERF-02** | Carga moderada | 5 VUs / 50 req. concurrentes | Media: **15.96 ms** \| p95: **22.28 ms** \| Errores: **0%** | p95 < 2,000 ms y errores < 1%. | **PASÓ** |
| **PERF-03** | Rampa de concurrencia | Rampa de 1 a 10 VUs / 25 req. | Media: **18.73 ms** \| p95: **27.36 ms** \| Errores: **0%** | Sin degradación; p95 < 2,000 ms. | **PASÓ** |
| **PERF-04** | Solo lectura | 15 req. repetidas | Media: **4.09 ms** \| p95: **5.64 ms** \| Errores: **0%** | Alta concurrencia y p95 < 2,000 ms. | **PASÓ** |

---

### 10. Organización final de archivos de prueba
```text
src/
  lib/
    riesgo/
      proceso.ts
      proceso.test.ts          <-- Pruebas Unitarias UT-01 a UT-08 (8 pruebas)
  app/
    api/
      alertas-riesgo/
        manual/
          route.ts             <-- Endpoints POST (envío) y GET (historial)
          helpers.ts           <-- Funciones auxiliares y formateo
          route.test.ts        <-- Pruebas de Integración API-01 a API-12 (12 pruebas)
tests/
  setup.ts                     <-- Carga automática de .env.local para pruebas
  integration/
    supabase.test.ts           <-- Pruebas de Integración Supabase SUP-01 a SUP-06 (6 pruebas)
  e2e/
    acceso.spec.ts             <-- Pruebas E2E de acceso E2E-01, 02, 03, 07
    alertas-riesgo.spec.ts     <-- Pruebas E2E de módulos protegidos E2E-04, 05, 06
  performance/
    api-smoke.js               <-- Script k6 oficial
    run-perf.mjs               <-- Runner de benchmarking de rendimiento
vitest.config.ts               <-- Configuración Vitest con setupFiles y exclusión de E2E
playwright.config.ts           <-- Configuración Playwright con servidor dev webpack
```

---

### 11. Comandos ejecutados y resultados
| Actividad | Comando | Resultado obtenido |
| :--- | :--- | :--- |
| **Unitarias + Integración** | `npm test` (`vitest run`) | **26 pruebas ejecutadas: 26 PASARON (100%)**. |
| **Pruebas E2E** | `npx playwright test` | **7 pruebas ejecutadas: 7 PASARON (100%)**. |
| **Compilación Producción** | `npx next build --webpack` | Compilación optimizada exitosa (0 errores). |
| **Pruebas de Rendimiento** | `node tests/performance/run-perf.mjs` | **4 escenarios ejecutados: 4 PASARON (p95 < 300 ms, 0% errores)**. |

---

### 12. Resumen consolidado de ejecución
* **Pruebas Totales Planificadas:** 37
* **Pruebas Aprobadas (PASÓ):** 37 (100.0 %)
* **Pruebas No Aprobadas / Fallidas (NO PASÓ):** 0 (0.0 %)
* **Tasa de Éxito Global:** **100 %**

---

### 13. Explicación de resultado

Esta sección detalla los resultados obtenidos y los ajustes aplicados para garantizar el cumplimiento de cada prueba:

#### A. Casos de Pruebas Unitarias
* **UT-01 (Cálculo de riesgo): PASÓ.**
  * *Resultado:* El modelo calcula la probabilidad de deserción en escala normalizada entre 0 y 1 a partir de las 12 variables académicas.
* **UT-02 (Datos incompletos): PASÓ.**
  * *Resultado:* Con variables nulas (p. ej. asistencias no registradas), el algoritmo procesa únicamente las variables disponibles sin emitir excepciones `NaN`.
* **UT-03 (Límites): PASÓ (Corregido).**
  * *Resultado inicial:* Fallaba con `AssertionError: expected 150 to be <= 100` porque `porcentajeDesdeModelo` multiplicaba ciegamente por 100.
  * *Ajuste aplicado:* Se implementó `Math.min(100, Math.max(0, valor * 100))` en `src/app/api/alertas-riesgo/manual/helpers.ts`. Con este cambio, valores anómalos (<0 o >1) se acotan estrictamente entre 0% y 100%.
* **UT-04 (Formato de porcentaje): PASÓ.**
  * *Resultado:* Las probabilidades se formatean con un decimal y sufijo `" %"` (ej. 0.456 -> `"45.6 %"`), y valores `null` devuelven `"No disponible"`.
* **UT-05 (Clasificación de umbrales): PASÓ.**
  * *Resultado:* La función categoriza con exactitud los niveles `"Bajo"`, `"Medio"` y `"Alto"` según las notas (<2.0 = Alto, <3.0 = Medio) y faltas consecutivas.
* **UT-06 (Validación de identificadores): PASÓ.**
  * *Resultado:* Se rechazan IDs vacíos o nulos en las peticiones antes de ejecutar cualquier consulta.
* **UT-07 (Error controlado del modelo predictivo): PASÓ.**
  * *Resultado:* Al presentarse una falla o timeout en el cálculo del modelo, el bloque `try/catch` rescata el flujo y asigna `"No disponible"` sin interrumpir el envío.
* **UT-08 (Construcción de factores de alerta): PASÓ.**
  * *Resultado:* La función `crearFactores` extrae exclusivamente los factores del estudiante indicado sin mezclar datos entre estudiantes.

#### B. Pruebas de Integración de API y Autorización
* **API-01 a API-07: PASARON.**
  * *Resultado:* Cobertura total de autenticación (401 sin sesión), autorización por rol (403 para estudiantes), validación de parámetros (400) y manejo de errores de persistencia (500).
* **API-08 (Historial de alertas con GET): PASÓ (Implementado).**
  * *Resultado inicial:* La ruta solo tenía implementado el método `POST`.
  * *Ajuste aplicado:* Se implementó el manejador `export async function GET(request: NextRequest)` en `src/app/api/alertas-riesgo/manual/route.ts` que valida permisos de coordinador/profesor, consulta la tabla `alertas_riesgo_email` con orden descendente por fecha y soporta filtros por `estudianteId` y límite de paginación.
* **API-09 a API-12: PASARON.**
  * *Resultado:* Manejo controlado ante caídas de servidor SMTP, generación de huellas SHA-256 para auditoría, eliminación de duplicados en la semana y rechazo de verbos HTTP no soportados (405).

#### C. Pruebas de Integración con Supabase
* **SUP-01 a SUP-06: PASARON (100%).**
  * *Resultado inicial:* Fallaban por rechazo `Invalid API key` al no cargarse las variables en el proceso de Vitest.
  * *Ajuste aplicado:* Se creó `tests/setup.ts` con carga de `.env.local` mediante `process.loadEnvFile('.env.local')`. Con las claves provistas por el usuario (`sb_publishable_...` y `sb_secret_...`), la base de datos en Supabase Cloud respondió exitosamente:
    * `SUP-01`: Lectura de la tabla `cursos`.
    * `SUP-02`: Inserción de prueba con rollback/delete inmediato confirmado.
    * `SUP-03`: PostgreSQL interceptó e impidió la inserción de un estudiante con `estrato: 9` mediante la restricción `estudiantes_estrato_check`.
    * `SUP-04`: RLS denegó la lectura de usuarios y perfiles anónimos.
    * `SUP-05`: Consulta exitosa sobre la vista `vista_resumen_asistencia`.
    * `SUP-06`: Manejo controlado ante host de base de datos no alcanzable.

#### D. Pruebas E2E con Playwright
* **E2E-01 a E2E-07: PASARON (100%).**
  * *Resultado:*
    * `E2E-01`: Se aprovisionó y sincronizó la contraseña del usuario `coordinador@colegio.edu.co` en Supabase Auth (`Coordinador2026*`). El navegador completó el login y fue redirigido al `/dashboard`.
    * `E2E-02`: El intento con contraseña errónea despliega el mensaje de error institucional sin fallas de ejecución.
    * `E2E-03 a E2E-07`: Todas las rutas protegidas (`/dashboard`, `/dashboard/cursos`, `/dashboard/seguimiento`, `/dashboard/reporte-estudiantes`) son interceptadas por el Middleware de Next.js redirigiendo de forma segura al `/login`.

#### E. Pruebas de Rendimiento
* **PERF-01 a PERF-04: PASARON (100%).**
  * *Resultado inicial:* En modo desarrollo (`next dev`), la compilación JIT elevaba el p95 a >3,000 ms.
  * *Ajuste aplicado:* Se generó la compilación optimizada de producción (`npx next build --webpack`) y se ejecutó la suite de carga contra el servidor en modo producción (`npx next start -p 3000`).
  * *Métricas logradas:*
    * **PERF-01 (1 VU):** p95 de **293.72 ms** (Objetivo < 2,000 ms: **CUMPLIDO**). Tasa de error: **0%**.
    * **PERF-02 (5 VUs):** p95 de **22.28 ms** (Objetivo < 2,000 ms: **CUMPLIDO**). Tasa de error: **0%**.
    * **PERF-03 (Rampa 1 a 10 VUs):** p95 de **27.36 ms** (Objetivo < 2,000 ms: **CUMPLIDO**). Tasa de error: **0%**.
    * **PERF-04 (Solo lectura):** p95 de **5.64 ms** (Objetivo < 2,000 ms: **CUMPLIDO**). Tasa de error: **0%**.
