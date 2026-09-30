# SDD-Spec-High: Especificación Funcional Formal de Alta Rigurosidad (SDD)

Este workflow guía al asistente de IA en una **entrevista técnica estructurada (Grill-Me)** con el usuario para capturar exhaustivamente todos los requerimientos funcionales, contratos de interfaces y criterios de aceptación BDD (Caja Negra) antes de redactar el archivo oficial `docs/specs/XX-feature/spec.md`.

---

## 1. Protocolo de Ejecución del Asistente (Modo Entrevista / Grill-Me)

Cuando el usuario invoque este workflow (`/sdd-spec-high`):

1. **Lectura Previa Obligatoria de la Constitución**:
   - Lee `docs/constitution.md` para alinear el nuevo feature con la misión, el tech stack, las convenciones de nomenclatura y los principios innegociables del proyecto.
2. **Determinación del Siguiente Módulo (`docs/specs/XX-nombre/`)**:
   - Escanea el directorio `docs/specs/` para identificar las carpetas existentes (ej. `01-auth/`, `02-billing/`).
   - Propone automáticamente el siguiente número consecutivo con un slug representativo (ej. `docs/specs/03-gestion-tickets/`) y solicita confirmación al usuario.
3. **Entrevista Técnica Interactiva (Grill-Me)**:
   - Realiza preguntas una a una o en bloques estructurados para profundizar en:
     - **Actores y Roles**: ¿Quién interactúa con el feature? ¿Qué permisos requiere?
     - **Flujo Principal (Happy Path)**: Paso a paso de la acción exitosa y su resultado observable.
     - **Casos de Borde y Errores (Edge Cases)**: Datos inválidos, límites de entrada, recursos no encontrados, caídas de dependencias.
     - **Contratos de Datos**: Campos obligatorios, tipos primitivos, enums y estructura del payload de entrada/salida.
     - **Invariantes del Dominio**: Reglas de negocio que nunca deben violarse bajo ninguna circunstancia.
4. **Redacción y Creación del Artefacto**:
   - Genera el archivo `spec.md` en la carpeta acordada (`docs/specs/XX-nombre/spec.md`) siguiendo la plantilla formal.

---

## 2. Los 5 Bloques Requeridos en la Especificación

### Bloque 1: Contexto y Dominio
- **Módulo / Feature**: Nombre semántico del feature.
- **Objetivo Principal**: Problema de negocio que resuelve.
- **Actores / Roles**: Usuarios y sistemas externos que participan.

### Bloque 2: Requerimientos Formales EARS (Easy Approach to Requirements Syntax)
Clasificación de requerimientos en los 5 patrones EARS para eliminar ambigüedades:
- **Ubiquitous (Siempre activo)**: El sistema deberá [comportamiento constante].
- **Event-Driven (Disparado por evento)**: CUANDO [evento ocurra], el sistema deberá [respuesta esperada].
- **State-Driven (Condición de estado)**: MIENTRAS [el sistema esté en este estado], el sistema deberá [comportamiento].
- **Optional Feature (Característica opcional)**: DONDE [característica esté habilitada], el sistema deberá [comportamiento].
- **Unwanted Behavior (Manejo de errores/excepciones)**: SI [condición de error / fallo], ENTONCES el sistema deberá [respuesta de recuperación sin efectos secundarios].

### Bloque 3: Criterios de Aceptación BDD (Caja Negra / Gherkin)
Escenarios de prueba desde la perspectiva externa del usuario o cliente de la API (sin mencionar clases ni bases de datos internas):
- Happy Path principal.
- Validaciones de entrada fallidas.
- Casos de borde y excepciones.

### Bloque 4: Contratos de Datos e Interfaces Tipadas
Definición de firmas de datos (TypeScript / JSON Schema) con tipos estrictos (cero `any`).

### Bloque 5: Invariantes del Dominio y Calidad
Checklist de reglas inviolables de negocio, seguridad Zero Trust e idempotencia.

---

## 3. Plantilla de Salida: `docs/specs/XX-nombre/spec.md`

El asistente redactará el archivo final con esta estructura exacta:

```markdown
# Especificación Funcional: [Nombre del Feature]

> Módulo: docs/specs/XX-nombre/ | Estado: Borrador Formal | Tipo: SDD-Spec-High

---

## 1. Contexto y Objetivos del Módulo
- **Módulo / Feature**: [Nombre descriptivo]
- **Objetivo Principal**: [Qué problema resuelve]
- **Usuarios / Roles Involucrados**: [Actores]

---

## 2. Requerimientos Formales EARS
- **REQ-01 (Ubiquitous)**: El sistema deberá ...
- **REQ-02 (Event-Driven)**: CUANDO el usuario envíe ..., el sistema deberá ...
- **REQ-03 (State-Driven)**: MIENTRAS el estado sea ..., el sistema deberá ...
- **REQ-04 (Unwanted Behavior)**: SI el payload contiene datos inválidos, ENTONCES el sistema deberá responder con código de error descriptivo y abortar la transacción.

---

## 3. Criterios de Aceptación BDD (Caja Negra / Gherkin)

```gherkin
Feature: [Nombre del feature]

  Scenario: Flujo exitoso principal (Happy Path)
    Given [precondición del sistema o datos existentes]
    When [el usuario o proceso ejecuta la acción principal]
    Then [el resultado observable y estado resultante]

  Scenario: Validación de entrada fallida (Edge Case)
    Given [precondición con datos inválidos o faltantes]
    When [el usuario intenta la acción]
    Then [el sistema rechaza con mensaje de error específico sin mutar estado]
```

---

## 4. Contratos de Datos e Interfaces Tipadas

```typescript
// Contrato de Entrada (Request / Input DTO)
export interface FeatureRequest {
  id: string;
  payload: Record<string, unknown>;
}

// Contrato de Salida (Response / Output DTO)
export interface FeatureResponse {
  success: boolean;
  data?: unknown;
  errorCode?: string;
  message?: string;
}
```

---

## 5. Invariantes del Dominio y Seguridad
- [ ] Invariante 1: No se permite la mutación de estado sin previa validación de esquema.
- [ ] Invariante 2: Las transacciones deben ser atómicas e idempotentes.
- [ ] Invariante 3: Validación estricta de entradas en los bordes (Zero Trust).
- [ ] Invariante 4: Cero acoplamiento a detalles de persistencia en la especificación.
```
