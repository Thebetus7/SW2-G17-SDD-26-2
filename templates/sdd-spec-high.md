# SDD-Spec-High: Especificación Funcional Formal de Alta Rigurosidad (SDD)

Este workflow guía al asistente de IA en una **entrevista técnica estructurada (Grill-Me)** con el usuario para capturar exhaustivamente todos los requerimientos funcionales, historias de usuario, escenarios de aceptación BDD (Caja Negra) y contratos de interfaces antes de redactar el archivo oficial `docs/specs/XX-nombre/spec.md`.

---

## 1. Protocolo de Ejecución del Asistente (Modo Entrevista / Grill-Me)

Cuando el usuario invoque este workflow (`/sdd-spec-high`):

1. **Lectura Previa Obligatoria de la Constitución**:
   - Lee `docs/constitution.md` para alinear la especificación con los principios innegociables, estándares de codificación, stack tecnológico y la regla de no asumir dependencias no acordadas.
2. **Determinación del Siguiente Módulo (`docs/specs/XX-nombre/`)**:
   - Escanea el directorio `docs/specs/` para identificar los módulos existentes (ej. `01-auth/`, `02-billing/`).
   - Propone automáticamente el siguiente número consecutivo con un slug representativo (ej. `docs/specs/03-gestion-tickets/`) y solicita confirmación al usuario.
3. **Entrevista Técnica Interactiva (Grill-Me)**:
   - Realiza preguntas una a una utilizando herramientas interactivas o preguntas concisas para profundizar en:
     - **Objetivo y Actores**: ¿Quién utiliza esta funcionalidad? ¿Qué permisos y roles se requieren?
     - **Requerimientos Funcionales y EARS**: ¿Cuáles son los comportamientos del sistema ante eventos, estados o fallos?
     - **Historias de Usuario**: ¿Qué valor de negocio aporta cada acción (*Como... Quiero... Para...*)?
     - **Criterios de Aceptación (BDD)**: Flujo exitoso (*Happy Path*) y casos de borde o error (*Edge Cases* / *Unwanted Behavior*).
     - **Contratos de Interfaces**: Estructura estricta de payloads (Request/Response DTOs) sin tipos ambiguos (`any`).
     - **Invariantes del Dominio**: Reglas de negocio que nunca pueden violarse bajo ninguna circunstancia.
4. **Redacción y Creación del Artefacto**:
   - Genera el archivo `spec.md` en la carpeta acordada (`docs/specs/XX-nombre/spec.md`) siguiendo la estructura jerárquica formal.

---

## 2. Sistema de Identificadores y Trazabilidad Jerárquica

Para garantizar trazabilidad bidireccional desde la especificación hasta las pruebas y el código, se utiliza la siguiente jerarquía unívoca de IDs:

```text
RF-XX (Requerimiento Funcional + Fórmula EARS)
 └── US-XX.Y (Historia de Usuario: Valor de Negocio)
      ├── SC-XX.Y.1 [Happy Path] (Escenario Gherkin Exitoso)
      └── SC-XX.Y.2 [Edge Case / Unwanted Behavior] (Escenario Gherkin de Error o Límite)
```

- **`RF-XX`**: Requerimiento Funcional numerado consecutivamente (`RF-01`, `RF-02`). Contiene la definición formal bajo sintaxis **EARS**.
- **`US-XX.Y`**: Historia de Usuario asociada al requerimiento (`US-01.1`, `US-01.2`). Define el actor, la acción y el beneficio esperado.
- **`SC-XX.Y.Z`**: Escenario BDD Gherkin ejecutable (`SC-01.1.1`, `SC-01.1.2`). Es la base directa para los tests de Caja Negra (`test/blackbox/`).
- **`INV-XX`**: Invariante de Dominio numerada (`INV-01`, `INV-02`). Regla de negocio o seguridad inviolable.

---

## 3. Patrones de Sintaxis EARS (Easy Approach to Requirements Syntax)

Cada `RF-XX` debe categorizarse en uno de los 5 patrones EARS para eliminar ambigüedades:

1. **Ubiquitous (Siempre Activo)**:
   - *Sintaxis*: "El sistema deberá [comportamiento constante]".
2. **Event-Driven (Disparado por Evento)**:
   - *Sintaxis*: "CUANDO [evento o estímulo], el sistema deberá [respuesta esperada]".
3. **State-Driven (Condición de Estado)**:
   - *Sintaxis*: "MIENTRAS [el sistema esté en este estado], el sistema deberá [comportamiento]".
4. **Optional Feature (Característica Opcional)**:
   - *Sintaxis*: "DONDE [la característica esté habilitada/presente], el sistema deberá [comportamiento]".
