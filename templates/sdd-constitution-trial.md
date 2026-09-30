# SDD-Constitution-Trial: Constitución del Proyecto (Entrevista y Acuerdos Innegociables)

Este workflow guía al asistente de IA en una **entrevista exhaustiva e interactiva** con el usuario para definir las bases inquebrantables del proyecto y redactar el archivo fundamental `docs/constitution.md`.

---

## 1. Misión Operativa del Asistente (Modo Entrevista / Grill-Me)

Cuando el usuario invoque este workflow (`/sdd-constitution-trial`):

1. **Auditoría Previa**:
   - Inspecciona si ya existe `docs/constitution.md`. Si existe, lee sus secciones y pregunta al usuario si desea refinar puntos específicos o agregar nuevos módulos.
2. **Entrevista Activa (Preguntas una a una o en bloques guiados)**:
   - Haz cuantas preguntas sean necesarias para aclarar completamente la visión, el stack y las decisiones operativas sin asumir nada por tu cuenta.
   - Profundiza en cada uno de los 5 pilares estructurales detallados a continuación.
3. **Generación del Artefacto**:
   - Redacta de forma estructurada y profesional el archivo `docs/constitution.md` al finalizar el consenso.

---

## 2. Los 5 Pilares de la Constitución

### Pilar 1: Misión y Propósito del Proyecto
- **Declaración de Misión**: ¿Qué problema real del mundo resuelve este software y para quién?
- **Core Concepts (Conceptos Clave del Dominio)**: Términos del negocio innegociables (lenguaje ubicuo de Domain-Driven Design).
- **Límites del Proyecto (Out of Scope)**: Qué cosas **NO** hará este sistema bajo ninguna circunstancia.

### Pilar 2: Tech Stack, Arquitectura & Suite de Testing
- **Frontend / UI**: Framework, librería de componentes, motor de estilos, gestión de estado.
- **Backend / API**: Lenguaje, framework de servidor, patrón de arquitectura (Clean Architecture, Modular Monolith, Hexagonal).
- **Base de Datos & Persistencia**: Motor de base de datos (PostgreSQL, Supabase, SQLite, Mongo), ORM / Query Builder, estrategia de migraciones.
- **Diseño Creativo & UX/UI**: Paleta de colores, tipografías, principios de diseño, diseño responsive y accesibilidad.
- **Ecosistema de Testing (Elección Autónoma de la IA)**:
  - La IA evaluará el stack elegido y seleccionará autónomamente la combinación más eficiente, moderna y rápida de herramientas para:
    - **Caja Negra / Aceptación (BDD & E2E / API)**: Herramientas óptimas según el tipo de app (ej. Playwright, Cypress, Supertest, Vitest E2E o Cucumber).
    - **Caja Blanca / Estructural (Unit & Integration TDD)**: Runner nativo y rápido (ej. Vitest, Jest, PyTest, Go test) con reporte de cobertura de ramas (Branch Coverage).
- **Estándares de Codificación & Linters (Code Standards)**:
  - **Tipado Estricto**: Prohibición explícita de tipos inseguros (`any` en TypeScript), validación de esquema en tiempo de ejecución (Zod, Pydantic, etc.).
  - **Convenciones de Nomenclatura**: Nombres descriptivos y semánticos (`camelCase` para funciones/variables, `PascalCase` para clases/tipos/componentes, `kebab-case` para archivos y endpoints).
  - **Formateo y Análisis Estático**: Herramientas seleccionadas por la IA (ESLint, Prettier, Biome, Ruff, Clippy).
  - **Pureza y Determinismo**: Preferencia por funciones puras, inmutabilidad de datos y aislamiento estricto de efectos secundarios (*side effects*).
  - **Manejo de Errores Tipado**: Prohibición de silenciar errores en bloques `catch` vacíos; uso de errores de dominio explícitos o patrones de resultado (`Result<T, E>`).

### Pilar 3: Roadmap & Decisiones de Infraestructura
- **Entorno de Contenedores**: ¿Se utilizará Docker / Docker Compose para desarrollo local y producción?
- **Gestión de Credenciales & Configuración**: ¿Estrategia centralizada con `.env` / `.env.example`, o gestores de secretos (Vault, Doppler)? Prohibición estricta de hardcodear llaves o credenciales.
- **Estrategia Git y Ramas**: Convención de commits (Conventional Commits: `feat:`, `fix:`, `chore:`), flujos de ramas (`main`, `develop`, feature branches) y política de Pull Requests.
- **Milestones del Roadmap**: Fases iniciales de entrega (Fase 1: MVP Core, Fase 2: Integraciones, Fase 3: Hardening y Despliegue).

