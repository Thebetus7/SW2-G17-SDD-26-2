# SDD-Execution: Ejecución Paso a Paso, Autonomía Técnica y Validación Dual (SDD)

Este workflow guía al asistente de IA en la **implementación física del código**, resolviendo las tareas de `docs/specs/XX-nombre/tasks.md` bajo el ciclo TDD y validación dual (Caja Blanca + Caja Negra).

> **Mandato de Copiloto Técnico Senior**:
> Al implementar código (`[GREEN: Impl]` o `[GREEN: Blackbox Pass]`), la IA no actúa como un transcriptor ciego. **Tiene la autonomía y la responsabilidad de incorporar todas las configuraciones, ciclos de vida y protecciones estándar del framework** (ej. migraciones de datos, manejo de errores de I/O, estados de carga/vacío y liberación de recursos) necesarias para que el software sea robusto en el mundo real, aunque la tarea no lo describa palabra por palabra.

---

## 1. Resolución del Módulo a Ejecutar (`[XX.]`)

Cuando el usuario invoque este workflow (`/sdd-execution`):
1. **Con Argumento `[XX.]` o `[XX]`**: Localiza la carpeta correspondiente en `docs/specs/` con `tasks.md`.
2. **Sin Argumento**: Selecciona automáticamente el último módulo disponible con tareas pendientes.

---

## 2. Mapa de Contexto del Asistente

Antes de escribir cualquier línea de código, el asistente debe inspeccionar:
- `docs/constitution.md`: Stack tecnológico, estándares de codificación y comandos del proyecto.
- `docs/specs/XX-nombre/spec.md`: Escenarios Gherkin `SC-XX.Y.Z` y datos funcionales.
- `docs/specs/XX-nombre/plan.md`: Contratos tipados, persistencia física y diagramas de secuencia.
- `docs/specs/XX-nombre/tasks.md`: Lista de tareas pendientes (`[ ]`).

---

## 3. Protocolo de Ejecución TDD con Criterio de Copiloto

El asistente toma la primera tarea pendiente (`[ ]`) del archivo `tasks.md` y aplica el ciclo correspondiente:

1. **Si la tarea es `[RED: Whitebox]`**:
   - Crea el test unitario o de repositorio.
   - Ejecuta el comando de test y confirma que falla por la causa esperada.
2. **Si la tarea es `[GREEN: Impl]`**:
   - Implementa el código de producción necesario en `src/` (o `lib/`).
   - Aplica buenas prácticas de ingeniería (manejo seguro de errores, inmutabilidad, persistencia robusta).
   - Ejecuta el comando de test y confirma que pasa al 100% en verde.
3. **Si la tarea es `[REFACTOR]`**:
   - Limpia y optimiza el código respetando los estándares de codificación.
   - Ejecuta linters y tests existentes, garantizando cero regresiones y cero errores estáticos.
4. **Si la tarea es `[RED: Blackbox SC-XX.Y.Z]`**:
   - Crea el test de aceptación mapeado al escenario Gherkin correspondiente.
   - Ejecuta el comando y confirma que falla porque el flujo aún no está conectado.
5. **Si la tarea es `[GREEN: Blackbox Pass]`**:
   - Conecta el componente UI o endpoint con los controladores hasta que el escenario de Caja Negra pase en verde.
   - Asegura una experiencia de usuario limpia, ergonómica y con flujo cerrado.
6. **Si la tarea es `[VERIFY]`**:
   - Ejecuta la suite de pruebas completa, análisis de linters y verificaciones en runtime real.

---

## 4. Cierre Físico Inmediato en `tasks.md`

- Inmediatamente después de verificar que el comando de test o verificación fue exitoso, el asistente actualiza `docs/specs/XX-nombre/tasks.md` marcando la tarea con una `[x]`.
- Prohibido marcar tareas como completadas sin haber ejecutado y verificado físicamente los comandos de prueba.
