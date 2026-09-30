# SDD-Spec-High: Especificación Funcional Formal de Alta Rigurosidad (SDD)

Este workflow guía al asistente de IA en una **entrevista técnica estructurada (Grill-Me)** con el usuario para capturar exhaustivamente los requerimientos de negocio y estructurarlos formalmente en **secciones independientes y trazables** dentro de `docs/specs/XX-nombre/spec.md`:
1. **Contexto y Objetivos del Módulo**
2. **Historias de Usuario (HU)**
3. **Requisitos Funcionales (RF con sintaxis EARS)**
4. **Criterios de Aceptación y Escenarios BDD (SC con sintaxis Gherkin)**
5. **Datos Funcionales del Módulo (Entradas y Salidas)**

> **Principio de Caja Negra**: Esta especificación es estrictamente funcional. Modela el comportamiento observable y el valor de negocio. No debe incluir código fuente, interfaces de programación (TypeScript, Java, etc.), clases, patrones de diseño internos ni esquemas de base de datos. Esos aspectos pertenecen a la fase de Plan Técnico (`sdd-plan-tech`).

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
     - **Actores y Roles**: ¿Quién interactúa con el sistema y qué permisos tiene?
     - **Historias de Usuario (HU)**: ¿Qué objetivo y beneficio de negocio persigue cada actor?
     - **Requisitos Funcionales (RF)**: ¿Qué comportamiento observable debe tener el sistema ante estímulos, estados o fallos?
     - **Criterios de Aceptación (SC)**: ¿Cuál es el flujo exitoso (*Happy Path*) y qué situaciones límite (*Edge Cases* / *Unwanted Behavior*) deben controlarse?
     - **Datos Funcionales**: ¿Qué información de entrada proporciona el usuario y qué datos devuelve el sistema?
4. **Redacción y Creación del Artefacto**:
   - Genera el archivo `spec.md` en la carpeta acordada (`docs/specs/XX-nombre/spec.md`) siguiendo la plantilla oficial por secciones separadas.

---

## 2. Sistema de Identificadores y Trazabilidad Derivada

Para garantizar máxima legibilidad y trazabilidad cruzada sin anidar bloques de texto, los identificadores derivan jerárquicamente del ID de la Historia de Usuario:

```text
SECCIÓN 2: HU-01 (Historia de Usuario: Perspectiva de Usuario)
              ↓
SECCIÓN 3: RF-01.1, RF-01.2 (Requisitos Funcionales: Perspectiva de Sistema / EARS)
              ↓
SECCIÓN 4: SC-01.1.1, SC-01.1.2 (Criterios de Aceptación: Perspectiva de Pruebas / Gherkin)
```

- **`HU-XX`**: Historia de Usuario (`HU-01`, `HU-02`).
- **`RF-XX.Y`**: Requisito Funcional derivado de la historia `HU-XX` (`RF-01.1`, `RF-01.2`).
- **`SC-XX.Y.Z`**: Criterio de Aceptación derivado del requisito funcional `RF-XX.Y` (`SC-01.1.1` = Happy Path, `SC-01.1.2` = Edge Case / Unwanted Behavior).

---

## 3. Patrones de Sintaxis EARS para Requisitos Funcionales

En la Sección 3, cada `RF-XX.Y` debe redactarse bajo uno de los 5 patrones canónicos de **EARS** (Easy Approach to Requirements Syntax):

1. **Ubiquitous (Siempre Activo)**:
   - *Sintaxis*: "El sistema deberá [comportamiento constante]".
2. **Event-Driven (Disparado por Evento)**:
   - *Sintaxis*: "CUANDO [evento o estímulo], el sistema deberá [respuesta esperada]".
3. **State-Driven (Condición de Estado)**:
   - *Sintaxis*: "MIENTRAS [el sistema se encuentre en este estado], el sistema deberá [comportamiento]".
4. **Optional Feature (Característica Opcional)**:
   - *Sintaxis*: "DONDE [la opción esté habilitada], el sistema deberá [comportamiento]".
5. **Unwanted Behavior (Manejo de Fallos / Comportamiento No Deseado)**:
   - *Sintaxis*: "SI [condición de error / entrada inválida], ENTONCES el sistema deberá [respuesta controlada sin efectos secundarios]".

---

## 4. Plantilla Oficial de Salida: `docs/specs/XX-nombre/spec.md`

El asistente redactará el archivo final con estas **5 secciones separadas e independientes** (100% libre de código):

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

