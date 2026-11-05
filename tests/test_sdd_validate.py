import importlib.util
from pathlib import Path
import tempfile
import unittest

ROOT = Path(__file__).resolve().parents[1]
spec = importlib.util.spec_from_file_location('sdd_validate', ROOT / 'tools/sdd_validate.py')
sdd = importlib.util.module_from_spec(spec)
spec.loader.exec_module(sdd)


def task(ident='T1.1', depends='—', status='PENDING'):
    return f'''### {ident} [IMPL] Registrar una operación
**Status:** {status}
**Depends on:** {depends}
**Traceability:** PLAN-01, RF-01.1, SC-01.1.1
**Files:** src/operation.py
**Objective:** Registrar operación una sola vez.
**Work:** Implementar contrato aprobado.
**Done when:** Se comprueba persistencia e idempotencia.
**Verification:** NOT_RUN
**Command:** pendiente
**Exit code:** pendiente
**Evidence:** pendiente
'''


def document(*tasks):
    return ('# Tasks: Prueba\n' + sdd.START + '\n' + sdd.END + '\n\n'
            'Version: 1\nSpec-SHA256: pendiente\nPlan-SHA256: pendiente\n\n'
            '## Tareas detalladas\n\n' + '\n'.join(tasks))


def complete(text):
    return (text.replace('**Status:** PENDING', '**Status:** COMPLETED')
            .replace('**Verification:** NOT_RUN', '**Verification:** PASS')
            .replace('**Command:** pendiente', '**Command:** python -m unittest tests.test_operation')
            .replace('**Exit code:** pendiente', '**Exit code:** 0')
            .replace('**Evidence:** pendiente', '**Evidence:** 3 tests OK; persistencia y doble envío comprobados.'))


class ProgressTests(unittest.TestCase):
    def test_dashboard_at_top_and_idempotent(self):
        text = sdd.with_progress(document(task()))
        self.assertTrue(text.startswith('# Tasks: Prueba\n' + sdd.START + '\n## Task Progress'))
        self.assertIn('| Total de tareas | 1 |', text)
        self.assertIn('- [ ] T1.1', text)
        self.assertEqual(text, sdd.with_progress(text))

    def test_state_transitions_and_evidence_at_top(self):
        original = document(complete(task()), task('T1.2', 'T1.1'))
        text = sdd.with_progress(original)
        self.assertIn('| Progreso | 50.0% |', text)
        self.assertIn('Status: IN_PROGRESS', text)
        self.assertIn('- [x] T1.1', text)
        self.assertIn('3 tests OK', text.split(sdd.END)[0])
        finished = sdd.with_progress(complete(original))
        self.assertIn('Status: COMPLETED', finished)
        self.assertIn('| Progreso | 100.0% |', finished)

    def test_testing_and_blocked_states(self):
        text = document(task(status='BLOCKED') + '**Blocker:** Sin servicio local\n'
                        '**Source:** Entorno\n**Required action:** Iniciar servicio de pruebas\n')
        self.assertIn('Status: BLOCKED', sdd.with_progress(text))
        self.assertIn('- [!]', sdd.with_progress(text))
        self.assertIn('- [?]', sdd.with_progress(document(task(status='TESTING'))))

    def test_invalid_dag_and_duplicate_ids(self):
        for text in (document(task(), task()), document(task(depends='T2.1')),
                     document(task(depends='T1.2'), task('T1.2', 'T1.1')),
                     document(task(), task('T1.2', 'T1.1', 'IN_PROGRESS'))):
            with self.subTest(text=text), self.assertRaises(sdd.Invalid):
                sdd.with_progress(text)

    def test_completed_requires_real_fields_not_placeholders(self):
        for text in (task(status='COMPLETED'), complete(task()).replace('**Exit code:** 0', '**Exit code:** 1'),
                     complete(task()).replace('3 tests OK; persistencia y doble envío comprobados.', 'pendiente')):
            with self.subTest(text=text), self.assertRaises(sdd.Invalid):
                sdd.with_progress(document(text))

    def test_missing_fields_and_invalid_markers(self):
        for text in (document(task()).replace(sdd.END, ''),
                     document(task()).replace('**Status:** PENDING', '**Status:** UNKNOWN'),
                     document(task()).replace('**Status:** PENDING', '**Status:**'),
                     document(task()).replace('**Done when:** Se comprueba persistencia e idempotencia.\n', ''),
                     document(task()).replace(sdd.START, '## Otra sección\n' + sdd.START)):
            with self.subTest(text=text), self.assertRaises(sdd.Invalid):
                sdd.with_progress(text)

    def test_commands_in_evidence_are_not_executed(self):
        with tempfile.TemporaryDirectory() as temp:
            sentinel = Path(temp) / 'must-not-exist'
            text = complete(task()).replace('python -m unittest tests.test_operation', f'touch {sentinel}')
            sdd.with_progress(document(text))
            self.assertFalse(sentinel.exists())


