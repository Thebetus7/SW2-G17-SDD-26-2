# SDD-Spec-High: Especificación Funcional Formal de Alta Rigurosidad (SDD)

Este workflow guía al asistente de IA en una **entrevista técnica estructurada (Grill-Me)** con el usuario para capturar exhaustivamente los requerimientos de negocio y estructurarlos formalmente en **Historias de Usuario**, **Requisitos Funcionales (EARS)** y **Criterios de Aceptación BDD (Gherkin)** dentro de `docs/specs/XX-nombre/spec.md`.

> **Principio de Caja Negra**: Esta especificación es estrictamente funcional. Describe el **QUÉ** y el valor de negocio observable. No debe incluir código fuente, interfaces de programación (TypeScript, Java, etc.), clases, patrones de diseño internos ni detalles de base de datos. Esos aspectos pertenecen a la fase de Plan Técnico (`sdd-plan-tech`).

---

## 1. Protocolo de Ejecución del Asistente (Modo Entrevista / Grill-Me)

Cuando el usuario invoque este workflow (`/sdd-spec-high`):

1. **Lectura Previa de la Constitución**:
   - Lee `docs/constitution.md` para alinear la especificación con la visión del proyecto y el dominio de negocio.
2. **Determinación del Siguiente Módulo (`docs/specs/XX-nombre/`)**:
   - Escanea el directorio `docs/specs/` para identificar los módulos existentes (ej. `01-auth/`, `02-billing/`).
   - Propone automáticamente el siguiente número consecutivo con un slug representativo (ej. `docs/specs/03-gestion-tickets/`) y solicita confirmación al usuario.
3. **Entrevista de Requerimientos (Grill-Me)**:
   - El usuario transmite sus **requerimientos** en lenguaje natural o de negocio.
   - El asistente realiza preguntas interactivas una a una para profundizar en:
     - **Actores y Roles**: ¿Quién interactúa con el sistema y qué rol cumple?
     - **Historias de Usuario**: ¿Qué objetivo y beneficio de negocio persigue el usuario?
     - **Requisitos Funcionales (Comportamiento del Sistema)**: ¿Qué debe hacer el sistema ante estímulos, estados o errores?
     - **Casos de Éxito y Borde**: ¿Cuál es el camino feliz (*Happy Path*) y qué situaciones adversas (*Edge Cases* / *Unwanted Behavior*) deben controlarse?
     - **Datos Funcionales**: ¿Qué información de entrada proporciona el usuario y qué datos devuelve el sistema?
4. **Redacción y Creación del Artefacto**:
   - Redacta el archivo `spec.md` en la carpeta acordada (`docs/specs/XX-nombre/spec.md`) siguiendo la plantilla formal.

---

## 2. Estructura y Jerarquía de Identificadores

Los requerimientos recopilados en la entrevista se traducen formalmente a la siguiente jerarquía:

```text
US-XX (Historia de Usuario: Valor para el Usuario)
 └── RF-XX.Y (Requisito Funcional: Comportamiento del Sistema con EARS)
      ├── SC-XX.Y.1 [Happy Path] (Escenario Gherkin Exitoso)
      └── SC-XX.Y.2 [Edge Case / Unwanted Behavior] (Escenario Gherkin de Excepción o Límite)
```

- **`US-XX`**: Historia de Usuario numerada (`US-01`, `US-02`). Expresa la necesidad y el valor de negocio (*Como [rol] quiero [acción] para [beneficio]*).
- **`RF-XX.Y`**: Requisito Funcional del sistema (`RF-01.1`, `RF-01.2`). Expresa el comportamiento exacto y normativo del sistema aplicando la sintaxis **EARS**.
- **`SC-XX.Y.Z`**: Criterio de Aceptación ejecutable en formato Gherkin (`SC-01.1.1`, `SC-01.1.2`). Describe el comportamiento de Caja Negra desde la perspectiva externa.

---

## 3. Patrones de Sintaxis EARS para Requisitos Funcionales

Cada `RF-XX.Y` debe redactarse utilizando uno de los patrones oficiales de **EARS** (Easy Approach to Requirements Syntax) para eliminar ambigüedades:

1. **Ubiquitous (Siempre Activo)**:
   - *Sintaxis*: "El sistema deberá [comportamiento constante]".
2. **Event-Driven (Disparado por Evento)**:
   - *Sintaxis*: "CUANDO [evento o estímulo], el sistema deberá [respuesta esperada]".
3. **State-Driven (Condición de Estado)**:
   - *Sintaxis*: "MIENTRAS [el sistema se encuentre en este estado], el sistema deberá [comportamiento]".
4. **Optional Feature (Característica Opcional)**:
   - *Sintaxis*: "DONDE [la opción esté habilitada], el sistema deberá [comportamiento]".
