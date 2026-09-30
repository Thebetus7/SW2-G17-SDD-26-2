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

## 📦 Flujos SDD Incluidos

1. **`/spec-init`** (`templates/spec-init.md`): Redacción de requerimientos funcionales formales con sintaxis EARS, escenarios Gherkin BDD y contratos de interfaces.
2. **`/plan`** (`templates/plan.md`): Planificación técnica, diagramas de secuencia Mermaid y partición en Vertical Slices.
3. **`/task-verify`** (`templates/task-verify.md`): Ciclo TDD Red-Green-Refactor y matriz de validación dual (código + especificación).

---

## 🚀 Despliegue y Publicación

Consulta la guía detallada en [DEPLOY.md](DEPLOY.md) para aprender a subir tu propio fork a GitHub y configurar tus URLs canónicas.
