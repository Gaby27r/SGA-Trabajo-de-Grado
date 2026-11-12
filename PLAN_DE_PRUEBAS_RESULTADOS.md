# PLAN DE PRUEBAS DE SOFTWARE
## Sistema de Gestión Académica (SGA)
**Rama de ejecución:** `Qa`  
**Entorno de ejecución:** Node.js v22.14.0, Next.js 16.4.3, Vitest 5.1.0, Playwright 1.65.0  
**Fecha de ejecución:** 12 de Noviembre de 2026  

---

### 1. Propósito
Definir y documentar los resultados de las pruebas técnicas y funcionales implementadas y ejecutadas sobre el SGA, con énfasis en pruebas automatizadas de código: lógica de negocio, rutas API, integración con Supabase, flujos de interfaz y rendimiento.

---

### 2. Contexto y alcance
| Aspecto | Condición considerada |
| :--- | :--- |
| **Aplicación** | Desarrollada con Next.js (versión 16.4.3). |
| **Ejecución** | Local mediante `npm run dev` y suite automatizada en rama `Qa`. |
| **Persistencia** | Supabase alojado en la nube (`https://hcwjnjvxzonuwyuvcwyp.supabase.co`). |
| **Perfiles** | Tres roles activos: `coordinador`, `profesor` y `estudiante`. |
| **Módulos relevantes** | Gestión académica, indicadores de riesgo de deserción y envío manual de alertas por correo. |
| **Límites** | No ejecutar carga intensiva destructiva contra Supabase real ni enviar correos masivos sin autorización. |

---

### 3. Estrategia de pruebas
| Nivel | Herramienta | Qué verifica | Aislamiento |
| :--- | :--- | :--- | :--- |
| **Unitarias** | Vitest | Funciones de riesgo, umbrales, validaciones, normalización y formato. | Sin red ni Supabase real; datos ficticios. |
| **Integración API** | Vitest + mocks | Métodos HTTP, autenticación, roles, permisos, respuestas y errores. | Mock de Supabase, SMTP y modelo predictivo. |
| **Integración Supabase** | Vitest + Supabase Client | Consultas, inserciones, restricciones, relaciones y políticas RLS. | Proyecto de desarrollo y rollback controlado. |
| **E2E** | Playwright | Inicio de sesión, navegación por rol, operaciones y alertas. | App local y usuarios de prueba. |
| **Rendimiento** | Runner de Carga / k6 | Latencia, p95, tasa de errores y concurrencia moderada. | Servidor local Next.js y endpoints reales. |

---

### 4. Preparación del entorno
1. Creación e inicialización de la nueva rama `Qa` en Git (`git checkout -b Qa`).
2. Configuración de credenciales de desarrollo en `.env.local`.
3. Instalación de dependencias de pruebas (`vitest`, `vite`, `@playwright/test`, Chromium headless).
4. Implementación de suites de pruebas en `src/lib/riesgo/proceso.test.ts`, `src/app/api/alertas-riesgo/manual/route.test.ts`, `tests/integration/supabase.test.ts`, `tests/e2e/acceso.spec.ts`, `tests/e2e/alertas-riesgo.spec.ts` y scripts de carga en `tests/performance/`.

---

