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

### Pilar 2: Tech Stack & Arquitectura
- **Frontend / UI**: Framework, librería de componentes, motor de estilos, gestión de estado.
- **Backend / API**: Lenguaje, framework de servidor, patrón de arquitectura (Clean Architecture, Modular Monolith, Hexagonal).
- **Base de Datos & Persistencia**: Motor de base de datos (PostgreSQL, Supabase, SQLite, Mongo), ORM / Query Builder, estrategia de migraciones.
- **Diseño Creativo & UX/UI**: Paleta de colores, tipografías, principios de diseño, diseño responsive y accesibilidad.

### Pilar 3: Roadmap & Decisiones de Infraestructura
- **Entorno de Contenedores**: ¿Se utilizará Docker / Docker Compose para desarrollo local y producción?
- **Gestión de Credenciales & Configuración**: ¿Estrategia centralizada con `.env` / `.env.example`, o gestores de secretos (Vault, Doppler)? Prohibición estricta de hardcodear llaves o credenciales.
- **Estrategia Git y Ramas**: Convención de commits (Conventional Commits: `feat:`, `fix:`, `chore:`), flujos de ramas (`main`, `develop`, feature branches) y política de Pull Requests.
- **Milestones del Roadmap**: Fases iniciales de entrega (Fase 1: MVP Core, Fase 2: Integraciones, Fase 3: Hardening y Despliegue).

### Pilar 4: Principios Innegociables (Core Principles)
- **Principio 1 (Spec-First)**: Ninguna línea de código de producción se escribe sin su correspondiente especificación aprobada en `docs/specs/`.
- **Principio 2 (Validación Dual)**: Cada feature debe demostrar el cumplimiento de los tests unitarios y la satisfacción de los escenarios Gherkin.
- **Principio 3 (Seguridad y Privacidad)**: Validación estricta de entradas en los bordes del sistema (Zero Trust).
- **Principio 4 (Idempotencia y Transaccionalidad)**: Mutaciones de datos seguras y recuperables ante fallos.

### Pilar 5: Procedimientos Operativos (Comandos Oficiales)
Definición de los scripts estándar que el asistente debe usar para interactuar con el proyecto:
- Levantar entorno local / dev: `npm run dev` / `docker compose up`
- Ejecutar tests: `npm test` / `pytest`
- Linters y formato: `npm run lint` / `npm run format`
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

## 2. Tech Stack y Arquitectura
- **Frontend**: [Detalles de UI]
- **Backend / Servicios**: [Detalles de servidor]
- **Persistencia**: [Base de datos y ORM]
- **Diseño y Estética**: [Reglas de UX/UI]

---

## 3. Infraestructura y Roadmap
- **Contenedores (Docker)**: [Configuración definida]
- **Credenciales y Entornos**: [Uso de .env y seguridad]
- **Flujo Git**: [Conventional commits y ramas]
- **Fases del Roadmap**: [Milestones planificados]

---

## 4. Principios Innegociables
1. [Principio 1]
2. [Principio 2]
3. [Principio 3]

---

## 5. Comandos Oficiales del Proyecto
| Acción | Comando |
| :--- | :--- |
| Levantar Dev | `...` |
| Ejecutar Tests | `...` |
| Formatear / Lint | `...` |
```
