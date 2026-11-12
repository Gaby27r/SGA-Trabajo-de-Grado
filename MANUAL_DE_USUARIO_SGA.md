# MANUAL DE USUARIO
# Sistema de Gestión Académica (SGA)
### Guía Integral para Coordinadores, Profesores, Estudiantes y Acudientes

**Versión del Sistema:** 1.0  
**Fecha de Publicación:** Noviembre de 2026  
**Institución:** Sistema de Gestión Académica y Prevención de la Deserción Escolar  

---

## 📑 Tabla de Contenido

1. [Introducción y Bienvenida](#1-introducción-y-bienvenida)
2. [Roles de Usuario y Permisos](#2-roles-de-usuario-y-permisos)
3. [Módulo de Acceso, Autenticación y Seguridad](#3-módulo-de-acceso-autenticación-y-seguridad)
4. [Módulo del Coordinador (Administración General)](#4-módulo-del-coordinador-administración-general)
   - 4.1. Panel Principal de Control (Dashboard)
   - 4.2. Gestión de Cursos y Jornadas
   - 4.3. Gestión de Estudiantes y Matrículas
   - 4.4. Gestión del Cuerpo Docente
   - 4.5. Programación de Horarios de Clases
   - 4.6. Seguimiento Académico y Consolidado
   - 4.7. Reporte Predictivo de Riesgo de Deserción y Emisión de Alertas
5. [Módulo del Docente ("Mis Estudiantes")](#5-módulo-del-docente-mis-estudiantes)
   - 5.1. Consulta de Cursos y Materias Asignadas
   - 5.2. Registro y Modificación de Calificaciones (Periodos 1 y 2)
   - 5.3. Control Diario de Asistencia y Retardos
   - 5.4. Registro de Anotaciones Disciplinarias (Leves y Graves)
   - 5.5. Solicitud de Seguimiento Preventivo
6. [Módulo del Estudiante ("Mi Información")](#6-módulo-del-estudiante-mi-información)
   - 6.1. Resumen de Desempeño y Métricas Personales
   - 6.2. Directorio de Profesores y Materias
   - 6.3. Boletín Digital de Calificaciones
   - 6.4. Horario Semanal de Clases
   - 6.5. Historial Completo de Asistencia
7. [Guía Rápida de Preguntas Frecuentes (FAQ)](#7-guía-rápida-de-preguntas-frecuentes-faq)
8. [Glosario de Términos](#8-glosario-de-términos)

---

## 1. Introducción y Bienvenida

El **Sistema de Gestión Académica (SGA)** es una plataforma digital moderna e intuitiva diseñada para centralizar la gestión escolar, optimizar el registro de notas y asistencia, y **prevenir tempranamente la deserción escolar** mediante analítica predictiva de datos.

### ¿Para qué sirve el sistema?
- **Para los Coordinadores:** Permite administrar la estructura escolar (grados, horarios, matrículas, profesores) y vigilar la salud académica de toda la institución mediante un semáforo predictivo de riesgo.
- **Para los Profesores:** Facilita la toma de asistencia diaria desde cualquier dispositivo, el registro ágil de notas por periodo y la anotación de incidencias en el observador escolar.
- **Para los Estudiantes y Acudientes:** Ofrece un canal de consulta transparente para revisar calificaciones actualizadas, historial de asistencia y horarios de clase en tiempo real.

---

## 2. Roles de Usuario y Permisos

El sistema adapta su interfaz automáticamente según el perfil de la persona que ingresa:

| Rol | ¿Quién lo usa? | Funcionalidades Principales |
| :--- | :--- | :--- |
| **Coordinador** | Directivos, rectoría y secretaría académica. | • Creación y edición de cursos.<br>• Matrícula de estudiantes y registro de acudientes.<br>• Creación y vinculación de profesores.<br>• Construcción de la grilla de horarios.<br>• Reporte predictivo de deserción (IA).<br>• Emisión de correos de alerta preventiva. |
| **Profesor** | Docentes de todas las asignaturas. | • Registro de notas (Periodos 1 y 2).<br>• Toma de lista diaria (Asistió, Faltó, Justificación, Retardo).<br>• Observador disciplinario (anotaciones leves y graves).<br>• Consulta de riesgo de sus cursos asignados. |
| **Estudiante / Acudiente** | Alumnos matriculados y sus familias. | • Consulta del boletín digital de notas.<br>• Consulta de horario de clases semanal.<br>• Revisión del historial de asistencia y faltas.<br>• Identificación de sus docentes asignados. |

---

## 3. Módulo de Acceso, Autenticación y Seguridad

### 3.1. ¿Cómo iniciar sesión?
1. Abra su navegador web (Google Chrome, Mozilla Firefox, Microsoft Edge o Safari) e ingrese a la dirección web institucional:  
   `http://colegio.edu.co/login` (o la dirección provista por su institución).
2. En la pantalla verá dos paneles:
   - **Panel Izquierdo:** Mensaje institucional de "Gestión Académica".
   - **Panel Derecho:** Formulario de inicio de sesión.
3. Ingrese sus datos:
   - **Correo electrónico:** Su correo institucional (ejemplo: `coordinador@colegio.edu.co` o `profesor@colegio.edu.co`).
   - **Contraseña:** Su contraseña asignada.
4. Haga clic en el botón negro **"Entrar"**.
5. El sistema verificará sus datos y lo dirigirá automáticamente a la pantalla correspondiente a su rol.

> **💡 Nota importante:** Si ingresa datos incorrectos, el sistema desplegará un recuadro rojo informando: *"Correo o contraseña incorrectos"*. Si presenta problemas continuos, comuníquese con la secretaría del colegio.

### 3.2. ¿Cómo cerrar sesión?
En la parte inferior de la barra de navegación lateral (menú izquierdo) encontrará su nombre y su rol. Para salir de forma segura:
1. Haga clic en el botón **"Cerrar sesión"**.
2. Su sesión se cerrará de inmediato y regresará a la pantalla de bienvenida.
3. **Recomendación:** Cierre siempre su sesión si está utilizando un computador compartido.

---

## 4. Módulo del Coordinador (Administración General)

*Este módulo solo es visible para usuarios con rol de **Coordinador**.*

### 4.1. Panel Principal de Control (`/dashboard`)
Al ingresar, el coordinador verá un resumen visual con los números clave del colegio:
- **Tarjetas de Estadísticas:**
  - **Cursos activos:** Cantidad de salones/grados configurados.
  - **Estudiantes matriculados:** Total de alumnos en el sistema.
  - **Profesores:** Total de docentes vinculados.
- **Cuadrícula de Cursos:** Tarjetas con el nombre del curso (ejemplo: *4to A*, *8vo A*) y la cantidad exacta de estudiantes en cada uno. Al hacer clic sobre cualquier curso, el sistema lo llevará directamente a su horario de clases.

---

### 4.2. Gestión de Cursos y Jornadas (`/dashboard/cursos`)
Este módulo organiza los grupos de estudiantes del colegio.

#### ¿Cómo crear un nuevo curso?
1. En el menú lateral, haga clic en **"Cursos"**.
2. En la parte superior derecha, presione el botón azul **"+ Nuevo curso"**.
3. Se abrirá una ventana emergente donde debe completar:
   - **Nombre del curso:** Escriba el identificador (ejemplo: *10mo A*, *6to B*).
   - **Jornada:** Seleccione o escriba la jornada correspondiente (*Mañana*, *Tarde*, o *Única*).
4. Haga clic en **"Guardar"**. El nuevo curso aparecerá de inmediato en la tabla.

#### ¿Cómo editar o eliminar un curso?
- **Para editar:** En la fila del curso, haga clic en el ícono del **Lápiz**. Modifique los campos deseados y guarde los cambios.
- **Para eliminar:** Haga clic en el ícono de la **Papelera**. Aparecerá una ventana de confirmación para evitar borrados accidentales; confirme solo si el curso ya no tiene alumnos matriculados.

---

### 4.3. Gestión de Estudiantes y Matrículas (`/dashboard/estudiantes`)
Permite registrar y administrar la ficha escolar de cada alumno.

#### ¿Cómo matricular a un nuevo estudiante?
1. Haga clic en **"Estudiantes"** en el menú lateral.
2. Presione el botón **"+ Nuevo estudiante"**.
3. Diligencie el formulario con la siguiente información:
   - **Nombre completo:** Nombres y apellidos del estudiante.
   - **Curso:** Seleccione el curso al que ingresa.
   - **Nombre del acudiente:** Nombre del padre, madre o tutor legal.
   - **Teléfono del acudiente:** Número de contacto telefónico.
   - **Estrato socioeconómico:** Valor numérico del 1 al 6 (requerido para los modelos de apoyo estudiantil).
   - **¿Ha repetido año?:** Indique *Sí* o *No*.
   - **Clases asignadas:** Marque los bloques de materias a los que asistirá.
4. Presione **"Guardar estudiante"**.

#### ¿Cómo buscar o filtrar estudiantes?
En la parte superior de la lista encontrará un selector de cursos:
- Seleccione **"Todos"** para ver la lista completa.
- Seleccione un curso específico (ej. *8vo A*) para ver únicamente los alumnos de ese salón.
- Seleccione **"Sin curso asignado"** para ubicar estudiantes pendientes por salón.

---

### 4.4. Gestión del Cuerpo Docente (`/dashboard/profesores`)
Permite registrar la planta de profesores y sus datos institucionales.

#### ¿Cómo registrar a un profesor?
1. Haga clic en **"Profesores"** en el menú lateral.
2. Presione el botón **"+ Nuevo profesor"**.
3. Complete:
   - **Nombre completo:** Título y nombres del docente (ej. *Lic. María Rodríguez*).
   - **Correo electrónico:** Correo con el que iniciará sesión.
   - **Teléfono:** Número celular o de contacto.
4. Haga clic en **"Guardar"**. El docente quedará habilitado para que se le asignen materias en el horario.

---

### 4.5. Programación de Horarios de Clases (`/dashboard/horario`)
Permite estructurar la rutina académica semanal de cada curso.

#### Pasos para armar el horario:
1. Haga clic en **"Horario"** en el menú lateral.
2. Seleccione el curso a programar en el menú desplegable superior (ejemplo: *4to A*).
3. Verá una grilla con los días de **Lunes a Viernes**.
4. Para programar una clase:
   - Haga clic en **"+ Agregar bloque"** en el día deseado.
   - Seleccione la **Materia** (ej. *Matemáticas*, *Lenguaje*, *Ciencias*).
   - Asigne el **Profesor** encargado.
   - Defina la **Hora de Inicio** y **Hora de Fin** (ej. *07:00 a 08:30*).
   - *(Opcional)* Si es un recreo o descanso, marque la casilla **"Es descanso"** (no requerirá profesor).
5. Haga clic en **"Guardar bloque"**. La clase se pintará en el calendario escolar del curso y aparecerá de inmediato en los paneles del profesor y del estudiante.

---

### 4.6. Seguimiento Académico Global (`/dashboard/seguimiento`)
Proporciona una vista consolidada en tiempo real de toda la institución:
- Muestra en una sola tabla:
  - Nombre del estudiante y curso.
  - **Promedio acumulado del Periodo 1 y Periodo 2.**
  - **Total de inasistencias** y **máximo número de faltas seguidas**.
  - **Retardos acumulados**.
  - **Anotaciones disciplinarias** (conteo de leves y graves).

Esta pantalla permite a la rectoría y coordinación identificar patrones antes de que finalice el año escolar.

---

### 4.7. Reporte Predictivo de Riesgo de Deserción y Emisión de Alertas (`/dashboard/reporte-estudiante`)
**Es una de las herramientas más poderosas del SGA:** utiliza inteligencia analítica para clasificar a los estudiantes según su riesgo de abandonar el colegio o reprobar el año.

#### El Semáforo de Riesgo:
- 🔴 **Nivel Alto (Riesgo Crítico):** Estudiantes que presentan notas promedio inferiores a 2.0, más de 5 inasistencias acumuladas, 3 o más faltas seguidas o anotaciones disciplinarias graves. Requieren intervención prioritaria.
- 🟡 **Nivel Medio (Riesgo Moderado):** Estudiantes con notas entre 2.0 y 2.99, faltas entre 3 y 4, o anotaciones leves repetitivas. Requieren seguimiento y tutoría.
- 🟢 **Nivel Informativo (Bajo Riesgo / Normal):** Estudiantes con desempeño regular o alto sin alertas críticas.

#### ¿Cómo enviar una Alerta Preventiva por Correo Electrónico?
Cuando detecte a un estudiante en riesgo alto o medio:
1. Ingrese a **"Reporte de estudiante"**.
2. Filtre por curso si lo desea.
3. Ubique al estudiante en la lista y haga clic en **"Ver factores"** o en el botón **"Enviar alerta manual"** (ícono de sobre).
4. El sistema le mostrará una confirmación:
   > *"¿Deseas enviar la alerta de seguimiento al correo registrado de [Nombre del Estudiante]?"*
5. Haga clic en **"Aceptar"**.
6. **¿Qué sucede internamente?**
   - El sistema construye un correo formal con diseño institucional.
   - Incluye el detalle exacto de las notas bajas, asistencias y recomendaciones de acompañamiento.
   - Envía el correo automáticamente al acudiente y con copia a coordinación.
   - Registra el envío en la base de datos con una huella de auditoría para evitar duplicados en la misma semana.
7. Aparecerá una notificación verde en pantalla confirmando el envío exitoso.

---

## 5. Módulo del Docente ("Mis Estudiantes")

*Este módulo está diseñado para los **Profesores** y se encuentra en `/dashboard/profesor`.*

### 5.1. Consulta de Cursos y Materias Asignadas
Al ingresar, el docente verá únicamente los cursos y materias que tiene asignados en su horario:
1. En la parte superior, use el selector **"Curso"** para elegir el salón con el que va a trabajar.
2. Use el selector **"Materia"** si imparte más de una clase en dicho grupo.
3. La lista mostrará automáticamente los estudiantes matriculados en ese salón.

---

### 5.2. Registro y Modificación de Calificaciones
1. En la tabla de estudiantes, verá las columnas correspondientes a **Periodo 1** y **Periodo 2**.
2. Para ingresar o editar una nota:
   - Haga clic sobre la casilla de nota del estudiante.
   - Escriba el valor numérico en la escala permitida (ejemplo: `3.8` o `4.5`).
   - El sistema calcula y actualiza los promedios al guardar.
3. Presione el botón **"Guardar notas"** para persistir los cambios.

---

### 5.3. Control Diario de Asistencia y Retardos
Permite registrar la asistencia en segundos desde el computador del salón o un teléfono móvil:
1. En la barra superior de la sección de asistencia, seleccione la **Fecha de la clase** (por defecto carga la fecha de hoy).
2. Para cada estudiante encontrará cuatro opciones rápidas:
   - **Asistió:** Marca presencia en clase.
   - **Faltó:** Registra inasistencia injustificada.
   - **Justificación:** Si el acudiente presentó excusa médica o formal.
   - **Retardo:** Si el alumno ingresó al aula después de la hora estipulada.
3. En la columna **Observación**, puede escribir notas aclaratorias (ejemplo: *"Presentó excusa médica de EPS"* o *"Llegó 20 minutos tarde"*).
4. Haga clic en **"Guardar asistencia"**.

---

### 5.4. Registro de Anotaciones Disciplinarias (Observador)
1. Ubique la fila del estudiante al que desea registrar un suceso.
2. Haga clic en el botón **"+ Anotación"** (ícono de portapapeles).
3. Seleccione el tipo de falta:
   - **Leve:** Comportamientos menores (porte inadecuado del uniforme, uso de celular en clase, falta de material).
   - **Grave:** Agresiones verbales/físicas, deshonestidad académica o daño a instalaciones.
4. Escriba la **Descripción detallada** del hecho y los compromisos adquiridos por el estudiante.
5. Haga clic en **"Guardar anotación"**. Esta novedad se sumará automáticamente a los factores analizados por el semáforo de riesgo de coordinación.

---

## 6. Módulo del Estudiante ("Mi Información")

*Este portal es de acceso para el **Estudiante y su Acudiente** en `/dashboard/estudiante`.*

### 6.1. Resumen de Desempeño
Al ingresar, el alumno encontrará 4 tarjetas informativas en la parte superior:
- **Promedio Periodo 1:** Calificación promedio obtenida en el primer lapso.
- **Promedio Periodo 2:** Calificación promedio obtenida en el segundo lapso.
- **Inasistencias:** Conteo total de clases a las que ha faltado.
- **Máx. faltas consecutivas:** Mayor número de ausencias seguidas en el año escolar.

---

### 6.2. Mis Profesores y Materias
Una tabla clara donde el estudiante puede consultar:
- Qué materias cursa actualmente.
- El nombre completo de cada docente a cargo.

---

### 6.3. Boletín Digital de Calificaciones
Muestra el desglose de notas por cada materia y periodo académico:
- Permite verificar si alguna materia se encuentra en estado reprobatorio (menor a 3.0) para preparar recuperaciones o solicitar tutorías a tiempo.

---

### 6.4. Horario Semanal de Clases
Un calendario ordenado de Lunes a Viernes con:
- Bloques de horario (hora de entrada y salida de cada hora de clase).
- Materia correspondiente a cada hora.
- Nombre del profesor que dictará cada clase.

---

### 6.5. Historial Completo de Asistencia
El estudiante y su familia pueden auditar día a día su historial:
- Fecha exacta de cada registro.
- Estado asignado por el docente (*Asistió*, *Faltó*, *Justificación*, *Retardo*).
- Observaciones registradas por el profesor en caso de tardanzas o justificaciones.

---

## 7. Guía Rápida de Preguntas Frecuentes (FAQ)

### ¿Qué hago si olvidé mi contraseña institucional?
Comuníquese con la coordinación del colegio o envíe un correo al administrador del sistema. El coordinador puede restablecer o actualizar su acceso de forma segura desde la consola central.

### ¿Por qué como docente no veo a un estudiante en mi lista de clase?
Verifique con coordinación si el estudiante ya fue vinculado al curso correspondiente (`/dashboard/estudiantes`) y si tiene asignadas las clases del horario escolar.

### ¿Por qué el semáforo marca a un estudiante en Nivel Alto si sus notas son buenas?
El modelo predictivo no solo evalúa notas: también analiza si el estudiante acumula muchas inasistencias consecutivas, si tiene anotaciones graves en el observador o si tiene condición de extraedad o año repetido.

### ¿Qué pasa si envío una alerta por correo dos veces en la misma semana?
El sistema cuenta con un control de duplicados inteligente. Si se envía una nueva alerta durante la misma semana calendario, el sistema actualiza el registro existente en lugar de saturar la bandeja del acudiente con correos repetidos.

---

## 8. Glosario de Términos

- **SGA:** Sistema de Gestión Académica.
- **Semáforo de Riesgo:** Indicador visual (Verde, Amarillo, Rojo) que sintetiza la probabilidad de reprobación o retiro del estudiante.
- **Check Constraint:** Regla de seguridad de la base de datos que garantiza que los datos ingresados sean válidos (por ejemplo, que el estrato sea únicamente entre 1 y 6).
- **Inasistencia Justificada:** Falta al aula que cuenta con soporte médico o excusa aprobada por coordinación.
- **Bloque de Horario:** Unidad de tiempo semanal (hora inicio y fin) en la que se imparte una materia específica.
- **RLS (Row Level Security):** Política de seguridad que garantiza que un estudiante solo pueda ver sus propias notas y ningún estudiante pueda ver los datos de sus compañeros.

---
*Manual generado para el Sistema de Gestión Académica (SGA) — Noviembre de 2026.*
