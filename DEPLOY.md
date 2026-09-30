# Guía de Despliegue y Publicación: Herramienta SDD Multi-IDE

Esta guía explica paso a paso cómo subir este proyecto a **GitHub** para que cualquier desarrollador pueda instalar tus flujos SDD en cualquier proyecto con una sola línea de comandos (`curl` o PowerShell).

---

## 1. ¿Cómo funciona la distribución sin servidores?

No necesitas pagar ni configurar un servidor web, VPS ni Docker.
Cuando subes un repositorio público a **GitHub**, GitHub sirve automáticamente cada archivo de forma plana y directa a través de su CDN en:

```text
https://raw.githubusercontent.com/<TU-USUARIO-GITHUB>/<TU-REPOSITORIO>/main/<RUTA-DEL-ARCHIVO>
```

Cualquier terminal del mundo con conexión a internet puede consumir esa URL directamente mediante `curl` o `irm` (Invoke-RestMethod).

---

## 2. Paso a Paso para Subir a GitHub

### Paso A: Inicializar el repositorio Git local
Abre tu terminal en la carpeta de este proyecto (`SW2-G17-SDD-26-2`) y ejecuta:

```bash
git init
git add .
git commit -m "feat: instalador universal sdd y plantillas canónicas"
git branch -M main
```

### Paso B: Crear el repositorio en GitHub
1. Ingresa a [https://github.com/new](https://github.com/new).
2. Asigna un nombre al repositorio (por ejemplo: `SW2-G17-SDD-26-2` o `sdd-workflows`).
3. **IMPORTANTE**: Asegúrate de marcarlo como **Public** (Público). Si es privado, `curl` pedirá autenticación o tokens personales.
4. No inicialices con README ni `.gitignore` (ya los tenemos creados). Haz clic en **Create repository**.

### Paso C: Vincular y subir tu código
Copia y ejecuta los comandos que te proporciona GitHub:

```bash
git remote add origin https://github.com/<TU-USUARIO>/<TU-REPOSITORIO>.git
git push -u origin main
```

---

## 3. Actualizar las URLs de tu Instalador

En los archivos `install.sh` e `install.ps1`, localiza la variable de usuario de GitHub y actualízala con tu nombre de usuario real:

- En `install.sh`:
  ```bash
  GITHUB_USER="tu-nombre-de-usuario"
  GITHUB_REPO="nombre-de-tu-repo"
  ```
- En `install.ps1`:
  ```powershell
  $GithubUser = "tu-nombre-de-usuario"
  $GithubRepo = "nombre-de-tu-repo"
  ```

Haz un commit rápido con el cambio:
```bash
git add install.sh install.ps1
git commit -m "chore: configurar urls canónicas de github"
git push
```

---

## 4. ¿Cómo lo usan tus compañeros o tú en otros proyectos?

Una vez publicado, para instalar los workflows SDD en **cualquier proyecto nuevo**, solo abren la terminal en la raíz de su proyecto y ejecutan:

### En Linux, macOS o Windows Git Bash:
```bash
curl -fsSL https://raw.githubusercontent.com/<TU-USUARIO>/<TU-REPOSITORIO>/main/install.sh | bash
```

### En Windows PowerShell nativo:
```powershell
irm https://raw.githubusercontent.com/<TU-USUARIO>/<TU-REPOSITORIO>/main/install.ps1 | iex
```

### Modo no interactivo (automatizado en scripts o CI/CD):
Si se desea instalar directamente para Cursor sin mostrar el menú interactivo:
```bash
curl -fsSL https://raw.githubusercontent.com/<TU-USUARIO>/<TU-REPOSITORIO>/main/install.sh | bash -s cursor
```
o en PowerShell:
```powershell
& ([scriptblock]::Create((irm https://raw.githubusercontent.com/<TU-USUARIO>/<TU-REPOSITORIO>/main/install.ps1))) -Target cursor
```
