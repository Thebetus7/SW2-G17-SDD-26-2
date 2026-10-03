# SDD Universal del GRUPO 17 SW2-26-2

Herramienta de distribución, instalación instantánea y orquestación de flujos de trabajo **Spec-Driven Development (SDD)**.

> _"Creé este framework para aplicar Spec-Driven Development (SDD) en cada uno de nuestros proyectos de ahora en adelante. Adoptar esta metodología no solo consolida las mejores prácticas de la industria, sino que representa el auténtico futuro de la programación."_

## IDEs Disponibles

- **Antigravity**
- **Cursor**
- **VS Code / Copilot**
- **OpenCode / Continue**
---
## ⚡ Instalación Rápida

Abre la terminal en la raíz del proyecto donde quieras habilitar la metodología SDD y ejecuta:

### Linux / macOS / Windows Git Bash:

```bash
curl -fsSL https://raw.githubusercontent.com/Thebetus7/SW2-G17-SDD-26-2/main/install.sh | bash
```

### Windows (PowerShell):

```powershell
irm https://raw.githubusercontent.com/Thebetus7/SW2-G17-SDD-26-2/main/install.ps1 | iex
```
---

## 🏛️ Estructura Documental en tu Proyecto (`docs/`)

Una vez instalado, el desarrollo bajo SDD organiza la documentación en carpetas versionadas dentro de `docs/`:

```text
📁 MI-PROYECTO/
├── 📄 AGENTS.md                        <-- Instrucciones operativas, gobernanza y reglas de precedencia
└── 📁 docs/                            <-- Ámbito exclusivo de lectura/escritura documental SDD
    ├── 📄 constitution.md              <-- Misión, flujos globales, modelo conceptual y restricciones
    └── 📁 specs/
        ├── 📁 01-modulo-core/
        │   ├── 📄 spec.md              <-- QUÉ funcional: EARS, Gherkin BDD y contratos de datos
        │   ├── 📄 plan.md              <-- CÓMO técnico: arquitectura y estructura física de archivos
        │   └── 📄 tasks.md             <-- Trabajo ejecutable: Task Progress, slices y dependencias
        └── 📁 02-siguiente-feature/
            ├── 📄 spec.md
            ├── 📄 plan.md
            └── 📄 tasks.md
```

> 📌 **Separación de Responsabilidades:** SDD gobierna formalmente la documentación en `docs/` y el archivo maestro `AGENTS.md`. La estructura física de archivos del código de producción y las suites de pruebas no se predetermina de forma rígida en la inicialización, sino que es responsabilidad exclusiva de la fase de planificación ([`/sdd-planning`](templates/sdd-planning.md)), la cual diseña el árbol físico de archivos según el tech stack y la arquitectura elegida.

---

### Detalle de los Comandos Oficiales Incluidos:

