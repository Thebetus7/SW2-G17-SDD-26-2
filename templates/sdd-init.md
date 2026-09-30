# SDD-Init: Inicializador de AGENTS.md

Cuando el usuario invoque `/sdd-init`, copia y pega directamente la siguiente plantilla estándar en el archivo `AGENTS.md` de la raíz del proyecto (creándolo si no existe o reemplazando la plantilla base, adaptando los comandos oficiales según las herramientas del proyecto):

---

```markdown
# Guía Operativa de Desarrollo y Contexto Maestro (AGENTS.md)

Este documento es la referencia operativa y arquitectónica para el desarrollo del proyecto bajo la metodología SDD (Spec-Driven Development).

---

## 1. Jerarquía de Verdad y Precedencia Innegociable

Ante cualquier duda o discrepancia durante el desarrollo, la precedencia obligatoria es:

1. `docs/constitution.md`: Constitución del Proyecto. Define la verdad absoluta: visión del producto, principios innegociables de ingeniería, stack tecnológico base, arquitectura y roadmap. Nada puede contradecirla.
2. `docs/specs/XX/spec.md`: Especificación Funcional. Define el QUÉ funcional mediante requerimientos de negocio, contratos de datos y criterios de aceptación observables (sintaxis EARS y Gherkin).
3. `docs/specs/XX/plan.md`: Plan Técnico & Runtime. Define el CÓMO técnico: arquitectura detallada, contratos tipados, garantías de runtime/persistencia y división en Vertical Slices.
4. `docs/specs/XX/tasks.md`: Checklist Atómico de Tareas. Secuencia de tareas atómicas para ejecución bajo ciclo TDD (Red-Green-Refactor) con validación dual.
5. Código Fuente (`src/` o `lib/`) y Tests (`tests/` o `test/`): La implementación física y sus baterías de verificación automatizada. Si el código diverge de la especificación o el plan, el código está incorrecto.

---

## 2. Principios de Copiloto Técnico Senior y Desarrollo Ágil

1. **Autonomía de Criterio Técnico (Senior Defaults)**:
   - Al implementar cualquier requerimiento, la IA orquesta proactivamente todas las configuraciones, ciclos de vida y conexiones técnicas que por lógica requiere un software maduro (ej. sincronización de esquemas, migraciones en persistencia, manejo de errores, estados de carga/vacío y liberación de recursos).
   - Se prohíbe dejar flujos incompletos o a medio conectar (ej. crear datos sin proveer su visualización o persistencia coherente).
2. **Ergonomía sin Sobre-Especificación de UI**:
   - Las especificaciones definen las reglas de negocio y los contratos de datos; la IA es responsable de diseñar interfaces limpias, accesibles y flujos CRUD completos y funcionales de punta a punta.
3. **Validación Dual Obligatoria**:
   - Todo cambio de código debe superar simultáneamente las pruebas de Caja Blanca (unitarias/estructurales) y las de Caja Negra (BDD con escenarios observables).
4. **Calidad de Código y Tipado Estricto**:
   - Cero tolerancia a advertencias de linters, código muerto o tipos inseguros (`any`).

---

## 3. Estructura Canónica de Directorios

```text
.
├── AGENTS.md                        <-- Guía de contexto, comandos y reglas maestras
├── docs/
│   ├── constitution.md              <-- Constitución del proyecto (misión, stack, roadmap)
│   └── specs/
│       ├── 01-modulo/
│       │   ├── spec.md              <-- Requerimientos EARS, Gherkin y contratos
│       │   ├── plan.md              <-- Arquitectura técnica, runtime y Vertical Slices
│       │   └── tasks.md             <-- Checklist atómico TDD
├── src/                             <-- Código de producción (o lib/)
└── tests/                           <-- Suites de tests (o test/)
```

---

## 4. Comandos Oficiales del Proyecto

| Acción | Comando |
| :--- | :--- |
| Levantar Entorno Dev | `...` |
| Tests Caja Blanca (Unit) | `...` |
| Tests Caja Negra (BDD) | `...` |
| Suite Completa & Cobertura | `...` |
| Formato y Linter | `...` |
| Migraciones / Esquema DB | `...` |
```
