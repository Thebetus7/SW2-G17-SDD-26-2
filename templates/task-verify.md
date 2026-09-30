# Task-Verify: Verificación TDD y Validación Dual (SDD)

Este workflow formaliza la validación cruzada: que el código implementado satisfaga tanto los tests automatizados como la especificación funcional.

---

## 1. Ciclo Red-Green-Refactor (TDD)

### Paso 1: Red (Fallo inicial comprobado)
- [ ] Escribir el test antes de la implementación con base en el escenario Gherkin.
- [ ] Ejecutar el test y confirmar que falla por la razón correcta (no por error de sintaxis).

### Paso 2: Green (Implementación mínima requerida)
- [ ] Escribir el código estrictamente necesario para que el test pase.
- [ ] Ejecutar la suite de pruebas y confirmar que pasa exitosamente.

### Paso 3: Refactor (Limpieza sin alterar comportamiento)
- [ ] Eliminar duplicidad, mejorar nombres y extraer utilidades.
- [ ] Comprobar que todos los tests continúen en verde.

---

## 2. Matriz de Validación Dual

| Escenario de Spec / Criterio | Test Automatizado Asociado | Estado (Pass/Fail) | Comentarios / Evidencia |
| :--- | :--- | :--- | :--- |
| Happy Path | `feature.spec.ts:L15` | ✔ Pass | Comportamiento verificado |
| Error handling (Edge Case) | `feature.spec.ts:L35` | ✔ Pass | Error específico emitido |

---

## 3. Checklist de Cierre y Verificación Fina

- [ ] Linter y formateador ejecutados sin advertencias ni errores.
- [ ] No existen `console.log` de depuración ni código muerto.
- [ ] Todas las invariantes de la especificación fueron respetadas.