1. **`/sdd-init`**: Orquestador metodológico. Configura la precedencia por ámbito, separación de decisiones, estados de ciclo de vida (`DRAFT`, `APPROVED`, etc.), trazabilidad y genera/mantiene `AGENTS.md`.
2. **`/sdd-constitution-trial`**: Entrevista estructurada de co-diseño bajo la regla suprema de nunca inventar ni omitir ambigüedades. Consolida `docs/constitution.md` (misión, flujos globales, modelo conceptual, restricciones y principios innegociables).
3. **`/sdd-spec-high`**: Especificación funcional formal y observable en `docs/specs/XX/spec.md`. Modela el QUÉ (HU, EARS, Gherkin BDD, contratos de datos y casos vacíos) aislando la implementación técnica.
4. **`/sdd-spec-low`**: Especificación ágil y concisa para tareas puntuales o de menor complejidad.
5. **`/sdd-spec-clarify`**: QA Gate formal. Audita exhaustivamente el `spec.md` con tests de doble interpretación y de implementador externo para clasificar hallazgos (`BLOCKING`, `IMPORTANT`) antes de autorizar el diseño técnico.
6. **`/sdd-planning`**: Plan técnico de arquitectura en `docs/specs/XX/plan.md`. Diseña la solución técnica, contratos tipados, diagramas de secuencia, garantías de runtime y define formalmente la estructura física de directorios y archivos de código/tests.
7. **`/sdd-task`**: Descomposición en trabajo atómico y ejecutable en `docs/specs/XX/tasks.md` organizado en Vertical Slices, con tablero de progreso en tiempo real (`Task Progress`), dependencias topológicas y evidencia obligatoria.
8. **`/sdd-execution`**: Motor de implementación y verificación física guiada. Ejecuta tareas, valida en consola con evidencia demostrable, actualiza atómicamente el estado y `Task Progress`, y retroalimenta al nivel documental correspondiente ante fallos.
9. **`/sdd-spec-anchored`**: Iteración, corrección de bugs y refinamiento integral en cascada. Actualiza coordinadamente la tríada documental (`spec.md` + `plan.md` + `tasks.md`), encolando nuevas tareas sin borrar el historial previo.
10. **`/doc-deploy`**: Generador de documentación de despliegue, instalación y flujo visual interactivo. Audita el proyecto real sin inventar infraestructura ficticia, determina servicios requeridos y genera una suite modular completa en Markdown (`00_RESUMEN_GENERAL.md` a `06_APAGAR_Y_REACTIVAR.md`) junto con el tablero visual interactivo en HTML (`07_FLUJO_VISUAL_DESPLIEGUE.html`).

---

## 🛠️ Guía Paso a Paso de Comandos SDD

### 1. `/sdd-init`: Inicialización

> **Punto de partida obligatorio:** Este es el **primer comando indispensable** que se debe ejecutar en cualquier proyecto para activar y calibrar la metodología SDD.

#### Modo de uso:

```text
/sdd-init [sin incluir ningun contexto]
```

#### ¿Por qué es fundamental?
Sin `/sdd-init`, el agente carece de contexto y principios rectores para comprender y operar bajo la metodología SDD. Este comando genera y mantiene el archivo maestro **`AGENTS.md`** en la raíz del proyecto, rigiendo todo el ciclo de desarrollo:

- **Gobernanza y reglas maestras:** Establece las instrucciones operativas, los límites de autonomía del asistente y la separación entre decisiones de negocio y técnicas.
- **Jerarquía y precedencia por ámbito:** Define el orden descendente estricto (`Constitution` ➔ `Spec` ➔ `Plan` ➔ `Tasks` ➔ `Code + Tests`), donde un nivel inferior no puede contradecir una decisión superior.
- **Estados de artefactos y trazabilidad:** Introduce estados normativos (`DRAFT`, `APPROVED`, `NEEDS_CLARIFICATION`, etc.) y la cadena de trazabilidad desde la intención hasta la evidencia.
- **Ámbito documental exclusivo:** Gobierna la documentación en `docs/` sin predeterminar rígidamente la estructura física de código, delegándola a la fase de planificación técnica.

### 2. `/sdd-constitution-trial`: Constitución del Proyecto

> **Fundación del proyecto:** Entrevista interactiva estructurada (_Grill-Me_) bajo la **regla suprema de nunca inventar, suponer ni omitir ambigüedades**, definiendo la misión, flujos globales, modelo conceptual y restricciones antes de programar.

#### Modo de uso:

```text
/sdd-constitution-trial [opcional: breve descripción o idea general de tu proyecto]
```

#### ¿Por qué es fundamental?
Sin `/sdd-constitution-trial`, el proyecto carece de una base global sólida y coherente, provocando que la IA asuma stacks, alcances o reglas no deseadas. Este comando redacta el documento supremo **`docs/constitution.md`**, el cual establece:

