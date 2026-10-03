# ==============================================================================
# SDD Tooling Universal Installer para PowerShell (Windows Nativo)
# Ejecución: irm https://raw.githubusercontent.com/.../install.ps1 | iex
# ==============================================================================

param (
    [string]$Target = ""
)

$ErrorActionPreference = "Stop"

# Parámetros del repositorio remoto
$GithubUser   = if ($env:GITHUB_USER)   { $env:GITHUB_USER }   else { "Thebetus7" }
$GithubRepo   = if ($env:GITHUB_REPO)   { $env:GITHUB_REPO }   else { "SW2-G17-SDD-26-2" }
$GithubBranch = if ($env:GITHUB_BRANCH) { $env:GITHUB_BRANCH } else { "main" }

$BaseUrl = "https://raw.githubusercontent.com/$GithubUser/$GithubRepo/$GithubBranch/templates"

Write-Host ""
Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host "    🚀 SDD Workflows Installer (PowerShell)               " -ForegroundColor Cyan
Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host ""

$Workflows = @(
    "sdd-init.md",
    "sdd-constitution-trial.md",
    "sdd-spec-high.md",
    "sdd-spec-low.md",
    "sdd-spec-clarify.md",
    "sdd-planning.md",
    "sdd-task.md",
    "sdd-execution.md",
    "sdd-spec-anchored.md",
    "sdd-spec-anchored-spec.md",
    "sdd-spec-anchored-plan.md",
    "sdd-spec-anchored-task.md",
    "doc-deploy.md"
)

function Obtener-Plantilla {
    param ([string]$Archivo)
    $RutaLocal = Join-Path "templates" $Archivo
    if (Test-Path $RutaLocal) {
        return (Get-Content -Path $RutaLocal -Raw -Encoding utf8)
    } else {
        $Url = "$BaseUrl/$Archivo"
        return (Invoke-RestMethod -Uri $Url -Method Get)
    }
}

function Instalar-Antigravity {
    Write-Host "==> Instalando para Antigravity (.agents/workflows/ y .agents/skills/)..." -ForegroundColor Green
    $DestinoWorkflows = Join-Path (Get-Location) ".agents\workflows"
    if (-not (Test-Path $DestinoWorkflows)) {
        New-Item -ItemType Directory -Path $DestinoWorkflows -Force | Out-Null
    }
    
    foreach ($wf in $Workflows) {
        $NombreBase = [System.IO.Path]::GetFileNameWithoutExtension($wf)
        $Contenido = Obtener-Plantilla -Archivo $wf

        # 1. En workflows/
        $RutaSalida = Join-Path $DestinoWorkflows $wf
        [System.IO.File]::WriteAllText($RutaSalida, $Contenido, [System.Text.Encoding]::UTF8)
        Write-Host "  [OK] .agents/workflows/$wf" -ForegroundColor Gray

        # 2. En skills/ como estándar oficial de Antigravity
        $DestinoSkillDir = Join-Path (Get-Location) ".agents\skills\$NombreBase"
        if (-not (Test-Path $DestinoSkillDir)) {
            New-Item -ItemType Directory -Path $DestinoSkillDir -Force | Out-Null
        }
        $SkillHeader = "---`nname: $NombreBase`ndescription: Workflow SDD para $NombreBase`n---`n`n"
        $RutaSkill = Join-Path $DestinoSkillDir "SKILL.md"
        [System.IO.File]::WriteAllText($RutaSkill, ($SkillHeader + $Contenido), [System.Text.Encoding]::UTF8)
        Write-Host "  [OK] .agents/skills/$NombreBase/SKILL.md" -ForegroundColor Gray
    }
}

