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
WORKFLOWS=("sdd-init.md" "sdd-constitution-trial.md" "spec-init.md" "plan.md" "task-verify.md")

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
    echo -e "${GREEN}==> Instalando para Antigravity (.agents/workflows/ y .agents/skills/)...${NC}"
    mkdir -p .agents/workflows
    for wf in "${WORKFLOWS[@]}"; do
        nombre_base="${wf%.md}"
        contenido=$(obtener_plantilla "$wf")

        # 1. En workflows/
        echo "$contenido" > ".agents/workflows/$wf"
        echo -e "  ✔ .agents/workflows/$wf"

        # 2. En skills/ como estándar oficial de Antigravity
        mkdir -p ".agents/skills/$nombre_base"
        cat <<EOF > ".agents/skills/$nombre_base/SKILL.md"
---
name: $nombre_base
description: Workflow SDD para $nombre_base
---

$contenido
EOF
        echo -e "  ✔ .agents/skills/$nombre_base/SKILL.md"
    done
}

instalar_cursor() {
    echo -e "${GREEN}==> Instalando para Cursor (.cursor/commands/, .cursor/rules/ y .cursorrules)...${NC}"
    mkdir -p .cursor/commands
    mkdir -p .cursor/rules
    local cursorrules_content="# SDD Workflows y Reglas de Desarrollo\n\n"

    for wf in "${WORKFLOWS[@]}"; do
        nombre_base="${wf%.md}"
        contenido=$(obtener_plantilla "$wf")

        # 1. Custom Slash Command oficial de Cursor (.cursor/commands/<nombre>.md)
        # Esto hace que al escribir '/' en el chat de Cursor aparezca en el menú autocompletado
        echo "$contenido" > ".cursor/commands/${nombre_base}.md"
        echo -e "  ✔ .cursor/commands/${nombre_base}.md (Slash Command /${nombre_base})"

        # 2. Regla modular .mdc con frontmatter YAML (.cursor/rules/)
        local destino_rule=".cursor/rules/${nombre_base}.mdc"
        cat <<EOF > "$destino_rule"
---
description: Workflow SDD para $nombre_base
globs: *
alwaysApply: false
---

$contenido
EOF
        echo -e "  ✔ $destino_rule (Regla de contexto)"

        # 3. Acumular en .cursorrules (compatibilidad universal)
        cursorrules_content+="## Workflow: $nombre_base\n$contenido\n\n---\n\n"
    done

    # Escribir .cursorrules en la raíz
    echo -e "$cursorrules_content" > .cursorrules
    echo -e "  ✔ .cursorrules (raíz)"
}

instalar_opencode() {
    echo -e "${GREEN}==> Instalando para OpenCode / Continue (.continue/prompts/ y .continue/rules/)...${NC}"
    mkdir -p .continue/prompts
    mkdir -p .continue/rules

    for wf in "${WORKFLOWS[@]}"; do
        nombre_base="${wf%.md}"
        contenido=$(obtener_plantilla "$wf")

        # 1. Custom slash command en Continue (.prompt con frontmatter de invocación)
        cat <<EOF > ".continue/prompts/${nombre_base}.prompt"
temperature: 0.2
description: Workflow SDD $nombre_base
---
{{{ input }}}

$contenido
EOF
        echo -e "  ✔ .continue/prompts/${nombre_base}.prompt"

        # 2. En .continue/rules/ para reconocimiento contextual
        echo "$contenido" > ".continue/rules/${nombre_base}.md"
        echo -e "  ✔ .continue/rules/${nombre_base}.md"
    done
}

instalar_vscode() {
    echo -e "${GREEN}==> Instalando para VS Code / Copilot (.github/skills/, .github/prompts/ y copilot-instructions.md)...${NC}"
    mkdir -p .github/skills
    mkdir -p .github/prompts
    local instructions_content="# Instrucciones y Flujos de Desarrollo SDD\n\n"

    for wf in "${WORKFLOWS[@]}"; do
        nombre_base="${wf%.md}"
        contenido=$(obtener_plantilla "$wf")

        # 1. Estructura Oficial de VS Code Agent Skills (.github/skills/<nombre>/SKILL.md)
        mkdir -p ".github/skills/$nombre_base"
        cat <<EOF > ".github/skills/$nombre_base/SKILL.md"
---
name: $nombre_base
description: Workflow SDD para $nombre_base. Invocar cuando el usuario pida $nombre_base o flujos SDD.
---

$contenido
EOF
        echo -e "  ✔ .github/skills/$nombre_base/SKILL.md (VS Code Agent Skill)"

        # 2. Reusable Prompt Files (.prompt.md) reconocidos por Copilot Chat
        cat <<EOF > ".github/prompts/${nombre_base}.prompt.md"
---
name: $nombre_base
description: Workflow SDD para $nombre_base
---

$contenido
EOF
        echo -e "  ✔ .github/prompts/${nombre_base}.prompt.md"

        # 3. También versión .md estándar
        echo "$contenido" > ".github/prompts/${wf}"

        # 4. Acumular en las instrucciones maestras de Copilot
        instructions_content+="## Flujo SDD: $nombre_base\n$contenido\n\n---\n\n"
    done

    # Generar .github/copilot-instructions.md (reconocido nativamente por GitHub Copilot en VS Code)
    echo -e "$instructions_content" > .github/copilot-instructions.md
    echo -e "  ✔ .github/copilot-instructions.md"
}

