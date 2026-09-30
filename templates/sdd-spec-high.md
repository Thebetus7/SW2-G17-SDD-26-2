# SDD-Spec-High: Especificación Funcional Ágil y Formal (SDD)

Este workflow guía al asistente de IA en la captura estructurada de requerimientos de negocio para redactar el archivo `docs/specs/XX-nombre/spec.md`.

> **Principio de Caja Negra y Regla Antiatrapamiento de UI**:
> Esta especificación modela estrictamente el **comportamiento observable y las reglas de negocio**. 
> - **Sin código interno**: No incluye clases, DTOs, frameworks ni consultas SQL (pertenecen a `sdd-planning`).
> - **Sin sobre-especificación de UI**: Queda prohibido detallar estilos visuales, colores, paddings exactos o secuencias innecesarias de micro-diálogos. La IA asume el diseño ergonómico y las conexiones funcionales de la UI.

---

## 1. Protocolo de Ejecución del Asistente

Cuando el usuario invoque este workflow (`/sdd-spec-high`):

1. **Lectura de la Constitución**:
   - Lee `docs/constitution.md` para alinear el feature con la misión, el dominio y los principios acordados.
2. **Determinación del Siguiente Módulo (`docs/specs/XX-nombre/`)**:
   - Escanea `docs/specs/` y propone automáticamente el siguiente número consecutivo con un slug representativo (ej. `docs/specs/02-catalogo-productos/`).
3. **Entrevista Ágil de Requerimientos**:
   - La IA identifica los objetivos de negocio y plantea preguntas breves solo para clarificar:
     - Actores y permisos clave.
     - Reglas de negocio e invariantes (validaciones, cálculos, restricciones).
     - Entradas requeridas y salidas observables.
     - Casos de error o límites que el negocio debe controlar.
4. **Redacción del Artefacto**:
   - Genera el archivo `docs/specs/XX-nombre/spec.md` siguiendo la plantilla oficial.

---

## 2. Sistema de Trazabilidad Derivada

```text
SECCIÓN 2: HU-XX (Historia de Usuario: Perspectiva de Negocio)
              ↓
SECCIÓN 3: RF-XX.Y (Requisitos Funcionales: Sintaxis EARS)
              ↓
SECCIÓN 4: SC-XX.Y.Z (Criterios de Aceptación: Sintaxis Gherkin BDD)
```

- **`HU-XX`**: Historia de Usuario.
- **`RF-XX.Y`**: Requisito Funcional derivado con sintaxis EARS.
- **`SC-XX.Y.Z`**: Escenario BDD en Gherkin (`SC-XX.Y.1` = Happy Path, `SC-XX.Y.2` = Edge Case / Error).

---

## 3. Patrones de Sintaxis EARS para Requisitos Funcionales

Cada `RF-XX.Y` debe redactarse bajo uno de los patrones canónicos de EARS:
- **Ubiquitous (Siempre Activo)**: *"El sistema deberá [comportamiento constante]"*.
- **Event-Driven (Disparado por Evento)**: *"CUANDO [evento disparador], el sistema deberá [respuesta]"*.
- **State-Driven (Condicionado por Estado)**: *"MIENTRAS [estado del sistema], el sistema deberá [comportamiento]"*.
- **Optional Feature (Característica Opcional)**: *"DONDE [opción o feature habilitado], el sistema deberá [comportamiento]"*.
- **Unwanted Behavior (Manejo de Errores / Límites)**: *"SI [condición anómala o error], ENTONCES el sistema deberá [acción de contención y retroalimentación]"*.

---

## 4. Plantilla Oficial de Salida: `docs/specs/XX-nombre/spec.md`

```markdown
# Especificación Funcional: [Nombre del Módulo o Feature]

> Módulo: `docs/specs/XX-nombre/` | Estado: Aprobada | Metodología: SDD-Spec-High

---

## 1. Contexto y Objetivos de Negocio
- **Objetivo**: [Qué valor aporta esta funcionalidad]
- **Alcance**: [Qué incluye y qué queda explícitamente fuera]
- **Actores**: [Roles involucrados]

---

## 2. Historias de Usuario (HU)

### HU-01: [Título de la Historia]
**Como** [rol del usuario],  
**Quiero** [acción o capacidad deseada],  
**Para** [beneficio o valor de negocio obtenido].

---

## 3. Requisitos Funcionales (RF con Sintaxis EARS)

### Requisitos de HU-01
- **`RF-01.1` [Event-Driven]**: CUANDO el usuario solicita [acción], el sistema deberá [resultado].
- **`RF-01.2` [Unwanted Behavior]**: SI los datos ingresados no cumplen [regla], ENTONCES el sistema deberá rechazar la operación y mostrar el motivo del error.

---

## 4. Criterios de Aceptación y Escenarios BDD (Gherkin)

### Escenarios de RF-01.1
#### SC-01.1.1: [Happy Path - Título descriptivo]
```gherkin
Given [contexto inicial o estado del sistema]
When [acción observable ejecutada]
Then [resultado observable esperado]
```

#### SC-01.1.2: [Edge Case / Unwanted Behavior - Título descriptivo]
```gherkin
Given [contexto donde ocurre una anomalía o dato inválido]
When [se intenta ejecutar la acción]
Then [el sistema rechaza la operación sin corromper el estado]
```

---

## 5. Datos Funcionales del Módulo (Entradas y Salidas)

### 5.1 Datos de Entrada
| Parámetro | Tipo Funcional | Requerido | Regla de Validación de Negocio |
| :--- | :--- | :--- | :--- |
| `campo` | Texto / Número | Sí / No | Descripción de la regla o límites |

### 5.2 Datos de Salida / Observables
| Dato | Tipo Funcional | Descripción del Resultado |
| :--- | :--- | :--- |
| `resultado` | Objeto / Lista | Información retornada o reflejada al usuario |
```