- **Regla Suprema Anti-Suposiciones:** La IA tiene prohibido asumir silenciosamente decisiones de negocio; ante cualquier duda formula preguntas mínimas de alto impacto y reaudita tras cada respuesta.
- **Las 5 Dimensiones de Descubrimiento:** Audita y clarifica el flujo macro E2E, topología de datos conceptual, hardware/APIs externas, resiliencia/conectividad y restricciones globales.
- **Modelo conceptual y principios innegociables:** Fija los conceptos nucleares, límites operativos (*Out of Scope*) y políticas transversales que gobernarán todas las features.

#### ¿Qué contexto conviene proporcionar al ejecutarlo?
Para que la entrevista sea lo más precisa y rápida posible, es ideal suministrar (o tener claros) los siguientes puntos clave:

1. **Propósito y Visión General**: Qué problema resuelve la aplicación, a qué tipo de usuarios está dirigida y cuál es su objetivo principal.
2. **Stack Tecnológico de Preferencia**: Lenguajes, frameworks (ej. React, Next.js, Fastify, Spring Boot, Flutter, etc.), base de datos (PostgreSQL, Supabase, SQLite, Mongo) y librerías clave. _(Si no lo tienes definido, indícalo para que la IA proponga la mejor combinación)_.
3. **Límites de Alcance (_Scope & Out-of-Scope_)**: Qué funciones son el núcleo del producto y qué aspectos **NO** deben desarrollarse bajo ninguna circunstancia en esta etapa.
4. **Infraestructura y Despliegue**: Si el desarrollo debe apoyarse en contenedores (Docker / Docker Compose), gestión de secretos (`.env`) o plataformas de despliegue cloud.
5. **Estándares y Convenciones del Equipo**: Flujo de Git preferido, convenciones de commits (ej. _Conventional Commits_) y estándares de testing o linters.

> 💡 **Ejemplo de invocación con contexto enriquecido:**
> ```text
> /sdd-constitution-trial Plataforma SaaS de reservas de citas médicas con panel web en Next.js y API REST en Node/Express con PostgreSQL. Debe incluir Docker Compose para entorno local y autenticación con roles. Fuera de alcance: pasarela de pagos para el MVP.
> ```

### 3. `/sdd-spec-high`: Especificación Funcional Formal (Alta Rigurosidad)

> **Diseño de requerimientos:** Captura y formalización del comportamiento observable de un módulo o feature bajo la **regla suprema de no inventar comportamiento**, aislando por completo la implementación técnica.

#### Modo de uso:

```text
/sdd-spec-high [descripción, idea o requerimiento del módulo a construir]
```

#### ¿Por qué es fundamental?
Sin `/sdd-spec-high`, el desarrollo cae en la trampa de programar sin un contrato funcional claro, derivando en retrabajo, supuestos erróneos y falta de criterios de aceptación medibles. Este comando genera el documento **`docs/specs/XX-nombre/spec.md`**, el cual establece:

- **Historias de Usuario (HU):** Modela el valor de negocio y los roles de usuario involucrados (`HU-01`, etc.).
- **Requerimientos EARS (RF):** Redacta requisitos funcionales inequívocos bajo la sintaxis formal EARS (Event-Driven, State-Driven, Ubiquitous, Unwanted Behavior, etc.).
- **Criterios de Aceptación Gherkin (SC):** Escenarios BDD formales (`Dado / Cuando / Entonces`) para *Happy Path*, errores observables, casos vacíos y límites (*Edge Cases*).
- **Principio de Caja Negra Pura:** Modela estrictamente el **QUÉ** y los contratos de datos funcionales (entradas, precondiciones, postcondiciones y salidas), sin contaminarse con clases, ORMs ni código prematuro.

### 4. `/sdd-spec-clarify`: QA Gate de Especificación Funcional

> **Filtro de calidad funcional:** Gate formal que audita exhaustivamente el `spec.md` mediante el **test de doble interpretación** y el **test de implementador externo**, impidiendo avanzar a planificación si existen ambigüedades de negocio.

#### Modo de uso:

