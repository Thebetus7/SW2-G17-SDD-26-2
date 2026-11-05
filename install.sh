#!/usr/bin/env bash
# Bootstrap SDD. Ambos instaladores usan el mismo motor Python.
set -euo pipefail

if command -v python3 >/dev/null 2>&1 && python3 -c 'import sys; sys.exit(sys.version_info < (3, 9))'; then
    SDD_PYTHON=python3
elif command -v python >/dev/null 2>&1 && python -c 'import sys; sys.exit(sys.version_info < (3, 9))'; then
    SDD_PYTHON=python
else
    echo 'SDD requiere Python 3.9 o superior para instalar y validar tareas.' >&2
    exit 1
fi

SDD_ARGS=()
if [ -n "${1:-}" ]; then SDD_ARGS+=(--target "$1"); fi
SDD_SOURCE_DIR="${SDD_SOURCE_DIR:-}"
if [ -z "$SDD_SOURCE_DIR" ] && [ -f "${BASH_SOURCE[0]:-}" ]; then
    SDD_SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
    if [ -f "$SDD_SCRIPT_DIR/sdd/catalog.json" ]; then SDD_SOURCE_DIR="$SDD_SCRIPT_DIR"; fi
fi
if [ -n "$SDD_SOURCE_DIR" ]; then
    exec "$SDD_PYTHON" "$SDD_SOURCE_DIR/tools/sdd_install.py" --source "$SDD_SOURCE_DIR" "${SDD_ARGS[@]}"
fi

SDD_TEMP_DIR="$(mktemp -d)"
trap 'rm -rf -- "$SDD_TEMP_DIR"' EXIT
SDD_USER="${GITHUB_USER:-Thebetus7}"
SDD_REPO="${GITHUB_REPO:-SW2-G17-SDD-26-2}"
SDD_REF="${GITHUB_BRANCH:-main}"
curl -fsSL "https://raw.githubusercontent.com/$SDD_USER/$SDD_REPO/$SDD_REF/tools/sdd_install.py" -o "$SDD_TEMP_DIR/sdd_install.py"
"$SDD_PYTHON" "$SDD_TEMP_DIR/sdd_install.py" "${SDD_ARGS[@]}"