# Lista de opciones del menú
OPCIONES=(
    "Antigravity          (.agents/workflows/ y .agents/skills/)"
    "Cursor               (.cursor/rules/*.mdc y .cursorrules)"
    "OpenCode / Continue  (.continue/prompts/ y rules/)"
    "VS Code / Copilot    (.github/prompts/ y copilot-instructions.md)"
    "Todos los anteriores"
)

seleccionar_con_flechas() {
    local seleccionado=0
    local total=${#OPCIONES[@]}
    local key=""

    # Redirigir salidas y entradas a la consola real
    exec 3>&1
    exec 1>/dev/tty
    exec 0</dev/tty

    # Guardar configuración previa de terminal
    local old_stty
    old_stty=$(stty -g 2>/dev/null || true)

    # Ocultar cursor
    tput civis 2>/dev/null || true

    # Restaurar en caso de interrupción
    cleanup() {
        tput cnorm 2>/dev/null || true
        if [ -n "$old_stty" ]; then
            stty "$old_stty" 2>/dev/null || true
        fi
    }
    trap cleanup EXIT SIGINT

    # Configurar terminal en modo sin buffer
    stty -icanon -echo min 1 time 0 2>/dev/null || true

    while true; do
        # Dibujar opciones directamente en terminal
        for i in "${!OPCIONES[@]}"; do
            if [ "$i" -eq "$seleccionado" ]; then
                echo -e "  ${CYAN}${BOLD}❯ ${OPCIONES[$i]}${NC}"
            else
                echo -e "    ${OPCIONES[$i]}"
            fi
        done

        # Leer tecla
        key=$(dd bs=3 count=1 2>/dev/null || read -rsn1)

        case "$key" in
            $'\x1b[A'|[kK]) # Flecha Arriba
                ((seleccionado--))
                if [ "$seleccionado" -lt 0 ]; then
                    seleccionado=$((total - 1))
                fi
                ;;
            $'\x1b[B'|[jJ]) # Flecha Abajo
                ((seleccionado++))
                if [ "$seleccionado" -ge "$total" ]; then
                    seleccionado=0
                fi
                ;;
            ""|$'\n'|$'\r') # Enter
                break
                ;;
            $'\x03') # Ctrl+C
                cleanup
                exit 1
                ;;
        esac

        # Subir el cursor
        for ((i=0; i<total; i++)); do
            echo -en "\033[1A\033[2K"
        done
    done

    cleanup

    # Restaurar stdout original hacia el llamador
    exec 1>&3
    exec 3>&-

    echo "$((seleccionado + 1))"
}

# Si se pasó argumento directo (modo no interactivo), ej: ./install.sh cursor
TARGET_PARAM="${1:-}"

if [ -n "$TARGET_PARAM" ]; then
    OPCION="$TARGET_PARAM"
else
    echo -e "${YELLOW}Usa las flechas [↑/↓] para moverte y presiona [Enter] para elegir:${NC}\n" >/dev/tty 2>&1 || true
    OPCION=$(seleccionar_con_flechas)
fi

# Sanitizar cualquier retorno de carro \r o salto de línea \n residual
OPCION=$(echo "$OPCION" | tr -d '\r\n[:space:]')

case "$OPCION" in
    1*|*antigravity*)
        instalar_antigravity
        ;;
    2*|*cursor*)
        instalar_cursor
        ;;
    3*|*opencode*|*continue*)
        instalar_opencode
        ;;
    4*|*vscode*|*copilot*)
        instalar_vscode
        ;;
    5*|*all*|*todos*)
        instalar_antigravity
        instalar_cursor
        instalar_opencode
        instalar_vscode
        ;;
    *)
        echo -e "${YELLOW}Opción no reconocida ('$OPCION'). Cancelando.${NC}"
        exit 1
        ;;
esac

echo -e "\n${GREEN}${BOLD}🎉 ¡Workflows SDD instalados exitosamente!${NC}"
echo "Ahora puedes abrir el chat de tu agente y usar los comandos /spec-init, /plan y /task-verify."