### Pilar 4: Principios Innegociables (Core Principles & Quality Gates)
- **Principio 1 (Spec-First)**: Ninguna línea de código de producción se escribe sin su correspondiente especificación aprobada en `docs/specs/`.
- **Principio 2 (Validación Dual Obligatoria)**:
  - **Pruebas de Caja Blanca (White-Box)**: Todo servicio, cálculo o algoritmo de dominio debe tener tests unitarios que verifiquen branches, condiciones de borde (`edge cases`) y excepciones internas con cobertura demostrable.
  - **Pruebas de Caja Negra (Black-Box)**: Todo feature debe validar los escenarios de aceptación BDD (Gherkin) simulando el comportamiento observable por el cliente/usuario desde afuera, sin acoplarse a la implementación interna.
  - *Regla Inviolable*: Ninguna tarea o feature se considera terminado (`DONE`) si no supera simultáneamente ambas caras de la validación dual.
- **Principio 3 (Estándar de Calidad de Código)**: Código 100% libre de advertencias de linter, cero código comentado o muerto, tipado completo sin evasiones.
- **Principio 4 (Seguridad y Privacidad)**: Validación estricta de entradas en los bordes del sistema (Zero Trust).
- **Principio 5 (Idempotencia y Transaccionalidad)**: Mutaciones de datos seguras y recuperables ante fallos.

### Pilar 5: Procedimientos Operativos (Comandos Oficiales)
Definición de los scripts estándar que el asistente debe usar para interactuar con el proyecto:
- Levantar entorno local / dev: `npm run dev` / `docker compose up`
- Ejecutar tests de Caja Blanca (Unit): `npm run test:unit`
- Ejecutar tests de Caja Negra (E2E / Aceptación): `npm run test:e2e` / `npm run test:spec`
- Suite completa con cobertura: `npm test`
- Linters y formato: `npm run lint` / `npm run format`
- Type checking: `npm run typecheck`
- Migraciones de base de datos: `npm run db:migrate`

---

## 3. Plantilla de Salida: `docs/constitution.md`

El asistente estructurará el archivo final con este esquema Markdown:

```markdown
# Constitución del Proyecto: [Nombre del Proyecto]

> Versión: 1.0.0 | Estado: Activa y Vinculante

---

## 1. Misión y Dominio
- **Propósito**: [Descripción del valor aportado]
- **Core Concepts**: [Términos del negocio]
- **Límites (Out of Scope)**: [Lo que no se incluye]

---

## 2. Tech Stack, Arquitectura y Suite de Testing
- **Frontend**: [Detalles de UI]
- **Backend / Servicios**: [Detalles de servidor]
- **Persistencia**: [Base de datos y ORM]
- **Diseño y Estética**: [Reglas de UX/UI]
- **Suite de Testing (Selección Autónoma de la IA)**:
  - **Caja Negra / Aceptación (BDD & E2E)**: [Herramienta seleccionada, ej. Playwright / Supertest]
  - **Caja Blanca / Estructural (Unit TDD)**: [Runner seleccionado, ej. Vitest / Jest / PyTest]
- **Estándares de Codificación y Linters**:
  - **Tipado**: [Reglas de tipado estricto sin any]
  - **Linters / Formateador**: [Herramientas acordadas con la IA]
  - **Convenciones**: [Nomenclatura y manejo explícito de errores]

---

## 3. Infraestructura y Roadmap
- **Contenedores (Docker)**: [Configuración definida]
- **Credenciales y Entornos**: [Uso de .env y seguridad]
- **Flujo Git**: [Conventional commits y ramas]
- **Fases del Roadmap**: [Milestones planificados]

---

## 4. Principios Innegociables
1. **Spec-First**: Todo código responde a una especificación formal en `docs/specs/`.
2. **Validación Dual Obligatoria**: Superar simultáneamente los tests de Caja Blanca (unitarios) y los de Caja Negra (Gherkin BDD).
3. **Calidad de Código**: Cero advertencias de linter, tipado seguro y código limpio sin código muerto.
4. **Seguridad y Privacidad**: Validación estricta de inputs (Zero Trust).
5. **Idempotencia y Transaccionalidad**: Mutaciones seguras sin estados inconsistentes.

---

## 5. Comandos Oficiales del Proyecto
| Acción | Comando |
| :--- | :--- |
| Levantar Entorno Dev | `...` |
| Tests Caja Blanca (Unit) | `npm run test:unit` |
| Tests Caja Negra (E2E / BDD) | `npm run test:e2e` |
| Suite Completa & Cobertura | `npm test` |
| Formatear / Lint | `...` |
| Migraciones DB | `...` |
```
