#!/usr/bin/env bash
# ==============================================================================
# SDD Tooling Universal Installer
# Compatible con Linux, macOS y Windows (Git Bash / WSL)
# ==============================================================================

set -e

# Configuración del repositorio canónico
# NOTA: Reemplazar con tu usuario y repo de GitHub cuando lo publiques
GITHUB_USER="${GITHUB_USER:-Thebetus7}"
GITHUB_REPO="${GITHUB_REPO:-SW2-G17-SDD-26-2}"
GITHUB_BRANCH="${GITHUB_BRANCH:-main}"

BASE_URL="https://raw.githubusercontent.com/${GITHUB_USER}/${GITHUB_REPO}/${GITHUB_BRANCH}/templates"

# Estilos de consola
CYAN='\033[0;36m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BOLD='\033[1m'
NC='\033[0m' # No Color

echo -e "${CYAN}${BOLD}"
echo "=========================================================="
echo "    🚀 SDD Workflows Installer (Spec-Driven Dev)          "
echo "=========================================================="
echo -e "${NC}"

# Lista de plantillas a instalar
WORKFLOWS=("spec-init.md" "plan.md" "task-verify.md")

# Función para obtener contenido de la plantilla (vía web o local si existe)
obtener_plantilla() {
    local archivo="$1"
    if [ -f "./templates/$archivo" ]; then
        cat "./templates/$archivo"
    else
        curl -fsSL "${BASE_URL}/${archivo}"
    fi
}

instalar_antigravity() {
    echo -e "${GREEN}==> Instalando para Antigravity (.agents/workflows/)...${NC}"
    mkdir -p .agents/workflows
    for wf in "${WORKFLOWS[@]}"; do
        obtener_plantilla "$wf" > ".agents/workflows/$wf"
        echo -e "  ✔ .agents/workflows/$wf"
    done
}

instalar_cursor() {
    echo -e "${GREEN}==> Instalando para Cursor (.cursor/rules/)...${NC}"
    mkdir -p .cursor/rules
    for wf in "${WORKFLOWS[@]}"; do
        nombre_base="${wf%.md}"
        destino=".cursor/rules/${nombre_base}.mdc"
        contenido=$(obtener_plantilla "$wf")

        cat <<EOF > "$destino"
---
description: Workflow SDD para $nombre_base
globs: *
alwaysApply: false
---

$contenido
EOF
        echo -e "  ✔ $destino (con metadata de Cursor)"
    done
}

instalar_opencode() {
    echo -e "${GREEN}==> Instalando para OpenCode / Continue (.continue/prompts/)...${NC}"
    mkdir -p .continue/prompts
    for wf in "${WORKFLOWS[@]}"; do
        nombre_base="${wf%.md}"
        obtener_plantilla "$wf" > ".continue/prompts/${nombre_base}.prompt"
        echo -e "  ✔ .continue/prompts/${nombre_base}.prompt"
    done
}

instalar_vscode() {
    echo -e "${GREEN}==> Instalando para VS Code / Copilot (.github/prompts/)...${NC}"
    mkdir -p .github/prompts
    for wf in "${WORKFLOWS[@]}"; do
        obtener_plantilla "$wf" > ".github/prompts/$wf"
        echo -e "  ✔ .github/prompts/$wf"
    done
}

# Si se pasó argumento directo (modo no interactivo), ej: ./install.sh cursor
TARGET_PARAM="${1:-}"

if [ -n "$TARGET_PARAM" ]; then
    OPCION="$TARGET_PARAM"
else
    echo -e "${YELLOW}Selecciona el entorno/IDE donde deseas instalar los comandos SDD:${NC}"
    echo "1) Antigravity          (.agents/workflows/)"
    echo "2) Cursor               (.cursor/rules/*.mdc)"
    echo "3) OpenCode / Continue  (.continue/prompts/*.prompt)"
    echo "4) VS Code / Copilot    (.github/prompts/*.md)"
    echo "5) Todos los anteriores"
    echo ""
    read -p "Ingresa tu opción [1-5]: " OPCION
fi

case "$OPCION" in
    1|antigravity)
        instalar_antigravity
        ;;
    2|cursor)
        instalar_cursor
        ;;
    3|opencode|continue)
        instalar_opencode
        ;;
    4|vscode|copilot)
        instalar_vscode
        ;;
    5|all|todos)
        instalar_antigravity
        instalar_cursor
        instalar_opencode
        instalar_vscode
        ;;
    *)
        echo -e "${YELLOW}Opción no reconocida ($OPCION). Cancelando.${NC}"
        exit 1
        ;;
esac

echo -e "\n${GREEN}${BOLD}🎉 ¡Workflows SDD instalados exitosamente!${NC}"
echo "Ahora puedes abrir el chat de tu agente y usar los comandos /spec-init, /plan y /task-verify."