```text
/sdd-spec-clarify [opcional: prefijo del módulo, ej. 01. o vacío para auditar el último spec]
```

#### ¿Por qué es fundamental?
Sin `/sdd-spec-clarify`, los huecos conceptuales, suposiciones no validadas y casos de borde olvidados pasan directamente al código, multiplicando el costo de corregirlos después. Este comando audita y actualiza **`docs/specs/XX-nombre/spec.md`**, garantizando:

- **Clasificación de Hallazgos:** Distingue entre observaciones bloqueantes (`BLOCKING`) que exigen detenerse y preguntar al usuario, y mejoras menores (`IMPROVEMENT`).
- **Test de Doble Interpretación:** Verifica que dos desarrolladores independientes no puedan derivar dos comportamientos funcionales distintos a partir del mismo documento.
- **Trazabilidad estricta:** Comprueba la coherencia jerárquica de identificadores (`HU-XX` ➔ `RF-XX.Y` ➔ `SC-XX.Y.Z`).
- **No Trasladar Ambigüedades a Planning:** Protege la frontera entre negocio y arquitectura, impidiendo que el arquitecto técnico tenga que inventar comportamiento funcional.

### 5. `/sdd-planning`: Plan Técnico y Diseño de Arquitectura

> **Diseño del CÓMO técnico:** Transforma los requerimientos funcionales en una solución de ingeniería robusta, modelando capas, diagramas, contratos tipados, garantías de runtime y **definiendo formalmente la estructura física de directorios y archivos de código**.

#### Modo de uso:

```text
/sdd-planning [opcional: pedir /grill-me para refinar el plan]
```

#### ¿Por qué es fundamental?
Sin `/sdd-planning`, el equipo pasa directo de la idea al código sin definir arquitectura ni contratos de datos, provocando deuda técnica, tipos inseguros (`any`) y acoplamiento descontrolado. Este comando genera el documento **`docs/specs/XX-nombre/plan.md`**, el cual establece:

- **Definición de la Estructura Física de Archivos:** Es el único responsable de proyectar y definir el árbol concreto de directorios y archivos donde residirá el código de producción y los tests.
- **Lectura Acotada a SDD:** Para modelar la solución, consume como insumo de verdad exclusivamente la carpeta `docs/` (`constitution.md` y `spec.md`).
- **Arquitectura y contratos tipados:** Modela capas (presentación, dominio, infraestructura), diagramas de secuencia Mermaid, DTOs y validadores en runtime sin tipos ambiguos.
- **Garantías de persistencia e integridad:** Especifica relaciones, políticas de claves foráneas antihuérfanos (`ON DELETE SET NULL`, `CASCADE`), evolución de esquema y ciclo de vida de I/O.

### 6. `/sdd-task`: Descomposición Atómica y Ejecutable

> **Secuenciación de tareas:** Descompone el plan técnico en un checklist atómico, trazable y ejecutable, organizado en _Vertical Slices_ y con un tablero de progreso en tiempo real (**Task Progress**).

#### Modo de uso:

```text
/sdd-task [no necesita contexto, la IA lo genera automáticamente]
```

#### ¿Por qué es fundamental?
Sin `/sdd-task`, los desarrolladores y la IA abordan el desarrollo de forma monolítica o desordenada, dejando cabos sueltos e implementaciones a medias. Este comando genera el documento **`docs/specs/XX-nombre/tasks.md`**, el cual establece:

- **Task Progress en Cabecera:** Muestra al inicio del documento un resumen métrico en tiempo real (Total, Realizadas, Por realizar, Bloqueadas, En progreso, Progreso %) y estado operativo (`READY`, `IN_PROGRESS`, etc.).
- **Feature-First / Vertical Slices:** Agrupa el trabajo en flujos funcionales completos de punta a punta (persistencia + lógica + interfaz + validación), evitando capas desarticuladas.
- **Trazabilidad y Criterio de Done:** Cada tarea declara sus dependencias topológicas (`DEPENDS_ON`), enlaces a requisitos (`RF-XX.Y`, `SC-XX.Y.Z`) y criterios objetivos de finalización con evidencia requerida.