function Instalar-Cursor {
    Write-Host "==> Instalando para Cursor (.cursor/commands/, .cursor/rules/ y .cursorrules)..." -ForegroundColor Green
    $DestinoCommands = Join-Path (Get-Location) ".cursor\commands"
    $DestinoRules = Join-Path (Get-Location) ".cursor\rules"
    if (-not (Test-Path $DestinoCommands)) { New-Item -ItemType Directory -Path $DestinoCommands -Force | Out-Null }
    if (-not (Test-Path $DestinoRules)) { New-Item -ItemType Directory -Path $DestinoRules -Force | Out-Null }

    $CursorRulesContent = "# SDD Workflows y Reglas de Desarrollo`n`n"
    
    foreach ($wf in $Workflows) {
        $NombreBase = [System.IO.Path]::GetFileNameWithoutExtension($wf)
        $Contenido = Obtener-Plantilla -Archivo $wf

        # 1. Slash Command nativo de Cursor (.cursor/commands/<nombre>.md)
        $DestinoCommand = Join-Path $DestinoCommands "$NombreBase.md"
        [System.IO.File]::WriteAllText($DestinoCommand, $Contenido, [System.Text.Encoding]::UTF8)
        Write-Host "  [OK] .cursor/commands/$NombreBase.md (Slash Command /$NombreBase)" -ForegroundColor Gray

        # 2. Regla contextual .mdc
        $DestinoRule = Join-Path $DestinoRules "$NombreBase.mdc"
        $CursorHeader = "---`ndescription: Workflow SDD para $NombreBase`nglobs: *`nalwaysApply: false`n---`n`n"
        $ArchivoFinal = $CursorHeader + $Contenido
        [System.IO.File]::WriteAllText($DestinoRule, $ArchivoFinal, [System.Text.Encoding]::UTF8)
        Write-Host "  [OK] .cursor/rules/$NombreBase.mdc (Regla de contexto)" -ForegroundColor Gray

        $CursorRulesContent += "## Workflow: $NombreBase`n$Contenido`n`n---`n`n"
    }

    $RutaCursorrules = Join-Path (Get-Location) ".cursorrules"
    [System.IO.File]::WriteAllText($RutaCursorrules, $CursorRulesContent, [System.Text.Encoding]::UTF8)
    Write-Host "  [OK] .cursorrules (raíz)" -ForegroundColor Gray
}

function Instalar-OpenCode {
    Write-Host "==> Instalando para OpenCode / Continue (.continue/prompts/ y rules/)..." -ForegroundColor Green
    $DestinoPrompts = Join-Path (Get-Location) ".continue\prompts"
    $DestinoRules = Join-Path (Get-Location) ".continue\rules"
    if (-not (Test-Path $DestinoPrompts)) { New-Item -ItemType Directory -Path $DestinoPrompts -Force | Out-Null }
    if (-not (Test-Path $DestinoRules)) { New-Item -ItemType Directory -Path $DestinoRules -Force | Out-Null }
    
    foreach ($wf in $Workflows) {
        $NombreBase = [System.IO.Path]::GetFileNameWithoutExtension($wf)
        $Contenido = Obtener-Plantilla -Archivo $wf

        # 1. Custom slash command en Continue
        $DestinoPrompt = Join-Path $DestinoPrompts "$NombreBase.prompt"
        $PromptHeader = "temperature: 0.2`ndescription: Workflow SDD $NombreBase`n---`n{{{ input }}}`n`n"
        [System.IO.File]::WriteAllText($DestinoPrompt, ($PromptHeader + $Contenido), [System.Text.Encoding]::UTF8)
        Write-Host "  [OK] .continue/prompts/$NombreBase.prompt" -ForegroundColor Gray

        # 2. Regla contextual
        $DestinoRule = Join-Path $DestinoRules "$NombreBase.md"
        [System.IO.File]::WriteAllText($DestinoRule, $Contenido, [System.Text.Encoding]::UTF8)
        Write-Host "  [OK] .continue/rules/$NombreBase.md" -ForegroundColor Gray
    }
}

function Instalar-VSCode {
    Write-Host "==> Instalando para VS Code / Copilot (.github/skills/, .github/prompts/ y copilot-instructions.md)..." -ForegroundColor Green
    $DestinoSkills = Join-Path (Get-Location) ".github\skills"
    $DestinoDir = Join-Path (Get-Location) ".github\prompts"
    if (-not (Test-Path $DestinoSkills)) { New-Item -ItemType Directory -Path $DestinoSkills -Force | Out-Null }
    if (-not (Test-Path $DestinoDir))    { New-Item -ItemType Directory -Path $DestinoDir -Force | Out-Null }

    $InstructionsContent = "# Instrucciones y Flujos de Desarrollo SDD`n`n"
    
    foreach ($wf in $Workflows) {
        $NombreBase = [System.IO.Path]::GetFileNameWithoutExtension($wf)
        $Contenido = Obtener-Plantilla -Archivo $wf

        # 1. Estructura Oficial de VS Code Agent Skills (.github\skills\<nombre>\SKILL.md)
        $SkillFolder = Join-Path $DestinoSkills $NombreBase
        if (-not (Test-Path $SkillFolder)) { New-Item -ItemType Directory -Path $SkillFolder -Force | Out-Null }
        $SkillPath = Join-Path $SkillFolder "SKILL.md"
        $SkillHeader = "---`nname: $NombreBase`ndescription: Workflow SDD para $NombreBase. Invocar cuando el usuario pida $NombreBase o flujos SDD.`n---`n`n"
        [System.IO.File]::WriteAllText($SkillPath, ($SkillHeader + $Contenido), [System.Text.Encoding]::UTF8)
        Write-Host "  [OK] .github/skills/$NombreBase/SKILL.md (VS Code Agent Skill)" -ForegroundColor Gray

        # 2. Prompt File nativo de VS Code Copilot
        $DestinoPrompt = Join-Path $DestinoDir "$NombreBase.prompt.md"
        $PromptHeader = "---`nname: $NombreBase`ndescription: Workflow SDD para $NombreBase`n---`n`n"
        [System.IO.File]::WriteAllText($DestinoPrompt, ($PromptHeader + $Contenido), [System.Text.Encoding]::UTF8)
        Write-Host "  [OK] .github/prompts/$NombreBase.prompt.md" -ForegroundColor Gray

        # 3. .md estándar
        $Destino = Join-Path $DestinoDir $wf
        [System.IO.File]::WriteAllText($Destino, $Contenido, [System.Text.Encoding]::UTF8)

        $InstructionsContent += "## Flujo SDD: $NombreBase`n$Contenido`n`n---`n`n"
    }

    $RutaInstructions = Join-Path (Get-Location) ".github\copilot-instructions.md"
    [System.IO.File]::WriteAllText($RutaInstructions, $InstructionsContent, [System.Text.Encoding]::UTF8)
    Write-Host "  [OK] .github/copilot-instructions.md" -ForegroundColor Gray
}