5. **Unwanted Behavior (Comportamiento No Deseado / Error)**:
   - *Sintaxis*: "SI [condición de error / entrada inválida / recurso ausente], ENTONCES el sistema deberá [respuesta controlada sin efectos secundarios]".

---

## 4. Plantilla Oficial de Salida: `docs/specs/XX-nombre/spec.md`

El asistente redactará el archivo final con esta estructura exacta (100% libre de código):

```markdown
# Especificación Funcional: [Nombre del Módulo o Feature]

> Ruta: `docs/specs/XX-nombre/spec.md` | Estado: Aprobado / En Revisión | Metodología: SDD-Spec-High

---

## 1. Contexto y Objetivos del Módulo
- **Módulo / Feature**: [Nombre representativo del módulo]
- **Objetivo General**: [Problema de negocio o necesidad que resuelve]
- **Actores y Roles**:
  - `[Rol 1]`: [Descripción del actor y responsabilidades en este módulo]
  - `[Rol 2 / Sistema Externo]`: [Descripción del actor o servicio externo]

---

## 2. Historias de Usuario, Requisitos Funcionales y Criterios de Aceptación

### US-01: [Nombre de la Primera Historia de Usuario]
- **Como**: [rol o tipo de usuario]
- **Quiero**: [realizar esta acción o interacción específica]
- **Para**: [obtener este beneficio directo o valor de negocio]

#### RF-01.1: [Nombre del Requisito Funcional]
- **Patrón EARS**: [Ubiquitous | Event-Driven | State-Driven | Optional Feature | Unwanted Behavior]
- **Definición Formal**: [CUANDO / MIENTRAS / SI ...] el sistema deberá [acción obligatoria del sistema].

##### SC-01.1.1 [Happy Path]: [Título del escenario exitoso]
```gherkin
Scenario: SC-01.1.1 - [Título conciso del flujo exitoso]
  Given [precondición del sistema o datos iniciales requeridos]
  When [el actor ejecuta la acción con datos válidos]
  Then [el sistema confirma la operación con estado observable exitoso]
  And [el nuevo estado o recurso persiste correctamente]
```

##### SC-01.1.2 [Edge Case / Unwanted Behavior]: [Título del escenario límite o error]
```gherkin
Scenario: SC-01.1.2 - [Título conciso de validación, error o límite]
  Given [precondición con datos inválidos, estado adverso o recurso inexistente]
  When [el actor intenta ejecutar la acción]
  Then [el sistema rechaza la solicitud mostrando mensaje de error específico]
  And [el estado del sistema no sufre alteraciones ni efectos secundarios]
```

---

### US-02: [Nombre de la Segunda Historia de Usuario]
- **Como**: [rol]
- **Quiero**: [acción]
- **Para**: [beneficio]

#### RF-02.1: [Nombre del Requisito Funcional]
- **Patrón EARS**: [Patrón correspondiente]
- **Definición Formal**: [Definición formal según sintaxis EARS].

##### SC-02.1.1 [Happy Path]: [Título]
```gherkin
Scenario: SC-02.1.1 - [Título del escenario]
  Given [precondición]
  When [acción]
  Then [resultado observable]
```

##### SC-02.1.2 [Edge Case / Unwanted Behavior]: [Título]
```gherkin
Scenario: SC-02.1.2 - [Título del escenario]
  Given [precondición]
  When [acción]
  Then [resultado observable]
```

---

## 3. Datos Funcionales del Módulo (Campos de Entrada y Salida)

Definición conceptual y funcional de la información manipulada, sin tipos de lenguaje de programación:

### 3.1 Datos de Entrada
| Campo | Tipo Funcional | Requerido | Descripción de Negocio | Reglas de Validación |
| :--- | :--- | :--- | :--- | :--- |
| `nombreCampo1` | Texto | Sí | Identificador o dato de negocio | Mínimo 3 caracteres, sin símbolos especiales |
| `monto` | Numérico | Sí | Importe de la transacción | Mayor a 0, máximo 2 decimales |
| `observacion` | Texto | No | Nota opcional del usuario | Máximo 250 caracteres |

### 3.2 Datos de Salida / Confirmación
| Campo | Tipo Funcional | Siempre Presente | Descripción de Negocio |
| :--- | :--- | :--- | :--- |
| `identificador` | Texto | Sí | Código único generado para la operación |
| `estadoOperacion` | Texto (Estado) | Sí | Resultado observable (ej. EXITOSO, RECHAZADO) |
| `fechaRegistro` | Fecha y Hora | Sí | Momento exacto en que se consolidó la operación |
| `mensajeRespuesta`| Texto | No | Detalle informativo o descripción del motivo de rechazo |
```