### 7. `/sdd-execution`: Implementación, Verificación y Cierre Físico

> **Implementación física guiada:** Motor de desarrollo que toma las tareas ejecutables de `tasks.md`, escribe el código siguiendo el plan, ejecuta las pruebas reales en consola y aporta evidencia demostrable.

#### Modo de uso:

```text
/sdd-execution [establecer el número de tareas a ejecutar o presionar enter para ejecutar todas]
```

#### ¿Por qué es fundamental?
Sin `/sdd-execution`, la IA suele escribir código sin ejecutar pruebas, asumir que todo compila o dar por cerrado el trabajo sin evidencia. Este comando actúa como el motor de ejecución riguroso que:

- **Ejecuta lo aprobado sin inventar:** Materializa exactamente los contratos y rutas definidos en `plan.md` y `spec.md`.
- **Validación proporcional al riesgo:** Ejecuta los runners de test reales del proyecto (unitarios, BDD/E2E, linters, typechecks) y verifica que los resultados pasen al 100%.
- **Actualización atómica del progreso:** Tras verificar físicamente el resultado, actualiza de inmediato el estado de la tarea (`COMPLETED`), el registro de evidencia y recalcula la tabla de `Task Progress`.
- **Diagnóstico y Retroalimentación de Fallos:** Si una prueba falla o se descubre un cabo suelto, no maquilla el código: diagnostica si la causa es un bug, una falla de plan o una ambigüedad de negocio y devuelve el flujo al nivel correspondiente.
- **Cierre físico verificable:** Ejecuta los comandos en la terminal y solo tras validar el resultado en verde marca físicamente la tarea (`[x]`) en `tasks.md`.

### 8. `/sdd-spec-anchored`: Iteración, Refinamiento y Evolución en Cascada (Spec + Plan + Tasks)

> **Evolución y resolución de bugs guiada:** Orquesta en una sola pasada la actualización coordinada de la tríada documental (`spec.md` + `plan.md` + `tasks.md`) ante flujos no previstos, desajustes de experiencia o bugs en runtime, encolando nuevas tareas sin perder el historial.

#### Modo de uso:

```text
/sdd-spec-anchored [opcional: prefijo del módulo, ej. 01. o vacío para el último módulo] [descripción detallada del ajuste, bug o flujo a refinar]
```

> 💡 **Ejemplo real de invocación para refinamiento de experiencia:**
> ```text
> /sdd-spec-anchored 01. Quiero que la cámara funcione bien: cuando saca la foto muestra que procesa pero sigue la cámara en vivo y el usuario no sabe si se tomó la foto. Además, si la IA no detecta la API o no hay internet, no debe romper la app sino mostrar advertencias amigables (sin conexión, error de modelo) y permitir continuar manualmente.
> ```

#### ¿Por qué es fundamental?
Sin `/sdd-spec-anchored`, cuando una funcionalidad presenta bugs en ejecución o requiere afinar la experiencia de usuario, el equipo suele caer en la tentación de **parchar el código directamente**. Esto destruye la jerarquía de verdad de SDD y deja la documentación desfasada y obsoleta.

Este comando actúa como el **motor de evolución controlada**, ejecutando un protocolo riguroso en 3 pasos:

1. **Diagnóstico Contextual:** Contrasta lo que la especificación prometía frente al síntoma real reportado en runtime.
2. **Entrevista de Refinamiento (_Grill-Me_ en 4 Ejes):** Antes de tocar los documentos, la IA formula preguntas clave con opciones recomendadas sobre:
   - *Feedback Visual:* Congelamiento de imagen capturada, overlays con indicadores de procesamiento y estados de carga.
   - *Canal de Errores:* SnackBars, Banners o Diálogos modales con mensajes amigables al usuario frente a fallos técnicos.
   - *Degradación Elegante:* Flujos de continuidad manual si las APIs externas o la IA no responden.
   - *Persistencia Temporal:* Preservación segura de la captura y liberación de recursos de hardware.