class ModuleTests(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory()
        self.addCleanup(self.temp.cleanup)
        self.module = Path(self.temp.name) / 'docs/specs/01-operation'
        self.module.mkdir(parents=True)
        self.constitution = self.module.parent.parent / 'constitution.md'
        self.constitution.write_text('# Fixture\nStatus: APPROVED\nVersion: 1\n', encoding='utf-8')
        (self.module / 'spec.md').write_text('# Fixture\nStatus: APPROVED\nVersion: 1\nRF-01.1 SC-01.1.1\n', encoding='utf-8')
        (self.module / 'plan.md').write_text('# Fixture\nStatus: APPROVED\nVersion: 1\nPLAN-01\n', encoding='utf-8')
        self.tasks = self.module / 'tasks.md'
        self.tasks.write_text(document(task()), encoding='utf-8')
        sdd.bind(self.module, 'plan')
        sdd.bind(self.module, 'tasks')
        self.tasks.write_text(sdd.with_progress(sdd.read(self.tasks)), encoding='utf-8')

    def test_valid_module_and_stale_dashboard_detection(self):
        sdd.check_module(self.module)
        self.tasks.write_text(sdd.read(self.tasks).replace('| Total de tareas | 1 |', '| Total de tareas | 99 |'), encoding='utf-8')
        with self.assertRaisesRegex(sdd.Invalid, 'Tablero desactualizado'):
            sdd.check_module(self.module)

    def test_upstream_changes_invalidate_hashes(self):
        for path in (self.constitution, self.module / 'spec.md', self.module / 'plan.md'):
            original = path.read_text(encoding='utf-8')
            path.write_text(original + '\nCambio material\n', encoding='utf-8')
            with self.subTest(path=path), self.assertRaises(sdd.Invalid):
                sdd.check_module(self.module)
            path.write_text(original, encoding='utf-8')

    def test_unapproved_and_unknown_traceability(self):
        plan = self.module / 'plan.md'
        original = sdd.read(plan)
        plan.write_text(original.replace('APPROVED', 'DRAFT'), encoding='utf-8')
        with self.assertRaises(sdd.Invalid):
            sdd.bind(self.module, 'tasks')
        plan.write_text(original, encoding='utf-8')
        self.tasks.write_text(sdd.read(self.tasks).replace('**Traceability:** PLAN-01', '**Traceability:** PLAN-99'), encoding='utf-8')
        self.tasks.write_text(sdd.with_progress(sdd.read(self.tasks)), encoding='utf-8')
        with self.assertRaisesRegex(sdd.Invalid, 'referencias inexistentes'):
            sdd.check_module(self.module)

    def test_check_is_read_only(self):
        original = self.tasks.read_bytes()
        self.assertEqual(sdd.main(['check', str(self.module)]), 0)
        self.assertEqual(original, self.tasks.read_bytes())


if __name__ == '__main__':
    unittest.main()