5. **Unwanted Behavior (Comportamiento No Deseado / Manejo de Fallos)**:
   - *Sintaxis*: "SI [condición de error / fallo / entrada inválida], ENTONCES el sistema deberá [respuesta de recuperación controlada sin efectos secundarios]".

---

## 4. Plantilla Oficial de Salida: `docs/specs/XX-nombre/spec.md`

El asistente redactará el archivo final con esta estructura exacta y completa:

```markdown
# Especificación Funcional: [Nombre del Módulo o Feature]

> Ruta: `docs/specs/XX-nombre/spec.md` | Estado: Aprobado / En Revisión | Metodología: SDD-Spec-High

---

## 1. Contexto y Objetivos del Módulo
- **Módulo / Feature**: [Nombre representativo]
- **Objetivo General**: [Problema de negocio o necesidad técnica que resuelve]
- **Actores y Roles**:
  - `[Rol 1]`: [Descripción de responsabilidades y permisos]
  - `[Rol 2 / Sistema Externo]`: [Interacciones permitidas]

---

## 2. Requerimientos Funcionales, Historias y Criterios de Aceptación

### RF-01: [Nombre descriptivo del requerimiento]
- **Patrón EARS**: [Ubiquitous | Event-Driven | State-Driven | Optional Feature | Unwanted Behavior]
- **Definición Formal**: [CUANDO / MIENTRAS / SI ...] el sistema deberá [acción obligatoria del sistema].

#### US-01.1: [Nombre de la Historia de Usuario]
- **Narrativa**:
  - **Como**: [rol o tipo de usuario]
  - **Quiero**: [realizar esta acción o interacción específica]
  - **Para**: [obtener este beneficio directo o valor de negocio]

##### SC-01.1.1 [Happy Path]: [Descripción del flujo exitoso]
```gherkin
Scenario: SC-01.1.1 - [Título conciso del escenario exitoso]
  Given [precondición del sistema o estado inicial existente]
  When [el actor ejecuta la acción con datos válidos]
  Then [el sistema confirma la operación con estado observable exitoso]
  And [el nuevo estado o recurso persiste correctamente]
```

##### SC-01.1.2 [Edge Case / Unwanted Behavior]: [Descripción del caso límite o fallo]
```gherkin
Scenario: SC-01.1.2 - [Título conciso de validación, error o límite]
  Given [precondición con datos inválidos, estado no apto o recurso inexistente]
  When [el actor intenta ejecutar la acción]
  Then [el sistema rechaza la solicitud retornando código y mensaje de error específico]
  And [el estado del sistema permanece inalterado sin efectos secundarios]
```

---

### RF-02: [Nombre del segundo requerimiento]
- **Patrón EARS**: [Patrón correspondiente]
- **Definición Formal**: [Definición formal según sintaxis EARS].

#### US-02.1: [Nombre de la Historia de Usuario]
- **Narrativa**:
  - **Como**: [rol]
  - **Quiero**: [acción]
  - **Para**: [beneficio]

##### SC-02.1.1 [Happy Path]: [Descripción]
```gherkin
Scenario: SC-02.1.1 - [Título]
  Given [precondición]
  When [acción]
  Then [resultado observable]
```

##### SC-02.1.2 [Edge Case / Unwanted Behavior]: [Descripción]
```gherkin
Scenario: SC-02.1.2 - [Título]
  Given [precondición]
  When [acción]
  Then [resultado observable]
```

---

## 3. Contratos de Datos e Interfaces Tipadas

Los contratos de entrada y salida deben ser estrictos y tipados (cero uso de `any`), garantizando que la implementación valide los datos en los bordes:

```typescript
// DTO de Entrada (Request Payload)
export interface [FeatureName]InputDTO {
  id: string;
  name: string;
  amount: number;
  metadata?: Record<string, string>;
}

// DTO de Salida (Response Payload)
export interface [FeatureName]OutputDTO {
  success: boolean;
  resourceId: string;
  createdAt: string; // ISO 8601 UTC
}

// DTO de Error Tipado
export interface [FeatureName]ErrorDTO {
  errorCode: string;
  message: string;
  details?: Array<{ field: string; issue: string }>;
}
```

---

## 4. Invariantes del Dominio y Reglas de Negocio

Reglas innegociables que deben preservarse en todo momento durante el ciclo de vida del módulo:

- [ ] **INV-01**: [Regla de integridad referencial o validación de estado].
- [ ] **INV-02**: [Regla de seguridad o control de acceso basada en roles].
- [ ] **INV-03**: [Regla de idempotencia o atomicidad en operaciones concurrentes].
- [ ] **INV-04**: [Regla de auditoría o registro de eventos obligatorios].
```