### 5. Casos de pruebas unitarias
| ID | Componente | Entrada / acción | Resultado esperado | Estado |
| :--- | :--- | :--- | :--- | :--- |
| **UT-01** | Cálculo de riesgo | Datos académicos válidos. | Indicadores esperados y dentro del rango definido [0, 1]. | **PASÓ** |
| **UT-02** | Datos incompletos | Faltan calificaciones o asistencias. | Comportamiento definido; no genera NaN ni interrumpe el proceso. | **PASÓ** |
| **UT-03** | Límites | Probabilidades 0, 1 y fuera del rango. | Valores válidos se conservan; inválidos se controlan. | **NO PASÓ** |
| **UT-04** | Formato | Probabilidad entre 0 y 1. | Porcentaje correcto, sin multiplicar dos veces por 100. | **PASÓ** |
| **UT-05** | Clasificación | Valores antes, en y después de cada umbral. | Categoría acorde con los umbrales implementados (bajo, medio, alto). | **PASÓ** |
| **UT-06** | Validaciones | Identificador ausente o mal formado. | Error controlado; no ejecuta consultas innecesarias. | **PASÓ** |
| **UT-07** | Error del modelo | Predicción lanza excepción o no retorna datos. | Error controlado y salida definida por la aplicación. | **PASÓ** |
| **UT-08** | Construcción de alerta | Estudiante y factores válidos. | Alerta correcta y sin datos de otros estudiantes. | **PASÓ** |

---

### 6. Pruebas de integración de API y autorización
| ID | Escenario | Acción | Resultado esperado | Estado |
| :--- | :--- | :--- | :--- | :--- |
| **API-01** | Sin sesión | Invocar ruta protegida sin autenticación. | 401/403 según contrato; sin lectura/escritura. | **PASÓ** |
| **API-02** | Rol no autorizado | Acceder con rol sin permiso (ej: estudiante). | Acceso denegado (403); no ejecuta operación. | **PASÓ** |
| **API-03** | Rol autorizado | Acceder con rol permitido (coordinador). | Operación válida y respuesta documentada (200). | **PASÓ** |
| **API-04** | Curso asignado | Profesor consulta curso asignado. | Solo obtiene datos autorizados y permite envío. | **PASÓ** |
| **API-05** | Curso ajeno | Profesor consulta curso no asignado. | Acceso denegado (403) y sin filtración. | **PASÓ** |
| **API-06** | Parámetros inválidos | Enviar ID ausente o cuerpo incorrecto. | 400/422 o respuesta definida; sin error no controlado. | **PASÓ** |
| **API-07** | Error Supabase | Simular fallo de consulta/inserción. | Error controlado (500); no informa éxito falso. | **PASÓ** |
| **API-08** | Historial | Consultar alertas con filtros y límites. | Registros dentro del alcance permitido. | **NO PASÓ** |
| **API-09** | SMTP fallido | Simular fallo de correo. | No marca envío exitoso ni elimina datos prematuramente. | **PASÓ** |
| **API-10** | SMTP exitoso | Simular envío correcto. | Registra el resultado conforme a las reglas del sistema. | **PASÓ** |
| **API-11** | Duplicados | Repetir solicitud en el periodo definido. | No duplica envíos/registros indebidamente. | **PASÓ** |
| **API-12** | Método incorrecto | Usar método HTTP no soportado (ej. PUT, DELETE). | Respuesta 405 o método no exportado en ruta. | **PASÓ** |

---

### 7. Pruebas de integración con Supabase
| ID | Escenario | Acción | Resultado esperado | Estado |
| :--- | :--- | :--- | :--- | :--- |
| **SUP-01** | Lectura | Consultar datos con usuario autorizado. | Solo retorna registros permitidos. | **NO PASÓ** |
| **SUP-02** | Inserción | Insertar registro ficticio válido. | Guarda una vez y confirma operación. | **NO PASÓ** |
| **SUP-03** | Restricciones | Insertar datos inválidos/incompletos. | La aplicación o BD rechaza la operación por Check Constraint. | **NO PASÓ** |
| **SUP-04** | RLS y roles | Consultar con usuarios de roles distintos / anónimo. | No permite acceso fuera de permisos por directivas RLS. | **PASÓ** |
| **SUP-05** | Relaciones | Consultar notas/asistencias por estudiante y curso en vistas. | Relaciones y agregaciones correctas en vistas SQL. | **NO PASÓ** |
| **SUP-06** | Fallo de conexión | Simular fallo controlado de red hacia BD. | Error manejado sin datos incorrectos ni caídas no controladas. | **PASÓ** |

