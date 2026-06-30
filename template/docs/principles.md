# Principios de ingeniería (no negociables)

> Estos principios aplican **siempre**, en cualquier proyecto, sin importar
> su arquitectura ni cómo programen los demás desarrolladores. Son la forma
> de trabajar; la arquitectura concreta se decide aparte (ver
> `architecture.md`). Cualquier agente que trabaje en este repo los respeta.

## 1. Programación orientada a objetos con comportamiento

- El dominio modela **comportamiento, no solo datos**. Prohibidas las clases
  anémicas (solo getters/setters).
- Colaboración entre clases con **dependencias inyectadas por constructor**.
  Se programa contra **interfaces** (ports), no contra implementaciones.
- Sin funciones sueltas a nivel de módulo cuando la responsabilidad es de una
  clase. El grafo de dependencias se cablea en un único *composition root*.
- Se aplican encapsulamiento, polimorfismo y delegación: cada regla vive en un
  único lugar; los orquestadores delegan, no acumulan condicionales.

## 2. SOLID con la simplicidad como criterio rector (YAGNI)

- La opción por defecto es **la solución más simple que resuelve el problema
  real y presente**. No se construye para un futuro hipotético.
- Un patrón de diseño (Strategy, Factory, Observer, etc.) se aplica **cuando
  encaja de verdad** con el problema; no se fuerza por anticipación ni se
  evita por dogma.
- **Composición sobre herencia** como regla general, pero caso por caso: si
  para un caso puntual la herencia es claramente mejor y mejora el diseño, se
  considera con seriedad.

## 3. Decisiones dudosas → se consultan

- Cuando la mejor opción **no es clara** —elegir un patrón, decidir entre
  composición y herencia, sumar una abstracción o una capa, introducir una
  dependencia— se **detiene el trabajo** y se presenta el trade-off con pros
  y contras para que **el desarrollador decida**.
- Las decisiones con una opción **obviamente mejor** se resuelven de forma
  pragmática, sin consultar.

## 4. Sin sobreingeniería

- SOLID, los patrones y la composición son herramientas para **reducir
  complejidad**, no objetivos en sí mismos. Aplicarlos a ciegas —o evitarlos
  por prejuicio— agrega rigidez.
- La complejidad que contradiga "elegancia / YAGNI" requiere justificación
  explícita.

## 5. Tipado estricto y una sola fuente de verdad

- Tipado estricto: nada de tipos laxos ni escapes de tipo (`any` y similares).
- **Una sola fuente de verdad** para los tipos del contrato; no se duplican
  entre capas. Las respuestas de dependencias externas se **validan en el
  borde** antes de entrar al dominio.

## 6. Errores explícitos

- Las funciones que pueden fallar lanzan errores nombrados; no devuelven
  `null`/`undefined` silencioso ni se tragan excepciones.
- Toda integración externa tiene timeout y manejo de error explícito. Una
  falla acotada no se convierte en un cuelgue silencioso.

## 7. Tests no negociables para cerrar

- **Ningún cambio se da por terminado sin tests** que ejerciten su
  comportamiento. Build + tests en verde para mergear.
- El **nivel** de testing (TDD estricto, unit por responsabilidad,
  integración/e2e contra dependencias reales) **se decide por proyecto**
  según dónde vive el valor y el riesgo — ver `verification.md`. Lo
  innegociable es que el comportamiento quede cubierto; el cómo se adapta.
- Se testea **comportamiento (entrada→salida)**, no estructura. Se evita el
  acoplamiento a detalles internos (spies de "se llamó con X") que rompe ante
  cualquier refactor. Los dobles se inyectan por constructor y se mockea solo
  en los bordes, nunca la lógica de dominio.

## 8. Clean code

- Nombres claros y autoexplicativos: el código es la documentación.
- **Comentarios solo cuando se justifican**: breves (una o dos líneas), donde
  el código no se entiende por sí solo. Con buen naming, modularidad y SOLID
  bien aplicado, lo normal es que no hagan falta. Sin comentarios obvios,
  redundantes ni referencias a estados históricos del código.

## 9. Verificar contra documentación oficial

- Antes de implementar contra una API, librería o construct que no se domina,
  se **verifica el uso correcto contra la documentación oficial** en lugar de
  asumirlo. No se inventan APIs ni firmas.

## 10. Planificar lo no trivial

- Las tareas no triviales (más de 3 pasos o decisiones arquitectónicas) se
  **planifican antes de codear**. Si algo se desvía, se para y se replanifica.