## 2. Historias de Usuario (HU)

### HU-01: [Título de la Primera Historia de Usuario]
- **Como**: [rol o tipo de usuario]
- **Quiero**: [realizar esta acción o interacción específica]
- **Para**: [obtener este beneficio directo o valor de negocio]
- **Prioridad**: [Alta / Media / Baja]

### HU-02: [Título de la Segunda Historia de Usuario]
- **Como**: [rol]
- **Quiero**: [acción]
- **Para**: [beneficio]
- **Prioridad**: [Alta / Media / Baja]

---

## 3. Requisitos Funcionales (RF)

### RF-01.1: [Nombre del Requisito Funcional]
- **Historia Vinculada**: `HU-01`
- **Patrón EARS**: [Ubiquitous | Event-Driven | State-Driven | Optional Feature | Unwanted Behavior]
- **Definición Formal**: [CUANDO / MIENTRAS / SI ...] el sistema deberá [acción obligatoria del sistema].

### RF-01.2: [Nombre del Segundo Requisito Funcional]
- **Historia Vinculada**: `HU-01`
- **Patrón EARS**: [Patrón correspondiente]
- **Definición Formal**: [Definición formal según sintaxis EARS].

### RF-02.1: [Nombre del Requisito Funcional]
- **Historia Vinculada**: `HU-02`
- **Patrón EARS**: [Patrón correspondiente]
- **Definición Formal**: [Definición formal según sintaxis EARS].

---

## 4. Criterios de Aceptación y Escenarios BDD (SC)

### Escenarios para HU-01

#### SC-01.1.1 [Happy Path]: [Título del escenario exitoso]
- **Requisito Vinculado**: `RF-01.1`
```gherkin
Scenario: SC-01.1.1 - [Título conciso del flujo exitoso]
  Given [precondición del sistema o datos iniciales requeridos]
  When [el actor ejecuta la acción con datos válidos]
  Then [el sistema confirma la operación con estado observable exitoso]
  And [el nuevo estado o recurso persiste correctamente]
```

#### SC-01.1.2 [Edge Case / Unwanted Behavior]: [Título del caso límite o error]
- **Requisito Vinculado**: `RF-01.1`
```gherkin
Scenario: SC-01.1.2 - [Título conciso de validación, error o límite]
  Given [precondición con datos inválidos, estado adverso o recurso inexistente]
  When [el actor intenta ejecutar la acción]
  Then [el sistema rechaza la solicitud mostrando mensaje de error específico]
  And [el estado del sistema no sufre alteraciones ni efectos secundarios]
```

---

### Escenarios para HU-02

#### SC-02.1.1 [Happy Path]: [Título del escenario exitoso]
- **Requisito Vinculado**: `RF-02.1`
```gherkin
Scenario: SC-02.1.1 - [Título conciso]
  Given [precondición]
  When [acción]
  Then [resultado observable]
```

#### SC-02.1.2 [Edge Case / Unwanted Behavior]: [Título del escenario de excepción]
- **Requisito Vinculado**: `RF-02.1`
```gherkin
Scenario: SC-02.1.2 - [Título conciso]
  Given [precondición]
  When [acción]
  Then [resultado observable]
```

---

## 5. Datos Funcionales del Módulo (Entradas y Salidas)

Definición conceptual de los datos manejados por el módulo, libre de tipos de lenguaje de programación:

### 5.1 Datos de Entrada
| Campo | Tipo Funcional | Requerido | Descripción de Negocio | Reglas de Validación |
| :--- | :--- | :--- | :--- | :--- |
| `nombreCampo1` | Texto | Sí | Identificador o dato de negocio | Mínimo 3 caracteres, sin caracteres especiales |
| `monto` | Numérico | Sí | Importe de la transacción | Mayor a 0, máximo 2 decimales |
| `observacion` | Texto | No | Nota opcional del usuario | Máximo 250 caracteres |

### 5.2 Datos de Salida / Confirmación
| Campo | Tipo Funcional | Siempre Presente | Descripción de Negocio |
| :--- | :--- | :--- | :--- |
| `identificador` | Texto | Sí | Código único generado para la operación |
| `estadoOperacion` | Texto (Estado) | Sí | Resultado observable (ej. EXITOSO, RECHAZADO) |
| `fechaRegistro` | Fecha y Hora | Sí | Momento exacto en que se consolidó la operación |
| `mensajeRespuesta`| Texto | No | Detalle informativo o descripción del motivo de rechazo |
```
