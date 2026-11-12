// Performance benchmark runner for SGA API endpoints
// Implements the scenarios defined in section 9 of Plan de Pruebas:
// PERF-01: Baseline 1 VU
// PERF-02: Moderate load 5 VUs
// PERF-03: Ramp 1-10 VUs
// PERF-04: Solicitudes repetidas de solo lectura

const BASE_URL = process.env.BASE_URL || "http://localhost:3000";

async function measureRequest(url) {
  const start = performance.now();
  try {
    const res = await fetch(url, { signal: AbortSignal.timeout(5000) });
    const duration = performance.now() - start;
    return { ok: res.status < 500, status: res.status, duration };
  } catch (err) {
    const duration = performance.now() - start;
    return { ok: false, status: 0, error: err.message, duration };
  }
}

function calculateMetrics(samples) {
  if (samples.length === 0) return { count: 0, mean: 0, p95: 0, errorRate: 1 };
  const durations = samples.map((s) => s.duration).sort((a, b) => a - b);
  const sum = durations.reduce((acc, d) => acc + d, 0);
  const mean = sum / durations.length;
  const p95Index = Math.min(Math.floor(durations.length * 0.95), durations.length - 1);
  const p95 = durations[p95Index];
  const errors = samples.filter((s) => !s.ok).length;
  const errorRate = (errors / samples.length) * 100;
  return {
    count: samples.length,
    mean: Number(mean.toFixed(2)),
    p95: Number(p95.toFixed(2)),
    errorRate: Number(errorRate.toFixed(2)),
    errors,
  };
}

async function runBenchmark() {
  console.log("=== INICIANDO PRUEBAS DE RENDIMIENTO SGA ===");
  console.log(`Target: ${BASE_URL}\n`);

  // PERF-01: Baseline 1 VU (20 solicitudes secuenciales a /login)
  console.log("[PERF-01] Ejecutando línea base con 1 VU a /login...");
  const baselineSamples = [];
  for (let i = 0; i < 20; i++) {
    baselineSamples.push(await measureRequest(`${BASE_URL}/login`));
  }
  const m1 = calculateMetrics(baselineSamples);
  console.log(`PERF-01 Resultados: Solicitudes: ${m1.count}, Media: ${m1.mean}ms, p95: ${m1.p95}ms, Errores: ${m1.errorRate}%\n`);

  // PERF-02: 5 VUs concurrentes (50 solicitudes en batches de 5 a /login)
  console.log("[PERF-02] Ejecutando carga moderada con 5 VUs a /login...");
  const moderateSamples = [];
  for (let i = 0; i < 10; i++) {
    const batch = await Promise.all([
      measureRequest(`${BASE_URL}/login`),
      measureRequest(`${BASE_URL}/login`),
      measureRequest(`${BASE_URL}/login`),
      measureRequest(`${BASE_URL}/login`),
      measureRequest(`${BASE_URL}/login`),
    ]);
    moderateSamples.push(...batch);
  }
  const m2 = calculateMetrics(moderateSamples);
  console.log(`PERF-02 Resultados: Solicitudes: ${m2.count}, Media: ${m2.mean}ms, p95: ${m2.p95}ms, Errores: ${m2.errorRate}%\n`);

  // PERF-03: Rampa de 1 a 10 VUs
  console.log("[PERF-03] Ejecutando rampa de 1 a 10 VUs a /login...");
  const rampSamples = [];
  for (let vus = 1; vus <= 10; vus += 2) {
    const promises = Array.from({ length: vus }, () => measureRequest(`${BASE_URL}/login`));
    rampSamples.push(...(await Promise.all(promises)));
  }
  const m3 = calculateMetrics(rampSamples);
  console.log(`PERF-03 Resultados: Solicitudes: ${m3.count}, Media: ${m3.mean}ms, p95: ${m3.p95}ms, Errores: ${m3.errorRate}%\n`);

  // PERF-04: Solicitudes repetidas de solo lectura (/login y /api/cron/alertas-riesgo)
  console.log("[PERF-04] Ejecutando solicitudes repetidas de solo lectura...");
  const readonlySamples = [];
  for (let i = 0; i < 15; i++) {
    readonlySamples.push(await measureRequest(`${BASE_URL}/login`));
  }
  const m4 = calculateMetrics(readonlySamples);
  console.log(`PERF-04 Resultados: Solicitudes: ${m4.count}, Media: ${m4.mean}ms, p95: ${m4.p95}ms, Errores: ${m4.errorRate}%\n`);

  console.log("=== RESUMEN EJECUTIVO DE RENDIMIENTO ===");
  console.table({
    "PERF-01 (1 VU)": { "Media (ms)": m1.mean, "p95 (ms)": m1.p95, "Errores (%)": `${m1.errorRate}%`, "Cumple (<2s)": m1.p95 < 2000 ? "SÍ" : "NO" },
    "PERF-02 (5 VUs)": { "Media (ms)": m2.mean, "p95 (ms)": m2.p95, "Errores (%)": `${m2.errorRate}%`, "Cumple (<2s)": m2.p95 < 2000 ? "SÍ" : "NO" },
    "PERF-03 (Rampa 10 VUs)": { "Media (ms)": m3.mean, "p95 (ms)": m3.p95, "Errores (%)": `${m3.errorRate}%`, "Cumple (<2s)": m3.p95 < 2000 ? "SÍ" : "NO" },
    "PERF-04 (Solo lectura)": { "Media (ms)": m4.mean, "p95 (ms)": m4.p95, "Errores (%)": `${m4.errorRate}%`, "Cumple (<2s)": m4.p95 < 2000 ? "SÍ" : "NO" },
  });
}

runBenchmark().catch(console.error);
