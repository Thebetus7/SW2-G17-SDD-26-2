# Publicación y distribución del framework

Este repositorio distribuye Markdown y herramientas Python desde GitHub; no
necesita un servidor de aplicaciones. Python 3.9+ es requisito del proyecto destino.

## Publicar un fork

1. Crear un fork o repositorio público con estos archivos.
2. Cambiar los valores predeterminados del repositorio en `install.sh`, `install.ps1`
   y `tools/sdd_install.py`, y las URLs de instalación del README.
3. Ejecutar las pruebas y revisar el diff antes de publicar una rama o release.
4. Preferir una etiqueta o SHA de commit para instalaciones reproducibles. `main`
   ofrece la versión actual y puede cambiar entre descargas.

## Seleccionar repositorio y versión sin editar archivos

Las variables GITHUB_USER, GITHUB_REPO y GITHUB_BRANCH son leídas por ambos
bootstraps y por el motor Python. Asignarlas en el entorno del proceso instalador:

```bash
curl -fsSL https://raw.githubusercontent.com/USUARIO/REPO/VERSION/install.sh -o /tmp/sdd-install.sh
GITHUB_USER=USUARIO GITHUB_REPO=REPO GITHUB_BRANCH=VERSION bash /tmp/sdd-install.sh cursor
```

USUARIO, REPO y VERSION son valores que deben sustituirse por el fork y el tag/SHA
publicado. La URL del bootstrap y GITHUB_BRANCH deben indicar la misma versión.
No pegar una credencial en estas variables ni en la URL.

```powershell
$env:GITHUB_USER = 'USUARIO'
$env:GITHUB_REPO = 'REPO'
$env:GITHUB_BRANCH = 'VERSION'
& ([scriptblock]::Create((irm "https://raw.githubusercontent.com/$env:GITHUB_USER/$env:GITHUB_REPO/$env:GITHUB_BRANCH/install.ps1"))) -Target cursor
```

El endpoint raw público no proporciona autenticación para un repositorio privado.
Para repositorios privados o una instalación sin red, clonar por una vía ya
autorizada y ejecutar el bootstrap local. SDD_SOURCE_DIR permite indicar la fuente
local explícitamente, sin cambiar el directorio del proyecto destino.

## Comprobar y actualizar

```bash
python3 -m unittest discover -s tests -v
bash -n install.sh
```

Reejecutar el instalador desde la raíz del proyecto destino. El paquete se carga
antes de escribir; los archivos modificados y los comandos retirados reconocidos
se conservan en `.sdd/backups/`. No se sobrescriben documentos de negocio ya creados.
Revisar [migración](docs/MIGRATION.md) para convertir tareas existentes al contrato
verificable. El instalador actualiza solo los clientes seleccionados.

Se pueden versionar los workflows/herramientas instalados; excluir backups del
control de versiones. Para restaurar una actualización, recuperar los archivos
anteriores desde Git o las copias y revisar el diff. No hay rollback automático
transaccional de todos los archivos.