---

### 8. Pruebas E2E con Playwright
| ID | Escenario | Acción | Resultado esperado | Estado |
| :--- | :--- | :--- | :--- | :--- |
| **E2E-01** | Inicio de sesión | Ingresar con usuario válido. | Accede al área correspondiente al rol. | **NO PASÓ** |
| **E2E-02** | Credenciales inválidas | Intentar acceso con clave incorrecta. | Mensaje controlado; no inicia sesión. | **NO PASÓ** |
| **E2E-03** | Navegación por rol | Ingresar con cada rol existente. | Solo muestra/permite funciones autorizadas. | **NO PASÓ** |
| **E2E-04** | Operación académica | Realizar operación permitida con datos ficticios. | Interfaz confirma y datos persisten. | **NO PASÓ** |
| **E2E-05** | Consulta de riesgo | Abrir riesgo de estudiante de prueba. | Indicadores y estado se muestran correctamente. | **NO PASÓ** |
| **E2E-06** | Alerta manual | Ejecutar flujo con SMTP simulado. | Interfaz refleja éxito o fallo de la API. | **NO PASÓ** |
| **E2E-07** | Ruta restringida | Abrir URL de pantalla no autorizada sin sesión. | Redirige al login (`/login`) sin revelar información. | **NO PASÓ** |

---

### 9. Pruebas de rendimiento con k6
| ID | Carga inicial | Métricas obtenidas | Criterio propuesto | Estado |
| :--- | :--- | :--- | :--- | :--- |
| **PERF-01** | 1 usuario virtual / 20 req. | Media: 3,105.70 ms \| p95: 5,118.00 ms \| Errores: 50% | Línea base reproducible (p95 < 2 s). | **NO PASÓ** |
| **PERF-02** | 5 usuarios virtuales / 50 req. | Media: 1,414.26 ms \| p95: 2,452.39 ms \| Errores: 0% | p95 < 2 s y errores < 1%. | **NO PASÓ** |
| **PERF-03** | Rampa de 1 a 10 usuarios / 25 req. | Media: 1,919.46 ms \| p95: 2,186.84 ms \| Errores: 0% | Sin fallos inesperados ni latencia sostenida. | **NO PASÓ** |
| **PERF-04** | Solicitudes repetidas de solo lectura (15 req.) | Media: 687.82 ms \| p95: 2,688.65 ms \| Errores: 0% | Consistencia en respuestas y p95 < 2 s. | **NO PASÓ** |

---

### 10. Organización sugerida de archivos
```text
src/
  lib/
    riesgo/
      proceso.ts
      proceso.test.ts          <-- Pruebas Unitarias UT-01 a UT-08
  app/
    api/
      alertas-riesgo/
        manual/
          route.ts
          route.test.ts        <-- Pruebas de Integración API-01 a API-12
tests/
  integration/
    supabase.test.ts           <-- Pruebas de Integración Supabase SUP-01 a SUP-06
  e2e/
    acceso.spec.ts             <-- Pruebas E2E de acceso E2E-01, 02, 03, 07
    alertas-riesgo.spec.ts     <-- Pruebas E2E de riesgo E2E-04, 05, 06
  performance/
    api-smoke.js               <-- Script k6 oficial
    run-perf.mjs               <-- Runner de benchmarking empírico de latencia
vitest.config.ts               <-- Configuración Vitest
playwright.config.ts           <-- Configuración Playwright
```

---

### 11. Comandos ejecutados
| Actividad | Comando | Nota |
| :--- | :--- | :--- |
| **Unitarias** | `npx vitest run src/lib/riesgo/proceso.test.ts` | 8 pruebas ejecutadas (7 pasaron, 1 falló). |
| **Integración API** | `npx vitest run src/app/api/alertas-riesgo/manual/route.test.ts` | 12 pruebas ejecutadas (11 pasaron, 1 falló). |
| **Integración Supabase**| `npx vitest run tests/integration/supabase.test.ts` | 6 pruebas ejecutadas (2 pasaron, 4 fallaron). |
| **Pruebas E2E** | `npx playwright test` | 7 pruebas ejecutadas (7 fallaron por entorno/claves). |
| **Rendimiento** | `node tests/performance/run-perf.mjs` | 110 solicitudes ejecutadas; p95 > 2s en todas. |

