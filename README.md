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
├── 📄 AGENTS.md                        <-- Reglas del juego, comandos maestros y jerarquía
├── 📁 docs/
│   ├── 📄 constitution.md              <-- Misión, stack, suite de testing (Caja Negra y Blanca) y roadmap
│   └── 📁 specs/
│       ├── 📁 01-modulo-core/
│       │   ├── 📄 spec.md              <-- Requerimientos EARS, Gherkin y contratos de datos
│       │   ├── 📄 plan.md              <-- Arquitectura técnica y Vertical Slices
│       │   └── 📄 tasks.md             <-- Checklist atómico de tareas TDD
│       └── 📁 02-siguiente-feature/
│           ├── 📄 spec.md
│           ├── 📄 plan.md
│           └── 📄 tasks.md
└── 📁 src/                             <-- Código de producción
```

---

### Detalle de los Comandos Incluidos:

1. **`/sdd-init`**: Orquestador metodológico. Configura la precedencia de carpetas, jerarquía de verdad y genera el archivo maestro `AGENTS.md`.
2. **`/sdd-constitution-trial`**: Entrevista guiada interactiva (_Grill-Me_). Pregunta todo lo necesario y redacta `docs/constitution.md` con la misión, tech stack, roadmap (Docker, `.env`, Git), estándares de código y suite de testing.
3. **`/sdd-constitution`**: Plantilla canónica directa para redactar o consultar la constitución del proyecto.
4. **`/sdd-spec-high`**: Especificación formal exhaustiva con sintaxis EARS, escenarios Gherkin BDD y contratos de interfaces tipados en `docs/specs/XX/spec.md`.
5. **`/sdd-spec-low`**: Especificación ágil y concisa para tareas puntuales o de menor complejidad.
6. **`/sdd-spec-clarify`**: Filtro de QA. Audita el último `spec.md`, detecta ambigüedades o vacíos y los resuelve con el usuario antes de planificar.
7. **`/sdd-planning`**: Plan técnico de arquitectura, diagramas de secuencia, invariantes y partición en Vertical Slices en `docs/specs/XX/plan.md`.
8. **`/sdd-task`**: Desglose en checklist atómico secuenciado con ciclo TDD (Red-Green-Refactor) en `docs/specs/XX/tasks.md`.
9. **`/sdd-execution`**: Motor de ejecución paso a paso del checklist bajo **Validación Dual** obligatoria (Tests de Caja Blanca + Tests de Caja Negra).
10. **`/sdd-spec-anchored`** _(y variantes `-spec`, `-plan`, `-task`)_: Evolución e iteración anclada sobre specs existentes: actualiza el `spec.md`, adapta el `plan.md` y suma las nuevas tareas a `tasks.md` manteniendo el historial intacto.

---

## 🛠️ Guía Paso a Paso de Comandos SDD

### 1. `/sdd-init`: Inicialización

> **Punto de partida obligatorio:** Este es el **primer comando indispensable** que se debe ejecutar en cualquier proyecto para activar y calibrar la metodología SDD.

#### Modo de uso:

```text
/sdd-init [sin incluir ningun contexto]
```

#### ¿Por qué es fundamental?
Sin `/sdd-init`, No tiene contexto, ni forma de como deberia entender el Enfoque de desarrollo SDD. Este comando genera y mantiene el archivo maestro **`AGENTS.md`** en la raíz del proyecto, el cual es el documento esencial que rige todo el ciclo de desarrollo:

- **Reglas del juego y contexto maestro:** Define explícitamente el rol del agente de IA, las restricciones de arquitectura y las directivas de comportamiento.
- **Jerarquía de verdad innegociable:** Establece la precedencia estricta donde la especificación manda sobre el código (`Constitución` ➔ `Spec` ➔ `Plan` ➔ `Tasks` ➔ `Código y Tests`).
- **Estandarización de rutas:** Fija la estructura física canónica de directorios (`docs/specs/XX/`, `docs/constitution.md`, `src/`).

### 2. `/sdd-constitution-trial`: Constitución del Proyecto

> **Fundación del proyecto:** Entrevista interactiva guiada (_Grill-Me_) para definir la misión, stack técnico, roadmap y principios innegociables antes de programar.

#### Modo de uso:

```text
/sdd-constitution-trial [opcional: breve descripción o idea general de tu proyecto]
```

#### ¿Por qué es fundamental?
Sin `/sdd-constitution-trial`, el proyecto carece de una base técnica sólida, provocando que la IA asuma stacks, patrones o alcances no deseados. Este comando redacta el documento supremo **`docs/constitution.md`**, el cual establece:

- **Misión y límites claros:** Define el propósito del software, términos clave del negocio y qué queda estrictamente fuera de alcance (_Out of Scope_).
- **Stack técnico y suite de testing:** Fija las tecnologías oficiales (frontend, backend, base de datos, linters) y la estrategia de Validación Dual (Caja Blanca + Caja Negra).
- **Roadmap e infraestructura:** Acuerda la configuración de Docker, gestión de variables de entorno (`.env`), flujos de Git y los hitos de entrega.

#### ¿Qué contexto conviene proporcionar al ejecutarlo?
Para que la entrevista sea lo más precisa y rápida posible, es ideal suministrar (o tener claros) los siguientes puntos clave:

1. **Propósito y Visión General**: Qué problema resuelve la aplicación, a qué tipo de usuarios está dirigida y cuál es su objetivo principal.
2. **Stack Tecnológico de Preferencia**: Lenguajes, frameworks (ej. React, Next.js, Fastify, Spring Boot, etc.), base de datos (PostgreSQL, Supabase, SQLite, Mongo) y librerías clave. _(Si no lo tienes definido, indícalo para que la IA proponga la mejor combinación)_.
3. **Límites de Alcance (_Scope & Out-of-Scope_)**: Qué funciones son el núcleo del producto y qué aspectos **NO** deben desarrollarse bajo ninguna circunstancia en esta etapa.
4. **Infraestructura y Despliegue**: Si el desarrollo debe apoyarse en contenedores (Docker / Docker Compose), gestión de secretos (`.env`) o plataformas de despliegue cloud.
5. **Estándares y Convenciones del Equipo**: Flujo de Git preferido, convenciones de commits (ej. _Conventional Commits_) y estándares de testing o linters.

> 💡 **Ejemplo de invocación con contexto enriquecido:**
> ```text
> /sdd-constitution-trial Plataforma SaaS de reservas de citas médicas con panel web en Next.js y API REST en Node/Express con PostgreSQL. Debe incluir Docker Compose para entorno local y autenticación con roles. Fuera de alcance: pasarela de pagos para el MVP.
> ```

### 3. `/sdd-spec-high`: Especificación Funcional Formal (Alta Rigurosidad)

> **Diseño de requerimientos:** Entrevista técnica estructurada (_Grill-Me_) para definir el comportamiento observable de un módulo o feature sin escribir código prematuro.

#### Modo de uso:

```text
/sdd-spec-high [descripción, idea o requerimiento del módulo a construir]
```

#### ¿Por qué es fundamental?
Sin `/sdd-spec-high`, el desarrollo cae en la trampa de programar sin un contrato funcional claro, derivando en retrabajo, supuestos erróneos y falta de criterios de aceptación medibles. Este comando genera el documento **`docs/specs/XX-nombre/spec.md`**, el cual establece:

- **Historias de Usuario (HU):** Modela el valor de negocio y los roles de usuario involucrados (`HU-01`, etc.).
- **Requerimientos EARS (RF):** Redacta requisitos funcionales inequívocos bajo la sintaxis formal EARS (Event-Driven, State-Driven, Ubiquitous, etc.).
- **Criterios de Aceptación Gherkin (SC):** Escenarios BDD formales (`Dado / Cuando / Entonces`) para *Happy Path* y casos de borde (*Edge Cases*).
- **Principio de Caja Negra:** Modela estrictamente el **QUÉ** y los contratos de datos funcionales (entradas y salidas), aislando por completo la lógica interna de implementación.

### 4. `/sdd-spec-clarify`: Auditoría y Refinamiento Funcional (QA Gate)

> **Filtro de calidad funcional:** Audita exhaustivamente el `spec.md` en busca de ambigüedades, vacíos de lógica o casos de borde antes de avanzar a la arquitectura.

#### Modo de uso:

```text
/sdd-spec-clarify [opcional: prefijo del módulo, ej. 01. o vacío para auditar el último spec]
```

#### ¿Por qué es fundamental?
Sin `/sdd-spec-clarify`, los huecos conceptuales, suposiciones no validadas y casos de borde olvidados pasan directamente al código, multiplicando el costo de corregirlos después. Este comando audita y actualiza **`docs/specs/XX-nombre/spec.md`**, garantizando:

- **Detección de ambigüedades:** Identifica términos imprecisos o no testeables y entrevista al usuario (_Grill-Me_) para resolverlos de inmediato.
- **Trazabilidad estricta:** Comprueba la coherencia jerárquica de identificadores (`HU-XX` ➔ `RF-XX.Y` ➔ `SC-XX.Y.Z`).
- **Cobertura de casos de borde:** Asegura que cada requisito cuente con escenarios BDD en Gherkin tanto para el flujo exitoso (_Happy Path_) como para fallos y límites (_Edge Cases_).
- **Cero código prematuro:** Verifica que la especificación se mantenga como caja negra pura sin contaminarse con detalles de implementación o persistencia.

### 5. `/sdd-planning`: Plan Técnico y Diseño de Arquitectura

> **Diseño del CÓMO técnico:** Transforma los requerimientos funcionales en una solución de ingeniería robusta, modelando capas, diagramas, contratos tipados y partición en _Vertical Slices_.

#### Modo de uso:

```text
/sdd-planning [opcional: pedir /grill-me para refinar el plan]
```

#### ¿Por qué es fundamental?
Sin `/sdd-planning`, el equipo pasa directo de la idea al código sin definir arquitectura ni contratos de datos, provocando deuda técnica, tipos inseguros (`any`) y acoplamiento descontrolado. Este comando genera el documento **`docs/specs/XX-nombre/plan.md`**, el cual establece:

- **Arquitectura y flujo técnico:** Modela las capas del sistema (presentación, casos de uso, dominio, repositorios) y diseña diagramas de secuencia en Mermaid.
- **Contratos de datos tipados:** Traduce los datos funcionales a interfaces, DTOs y validadores en tiempo de ejecución (Zod, Pydantic, etc.) sin tipos ambiguos.
- **Modelo de persistencia:** Especifica esquemas de base de datos, relaciones, índices y estrategias de migración.
- **División en Vertical Slices:** Descompone la funcionalidad en rebanadas verticales independientes y entregables que atraviesan el sistema de extremo a extremo.

### 6. `/sdd-task`: Desglose Atómico de Tareas TDD

> **Secuenciación de tareas:** Descompone el plan técnico en un checklist atómico, trazable y verificable bajo ciclo TDD (Red-Green-Refactor) y rebanadas verticales (_Vertical Slices_).

#### Modo de uso:

```text
/sdd-task [no necesita contexto, la IA lo genera automáticamente]
```

#### ¿Por qué es fundamental?
Sin `/sdd-task`, los desarrolladores y la IA abordan el desarrollo de forma monolítica o desordenada, dejando cabos sueltos e implementaciones a medias. Este comando genera el documento **`docs/specs/XX-nombre/tasks.md`**, el cual establece:

- **Ciclo TDD explícito:** Cada ítem declara su fase precisa (`[RED: Whitebox]`, `[GREEN: Impl]`, `[REFACTOR]`, `[RED: Blackbox]`, `[GREEN: Blackbox Pass]`).
- **Trazabilidad directa:** Cada tarea enlaza formalmente al requisito (`RF-XX.Y`) y escenario Gherkin (`SC-XX.Y.Z`) que resuelve.
- **Vertical Slices cerrados:** Agrupa el trabajo en entregables completos e independientes que garantizan que ningún flujo quede a medio implementar.
- **Auditoría física de avance:** Establece un checklist tangible (`[ ]` / `[x]`) para monitorear el progreso exacto.

### 7. `/sdd-execution`: Ejecución Paso a Paso y Validación Dual

> **Implementación física guiada:** Motor de desarrollo que procesa las tareas de `tasks.md`, escribe el código en `src/`, ejecuta los tests en consola y asegura la Validación Dual.

#### Modo de uso:

```text
/sdd-execution [establecer el número de tareas a ejecutar o presionar enter para ejecutar todas]
```

#### ¿Por qué es fundamental?
Sin `/sdd-execution`, la IA suele escribir código sin ejecutar pruebas, asumir que todo compila o dar por cerrado el trabajo sin evidencia. Este comando actúa como el motor de ejecución riguroso que:

- **Aplica TDD real:** Crea primero el test que falla (`RED`), genera el código mínimo para ponerlo en verde (`GREEN`), y aplica mejoras y linters (`REFACTOR`).
- **Validación Dual obligatoria:** Ninguna tarea o slice se da por concluido si no supera simultáneamente las pruebas de Caja Blanca (unitarias/estructurales) y Caja Negra (aceptación BDD Gherkin).
- **Cierre físico verificable:** Ejecuta los comandos en la terminal y solo tras validar el resultado en verde marca físicamente la tarea (`[x]`) en `tasks.md`.

---

## 🚀 Despliegue y Fork

Consulta la guía detallada en [DEPLOY.md](DEPLOY.md) para aprender a subir tu propio fork a GitHub y configurar tus URLs canónicas.
