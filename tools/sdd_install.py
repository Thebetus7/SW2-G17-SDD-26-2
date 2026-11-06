#!/usr/bin/env python3
"""Shared SDD installer for Bash and PowerShell. Requires Python 3.9+."""
import argparse
from datetime import datetime, timezone
import json
import os
from pathlib import Path
import re
import sys
import tempfile
from urllib.parse import quote
from urllib.request import urlopen

START = '<!-- sdd:instructions:start -->'
END = '<!-- sdd:instructions:end -->'
DEPRECATED = ('sdd-spec-high', 'sdd-spec')
TARGETS = ('antigravity', 'cursor', 'opencode', 'continue', 'vscode', 'codex', 'claude')


class Installer:
    def __init__(self, root, source=None):
        self.root = Path(root).resolve()
        self.source = Path(source).resolve() if source else None
        user = quote(os.environ.get('GITHUB_USER', 'Thebetus7'), safe='')
        repo = quote(os.environ.get('GITHUB_REPO', 'SW2-G17-SDD-26-2'), safe='')
        ref = quote(os.environ.get('GITHUB_BRANCH', 'main'), safe='/')
        self.base = f'https://raw.githubusercontent.com/{user}/{repo}/{ref}/'
        self.backup = self.root / '.sdd' / 'backups' / (
            datetime.now(timezone.utc).strftime('%Y%m%dT%H%M%S%fZ'))
        self.files = {}

    def fetch(self, path):
        if self.source:
            return (self.source / path).read_text(encoding='utf-8-sig')
        with urlopen(self.base + path, timeout=30) as response:
            return response.read().decode('utf-8-sig')

    def safe_path(self, relative):
        path = self.root / relative
        if path.is_symlink() or not path.resolve().is_relative_to(self.root):
            raise ValueError(f'Ruta fuera del proyecto o symlink: {relative}')
        return path

    def preserve(self, path):
        destination = self.backup / path.relative_to(self.root)
        destination.parent.mkdir(parents=True, exist_ok=True)
        if not destination.exists():
            destination.write_bytes(path.read_bytes())

    def write(self, relative, text):
        path = self.safe_path(relative)
        if path.exists():
            if path.read_text(encoding='utf-8-sig') == text:
                return
            self.preserve(path)
        path.parent.mkdir(parents=True, exist_ok=True)
        with tempfile.NamedTemporaryFile(mode='w', encoding='utf-8', newline='\n',
                                         dir=path.parent, delete=False) as temp:
            temp.write(text)
            temp_path = Path(temp.name)
        try:
            temp_path.replace(path)
        finally:
            temp_path.unlink(missing_ok=True)

    def instructions(self, relative, block):
        path = self.safe_path(relative)
        text = path.read_text(encoding='utf-8-sig') if path.exists() else ''
        # Older installers generated the entire file. Preserve it in a backup.
        generated = text.startswith(('# SDD Workflows y Reglas de Desarrollo\n',
                                      '# Instrucciones y Flujos de Desarrollo SDD\n'))
        if generated:
            text = ''
        if START in text or END in text:
            if text.count(START) != 1 or text.count(END) != 1 or text.index(START) > text.index(END):
                raise ValueError(f'Marcadores SDD inválidos en {relative}')
            text = text[:text.index(START)] + block + text[text.index(END) + len(END):]
        else:
            text = text.rstrip() + ('\n\n' if text.strip() else '') + block + '\n'
        self.write(relative, text)

    def retire(self, relative):
        path = self.safe_path(relative)
        if not path.is_file():
            return
        text = path.read_text(encoding='utf-8-sig')
        # Only recognized SDD artifacts, never unrelated files with the same name.
        if re.search(r'^# SDD-Spec-(?:High|Assisted)\b', text, re.M):
            self.preserve(path)
            path.unlink()
        else:
            print(f'Conservado archivo no reconocido: {relative}', file=sys.stderr)

    def prepare(self):
        catalog_text = self.fetch('sdd/catalog.json')
        catalog = json.loads(catalog_text)
        if not isinstance(catalog, list) or not catalog:
            raise ValueError('Catálogo vacío o inválido')
        names = [entry['name'] for entry in catalog]
        if len(names) != len(set(names)) or any(not re.fullmatch(r'[a-z][a-z0-9-]*', n) for n in names):
            raise ValueError('Nombres inválidos o duplicados en catálogo')
        for entry in catalog:
            if not isinstance(entry['description'], str) or not entry['description'].strip():
                raise ValueError('Descripción vacía')
        paths = ['sdd/core.md', 'tools/sdd_validate.py'] + [f'templates/{n}.md' for n in names]
        self.files = {path: self.fetch(path) for path in paths}
        if any(not content.strip() for content in self.files.values()):
            raise ValueError('Archivo descargado vacío')
        # Fetch and validate the whole package before changing any project file.
        compile(self.files['tools/sdd_validate.py'], 'sdd_validate.py', 'exec')
        self.catalog = catalog
        self.catalog_text = catalog_text

    def install(self, target):
        targets = TARGETS if target == 'all' else (target,)
        self.prepare()
        self.write('.sdd/core.md', self.files['sdd/core.md'])
        self.write('.sdd/catalog.json', self.catalog_text)
        self.write('.sdd/tools/sdd_validate.py', self.files['tools/sdd_validate.py'])
        for item in self.catalog:
            self.write(f".sdd/workflows/{item['name']}.md", self.files[f"templates/{item['name']}.md"])
        core_block = (START + '\n## SDD\n\n'
                      'Al ejecutar SDD, leer `.sdd/core.md` y solo el workflow activo en\n'
                      '`.sdd/workflows/`. Aplicar la matriz de autonomía y verificar tareas con\n'
                      '`python3 .sdd/tools/sdd_validate.py`. El núcleo rige los comandos SDD,\n'
                      'sin reemplazar las políticas particulares del proyecto.\n' + END)
        self.instructions('AGENTS.md', core_block)
        for client in targets:
            for item in self.catalog + [dict(name='sdd-planning', description='Alias de sdd-plan-tecnico')]:
                name, description = item['name'], item['description']
                source_name = 'sdd-plan-tecnico' if name == 'sdd-planning' else name
                body = ('Leer `.sdd/core.md` y ejecutar el procedimiento en '
                        f'`.sdd/workflows/{source_name}.md`.\n'
                        'Leer esos archivos con las herramientas disponibles antes de actuar.\n')
                front = f'---\nname: {name}\ndescription: {json.dumps(description, ensure_ascii=False)}\n---\n\n'
                if client in ('antigravity', 'codex'):
                    self.write(f'.agents/skills/{name}/SKILL.md', front + body)
                    if client == 'codex':
                        self.write(f'.codex/skills/{name}/SKILL.md', front + body)
                        self.write(f'.codex/prompts/{name}.md',
                                   f'---\ndescription: {json.dumps(description, ensure_ascii=False)}\n---\n\n'
                                   + body + '\nArgumentos del usuario: $ARGUMENTS\n')
                    if client == 'antigravity':
                        self.write(f'.agents/workflows/{name}.md', '# ' + name + '\n\n' + body)
                elif client == 'cursor':
                    self.write(f'.cursor/commands/{name}.md', '# ' + name + '\n\n' + body)
                    # Explicitly manual rules: workflow bodies are not attached by file glob.
                    self.write(f'.cursor/rules/{name}.mdc', '---\nalwaysApply: false\n---\n\n' + body)
                elif client == 'continue':
                    self.write(f'.continue/rules/{name}.md',
                               front.replace('---\n\n', 'invokable: true\nalwaysApply: false\n---\n\n') + body)
                elif client == 'opencode':
                    self.write(f'.opencode/commands/{name}.md',
                               f'---\ndescription: {json.dumps(description, ensure_ascii=False)}\n---\n\n'
                               + body + '\nArgumentos del usuario: $ARGUMENTS\n')
                elif client == 'claude':
                    self.write(f'.claude/skills/{name}/SKILL.md', front + body)
                elif client == 'vscode':
                    self.write(f'.github/prompts/{name}.prompt.md', front + body)
                    self.write(f'.github/skills/{name}/SKILL.md', front + body)
            if client == 'cursor':
                self.instructions('.cursorrules', core_block)
            elif client == 'vscode':
                self.instructions('.github/copilot-instructions.md', core_block)
            elif client == 'claude':
                self.instructions('CLAUDE.md', core_block)
            elif client == 'codex':
                self.instructions('CODEX.md', core_block)
            if client in ('continue', 'opencode'):
                for item in self.catalog + [dict(name='sdd-planning')]:
                    name = item['name']
                    # Replace only known old SDD rules, which were globally attached.
                    old_paths = [f'.continue/prompts/{name}.prompt']
                    if client == 'opencode':
                        old_paths.append(f'.continue/rules/{name}.md')
                    for relative in old_paths:
                        old = self.safe_path(relative)
                        if old.exists() and re.search(r'^# (?:SDD|🚀 DOC-DEPLOY)', old.read_text(encoding='utf-8-sig'), re.M):
                            self.preserve(old)
                            old.unlink()
            for name in DEPRECATED:
                paths = {
                    'antigravity': [f'.agents/workflows/{name}.md', f'.agents/skills/{name}/SKILL.md'],
                    'codex': [f'.agents/skills/{name}/SKILL.md', f'.codex/skills/{name}/SKILL.md', f'.codex/prompts/{name}.md'],
                    'cursor': [f'.cursor/commands/{name}.md', f'.cursor/rules/{name}.mdc'],
                    'continue': [f'.continue/prompts/{name}.prompt', f'.continue/rules/{name}.md'],
                    'opencode': [f'.opencode/commands/{name}.md', f'.continue/prompts/{name}.prompt', f'.continue/rules/{name}.md'],
                    'vscode': [f'.github/prompts/{name}.prompt.md', f'.github/prompts/{name}.md', f'.github/skills/{name}/SKILL.md'],
                    'claude': [f'.claude/skills/{name}/SKILL.md'],
                }[client]
                for path in paths:
                    self.retire(path)
            if client == 'vscode':
                for item in self.catalog + [dict(name='sdd-planning')]:
                    old = f".github/prompts/{item['name']}.md"
                    path = self.safe_path(old)
                    if path.exists() and path.read_text(encoding='utf-8-sig').startswith('# SDD'):
                        self.preserve(path)
                        path.unlink()
        print('SDD instalado: ' + ', '.join(targets))
        print('Workflows bajo demanda en .sdd/workflows/. Comenzar con /sdd-init o /sdd-adopt.')
        if self.backup.exists():
            print(f'Copias de archivos anteriores: {self.backup}')