# Opciones del menú interactivo
$OpcionesMenu = @(
    "Antigravity          (.agents/workflows/ y .agents/skills/)",
    "Cursor               (.cursor/commands/, rules/ y .cursorrules)",
    "OpenCode / Continue  (.continue/prompts/ y rules/)",
    "VS Code / Copilot    (.github/skills/, prompts/ y copilot-instructions.md)",
    "Todos los anteriores"
)

function Seleccionar-ConFlechas {
    $Seleccionado = 0
    $Total = $OpcionesMenu.Count

    try {
        [Console]::CursorVisible = $false
    } catch {}

    while ($true) {
        for ($i = 0; $i -lt $Total; $i++) {
            if ($i -eq $Seleccionado) {
                Write-Host "  ❯ $($OpcionesMenu[$i])" -ForegroundColor Cyan
            } else {
                Write-Host "    $($OpcionesMenu[$i])" -ForegroundColor Gray
            }
        }

        $Key = [Console]::ReadKey($true)

        if ($Key.Key -eq [ConsoleKey]::UpArrow -or $Key.Key -eq [ConsoleKey]::K) {
            $Seleccionado--
            if ($Seleccionado -lt 0) { $Seleccionado = $Total - 1 }
        }
        elseif ($Key.Key -eq [ConsoleKey]::DownArrow -or $Key.Key -eq [ConsoleKey]::J) {
            $Seleccionado++
            if ($Seleccionado -ge $Total) { $Seleccionado = 0 }
        }
        elseif ($Key.Key -eq [ConsoleKey]::Enter) {
            break
        }

        # Subir el cursor para redibujar
        try {
            $CurrentTop = [Console]::CursorTop
            [Console]::SetCursorPosition(0, [Math]::Max(0, $CurrentTop - $Total))
        } catch {
            Write-Host "`e[${Total}A" -NoNewline
        }
    }

    try {
        [Console]::CursorVisible = $true
    } catch {}

    return ($Seleccionado + 1).ToString()
}

# Selección interactiva si no se especificó $Target
if ([string]::IsNullOrWhiteSpace($Target)) {
    Write-Host "Usa las flechas [↑/↓] para moverte y presiona [Enter] para elegir:" -ForegroundColor Yellow
    Write-Host ""
    $Opcion = Seleccionar-ConFlechas
} else {
    $Opcion = $Target
}

switch ($Opcion.ToLower()) {
    "1" { Instalar-Antigravity }
    "antigravity" { Instalar-Antigravity }
    "2" { Instalar-Cursor }
    "cursor" { Instalar-Cursor }
    "3" { Instalar-OpenCode }
    "opencode" { Instalar-OpenCode }
    "continue" { Instalar-OpenCode }
    "4" { Instalar-VSCode }
    "vscode" { Instalar-VSCode }
    "copilot" { Instalar-VSCode }
    "5" {
        Instalar-Antigravity
        Instalar-Cursor
        Instalar-OpenCode
        Instalar-VSCode
    }
    "all" {
        Instalar-Antigravity
        Instalar-Cursor
        Instalar-OpenCode
        Instalar-VSCode
    }
    Default {
        Write-Host "Opción '$Opcion' no reconocida. Operación cancelada." -ForegroundColor Yellow
        exit 1
    }
}

Write-Host ""
Write-Host "¡Workflows SDD instalados exitosamente!" -ForegroundColor Green
Write-Host "Ahora puedes abrir el chat de tu agente y comenzar con el comando /sdd-init."
