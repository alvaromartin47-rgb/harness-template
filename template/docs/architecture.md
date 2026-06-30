# Arquitectura — Qué significa "hacer un buen trabajo"

> Define el estándar de calidad de ESTE proyecto. Las revisiones evalúan el
> código contra este archivo. Los principios universales viven en
> `principles.md`; acá se decide **la arquitectura**, que sí depende del
> contexto del proyecto.

## Regla de oro: la arquitectura depende del estado del proyecto

La forma de programar (clean code, POO, SOLID — ver `principles.md`) es
**siempre la misma**. La **arquitectura** se decide según dónde estás parado:

### Proyecto NUEVO (greenfield)

Arquitectura preferida: **Clean Architecture / Hexagonal (Ports & Adapters)**.

- El **dominio** es lógica pura: no conoce frameworks, HTTP, base de datos ni
  SDKs de infraestructura.
- Los **adapters primarios** reciben la entrada (HTTP, eventos) y delegan en
  el dominio. Los **adapters secundarios** implementan los **ports** que el
  dominio define (DB, APIs externas).
- Las dependencias apuntan **hacia el dominio** (Dependency Inversion). El
  grafo se cablea en un único **composition root**.
- **Rationale:** aislar el dominio permite testear las reglas de negocio sin
  red ni infraestructura y sustituir cualquier integración sin tocarlas.

### Proyecto EMPEZADO con otra arquitectura (brownfield)

**Se respeta la arquitectura existente. NO se reescribe.**

- Aunque no sea la que elegirías, imponer Clean/Hexagonal sobre una base que
  ya tiene otra estructura es **sobreingeniería** y rompe la consistencia con
  el resto del equipo.
- Se aplican clean code, POO y SOLID **dentro** de la arquitectura que ya
  está. Se mejora localmente, sin migraciones arquitectónicas no pedidas.
- Si creés que un cambio de arquitectura aportaría valor real, **no lo hagas
  por tu cuenta**: presentá el trade-off y dejá que el desarrollador decida
  (`principles.md` §3).

### Ante la duda

Si no está claro qué arquitectura sigue el proyecto, o si una decisión roza la
frontera entre "mejora local" y "cambio estructural", **se consulta** antes de
avanzar.

## Estructura de este proyecto

<!-- RELLENA: módulos/capas reales de ESTE proyecto y la responsabilidad de
cada uno. En greenfield, refleja la separación dominio / adapters primarios /
adapters secundarios. En brownfield, describe la estructura tal como existe. -->

```
_describe la estructura real del proyecto_
```

## Reglas de dependencia

<!-- RELLENA: qué puede importar qué. Ej (hexagonal):
- domain/ no importa de adapters/ ni de SDKs de infra.
- el grafo se cablea solo en el composition root. -->

## Qué NO hacer

<!-- RELLENA con los anti-patrones concretos del proyecto. -->

- _Anti-patrón 1_
- _Anti-patrón 2_
