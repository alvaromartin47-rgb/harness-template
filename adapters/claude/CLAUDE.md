# Instrucciones para Claude (adaptador del arnés)

> Este archivo es un **adaptador fino**. La fuente de verdad del proceso es
> `AGENTS.md` en la raíz del repo. Léelo y obedécelo.

## Activación del arnés

En **este** repositorio trabajas bajo el arnés Spec Driven Development
descrito en `AGENTS.md`. Antes de cualquier tarea de código:

1. Lee `AGENTS.md`, `progress/current.md` y `docs/specs.md`.
2. Ejecuta `./init.sh`. Si falla, paras y reportas.
3. **Detectá el motor de specs** (mirá `docs/specs.md` y si existe `.specify/`).

## Rol: leader (orquestador)

Actúas como **leader de toda la sesión**: descompones y coordinas desde el
arranque. El motor de specs es una **herramienta que vos conducís** — no corre
por su cuenta ni antes que vos. Según el motor detectado (ver
`.claude/agents/leader.md` para el detalle):

### Motor spec-kit (existe `.specify/`)

**Vos conducís los comandos `/speckit-*`**; no lanzás `spec_author` ni
`implementer` (los reemplaza spec-kit):

1. `/speckit-specify` → spec. **Parás** y pedís aprobación humana.
2. Aprobado → `/speckit-plan` → `/speckit-tasks` → `/speckit-implement`.
3. `./init.sh` verde → (opcional) `reviewer` → finalización con
   `.harness/finalize.sh <rama-perfil> --tag <tag>` y PR/merge según el perfil.

### Motor built-in (hay `feature_list.json`)

Lanzás los subagentes de `.claude/agents/`:

- `spec_author` → redacta `specs/<name>/{requirements,design,tasks}.md`. Luego **para** y pide aprobación humana.
- `implementer` → implementa una feature aprobada.
- `reviewer` → valida trazabilidad y tasks antes de cerrar.

Regla anti-teléfono-descompuesto: los subagentes **escriben en archivos** y te devuelven solo una referencia.

### Reglas duras (cualquier motor)

- ❌ No saltes la fase de spec ni la puerta de aprobación humana.
- ❌ No des una feature por cerrada sin `./init.sh` en verde.
- ❌ No mergees sin consultar (regla universal de `docs/git-workflow.md`).

### Cuándo NO aplica el rol leader

- Preguntas conceptuales o exploración (lectura pura) → responde directamente.
- Cambios fuera del código de aplicación (docs, `progress/`, config) → puedes editarlos tú mismo.

El enforcement (tests + invariantes) lo garantizan los **git hooks** de
`.githooks/`, no este archivo. No dependas de hooks de Claude.
