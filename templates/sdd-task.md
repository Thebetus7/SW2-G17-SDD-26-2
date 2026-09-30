# SDD-Task: Desglose Atómico de Tareas TDD (SDD)

Este workflow analiza el plan técnico (`docs/specs/XX-nombre/plan.md`) y la especificación funcional (`docs/specs/XX-nombre/spec.md`) para desglosar el desarrollo en un checklist secuencial, trazable y verificable en `docs/specs/XX-nombre/tasks.md`.

> **Metodología Ágil TDD y Validación Dual**:
> Cada tarea es atómica y sigue el ciclo **Red-Green-Refactor**. El trabajo se divide en *Vertical Slices* (rebanadas verticales de extremo a extremo), garantizando flujos cerrados y funcionales.
> - **Cero micro-tareas cosméticas**: No se crean tareas para detalles mínimos de estilo; las tareas de presentación cubren vistas y controladores completamente conectados.
> - **Verificación real**: Incluye pruebas de integración con persistencia real y no solo entornos en memoria.

---

## 1. Resolución del Módulo a Desglosar (`[XX.]`)

Cuando el usuario invoque este workflow (`/sdd-task`):
1. **Con Argumento `[XX.]` o `[XX]`**: Localiza la carpeta correspondiente en `docs/specs/` con `plan.md` y `spec.md`.
2. **Sin Argumento**: Selecciona automáticamente el último módulo disponible con `plan.md`.

---

## 2. Convención de Tareas Atómicas y Fases TDD

Cada tarea contiene su identificador por slice (`[T-X.Y]`), su fase TDD y su trazabilidad:

- `[RED: Whitebox]`: Creación del test unitario o de repositorio que falla antes de escribir el código fuente.
- `[GREEN: Impl]`: Implementación del código de producción necesario para superar el test.
- `[REFACTOR]`: Limpieza, cumplimiento de linters y optimización sin romper funcionalidad.
- `[RED: Blackbox SC-XX.Y.Z]`: Creación del test de aceptación de Caja Negra basado en el escenario Gherkin.
- `[GREEN: Blackbox Pass]`: Conexión completa del controlador o vista hasta poner en verde el escenario observable.
- `[VERIFY]`: Ejecución del comando de prueba o build correspondiente al cierre del slice.

---

## 3. Plantilla Oficial de Salida: `docs/specs/XX-nombre/tasks.md`

```markdown
# Checklist de Tareas Técnicas: [Nombre del Módulo o Feature]

> Módulo: `docs/specs/XX-nombre/` | Plan Técnico: `plan.md` | Especificación: `spec.md` | Estado: Pendiente

---

## 1. Resumen y Trazabilidad del Desglose

- **Módulo**: [Nombre del feature]
- **Objetivo**: Implementación guiada por pruebas (TDD) y validación dual (Caja Blanca + Caja Negra).
- **Historias Cubiertas**: `HU-01` -> `RF-01.1` -> `SC-01.1.1`, `SC-01.1.2`

---

## 2. Desglose en Vertical Slices (Ciclo TDD)

### Slice 1: Contratos, Entidades y Validaciones en los Bordes
*Objetivo: Tipos de dominio inmutables, DTOs y validaciones de entrada.*
- [ ] `T1.1` `[RED: Whitebox]`: Crear tests unitarios para entidades y validaciones de DTOs.
- [ ] `T1.2` `[GREEN: Impl]`: Implementar entidades y validaciones de entrada.
- [ ] `T1.3` `[REFACTOR]`: Aplicar linters y tipado estricto.

### Slice 2: Persistencia Física y Resiliencia de Esquema
*Objetivo: Tablas, DAOs y repositorios con soporte de versiones y migraciones.*
- [ ] `T2.1` `[RED: Whitebox]`: Crear tests de integración para DAOs/repositorios y migraciones.
- [ ] `T2.2` `[GREEN: Impl]`: Implementar esquemas, repositorios y estrategia de migración limpia.
- [ ] `T2.3` `[REFACTOR]`: Optimizar consultas y confirmar transaccionalidad.

### Slice 3: Lógica de Aplicación y Gestión de Estado
*Objetivo: Casos de uso / controladores reactivos orquestando el flujo.*
- [ ] `T3.1` `[RED: Whitebox]`: Tests unitarios de controladores simulando estados (carga, éxito, error).
- [ ] `T3.2` `[GREEN: Impl]`: Implementar controladores y casos de uso.
- [ ] `T3.3` `[REFACTOR]`: Limpieza y desacoplamiento de infraestructura.

### Slice 4: Integración UI y Validación de Escenarios de Negocio (Caja Negra)
*Objetivo: Vistas ergonómicas completamente conectadas y escenarios Gherkin en verde.*
- [ ] `T4.1` `[RED: Blackbox SC-01.1.1]`: Crear test de aceptación para el flujo exitoso.
- [ ] `T4.2` `[GREEN: Blackbox Pass]`: Conectar UI con el controlador hasta superar el test observable.
- [ ] `T4.3` `[RED: Blackbox SC-01.1.2]`: Crear test de aceptación para el escenario de error/límite.
- [ ] `T4.4` `[GREEN: Blackbox Pass]`: Manejo observable del error en la interfaz.
- [ ] `T4.5` `[VERIFY]`: Ejecutar suite completa con linter y verificar flujo en runtime real.
```