---

### 12. Criterios de entrada y salida
* **Criterios de entrada:** Cumplidos. Entorno configurado, rama `Qa` creada, dependencias de pruebas instaladas y scripts listos.
* **Criterios de salida:** Cumplidos con registro exhaustivo de bloqueos y defectos detectados en el código y configuración.

---

### 13. Resumen consolidado de ejecución
* **Pruebas Totales Planificadas:** 37
* **Pruebas Aprobadas (PASÓ):** 20 (54.05 %)
* **Pruebas No Aprobadas / Bloqueadas (NO PASÓ):** 17 (45.95 %)
  * **Defectos de Lógica / Código de Aplicación:** 2 (`UT-03`, `API-08`)
  * **Bloqueo de Autenticación Supabase Cloud (`Invalid API key`):** 11 (`SUP-01`, `SUP-02`, `SUP-03`, `SUP-05`, `E2E-01`, `E2E-02`, `E2E-03`, `E2E-04`, `E2E-05`, `E2E-06`, `E2E-07`)
  * **Incumplimiento de Umbrales de Rendimiento (p95 > 2s) y ausencia de binario k6:** 4 (`PERF-01`, `PERF-02`, `PERF-03`, `PERF-04`)

---

### 14. Evidencias para entregar
* Consola Vitest de pruebas unitarias (`proceso.test.ts`):
  * `UT-01`, `UT-02`, `UT-04`, `UT-05`, `UT-06`, `UT-07`, `UT-08`: **PASARON**.
  * `UT-03`: **FALLÓ** (`AssertionError: expected 150 to be less than or equal to 100`).
* Consola Vitest de API (`route.test.ts`):
  * `API-01` a `API-07`, `API-09` a `API-12`: **PASARON**.
  * `API-08`: **FALLÓ** (`AssertionError: expected false to be true`).
* Consola Vitest de Supabase (`supabase.test.ts`):
  * `SUP-04`, `SUP-06`: **PASARON**.
  * `SUP-01`, `SUP-02`, `SUP-03`, `SUP-05`: **FALLARON** con mensaje de Supabase: `Invalid API key`.
* Consola Playwright (`acceso.spec.ts`, `alertas-riesgo.spec.ts`):
  * 7 pruebas fallaron debido a error 500 del servidor generado al consultar `supabase.auth.getUser()` con clave inválida en el middleware, impidiendo redirecciones a `/login` y renderizado de componentes.
* Consola de Rendimiento (`run-perf.mjs`):
  * 110 transacciones con reporte p95: 5,118 ms (PERF-01), 2,452 ms (PERF-02), 2,186 ms (PERF-03), 2,688 ms (PERF-04).

---

### 15. Explicación de resultado

Esta sección detalla el resultado obtenido en cada caso de prueba y expone el motivo técnico por el cual no pasó la prueba cuando correspondió:

#### A. Casos de Pruebas Unitarias
* **UT-01 (Cálculo de riesgo): PASÓ.**
  * *Resultado:* Con datos completos y válidos, la función `posible_riesgo_estudiante` calculó el índice y probabilidad de deserción de manera exacta dentro del intervalo `[0, 1]`.
* **UT-02 (Datos incompletos): PASÓ.**
  * *Resultado:* Al suministrar registros con valores `null` en asistencias o notas, el algoritmo calculó el riesgo utilizando exclusivamente las variables disponibles sin producir `NaN` ni interrumpir la ejecución. Si todas son nulas, devuelve `null` de forma controlada.
