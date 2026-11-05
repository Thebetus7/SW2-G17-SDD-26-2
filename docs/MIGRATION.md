# Migración al generador único y tareas verificables

## Comandos y adaptadores

- Eliminar `templates/sdd-spec-high.md`.
- Conservar el generador `sdd-spec-assisted` y actualizar las invocaciones antiguas de `sdd-spec`.
- Mantener `sdd-planning` como alias de `sdd-plan-tecnico`.
- Usar catálogo único `sdd/catalog.json`; no recomendar comandos no instalados.

Reejecutar el instalador para cada cliente utilizado, o `all`. Los archivos
reconocidos de los comandos retirados se copian a `.sdd/backups/` y se retiran de
las carpetas activas. Los artefactos no reconocidos se conservan con aviso; revisar
si son adaptaciones propias y migrarlos manualmente. Las copias no deben publicarse
porque pueden contener configuración particular. Se preservan las secciones de
instrucciones ajenas al bloque SDD.

OpenCode ahora tiene comandos en `.opencode/commands/`; Continue usa prompts
invocables Markdown en `.continue/rules/`. Los adaptadores de Cursor son manuales,
sin glob global. Todos apuntan al procedimiento común de `.sdd/workflows/`.

## Documentación existente

No reemplazar specs, planes ni tareas existentes por plantillas vacías. Hacer la
migración en una rama y conservar el historial Git.

1. Revisar reglas que remitan a comandos retirados y sustituirlas por `/sdd-spec-assisted`.
2. Conservar todos los RF/RB/SC/PLAN vigentes. Resolver conflictos de aprobación:
   spec pasa por clarificación y usa `Status: APPROVED` solo tras revisión.
3. Normalizar `Status:` y `Version:` (entero positivo) en constitución, spec y plan.
4. En tasks, conservar IDs, trabajo, dependencias y evidencia. Convertir títulos a
   `### T1.1 [TIPO] Nombre` y usar los campos de [sdd-task](../templates/sdd-task.md).
   No convertir una tarea en COMPLETED si su evidencia es «pendiente».
5. Mover resúmenes manuales antiguos a la bitácora histórica, retirar duplicados e
   insertar los marcadores tras el título `# Tasks: Nombre`:

```markdown
<!-- sdd:progress:start -->
<!-- sdd:progress:end -->
```

6. Validar entradas y vincularlas con `bind --artifact plan`, después
   `bind --artifact tasks`. Generar `progress` y ejecutar `check`.
7. Revisar el diff, recuperar evidencia que falte o registrar validación pendiente.
   Conservar evidencia histórica de comportamientos sustituidos y añadir tareas
   de revalidación del contrato actual.

## Alcance de las garantías

Las restricciones de escritura son políticas para el agente. El verificador
comprueba estructura, hashes y evidencia declarada; no crea un sandbox, no aprueba
reglas de negocio y no demuestra que un comando haya sido ejecutado. Usar controles
del cliente, pruebas reales y revisión según riesgo.
