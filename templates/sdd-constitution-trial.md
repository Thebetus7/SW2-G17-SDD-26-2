# SDD-Constitution-Trial: Constitución del Proyecto (Propuesta Proactiva y Acuerdos Innegociables)

Este workflow guía al asistente de IA en una **entrevista proactiva y ágil** con el usuario para definir las bases arquitectónicas del proyecto y redactar el archivo maestro `docs/constitution.md`.

---

## 1. Misión Operativa del Asistente (Modo Copiloto Proactivo)

Cuando el usuario invoque este workflow (`/sdd-constitution-trial`):

1. **Auditoría Previa**:
   - Inspecciona si ya existe `docs/constitution.md`. Si existe, lee sus secciones y consulta si se desea refinar aspectos específicos.
2. **Propuesta Proactiva de la IA (Cero Interrogatorios Burocráticos)**:
   - A partir de la idea general o descripción de negocio que comparta el usuario, **la IA no formula un cuestionario masivo ni pregunta obviedades técnicas**.
   - La IA diseña y presenta directamente una **propuesta arquitectónica y técnica integral**, recomendando el stack óptimo, las convenciones de persistencia, la estrategia de testing y las invariantes de calidad.
   - El usuario solo valida, ajusta o aprueba la propuesta en 1 o 2 iteraciones breves.
3. **Generación del Artefacto**:
   - Redacta de forma estructurada el archivo `docs/constitution.md` al confirmarse el consenso.

---

## 2. Los 5 Pilares de la Constitución

### Pilar 1: Misión y Propósito del Proyecto
- **Declaración de Misión**: Problema real que resuelve el sistema y usuarios objetivo.
- **Core Concepts**: Vocabulario ubicuo del dominio (Domain-Driven Design).
- **Límites Claros (Out of Scope)**: Qué funcionalidades NO forman parte del alcance.

### Pilar 2: Tech Stack, Arquitectura & Suite de Testing
- **Frontend / UI**: Framework, gestión de estado y diseño ergonómico.
- **Backend / Servicios**: Arquitectura limpia (Clean Architecture / Hexagonal / Feature-First).
- **Persistencia & Runtime**: Motor de datos (PostgreSQL, SQLite/Drift, Supabase, etc.), ORM y estrategia de migraciones / evolución de esquema.
- **Suite de Testing (Selección Autónoma de la IA)**:
  - **Caja Negra / Aceptación (BDD & E2E)**: Validación de comportamiento observable desde la perspectiva del usuario.
  - **Caja Blanca / Estructural (Unit & Integration TDD)**: Runner nativo con cobertura de ramas lógicas.
- **Estándares de Código**: Tipado estricto (cero `any`), nomenclatura semántica, pureza funcional y manejo explícito de errores (tipos de fallo o patrón `Result<S, E>`).

### Pilar 3: Infraestructura, Credenciales y Roadmap
- **Entorno y Ejecución**: Contenedores, emuladores o tooling local.
- **Seguridad de Secretos**: Estrategia de variables de entorno (`.env`, `--dart-define`) sin hardcodear credenciales.
- **Control de Versiones**: Conventional Commits (`feat:`, `fix:`, `refactor:`, `test:`, `docs:`) y estrategia de ramas.
- **Roadmap**: Hitos incrementales de entrega (MVP Core, Integraciones, Hardening).

### Pilar 4: Principios Innegociables (Core Principles & Quality Gates)

1. **Principio 1 (Spec-First Ágil)**: Todo desarrollo responde a una especificación en `docs/specs/`, pero sin burocracia paralizante. Las especificaciones son ágiles y orientadas a valor de negocio.
2. **Principio 2 (Validación Dual Obligatoria)**: Cada feature debe superar simultáneamente las pruebas de Caja Blanca (unitarias/estructurales) y las de Caja Negra (BDD con escenarios observables).
3. **Principio 3 (Autonomía de Criterio Técnico y Senior Defaults)**:
   - La IA actúa como un copiloto técnico Senior: al implementar cualquier funcionalidad, **orquesta por defecto todas las configuraciones, ciclos de vida y conexiones técnicas que por lógica requiere un software maduro** (ej. inicialización sana de almacenamiento, control de versiones de esquema, manejo resiliente de errores, estados de carga/vacío y liberación de recursos).
   - El usuario no necesita recordar detalles obvios de plataforma o infraestructura; la IA los anticipa e implementa bajo las mejores prácticas de la industria.
4. **Principio 4 (Ergonomía y No Sobre-Especificación de UI)**:
   - Las especificaciones definen el QUÉ funcional (reglas de negocio y contratos de datos). Queda prohibido sobre-especificar la UI con minucias cosméticas (paddings, paletas exactas por píxel o micro-diálogos redundantes).
   - La IA tiene la autonomía de diseñar interfaces limpias, accesibles y con flujos CRUD completos y funcionales de punta a punta.
5. **Principio 5 (Calidad de Código y Tipado Estricto)**: Cero tolerancia a código muerto, advertencias de linters o evasiones de tipado.
6. **Principio 6 (Seguridad, Idempotencia y Transaccionalidad)**: Validación Zero Trust en las entradas y mutaciones de datos seguras y atómicas.

### Pilar 5: Procedimientos Operativos (Comandos Oficiales)
Definición de scripts de una sola línea para:
- Levantar entorno de desarrollo / dev server.
- Ejecutar tests de Caja Blanca (Unit).
- Ejecutar tests de Caja Negra (BDD / Aceptación).
- Suite completa con reporte de cobertura.
- Linters, formateadores y typecheck.
- Migraciones o sincronización de esquema de base de datos.

---

## 3. Plantilla de Salida: `docs/constitution.md`

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
- **Frontend / UI**: [Detalles de UI y gestión de estado]
- **Backend / Servicios**: [Detalles de servidor o capas de aplicación]
- **Persistencia & Runtime**: [Motor, ORM y estrategia de migraciones]
- **Suite de Testing**:
  - **Caja Negra / Aceptación (BDD)**: [Herramienta seleccionada]
  - **Caja Blanca / Estructural (Unit TDD)**: [Runner seleccionado]
- **Estándares de Codificación**: [Tipado estricto, linters y manejo explícito de errores]

---

## 3. Infraestructura y Roadmap
- **Entorno de Ejecución**: [Configuración definida]
- **Credenciales y Entornos**: [Uso de variables y seguridad]
- **Flujo Git**: [Conventional commits]
- **Fases del Roadmap**: [Milestones planificados]

---

## 4. Principios Innegociables
1. **Spec-First Ágil**: Código respaldado por especificaciones claras sin burocracia excesiva.
2. **Validación Dual Obligatoria**: Superar simultáneamente Caja Blanca y Caja Negra.
3. **Autonomía de Criterio Técnico (Senior Defaults)**: Orquestación proactiva de persistencia, migraciones y ciclo de vida.
4. **Ergonomía sin Sobre-Especificación UI**: Foco en reglas de negocio; la IA resuelve conexiones y flujos CRUD completos.
5. **Calidad de Código y Tipado Estricto**: Cero warnings, tipado seguro y código limpio.
6. **Idempotencia y Transaccionalidad**: Mutaciones seguras sin inconsistencias de estado.

---

## 5. Comandos Oficiales del Proyecto
| Acción | Comando |
| :--- | :--- |
| Levantar Entorno Dev | `...` |
| Tests Caja Blanca (Unit) | `...` |
| Tests Caja Negra (BDD / E2E) | `...` |
| Suite Completa & Cobertura | `...` |
| Formato & Linter | `...` |
| Migraciones / Esquema DB | `...` |
```