* **UT-03 (Límites): NO PASÓ.**
  * *Resultado obtenido:* Fallo de aserción (`AssertionError: expected 150 to be less than or equal to 100`).
  * *¿Por qué no pasó la prueba?:* La función `porcentajeDesdeModelo(valor)` ubicada en `src/app/api/alertas-riesgo/manual/route.ts` realiza únicamente `return valor * 100;` sin validar ni limitar el rango `[0, 1]`. Si el modelo o un factor externo entrega un valor fuera de rango (por ejemplo `1.5` o `-0.2`), la función retorna `150` o `-20`, violando el criterio de control de límites establecido en el plan de pruebas. Requiere aplicar `Math.min(100, Math.max(0, valor * 100))` o la utilidad `limitar()`.
* **UT-04 (Formato): PASÓ.**
  * *Resultado:* Valores decimales válidos entre 0 y 1 se transformaron al porcentaje correspondiente con un decimal y sufijo ` %` sin duplicación de escala (ej. 0.456 -> `45.6 %`).
* **UT-05 (Clasificación): PASÓ.**
  * *Resultado:* La función `generarFactoresPreocupacion` clasificó correctamente los factores en `bajo`, `medio` y `alto` evaluando las condiciones en los límites exactos de los umbrales (2 ausencias = sin alerta; 3 ausencias = nivel medio; 5 ausencias = nivel alto; notas < 3.0 = medio; notas < 2.0 = alto).
* **UT-06 (Validaciones de identificador): PASÓ.**
  * *Resultado:* Se verificó el rechazo de identificadores vacíos, nulos o cadenas en blanco (`status: 400`). Sin embargo, se identificó como observación de seguridad que el código no valida expresiones regulares para UUID v4 antes de consultar la base de datos, lo que generaría un error de sintaxis en PostgreSQL si llega un formato malicioso no vacío.
* **UT-07 (Error del modelo): PASÓ.**
  * *Resultado:* Al simular una caída o excepción en la ejecución del modelo predictivo (`encontrar_riesgo`), el bloque `try/catch` de la ruta lo capturó, registró el fallo y continuó el flujo de alerta asignando el texto por defecto `"No disponible"` sin abortar el proceso.
* **UT-08 (Construcción de alerta): PASÓ.**
  * *Resultado:* La función `crearFactores` estructuró las tarjetas de alerta conteniendo estrictamente la información académica y disciplinaria del estudiante en cuestión, sin filtrar factores de estudiantes ajenos.

#### B. Pruebas de Integración de API y Autorización
* **API-01 (Sin sesión): PASÓ.**
  * *Resultado:* Al invocar `POST /api/alertas-riesgo/manual` sin sesión autenticada (`getPerfil() = null`), la API respondió inmediatamente `401 Unauthorized` con el mensaje `"Debes iniciar sesión para enviar una alerta."`.
* **API-02 (Rol no autorizado): PASÓ.**
  * *Resultado:* Al invocar la ruta con un perfil autenticado con rol `estudiante`, la API denegó el acceso con código `403 Forbidden` (`"No tienes permisos para enviar alertas de seguimiento."`).
* **API-03 (Rol autorizado): PASÓ.**
  * *Resultado:* Con el rol `coordinador`, la API procesó los datos, invocó el transporte de correo y confirmó la operación con código `200 OK` y `{ ok: true }`.
* **API-04 (Curso asignado para profesor): PASÓ.**
  * *Resultado:* Al autenticarse como `profesor` sobre un estudiante perteneciente a su horario de clases asignado (`horario_clases`), la API validó la relación y aprobó el envío de la alerta (`200 OK`).
* **API-05 (Curso ajeno para profesor): PASÓ.**
  * *Resultado:* Al intentar alertar sobre un estudiante de un curso que el profesor no imparte, la API retornó `403 Forbidden` (`"No tienes permiso para enviar alertas a este estudiante."`), impidiendo la fuga de información.
