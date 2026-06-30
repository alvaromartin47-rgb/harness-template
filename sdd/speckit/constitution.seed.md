# Constitución del proyecto

> Sembrada por el harness desde sus principios de ingeniería
> (`docs/principles.md`, `docs/architecture.md`, `docs/conventions.md`).
> Refínala con `/speckit-constitution` cuando quieras adaptarla al proyecto.
> Cada plan (`/speckit-plan`) verifica el cumplimiento de esta constitución.

## Core Principles

### I. POO con comportamiento
El dominio modela comportamiento, no solo datos: se prohíben las clases
anémicas (solo getters/setters). La colaboración es entre clases con
dependencias inyectadas por constructor, programando contra interfaces (ports),
no implementaciones. El grafo se cablea en un único composition root. Se aplican
encapsulamiento, polimorfismo y delegación.

### II. SOLID con simplicidad como criterio rector (YAGNI)
La opción por defecto es la solución más simple que resuelve el problema real y
presente. Un patrón de diseño se aplica cuando encaja de verdad, no por
anticipación. Composición sobre herencia como regla general, decidida caso por
caso.

### III. Decisiones dudosas se consultan
Cuando la mejor opción no es clara —elegir un patrón, composición vs herencia,
sumar una abstracción o capa, introducir una dependencia— se detiene el trabajo
y se presenta el trade-off para que el desarrollador decida. Las decisiones con
una opción obviamente mejor se resuelven solas, sin consultar.

### IV. Arquitectura según el contexto
Proyecto nuevo (greenfield): arquitectura preferida Clean / Hexagonal (Ports &
Adapters), dominio puro. Proyecto empezado (brownfield): se RESPETA la
arquitectura existente; no se reescribe. Se aplican clean code, POO y SOLID
DENTRO de lo que ya hay. Un cambio estructural se consulta, no se impone.
Ver `docs/architecture.md`.

### V. Tipado estricto y una sola fuente de verdad
Sin escapes de tipo. Una sola fuente de verdad para los tipos del contrato; las
respuestas externas se validan en el borde antes de entrar al dominio.

### VI. Errores explícitos
Las funciones que pueden fallar lanzan errores nombrados; no devuelven null
silencioso ni tragan excepciones. Toda integración externa tiene timeout y
manejo de error explícito.

### VII. Tests no negociables para cerrar (NON-NEGOTIABLE)
Ningún cambio se cierra sin tests que ejerciten su comportamiento; build + tests
en verde para mergear. El nivel (TDD estricto, unit por responsabilidad,
integración/e2e contra dependencias reales) se decide por proyecto según dónde
viven el valor y el riesgo. Se testea comportamiento (entrada→salida), no
estructura. Ver `docs/verification.md`.

### VIII. Clean code
Nombres claros y autoexplicativos: el código es la documentación. Comentarios
solo cuando se justifican (breves, donde el código no se entiende por sí solo).
Sin comentarios obvios ni redundantes.

### IX. Verificar contra documentación oficial
Antes de implementar contra una API, librería o construct que no se domina, se
verifica el uso correcto contra la documentación oficial. No se inventan firmas.

## Governance

Esta constitución prevalece sobre prácticas ad-hoc. Los principios universales
(I-III, V-IX) aplican siempre; la arquitectura (IV) se adapta al contexto del
proyecto. Una violación se corrige o se justifica explícitamente. La complejidad
que contradiga "elegancia / YAGNI" requiere justificación escrita.

**Versión**: 1.0.0 (semilla del harness) | **Ratificada**: (completar con `/speckit-constitution`)
