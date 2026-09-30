# SDD-Execution: Ejecución Paso a Paso y Validación Dual (SDD)

Este workflow guía al asistente de IA en la **implementación física del código**, resolviendo las tareas de `docs/specs/XX-feature/tasks.md` una por una bajo validación dual.

---

## 1. Reglas de Ejecución del Asistente
1. **Una tarea a la vez**: Toma la primera tarea pendiente (`[ ]`) del archivo `tasks.md`.
2. **Ciclo TDD Estricto**:
   - Primero escribe el test (Caja Blanca / Roja).
   - Confirma que falla por la razón esperada.
   - Escribe el código en `src/` estrictamente necesario para ponerlo en verde.
   - Refactoriza y limpia linter sin romper ningún test previo.
3. **Cierre Físico**: Marca la tarea con una `[x]` en `tasks.md` inmediatamente después de verificarla.
4. **Validación Dual Obligatoria**:
   - Tests de Caja Blanca en verde (`npm run test:unit`).
   - Tests de Caja Negra en verde (`npm run test:e2e`).
   - Linters y chequeo de tipos en verde (`npm run lint`, `npm run typecheck`).

---

## 2. Matriz de Validación Dual

| Tarea / Criterio | Test de Caja Blanca (Unit) | Test de Caja Negra (Aceptación / BDD) | Estado |
| :--- | :--- | :--- | :--- |
| `[T-1.1]` Contratos | `contracts.spec.ts` (Pass) | N/A | ✔ Pass |
| `[T-2.1]` Caso de Uso | `usecase.spec.ts` (Pass) | N/A | ✔ Pass |
| `[T-3.2]` Flujo E2E | `service.spec.ts` (Pass) | `feature.spec.ts` (Gherkin Happy Path) | ✔ Pass |

---

## 3. Criterio de Aceptación Final
El feature se considera terminado solo cuando todas las casillas de `tasks.md` estén marcadas con `[x]` y la suite de tests completa pase al 100%.