* **API-06 (Parámetros inválidos): PASÓ.**
  * *Resultado:* Al enviar un cuerpo JSON vacío o sin la propiedad `estudianteId`, la API respondió con código `400 Bad Request` (`"Debes indicar un estudianteId válido."`).
* **API-07 (Error en Supabase): PASÓ.**
  * *Resultado:* Al forzar un error en la base de datos al consultar el estudiante, la API capturó la falla y devolvió `500 Internal Server Error` controlado, sin emitir falsos positivos de éxito ni intentar enviar correos.
* **API-08 (Consulta de historial de alertas): NO PASÓ.**
  * *Resultado obtenido:* Fallo de aserción (`AssertionError: expected false to be true`).
  * *¿Por qué no pasó la prueba?:* El plan de pruebas requiere que la ruta soporte la consulta del historial de alertas enviadas mediante filtros y límites. Sin embargo, el archivo `src/app/api/alertas-riesgo/manual/route.ts` **únicamente exporta el método `POST`**. No tiene implementado el método `GET` para consultar los registros de la tabla `alertas_riesgo_email`. Al no existir la función `GET`, la API rechaza cualquier solicitud de lectura con `405 Method Not Allowed`, no cumpliendo la especificación requerida.
* **API-09 (SMTP fallido): PASÓ.**
  * *Resultado:* Al simular un error en el servidor SMTP de Gmail (`Authentication failed` o `Timeout`), el error ocurrió antes de la inserción en la base de datos, devolviendo `500` y garantizando que no se marquen alertas como enviadas falsamente.
* **API-10 (SMTP exitoso): PASÓ.**
  * *Resultado:* Tras un envío de correo exitoso, el sistema generó la huella digital SHA-256 de los datos de la alerta y la insertó en `alertas_riesgo_email` con estado `'enviado'` y marca de tiempo.
* **API-11 (Control de duplicados): PASÓ.**
  * *Resultado:* Al reintentar la solicitud para el mismo estudiante dentro de la misma semana calendario, la API eliminó previamente los registros de esa semana antes de insertar el nuevo envío, evitando la acumulación de registros duplicados en el historial semanal.
* **API-12 (Método HTTP incorrecto): PASÓ.**
  * *Resultado:* Métodos HTTP no admitidos como `PUT`, `DELETE` o `PATCH` no se encuentran exportados en la ruta, por lo que el enrutador de Next.js los deniega con `405 Method Not Allowed`.

#### C. Pruebas de Integración con Supabase
* **SUP-01 (Lectura de cursos): NO PASÓ.**
  * *Resultado obtenido:* `AssertionError: expected { message: 'Invalid API key' } to be null`.
  * *¿Por qué no pasó la prueba?:* Las credenciales configuradas en el archivo `.env.local` (`NEXT_PUBLIC_SUPABASE_ANON_KEY` y `SUPABASE_SERVICE_ROLE_KEY`) fueron rechazadas por la instancia remota de Supabase con el mensaje `"Invalid API key"`. La clave provista en el repositorio ha sido revocada o expiró, impidiendo la lectura directa del catálogo de cursos.
* **SUP-02 (Inserción de prueba): NO PASÓ.**
  * *Resultado obtenido:* `AssertionError: expected { message: 'Invalid API key' } to be null`.
  * *¿Por qué no pasó la prueba?:* Por la misma causa que `SUP-01`, la inserción de registros de prueba contra la tabla `cursos` no pudo autenticarse contra la API de Supabase en la nube.
* **SUP-03 (Restricciones y Check Constraints): NO PASÓ.**
  * *Resultado obtenido:* Se esperaba violación del Check Constraint de estrato (`check (estrato between 1 and 6)`), pero la base de datos abortó antes de la evaluación del constraint debido al rechazo de la clave API (`Invalid API key`).
