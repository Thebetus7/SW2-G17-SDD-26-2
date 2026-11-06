import contextlib
import importlib.util
import io
import json
import os
from pathlib import Path
import re
import shutil
import subprocess
import sys
import tempfile
import unittest

ROOT = Path(__file__).resolve().parents[1]
spec = importlib.util.spec_from_file_location('sdd_install', ROOT / 'tools/sdd_install.py')
installer = importlib.util.module_from_spec(spec)
spec.loader.exec_module(installer)


class InstallTests(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory()
        self.addCleanup(self.temp.cleanup)
        self.root = Path(self.temp.name)

    def install(self, target):
        with contextlib.redirect_stdout(io.StringIO()):
            installer.Installer(self.root, ROOT).install(target)

    def test_catalog_matches_templates_and_workflow_references(self):
        names = {entry['name'] for entry in json.loads((ROOT / 'sdd/catalog.json').read_text())}
        self.assertEqual(names, {p.stem for p in (ROOT / 'templates').glob('*.md')})
        self.assertNotIn('sdd-spec-high', names)
        self.assertNotIn('sdd-spec', names)
        for path in (ROOT / 'templates').glob('*.md'):
            text = path.read_text(encoding='utf-8')
            self.assertIn('.sdd/core.md', text)
            refs = set(re.findall(r'/(sdd-[a-z-]+)\b', text))
            self.assertLessEqual(refs, names | {'sdd-planning'}, path.name)

    def test_all_clients_install_small_adapters_and_alias(self):
        self.install('all')
        self.assertTrue((self.root / '.sdd/tools/sdd_validate.py').is_file())
        self.assertEqual((self.root / '.sdd/core.md').read_bytes(), (ROOT / 'sdd/core.md').read_bytes())
        paths = ('.agents/skills/sdd-spec-assisted/SKILL.md', '.agents/workflows/sdd-spec-assisted.md',
                 '.cursor/commands/sdd-spec-assisted.md', '.cursor/rules/sdd-spec-assisted.mdc',
                 '.opencode/commands/sdd-spec-assisted.md', '.continue/rules/sdd-spec-assisted.md',
                 '.github/prompts/sdd-spec-assisted.prompt.md', '.claude/skills/sdd-spec-assisted/SKILL.md',
                 '.codex/skills/sdd-spec-assisted/SKILL.md', '.codex/prompts/sdd-spec-assisted.md')
        for relative in paths:
            text = (self.root / relative).read_text(encoding='utf-8')
            self.assertIn('.sdd/workflows/sdd-spec-assisted.md', text)
            self.assertLess(len(text), 700)
        alias = (self.root / '.agents/skills/sdd-planning/SKILL.md').read_text()
        self.assertIn('name: sdd-planning', alias)
        self.assertIn('sdd-plan-tecnico.md', alias)
        self.assertNotIn('globs:', (self.root / '.cursor/rules/sdd-spec-assisted.mdc').read_text())
        self.assertIn('invokable: true', (self.root / '.continue/rules/sdd-spec-assisted.md').read_text())
        self.assertLess(len((self.root / '.cursorrules').read_text()), 700)
        self.assertIn('$ARGUMENTS', (self.root / '.codex/prompts/sdd-spec-assisted.md').read_text())

    def test_preserve_instructions_and_idempotent_reinstall(self):
        for name in ('AGENTS.md', '.cursorrules', 'CLAUDE.md', 'CODEX.md', '.github/copilot-instructions.md'):
            path = self.root / name
            path.parent.mkdir(parents=True, exist_ok=True)
            path.write_text('# Equipo\nMantener política propia.\n', encoding='utf-8')
        self.install('all')
        before = {p.relative_to(self.root): p.read_bytes() for p in self.root.rglob('*') if p.is_file()}
        self.install('all')
        after = {p.relative_to(self.root): p.read_bytes() for p in self.root.rglob('*') if p.is_file()}
        self.assertEqual(before, after)
        for name in ('AGENTS.md', '.cursorrules', 'CLAUDE.md', 'CODEX.md', '.github/copilot-instructions.md'):
            text = (self.root / name).read_text(encoding='utf-8')
            self.assertIn('Mantener política propia.', text)
            self.assertEqual(text.count(installer.START), 1)

    def test_upgrade_removes_old_commands_and_backs_up_files(self):
        for name in ('sdd-spec-high', 'sdd-spec'):
            path = self.root / f'.cursor/commands/{name}.md'
            path.parent.mkdir(parents=True, exist_ok=True)
            path.write_text('# SDD-Spec-High: Fixture\n', encoding='utf-8')
        rules = self.root / '.cursorrules'
        rules.write_text('# SDD Workflows y Reglas de Desarrollo\n\nManual antiguo\n', encoding='utf-8')
        self.install('cursor')
        self.assertFalse((self.root / '.cursor/commands/sdd-spec-high.md').exists())
        self.assertFalse((self.root / '.cursor/commands/sdd-spec.md').exists())
        backups = list((self.root / '.sdd/backups').rglob('sdd-spec-high.md'))
        self.assertEqual(len(backups), 1)
        self.assertTrue(list((self.root / '.sdd/backups').rglob('.cursorrules')))
        self.assertNotIn('Manual antiguo', rules.read_text())

    def test_unrecognized_legacy_file_is_preserved(self):
        path = self.root / '.cursor/commands/sdd-spec-high.md'
        path.parent.mkdir(parents=True)
        path.write_text('# Documento del equipo\n', encoding='utf-8')
        with contextlib.redirect_stderr(io.StringIO()):
            self.install('cursor')
        self.assertEqual(path.read_text(), '# Documento del equipo\n')

    def test_missing_package_does_not_modify_destination(self):
        with tempfile.TemporaryDirectory() as source:
            with self.assertRaises(OSError):
                installer.Installer(self.root, source).install('cursor')
        self.assertEqual(list(self.root.iterdir()), [])

    @unittest.skipIf(os.name == 'nt', 'Symlink permissions differ on Windows')
    def test_write_rejects_symlink_outside_project(self):
        with tempfile.TemporaryDirectory() as outside:
            (self.root / '.sdd').symlink_to(outside, target_is_directory=True)
            with self.assertRaises(ValueError):
                self.install('cursor')
            self.assertEqual(list(Path(outside).iterdir()), [])

    @unittest.skipUnless(shutil.which('bash') and os.name != 'nt', 'Bash required')
    def test_bash_bootstrap_local_with_spaces(self):
        target = self.root / 'proyecto con espacios'
        target.mkdir()
        result = subprocess.run(['bash', str(ROOT / 'install.sh'), 'cursor'], cwd=target,
                                capture_output=True, text=True)
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertTrue((target / '.cursor/commands/sdd-spec-assisted.md').exists())
        result = subprocess.run(['bash', str(ROOT / 'install.sh'), 'unknown'], cwd=target,
                                capture_output=True, text=True)
        self.assertNotEqual(result.returncode, 0)

    pwsh_bin = shutil.which('pwsh') or shutil.which('powershell')

    @unittest.skipUnless(pwsh_bin, 'PowerShell required')
    def test_powershell_bootstrap_local(self):
        result = subprocess.run([self.pwsh_bin, '-NoProfile', '-File', str(ROOT / 'install.ps1'), '-Target', 'cursor'],
                                cwd=self.root, capture_output=True, text=True)
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertTrue((self.root / '.cursor/commands/sdd-spec-assisted.md').exists())


if __name__ == '__main__':
    unittest.main()
