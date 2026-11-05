# Decisiones y fuentes del framework

Revisión de referencias: 2026-11-05. Son guías de producto/ingeniería, no un estándar
único de SDD ni una certificación de este repositorio.

| Decisión | Fundamento |
| --- | --- |
| Núcleo breve y workflows bajo demanda | [OpenAI: Harness engineering](https://openai.com/index/harness-engineering/) describe AGENTS.md como mapa hacia fuentes especializadas. |
| Instrucciones concisas, procedimientos especializados y comprobaciones ejecutables | [Anthropic: Best practices](https://code.claude.com/docs/en/best-practices) distingue instrucciones interpretadas de controles deterministas. |
| Contexto pertinente y menor repetición | [Anthropic: Context engineering](https://www.anthropic.com/research/effective-context-engineering-for-ai-agents) explica el presupuesto de atención y la recuperación selectiva. |
| Reglas acotadas por propósito, sin globs globales de workflows | [Cursor: Rules](https://cursor.com/docs/rules) documenta reglas manuales y selección por contexto. |
| Intención → plan → tareas → implementación → comprobación | [GitHub Spec Kit](https://github.github.io/spec-kit/) ofrece procesos estructurados y revisión del resultado. |
| Adaptador específico para OpenCode | [OpenCode: Commands](https://docs.opencode.ai/docs/commands/) documenta archivos de comandos y argumentos. |
| Prompts invocables para Continue | [Continue: Prompts](https://docs.continue.dev/customize/deep-dives/prompts) documenta invokable y [Rules](https://docs.continue.dev/customize/deep-dives/rules) documenta selección contextual. |

La matriz HECHO/DERIVADO/TÉCNICO/PROPUESTA/BLOQUEO, los hashes de entradas y el tablero
generado son decisiones propias para resolver los problemas observados por el
autor. Su eficacia debe medirse en ejecuciones representativas. No se atribuyen
estos mecanismos concretos a las empresas citadas.

Se conserva la inferencia en seis dimensiones del generador asistido y la
formalización EARS/Gherkin. Se centralizan las reglas repetidas y se retiran
prescripciones estéticas universales. Se mantiene la protección del alcance sin
exigir aprobación para helpers o detalles técnicos reversibles.

El instalador requiere Python 3.9+ para compartir la lógica entre plataformas y
usar el mismo validador. Las copias permiten recuperar archivos anteriores; no
hay rollback transaccional de instalación. La actualización de documentos ya
existentes requiere revisión explícita para no perder reglas ni evidencia.