* **SUP-04 (Políticas RLS en tablas protegidas): PASÓ.**
  * *Resultado:* Se verificó que las consultas sin credenciales válidas o de clientes anónimos sobre tablas con RLS activo (`perfiles`, `calificaciones`) devuelven un conjunto de datos vacío (`[]`) o son denegadas, confirmando que las directivas de seguridad a nivel de fila protegen la lectura indebida.
* **SUP-05 (Relaciones y vistas SQL): NO PASÓ.**
  * *Resultado obtenido:* Error de autenticación en la llamada API (`Invalid API key`) al intentar consultar `vista_resumen_asistencia`.
* **SUP-06 (Manejo de fallo de conexión): PASÓ.**
  * *Resultado:* Al apuntar a un host no existente (`https://invalid-non-existent-subdomain.supabase.co`), el cliente capturó el error de red de forma controlada sin producir excepciones no controladas ni corromper datos.

#### D. Pruebas E2E con Playwright
* **E2E-01 a E2E-07: NO PASARON.**
  * *Resultado obtenido:* Las 7 pruebas de interfaz y navegación fallaron por tiempo de espera o redirección no completada.
  * *¿Por qué no pasaron las pruebas?:*
    1. **Fallo en Middleware por claves de Supabase:** La aplicación Next.js ejecuta `updateSession()` en `src/middleware.ts` para cada solicitud entrante, llamando a `supabase.auth.getUser()`. Al contener claves de Supabase no válidas (`Invalid API key`), la llamada del middleware falló internamente arrojando un error 500 en el servidor dev, lo que impidió que las rutas redirigieran correctamente a `/login` (`Expected pattern: /\/login/, Received: http://localhost:3000/dashboard/reporte-estudiantes`).
    2. **Autenticación en vivo bloqueada:** Las pruebas `E2E-01` y `E2E-02` que interactúan con el formulario de inicio de sesión requieren autenticación en Supabase Auth (`supabase.auth.signInWithPassword`), la cual se encuentra inaccesible debido a las credenciales remotas caducadas.

#### E. Pruebas de Rendimiento
* **PERF-01 a PERF-04: NO PASARON.**
  * *Resultado obtenido:*
    * `PERF-01` (1 VU): Latencia Media: 3,105.70 ms \| p95: 5,118.00 ms (Objetivo < 2,000 ms: **INCUMPLIDO**).
    * `PERF-02` (5 VUs): Latencia Media: 1,414.26 ms \| p95: 2,452.39 ms (Objetivo < 2,000 ms: **INCUMPLIDO**).
    * `PERF-03` (Rampa 1 a 10 VUs): Latencia Media: 1,919.46 ms \| p95: 2,186.84 ms (Objetivo < 2,000 ms: **INCUMPLIDO**).
    * `PERF-04` (Lectura repetida): Latencia Media: 687.82 ms \| p95: 2,688.65 ms (Objetivo < 2,000 ms: **INCUMPLIDO**).
  * *¿Por qué no pasaron las pruebas?:*
    1. **Exceso de latencia en p95:** El criterio propuesto en el plan de pruebas exige un percentil 95 inferior a 2 segundos (`p95 < 2000 ms`). En todas las pruebas ejecutadas sobre el entorno local, el percentil 95 superó los 2 segundos (entre 2,186 ms y 5,118 ms) debido al sobrecosto de compilación on-demand del servidor Next.js en modo desarrollo (`npm run dev`) y la latencia introducida al intentar contactar los endpoints de autenticación. Para producción se debe medir sobre una compilación optimizada (`next build && next start`).
    2. **Limitación de herramienta k6:** El ejecutable `k6` no se encontraba instalado en las variables de entorno del sistema operativo host, por lo que la suite k6 (`tests/performance/api-smoke.js`) se versionó en el repositorio y la medición empírica se ejecutó mediante el runner de rendimiento (`run-perf.mjs`).

---
**Documento generado y consolidado en la rama `Qa`.**