def main(argv=None):
    parser = argparse.ArgumentParser(description=__doc__)
    aliases = {'copilot': 'vscode', 'codex-cli': 'codex', 'codex_cli': 'codex'}
    parser.add_argument('--target', choices=TARGETS + ('all',) + tuple(aliases.keys()))
    parser.add_argument('--source', type=Path, help='Repositorio local; sin red')
    parser.add_argument('--destination', type=Path, default=Path.cwd())
    args = parser.parse_args(argv)
    target = aliases.get(args.target, args.target)
    if not target:
        try:
            # Works when this installer is piped into the interpreter.
            tty_path = 'CON' if os.name == 'nt' else '/dev/tty'
            with open(tty_path, 'r') as tty_input, open(tty_path, 'w') as tty_output:
                options = TARGETS + ('all',)
                tty_output.write('\n'.join(f'{i + 1}. {name}' for i, name in enumerate(options)) + '\nSelecciona: ')
                tty_output.flush()
                choice = tty_input.readline().strip()
                target = options[int(choice) - 1] if choice.isdigit() and 1 <= int(choice) <= len(options) else choice
        except OSError:
            parser.error('Sin terminal interactiva. Indicar --target cursor (o el cliente deseado).')
    if target not in TARGETS + ('all',):
        parser.error(f'Cliente inválido: {target}')
    try:
        Installer(args.destination, args.source).install(target)
    except (OSError, ValueError, KeyError, TypeError) as exc:
        print(f'ERROR: {exc}', file=sys.stderr)
        return 1
    return 0


if __name__ == '__main__':
    sys.exit(main())
