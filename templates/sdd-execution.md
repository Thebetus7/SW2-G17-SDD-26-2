# SDD-Execution: Ejecución Paso a Paso y Validación Dual (SDD)

Este workflow guía al asistente de IA en la **implementación física del código**, resolviendo las tareas de `docs/specs/XX-nombre/tasks.md` bajo el ciclo TDD y validación dual (Caja Blanca + Caja Negra).

---

## 1. Resolución del Módulo a Ejecutar (`[XX.]`)

Cuando el usuario invoque este workflow (`/sdd-execution`):

1. **Invocación con Argumento `[XX.]` o `[XX]`** (ej. `/sdd-execution 01.` o `/sdd-execution 01`):
   - Extrae el identificador numérico indicado.
   - Localiza en `docs/specs/` la carpeta correspondiente (ej. `docs/specs/01-auth/tasks.md`).
2. **Invocación sin Argumento**:
   - Escanea el directorio `docs/specs/`.
   - Selecciona automáticamente el último módulo disponible con tareas pendientes y notifica al usuario.
3. Si el módulo no existe o carece de `tasks.md`, alerta al usuario indicando que debe ejecutarse previamente la fase `/sdd-task`.

---

## 2. Mapa de Contexto del Agente

Antes de escribir cualquier línea de código, el asistente debe inspeccionar:
- `docs/constitution.md`: Stack tecnológico, estándares de codificación y comandos del proyecto (test, build, lint).
- `docs/specs/XX-nombre/spec.md`: Escenarios Gherkin `SC-XX.Y.Z` y datos funcionales.
- `docs/specs/XX-nombre/plan.md`: Contratos tipados, diagrama de secuencia y persistencia.
- `docs/specs/XX-nombre/tasks.md`: Lista de tareas pendientes (`[ ]`).

---

## 3. Protocolo de Ejecución TDD (Simple y Directo)

El asistente toma la primera tarea pendiente (`[ ]`) del archivo `tasks.md` y aplica el ciclo correspondiente:

1. **Si la tarea es `[RED: Whitebox]`**:
   - Crea el test unitario en `test/whitebox/`.
   - Ejecuta el comando de test y confirma que falla por la causa esperada.
2. **Si la tarea es `[GREEN: Impl]`**:
   - Implementa el código mínimo necesario en `src/`.
   - Ejecuta el comando de test y confirma que pasa al 100% en verde.
3. **Si la tarea es `[REFACTOR]`**:
   - Limpia y optimiza el código respetando los estándares de codificación.
   - Ejecuta linters y tests existentes, garantizando cero regresiones y cero errores de linter.
4. **Si la tarea es `[RED: Blackbox SC-XX.Y.Z]`**:
   - Crea el test de aceptación en `test/blackbox/` mapeado al escenario Gherkin correspondiente.
   - Ejecuta el comando y confirma que falla porque el flujo aún no está conectado.
5. **Si la tarea es `[GREEN: Blackbox Pass]`**:
   - Conecta el endpoint o componente UI hasta que el escenario de Caja Negra pase en verde.
6. **Si la tarea es `[VERIFY]`**:
   - Ejecuta la suite de pruebas o typecheck correspondiente al cierre del slice.

---

## 4. Cierre Físico Inmediato en `tasks.md`

- Inmediatamente después de verificar que el comando de test fue exitoso, el asistente actualiza `docs/specs/XX-nombre/tasks.md` marcando la tarea con una `[x]`.
- Prohibido marcar tareas como completadas sin haber ejecutado y verificado físicamente los comandos de prueba.

---

## 5. Invariantes Universales del Agente

Durante toda la ejecución, el asistente respeta estrictamente estas 5 reglas:
1. **Cero código sin test previo**: Ninguna función o lógica de dominio se escribe sin un test en rojo previo.
2. **Tipado estricto (Zero Any)**: Prohibido introducir `any` o conversiones de tipos inseguras.
3. **Cero regresiones**: Todo cambio debe mantener en verde la suite de tests previamente implementada.
4. **Manejo defensivo de errores**: Prohibido silenciar excepciones o usar bloques catch vacíos.
5. **Linter limpio**: Cada paso finaliza con 0 errores y 0 warnings en los comandos de validación.

---

## 6. Formato de Reporte al Usuario

Tras completar la tarea, el asistente proporciona un resumen breve y directo:
- **Tarea completada**: Identificador y descripción de la tarea (ej. `[T-1.1]`).
- **Comando y resultado**: Comando ejecutado y resultado obtenido (ej. `npm test -> 3 tests passed`).
- **Estado de tasks.md**: Confirmación de la casilla `[x]` actualizada.
- **Siguiente paso sugerido**: La próxima tarea pendiente en la secuencia.
```