3. **Actualización en Cascada a Estado Puro:**
   - **`spec.md`:** Se actualiza in-situ incrementando la versión (`v1.1.0`, etc.) con nuevos requisitos EARS y escenarios Gherkin BDD, manteniéndose como la **fuente de verdad pura y definitiva**.
   - **`plan.md`:** Adapta los diagramas de secuencia, controladores de estado reactivos, DTOs y tipos de fallo de dominio.
   - **`tasks.md`:** **Conserva intacto el historial de tareas previas ya marcadas (`[x]`)** y encola al final una nueva sección (`### Iteración N: [Refinamiento / Fix]`) con tareas `[SETUP]`, `[IMPL]`, `[TEST]` y `[VERIFY]`.

Tras finalizar, la IA te invitará a ejecutar `/sdd-execution` para resolver inmediatamente las nuevas tareas encoladas bajo validación dual.

### 9. `/doc-deploy`: Documentación de Despliegue, Operaciones y Flujo Visual Interactivo

> **Entrega y operaciones en producción:** Genera una suite documental técnica completa, rigurosa y modular para desplegar, instalar, verificar, actualizar, mantener, apagar y reactivar el proyecto en entornos de producción, acompañada de un dashboard interactivo en HTML.

#### Modo de uso:

```text
/doc-deploy [opcional: proveedor de preferencia, ej. AWS, VPS, Docker, Railway, o vacío para autodetectar]
```

#### ¿Por qué es fundamental?
Sin `/doc-deploy`, la puesta en producción suele ser un proceso manual, caótico y propenso a errores, con guías desactualizadas o comandos ficticios. Este comando analiza el código fuente real, las dependencias y la configuración del proyecto para estructurar una documentación operativa a prueba de fallos:

- **Regla Suprema Anti-Invención de Infraestructura:** La IA tiene terminantemente prohibido asumir proveedores, sistemas operativos, IPs, puertos o comandos no verificados. Sigue el ciclo estricto: `INSPECCIONAR` ➔ `DETECTAR` ➔ `PREGUNTAR SI FALTA UNA DECISIÓN RELEVANTE` ➔ `RECIBIR RESPUESTA` ➔ `VERIFICAR` ➔ `GENERAR DOCUMENTACIÓN`.
- **Estructura Modular Completa:** Genera un directorio organizado y navegable:
  ```text
  [CARPETA_DESPLIEGUE]/
  ├── 00_RESUMEN_GENERAL.md
  ├── 01_CONFIGURAR_PROYECTO.md
  ├── 02_CREAR_INFRAESTRUCTURA_[CLOUD].md
  ├── 03_INSTALAR_HERRAMIENTAS.md
  ├── 04_DESPLEGAR_Y_VERIFICAR.md
  ├── 05_ACTUALIZAR_PRODUCCION.md
  ├── 06_APAGAR_Y_REACTIVAR.md
  └── 07_FLUJO_VISUAL_DESPLIEGUE.html
  ```
- **Flujo Visual Interactivo (HTML):** Produce un archivo HTML autónomo (`07_FLUJO_VISUAL_DESPLIEGUE.html`) con diagramas de flujo interactivos, verificación de pasos y comandos listos para copiar con un solo clic.
- **Ciclo de Vida Operativo Total:** Cubre no solo el despliegue inicial (*Happy Path*), sino también las tareas críticas del Día 2: actualización sin caída de servicio (*Zero-Downtime*), rollback, respaldos, monitoreo, costos y procedimientos de apagado seguro y reactivación.

---

## 🚀 Despliegue y Fork

Consulta la guía detallada en [DEPLOY.md](DEPLOY.md) para aprender a subir tu propio fork a GitHub y configurar tus URLs canónicas.

