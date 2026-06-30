# Spec Driven Development — motor **spec-kit**

> Este proyecto usa **spec-kit** como motor de specs (detectado por el harness:
> existe `.specify/`). El flujo SDD se ejecuta con los comandos `/speckit-*` del
> agente, no con el flujo built-in del harness ni con `feature_list.json`.

## Flujo

```
/speckit-constitution → /speckit-specify → ⏸ HUMANO → /speckit-plan → /speckit-tasks → /speckit-implement
```

1. **`/speckit-constitution`** — establece/actualiza los principios del proyecto
   en `.specify/memory/constitution.md`. Apóyate en `docs/principles.md`,
   `docs/architecture.md` y `docs/conventions.md` del harness como fuente de
   esos principios (clean code, POO, SOLID, greenfield/brownfield).
2. **`/speckit-specify`** — redacta la especificación de la feature.
3. **Pausa.** El humano revisa la spec y aprueba o pide cambios. **No se toca
   código sin spec aprobada** (regla universal de `AGENTS.md` §4).
4. **`/speckit-plan`** — plan técnico. Verifica explícitamente el cumplimiento
   de la constitución.
5. **`/speckit-tasks`** — desglosa en tareas accionables.
6. **`/speckit-implement`** — implementa siguiendo las tareas.

Skills opcionales: `/speckit-clarify` (de-riesgar antes de planear),
`/speckit-analyze` (consistencia entre artefactos), `/speckit-checklist`
(calidad de requirements).

## División de responsabilidades

- **spec-kit** gestiona el ciclo de cada feature: spec, plan, tasks, implement,
  y su propio tracking (`.specify/`, `specs/`, ramas).
- **El harness** aporta lo que spec-kit no cubre y sigue vigente:
  - Principios de ingeniería: `docs/principles.md`, `architecture.md`, `conventions.md`.
  - Flujo de Git del perfil: `docs/git-workflow.md`.
  - Enforcement agnóstico: `init.sh` + git hooks (`.githooks/`).
  - Bitácora de sesión: `progress/current.md` + `history.md`.
  - Cero rastros en git (spec-kit y harness van a `.git/info/exclude`).

## Verificación

Sigue valiendo `docs/verification.md` y `CHECKPOINTS.md`: tests no negociables
para cerrar, `./init.sh` en verde antes de dar nada por terminado. En este modo
`init.sh` no valida `feature_list.json` (no existe): el ciclo de specs lo
gobierna spec-kit.
