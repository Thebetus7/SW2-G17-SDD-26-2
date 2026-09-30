# SDD-Task: Desglose Atómico de Tareas TDD (SDD)

Este workflow transforma el plan técnico en un checklist secuencial y verificable en `docs/specs/XX-feature/tasks.md`.

---

## 1. Convención de Tareas Atómicas
Cada tarea debe ser autocontenida, verificable y seguir el ciclo **Red-Green-Refactor (TDD)**:
- [ ] `[T-01]` [Caja Blanca] Escribir tests unitarios que fallen para [Componente/Servicio].
- [ ] `[T-02]` [Implementación] Escribir el código mínimo necesario para poner `[T-01]` en verde.
- [ ] `[T-03]` [Refactor] Limpieza de código y verificación de linters sin romper tests.
- [ ] `[T-04]` [Caja Negra] Escribir y validar el test de aceptación BDD (Gherkin).

---

## 2. Checklist de Tareas por Vertical Slice

### Slice 1: Contratos y Dominio Base
- [ ] `[T-1.1]` Definir interfaces y esquemas de validación.
- [ ] `[T-1.2]` Tests de validación de datos (Caja Blanca).
- [ ] `[T-1.3]` Implementar validadores.

### Slice 2: Casos de Uso y Servicios
- [ ] `[T-2.1]` Tests unitarios con mocks de persistencia para el caso de uso.
- [ ] `[T-2.2]` Implementar lógica de negocio en el servicio.
- [ ] `[T-2.3]` Manejo de excepciones de dominio.

### Slice 3: Integración y Entrega
- [ ] `[T-3.1]` Endpoint o componente UI conectado.
- [ ] `[T-3.2]` Test de aceptación E2E / BDD (Caja Negra) en verde.
- [ ] `[T-3.3]` Verificación dual completa y linters.
