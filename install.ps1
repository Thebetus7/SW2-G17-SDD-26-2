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

$Workflows = @("spec-init.md", "plan.md", "task-verify.md")

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
    Write-Host "==> Instalando para Antigravity (.agents/workflows/)..." -ForegroundColor Green
    $DestinoDir = Join-Path (Get-Location) ".agents\workflows"
    if (-not (Test-Path $DestinoDir)) {
        New-Item -ItemType Directory -Path $DestinoDir -Force | Out-Null
    }
    
    foreach ($wf in $Workflows) {
        $Contenido = Obtener-Plantilla -Archivo $wf
        $RutaSalida = Join-Path $DestinoDir $wf
        [System.IO.File]::WriteAllText($RutaSalida, $Contenido, [System.Text.Encoding]::UTF8)
        Write-Host "  [OK] .agents/workflows/$wf" -ForegroundColor Gray
    }
}

function Instalar-Cursor {
    Write-Host "==> Instalando para Cursor (.cursor/rules/)..." -ForegroundColor Green
    $DestinoDir = Join-Path (Get-Location) ".cursor\rules"
    if (-not (Test-Path $DestinoDir)) {
        New-Item -ItemType Directory -Path $DestinoDir -Force | Out-Null
    }
    
    foreach ($wf in $Workflows) {
        $NombreBase = [System.IO.Path]::GetFileNameWithoutExtension($wf)
        $Contenido = Obtener-Plantilla -Archivo $wf
        $Destino = Join-Path $DestinoDir "$NombreBase.mdc"
        
        $CursorHeader = "---`ndescription: Workflow SDD para $NombreBase`nglobs: *`nalwaysApply: false`n---`n`n"
        $ArchivoFinal = $CursorHeader + $Contenido
        [System.IO.File]::WriteAllText($Destino, $ArchivoFinal, [System.Text.Encoding]::UTF8)
        Write-Host "  [OK] .cursor/rules/$NombreBase.mdc (con metadata de Cursor)" -ForegroundColor Gray
    }
}

function Instalar-OpenCode {
    Write-Host "==> Instalando para OpenCode / Continue (.continue/prompts/)..." -ForegroundColor Green
    $DestinoDir = Join-Path (Get-Location) ".continue\prompts"
    if (-not (Test-Path $DestinoDir)) {
        New-Item -ItemType Directory -Path $DestinoDir -Force | Out-Null
    }
    
    foreach ($wf in $Workflows) {
        $NombreBase = [System.IO.Path]::GetFileNameWithoutExtension($wf)
        $Contenido = Obtener-Plantilla -Archivo $wf
        $Destino = Join-Path $DestinoDir "$NombreBase.prompt"
        [System.IO.File]::WriteAllText($Destino, $Contenido, [System.Text.Encoding]::UTF8)
        Write-Host "  [OK] .continue/prompts/$NombreBase.prompt" -ForegroundColor Gray
    }
}

function Instalar-VSCode {
    Write-Host "==> Instalando para VS Code / Copilot (.github/prompts/)..." -ForegroundColor Green
    $DestinoDir = Join-Path (Get-Location) ".github\prompts"
    if (-not (Test-Path $DestinoDir)) {
        New-Item -ItemType Directory -Path $DestinoDir -Force | Out-Null
    }
    
    foreach ($wf in $Workflows) {
        $Contenido = Obtener-Plantilla -Archivo $wf
        $Destino = Join-Path $DestinoDir $wf
        [System.IO.File]::WriteAllText($Destino, $Contenido, [System.Text.Encoding]::UTF8)
        Write-Host "  [OK] .github/prompts/$wf" -ForegroundColor Gray
    }
}

# Selección interactiva si no se especificó $Target
if ([string]::IsNullOrWhiteSpace($Target)) {
    Write-Host "Selecciona el entorno/IDE donde deseas instalar los comandos SDD:" -ForegroundColor Yellow
    Write-Host "1. Antigravity          (.agents/workflows/)"
    Write-Host "2. Cursor               (.cursor/rules/*.mdc)"
    Write-Host "3. OpenCode / Continue  (.continue/prompts/*.prompt)"
    Write-Host "4. VS Code / Copilot    (.github/prompts/*.md)"
    Write-Host "5. Todos los anteriores"
    Write-Host ""
    $Opcion = Read-Host "Ingresa tu opción (1-5)"
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
Write-Host "Ahora puedes abrir el chat de tu agente y usar los comandos /spec-init, /plan y /task-verify."
