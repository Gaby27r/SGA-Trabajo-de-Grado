import http from "k6/http";
import { check, sleep } from "k6";

export const options = {
  scenarios: {
    // PERF-01: Carga inicial - 1 usuario virtual por 1 min
    smoke_baseline: {
      executor: "constant-vus",
      vus: 1,
      duration: "1m",
      exec: "testBaseline",
    },
    // PERF-02: Concurrencia moderada - 5 usuarios virtuales por 2 min
    moderate_load: {
      executor: "constant-vus",
      vus: 5,
      duration: "2m",
      startTime: "1m",
      exec: "testModerate",
    },
    // PERF-03: Rampa de 1 a 10 usuarios en 3 min
    ramp_stress: {
      executor: "ramping-vus",
      startVUs: 1,
      stages: [
        { duration: "1m", target: 5 },
        { duration: "1m", target: 10 },
        { duration: "1m", target: 1 },
      ],
      startTime: "3m",
      exec: "testRamp",
    },
    // PERF-04: Solicitudes repetidas de solo lectura
    readonly_consistency: {
      executor: "constant-vus",
      vus: 3,
      duration: "1m",
      startTime: "6m",
      exec: "testReadOnly",
    },
  },
  thresholds: {
    http_req_failed: ["rate<0.01"], // Errores < 1%
    http_req_duration: ["p(95)<2000"], // p95 < 2s
  },
};

const BASE_URL = __ENV.BASE_URL || "http://localhost:3000";

export function testBaseline() {
  const res = http.get(`${BASE_URL}/login`);
  check(res, {
    "login status 200": (r) => r.status === 200,
    "latencia < 2000ms": (r) => r.timings.duration < 2000,
  });
  sleep(1);
}

export function testModerate() {
  const res = http.get(`${BASE_URL}/api/cron/alertas-riesgo`);
  check(res, {
    "cron endpoint responde": (r) => r.status === 200 || r.status === 401 || r.status === 403,
    "latencia < 2000ms": (r) => r.timings.duration < 2000,
  });
  sleep(1);
}

export function testRamp() {
  const res = http.get(`${BASE_URL}/login`);
  check(res, {
    "respuesta exitosa": (r) => r.status === 200,
    "estabilidad sin 500": (r) => r.status < 500,
  });
  sleep(0.5);
}

export function testReadOnly() {
  const res = http.get(`${BASE_URL}/login`);
  check(res, {
    "consistencia de respuesta": (r) => r.body && r.body.length > 500,
  });
  sleep(0.2);
}
