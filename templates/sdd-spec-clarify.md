# SDD-Spec-Clarify: Auditoría y Clarificación de Especificación (QA Gate)

Este workflow actúa como el **filtro de calidad (QA Gate)** para auditar, clarificar y refinar exhaustivamente un archivo `spec.md` antes de avanzar hacia la fase de planificación técnica.

---

## 1. Resolución del Módulo a Auditar (`[XX.]`)

Cuando el usuario invoque este workflow con o sin argumento:

1. **Invocación con Argumento `[XX.]` o `[XX]`** (ej. `/sdd-spec-clarify 01.` o `/sdd-spec-clarify 02`):
   - Extrae el prefijo numérico indicado.
   - Localiza en `docs/specs/` la carpeta que coincida con ese identificador (ej. `docs/specs/01-autenticacion/spec.md`).
2. **Invocación sin Argumento**:
   - Escanea el directorio `docs/specs/`.
   - Selecciona automáticamente el último módulo generado (el de mayor número consecutivo) e informa al usuario qué especificación está siendo auditada.
3. Si el módulo no existe o no contiene un archivo `spec.md`, alerta al usuario y detiene la ejecución.

---

## 2. Coordinación y Checklist de Auditoría (5 Dimensiones Críticas)

El asistente debe leer `docs/constitution.md` y luego auditar el `docs/specs/XX-nombre/spec.md` seleccionado, verificando la consistencia de sus **5 secciones independientes**:

### Dimensión 1: Trazabilidad Jerárquica de Identificadores
- [ ] Cada Historia de Usuario cuenta con un identificador único `HU-XX`.
- [ ] Cada Requisito Funcional `RF-XX.Y` en la Sección 3 declara explícitamente su enlace a `HU-XX`.
- [ ] Cada Criterio de Aceptación `SC-XX.Y.Z` en la Sección 4 declara su enlace a `RF-XX.Y`.
- [ ] No existen IDs huérfanos o discontinuos.

### Dimensión 2: Determinismo y Sintaxis EARS
- [ ] Todos los requisitos en la Sección 3 siguen estrictamente uno de los 5 patrones EARS (*Ubiquitous*, *Event-Driven*, *State-Driven*, *Optional Feature*, *Unwanted Behavior*).
- [ ] No existen términos vagos, subjetivos o no testeables (ej. "rápido", "intuitivo", "cuando sea conveniente", "adecuado").

### Dimensión 3: Cobertura de Escenarios BDD (Caja Negra / Gherkin)
- [ ] Cada Historia de Usuario posee al menos dos escenarios formalizados en Gherkin:
  - `SC-XX.Y.1 [Happy Path]`: Flujo exitoso con datos válidos y resultado observable.
  - `SC-XX.Y.2 [Edge Case / Unwanted Behavior]`: Validación de errores, límites o datos inválidos sin mutación de estado.
- [ ] Los pasos `Given / When / Then` están formulados desde la perspectiva externa de usuario o cliente API.

### Dimensión 4: Coherencia de Datos Funcionales (Sección 5)
- [ ] Todos los campos, parámetros y estados mencionados en los escenarios Gherkin están formalizados en las tablas de **Datos de Entrada** o **Datos de Salida**.
- [ ] Cada campo declara su tipo funcional (Texto, Numérico, Fecha, Booleano, etc.), si es requerido y sus reglas de validación en lenguaje natural.

### Dimensión 5: Principio Estricto de Caja Negra (Cero Código)
- [ ] El documento está 100% libre de código fuente, interfaces TypeScript/Java, nombres de clases o métodos.
- [ ] No se mencionan detalles internos de persistencia, motores de bases de datos ni tablas SQL.

---

## 3. Protocolo de Entrevista de Clarificación (Grill-Me)

Si durante la auditoría el asistente detecta ambigüedades, vacíos de información, inconsistencias o falta de escenarios límite:

1. **Presentación de Hallazgos**:
   - Expone brevemente los puntos débiles o vacíos encontrados en el `spec.md`.
2. **Preguntas Puntuales al Usuario**:
   - Plantea preguntas concisas una a una para que el usuario aclare las reglas de negocio o los casos de borde pendientes (ej. límites numéricos, comportamiento ante caídas de servicios externos, reglas de validación específicas).

---

## 4. Actualización del Documento `spec.md`

Una vez que el usuario responde y se resuelven las dudas:

1. **Edición Directa In-situ**:
   - El asistente actualiza directamente `docs/specs/XX-nombre/spec.md`, incorporando los nuevos requisitos, escenarios o precisiones en sus respectivas secciones.
2. **Cierre de la Fase de Clarificación**:
   - Muestra un resumen de los cambios aplicados en la especificación.
   - No declara aprobaciones finales definitivas del sistema, dejando el documento refinado y coordinado para que la fase de **Planificación Técnica** (`sdd-plan-tech` / `sdd-plan-high`) proceda con el diseño de arquitectura y viabilidad.
```
