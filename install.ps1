# Bootstrap SDD. Motor compartido con install.sh; requiere Python 3.9+.
param ([string]$Target = "")
$ErrorActionPreference = "Stop"

$SddPython = $null
$SddPrefix = @()
foreach ($candidate in @("py", "python3", "python")) {
    if (Get-Command $candidate -ErrorAction SilentlyContinue) {
        $prefix = @()
        if ($candidate -eq "py") { $prefix = @("-3") }
        & $candidate @prefix -c "import sys; sys.exit(sys.version_info < (3, 9))" 2>$null
        if ($LASTEXITCODE -eq 0) { $SddPython = $candidate; $SddPrefix = $prefix; break }
    }
}
if (-not $SddPython) { throw "SDD requiere Python 3.9 o superior para instalar y validar tareas." }

$SddArgs = @()
if ($Target) { $SddArgs += @("--target", $Target) }
$SddSource = $env:SDD_SOURCE_DIR
if (-not $SddSource -and $PSScriptRoot -and (Test-Path (Join-Path $PSScriptRoot "sdd/catalog.json"))) {
    $SddSource = $PSScriptRoot
}
$SddTemp = $null
try {
    if ($SddSource) {
        $SddScript = Join-Path $SddSource "tools/sdd_install.py"
        $SddArgs += @("--source", $SddSource)
    } else {
        $SddTemp = Join-Path ([System.IO.Path]::GetTempPath()) ([guid]::NewGuid().ToString())
        New-Item -ItemType Directory -Path $SddTemp | Out-Null
        $SddScript = Join-Path $SddTemp "sdd_install.py"
        $SddUser = if ($env:GITHUB_USER) { $env:GITHUB_USER } else { "Thebetus7" }
        $SddRepo = if ($env:GITHUB_REPO) { $env:GITHUB_REPO } else { "SW2-G17-SDD-26-2" }
        $SddRef = if ($env:GITHUB_BRANCH) { $env:GITHUB_BRANCH } else { "main" }
        Invoke-WebRequest -UseBasicParsing -Uri "https://raw.githubusercontent.com/$SddUser/$SddRepo/$SddRef/tools/sdd_install.py" -OutFile $SddScript
    }
    & $SddPython @SddPrefix $SddScript @SddArgs
    if ($LASTEXITCODE -ne 0) { throw "La instalación SDD falló (código $LASTEXITCODE)." }
} finally {
    if ($SddTemp -and (Test-Path $SddTemp)) { Remove-Item -LiteralPath $SddTemp -Recurse -Force }
}
