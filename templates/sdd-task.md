# SDD-Task: Desglose Atómico de Tareas TDD (SDD)

Este workflow analiza de manera autónoma el plan técnico (`docs/specs/XX-nombre/plan.md`) y la especificación funcional (`docs/specs/XX-nombre/spec.md`) para desglosar el desarrollo en un checklist secuencial, trazable y verificable en `docs/specs/XX-nombre/tasks.md`.

> **Metodología Ágil TDD y Validación Dual**: Cada tarea es atómica y sigue estrictamente el ciclo **Red-Green-Refactor**. El trabajo se divide en *Vertical Slices* (rebanadas verticales de extremo a extremo), asegurando que ningún slice quede con flujos abiertos o incompletos. No requiere entrevista obligatoria; se genera directamente a partir del plan técnico.

---

## 1. Resolución del Módulo a Desglosar (`[XX.]`)

Cuando el usuario invoque este workflow (`/sdd-task`):

1. **Invocación con Argumento `[XX.]` o `[XX]`** (ej. `/sdd-task 01.` o `/sdd-task 01`):
   - Extrae el identificador numérico indicado.
   - Localiza en `docs/specs/` la carpeta correspondiente que contenga `plan.md` y `spec.md` (ej. `docs/specs/01-auth/`).
2. **Invocación sin Argumento**:
   - Escanea el directorio `docs/specs/`.
   - Selecciona automáticamente el último módulo disponible con `plan.md` y notifica al usuario qué módulo se está desglosando.
3. Si el módulo no existe o carece de `plan.md`, alerta al usuario indicando que debe ejecutarse previamente la fase `/sdd-planning`.

---

## 2. Convención de Tareas Atómicas y Fases TDD

Cada tarea debe contener su identificador por slice (`[T-X.Y]`), su etiqueta de fase TDD explícita y su referencia de trazabilidad a la especificación:

- `[RED: Whitebox]`: Creación del test unitario de Caja Blanca que falla antes de escribir el código fuente.
- `[GREEN: Impl]`: Implementación del código mínimo necesario para poner el test en verde.
- `[REFACTOR]`: Limpieza, optimización y cumplimiento de linters sin alterar el comportamiento observable.
- `[RED: Blackbox SC-XX.Y.Z]`: Creación del test de aceptación de Caja Negra basado directamente en el escenario Gherkin correspondiente.
- `[GREEN: Blackbox Pass]`: Cableado e integración de extremo a extremo hasta poner el escenario de Caja Negra en verde.
- `[VERIFY]`: Ejecución del comando de prueba o build correspondiente al cierre del slice.

---

## 3. Plantilla Oficial de Salida: `docs/specs/XX-nombre/tasks.md`

El asistente redactará el archivo final con esta estructura formal y completa:

```markdown
# Checklist de Tareas Técnicas: [Nombre del Módulo o Feature]

> Módulo: `docs/specs/XX-nombre/` | Plan Técnico: `plan.md` | Especificación: `spec.md` | Estado: Pendiente de Ejecución

---

## 1. Resumen y Trazabilidad del Desglose

- **Módulo**: [Nombre del feature]
- **Objetivo**: Implementación guiada por pruebas (TDD) y validación dual (Caja Blanca + Caja Negra).
- **Historias y Requisitos Cubiertos**:
  - `HU-01` -> `RF-01.1`, `RF-01.2` -> `SC-01.1.1`, `SC-01.1.2`
  - `HU-02` -> `RF-02.1` -> `SC-02.1.1`, `SC-02.1.2`

---

## 2. Desglose en Vertical Slices (Ciclo TDD)

### Slice 1: Contratos, DTOs y Validación de Entrada
*Objetivo: Establecer los contratos de datos fuertemente tipados y las reglas de validación en los bordes (Zero Trust).*

- [ ] `[T-1.1]` **[RED: Whitebox]** Crear tests unitarios en `test/whitebox/` para validar esquemas de entrada de `[FeatureName]InputDTO` (campos requeridos, tipos y límites).
- [ ] `[T-1.2]` **[GREEN: Impl]** Implementar el validador de esquema (Zod / Joi / ClassValidator) y la interfaz DTO hasta que `[T-1.1]` pase en verde.
- [ ] `[T-1.3]` **[REFACTOR]** Tipado estricto sin `any`, inmutabilidad (`readonly`) y verificación de linters.
- [ ] `[T-1.4]` **[VERIFY]** Ejecutar suite de validación unitaria y comprobar que todos los tests pasen exitosamente.

---

### Slice 2: Lógica de Dominio, Casos de Uso y Persistencia
*Objetivo: Implementar las reglas de negocio, transacciones atómicas y el almacenamiento de datos.*

- [ ] `[T-2.1]` **[RED: Whitebox]** Crear tests unitarios para el servicio `[FeatureName]Service` mockeando el repositorio, evaluando cálculo exitoso y lanzamiento de excepciones de dominio (`RF-01.1`, `RF-01.2`).
- [ ] `[T-2.2]` **[GREEN: Impl]** Implementar la lógica del servicio y entidades de dominio hasta que `[T-2.1]` pase en verde.
- [ ] `[T-2.3]` **[RED: Whitebox]** Crear tests de integración para el repositorio `[FeatureName]Repository` (persistencia y transacciones atómicas).
- [ ] `[T-2.4]` **[GREEN: Impl]** Implementar el adaptador de persistencia y migraciones de base de datos.
- [ ] `[T-2.5]` **[REFACTOR]** Aplicar inversión de dependencias, manejo defensivo de errores y eliminación de código duplicado.
- [ ] `[T-2.6]` **[VERIFY]** Ejecutar suite de pruebas de dominio y comprobar ejecución 100% verde.

---

### Slice 3: Capa de Presentación / API e Integración de Flujo
*Objetivo: Exponer el endpoint o interfaz gráfica y verificar los criterios de aceptación BDD de Caja Negra.*

- [ ] `[T-3.1]` **[RED: Blackbox SC-01.1.1]** Escribir test de aceptación funcional para el flujo exitoso (Happy Path) en `test/blackbox/`.
- [ ] `[T-3.2]` **[RED: Blackbox SC-01.1.2]** Escribir test de aceptación funcional para casos de borde o error (Edge Case / Unwanted Behavior) en `test/blackbox/`.
- [ ] `[T-3.3]` **[GREEN: Impl]** Implementar el controlador / endpoint HTTP o componente UI conectándolo al servicio.
- [ ] `[T-3.4]` **[GREEN: Blackbox Pass]** Ejecutar la suite de Caja Negra hasta que `[T-3.1]` y `[T-3.2]` pasen 100% en verde.
- [ ] `[T-3.5]` **[REFACTOR]** Pulir códigos de estado HTTP, logging estructurado sin datos sensibles y sanitización de respuestas.
- [ ] `[T-3.6]` **[VERIFY]** Ejecutar suite completa de extremo a extremo del slice.

---

## 3. Validación Dual y Checklist de Cierre

Antes de dar por concluida la implementación del módulo, deben cumplirse obligatoriamente los siguientes gates de calidad:

- [ ] **Gate 1 (Caja Blanca)**: Suite completa de pruebas unitarias al 100% verde (`npm run test:unit` o equivalente).
- [ ] **Gate 2 (Caja Negra)**: Todos los escenarios Gherkin (`SC-XX.Y.Z`) verificados y pasando en verde (`npm run test:e2e` o equivalente).
- [ ] **Gate 3 (Estándares de Código)**: Linter y formateador ejecutados con 0 errores y 0 warnings (`npm run lint` / `npm run check`).
- [ ] **Gate 4 (Tipado Estricto)**: Compilación exitosa del proyecto sin `any` ni evasiones de tipos (`npm run build` o `tsc --noEmit`).
- [ ] **Gate 5 (Invariantes Técnicas)**: Manejo explícito de excepciones, atomicidad confirmada y ausencia de dependencias circulares.
```
