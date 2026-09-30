# SDD-Spec-Clarify: Auditoría y Clarificación de Especificación (QA Gate)

Este workflow actúa como el **filtro de calidad (QA)** antes de pasar a la fase de planificación técnica. Audita el último archivo `docs/specs/XX-feature/spec.md` generado para detectar ambigüedades, vacíos o inconsistencias.

---

## 1. Misión Operativa del Asistente
1. Localiza y lee exhaustivamente el último `spec.md` generado en `docs/specs/`.
2. Analiza los 4 aspectos críticos de calidad:
   - **Completitud de Escenarios**: ¿Faltan casos de borde (*edge cases*), validaciones de límites o errores de red?
   - **Determinismo**: ¿Hay requerimientos ambiguos como "debe ser rápido", "fácil de usar" o "cuando sea necesario"?
   - **Contratos de Datos**: ¿Los tipos de entrada y salida cubren todos los campos opcionales o nulos?
   - **Alineación con la Constitución**: ¿El feature respeta las reglas de `docs/constitution.md`?

---

## 2. Entrevista de Clarificación (Preguntas al Usuario)
Formula al usuario las preguntas necesarias de forma ordenada:
- *Pregunta 1*: [Aclaración de caso de borde o condición no especificada]
- *Pregunta 2*: [Regla de negocio en caso de fallo]

---

## 3. Refinamiento y Aprobación
Una vez que el usuario responde:
- Actualiza directamente `docs/specs/XX-feature/spec.md` con las precisiones acordadas.
- Confirma que la especificación está formalmente aprobada y lista para la fase `/sdd-planning`.
