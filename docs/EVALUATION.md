# Evaluación de uso: inferencia, tareas y producto

Las pruebas automáticas de este repositorio verifican el motor de instalación y
el contrato documental. La calidad de un modelo siguiendo los workflows necesita
una evaluación adicional. Mantener fijo modelo, versión del cliente, presupuesto,
repositorio de partida y herramientas para comparar versiones del framework.

## Casos representativos

| Caso | Intención | Resultado observable |
| --- | --- | --- |
| Feature nueva | Registrar ventas y descontar stock | Infiere consistencia/doble envío; consulta política de stock negativo; recorre UI/API/BD y demuestra errores. |
| Proyecto existente | Agregar permisos a una operación | Recupera contratos reales, protege backend, respeta diseño y valida denegación y regresión. |
| Corrección pequeña | Evitar pérdida de un borrador al volver | Reproduce el caso, usa profundidad ligera y verifica navegación sin rediseño innecesario. |
| UI con estados | Listado con filtros, formulario y fallo de API | Define dirección visual, usa datos reales, mantiene jerarquía, teclado y responsive; muestra recuperación. |
| Iteración | Cambiar política de cancelación ya implementada | Revisa impacto, invalida entradas modificadas, preserva historia y revalida comportamiento nuevo. |

## Registro de una ejecución

Documentar prompt, commit inicial, modelo/versión, herramientas, comandos y outputs,
commit final y evidencia visual. Revisar:

- Requisitos originales conservados y propuestas nuevas aceptadas explícitamente.
- Consecuencias necesarias detectadas con razonamiento correcto.
- Preguntas útiles frente a preguntas repetidas o de bajo impacto.
- Cambios fuera del alcance y decisiones sin autorización.
- Tablero actualizado al inicio tras cada transición; métricas consistentes.
- Criterios de aceptación verificados con integración real.
- Calidad visual contra dirección acordada: jerarquía, composición, tipografía,
  legibilidad, consistencia, responsive, accesibilidad y estados.
- Tiempo, número de rondas y coste/tokens si la herramienta los proporciona.

Comparar varias ejecuciones por caso, registrando variación y limitaciones. Una
mejora visual requiere revisión de la aplicación funcionando; pasar los tests del
framework no demuestra una mejora estética. Un resultado NOT_RUN sigue pendiente.

## Comprobaciones automáticas disponibles

`python3 -m unittest discover -s tests -v` cubre instalaciones idempotentes,
preservación/migración, adaptadores, fallo de descarga local, dependencias de
tareas, evidencia incompleta, tablero desactualizado y cambios de entradas.

CI configura Python 3.9 y 3.13 en Linux y 3.13 en Windows/macOS, con prueba del
bootstrap PowerShell donde esté disponible. La generación de adaptadores no
significa que todos los clientes hayan sido probados de extremo a extremo.
