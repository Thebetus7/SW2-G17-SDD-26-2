# SDD Universal Workflows & Multi-IDE Installer

Herramienta de distribución e instalación instantánea de flujos de trabajo **Spec-Driven Development (SDD)** para múltiples entornos y agentes de IA (**Cursor**, **OpenCode / Continue** y **Antigravity**).

Permite mantener una **única fuente de verdad** (Single Source of Truth) en Markdown y desplegar automáticamente las reglas y prompts con la metadata que cada IDE requiere.

---

## ⚡ Instalación Rápida (One-Liner)

En la raíz del proyecto donde desees habilitar SDD:

### Linux / macOS / Git Bash:
```bash
curl -fsSL https://raw.githubusercontent.com/mi-usuario-github/SW2-G17-SDD-26-2/main/install.sh | bash
```

### Windows (PowerShell):
```powershell
irm https://raw.githubusercontent.com/mi-usuario-github/SW2-G17-SDD-26-2/main/install.ps1 | iex
```

El script desplegará un menú interactivo en consola:
```text
==========================================================
    🚀 SDD Workflows Installer (Spec-Driven Dev)
==========================================================

Selecciona el entorno/IDE donde deseas instalar los comandos SDD:
1) Antigravity          (.agents/workflows/)
2) Cursor               (.cursor/rules/*.mdc)
3) OpenCode / Continue  (.continue/prompts/*.prompt)
4) VS Code / Copilot    (.github/prompts/*.md)
5) Todos los anteriores
```

---

## 📂 Adaptación por Entorno

| Entorno / IDE | Destino Generado | Formato / Adaptación |
| :--- | :--- | :--- |
| **Antigravity** | `.agents/workflows/<nombre>.md` | Markdown puro compatible con comandos slash del chat. |
| **Cursor** | `.cursor/rules/<nombre>.mdc` | Inyecta cabecera YAML con metadatos (`description`, `globs: *`, etc.). |
| **OpenCode / Continue** | `.continue/prompts/<nombre>.prompt` | Formato `.prompt` para acceso rápido desde la barra lateral de chat. |
| **VS Code / Copilot** | `.github/prompts/<nombre>.md` | Formato nativo de reusable prompt files de GitHub Copilot en VS Code. |

---

## 📦 Flujos SDD Incluidos (Ciclo de Vida Formal de 8 Fases)

1. **`/sdd-init`**: Orquestador metodológico. Configura la precedencia de carpetas, jerarquía de verdad y genera `AGENTS.md`.
2. **`/sdd-constitution-trial`**: Entrevista interactiva (Grill-Me) para acordar misión, stack, suite de testing (Caja Negra y Blanca) y roadmap en `docs/constitution.md`.
3. **`/sdd-constitution`**: Plantilla canónica directa para redactar o consultar la constitución.
4. **`/sdd-spec-high`**: Especificación formal exhaustiva con EARS, Gherkin y contratos de datos tipados en `docs/specs/XX/spec.md`.
5. **`/sdd-spec-low`**: Especificación ágil y concisa para tareas puntuales o de menor complejidad.
6. **`/sdd-spec-clarify`**: Filtro de QA. Audita el último `spec.md`, detecta ambigüedades y las resuelve con el usuario antes de planificar.
7. **`/sdd-planning`**: Plan técnico de arquitectura, diagramas de secuencia e invariantes en `docs/specs/XX/plan.md`.
8. **`/sdd-task`**: Desglose en checklist atómico secuenciado con ciclo TDD en `docs/specs/XX/tasks.md`.
9. **`/sdd-execution`**: Motor de ejecución paso a paso del checklist bajo validación dual (Caja Blanca + Caja Negra).
10. **`/sdd-spec-anchored`** *(y variantes `-spec`, `-plan`, `-task`)*: Evolución e iteración anclada sobre specs existentes manteniendo trazabilidad.

---

## 🚀 Despliegue y Publicación

Consulta la guía detallada en [DEPLOY.md](DEPLOY.md) para aprender a subir tu propio fork a GitHub y configurar tus URLs canónicas.
