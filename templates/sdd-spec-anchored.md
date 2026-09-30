# SDD-Spec-Anchored: Iteración y Evolución Anclada a Especificación (SDD)

Este workflow gestiona la **evolución de un feature existente**. Cuando un requerimiento cambia o se añaden capacidades a un módulo previo en `docs/specs/XX-feature/`, este flujo orquesta la actualización en cascada sin perder trazabilidad.

---

## 1. Misión Operativa del Asistente
Cuando se solicite una iteración sobre un spec existente:
1. **Actualizar el Spec**: Modifica `docs/specs/XX-feature/spec.md` reflejando los nuevos requerimientos y escenarios Gherkin.
2. **Adaptar el Plan Técnico**: Ejecuta la adaptación en `docs/specs/XX-feature/plan.md` analizando los impactos en arquitectura e interfaces.
3. **Generar Nuevas Tareas**: Añade las tareas atómicas adicionales al final de `docs/specs/XX-feature/tasks.md` manteniendo el historial de las tareas ya completadas.
4. **Disparar Re-Ejecución**: Invoca `/sdd-execution` para completar las nuevas tareas bajo validación dual.
