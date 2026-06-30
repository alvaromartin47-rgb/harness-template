# AGENTS.md — Mapa de navegación para agentes de IA

> **Este archivo es la fuente de verdad del proceso.** Cualquier agente
> (Claude, Codex/GPT, Gemini, etc.) que trabaje en este repositorio debe
> leerlo y obedecerlo. No es una biblia de reglas: es un **mapa**. Lee solo
> lo que necesites cuando lo necesites (divulgación progresiva).
>
> Los archivos específicos de cada agente (`CLAUDE.md`, `.codex/`, etc.) son
> **adaptadores finos** que solo dicen "obedece este AGENTS.md". El proceso
> vive aquí.

---

## 1. Antes de empezar (obligatorio)

1. Ejecuta `./init.sh` y verifica que termina sin errores. Si falla, **para**
   y resuelve el entorno antes de tocar código.
2. Lee `progress/current.md` para entender en qué estado quedó la última sesión.
3. Lee `feature_list.json`. Toda feature con `"sdd": true` pasa por
   **Spec Driven Development** — ver `docs/specs.md` y §4.
4. Lee `docs/specs.md` antes de tocar cualquier spec o feature `sdd: true`.

## 2. Mapa del repositorio

| Archivo / carpeta            | Qué contiene                                                                | Cuándo leerlo |
|------------------------------|-----------------------------------------------------------------------------|---------------|
| `feature_list.json`          | Lista de tareas con estado (`pending` / `spec_ready` / `in_progress` / `done` / `blocked`) | Siempre, al empezar |
| `progress/current.md`        | Estado de la sesión actual                                                  | Siempre, al empezar |
| `progress/history.md`        | Bitácora append-only de sesiones anteriores                                 | Si necesitas contexto histórico |
| `specs/<feature>/`           | `requirements.md` + `design.md` + `tasks.md`                               | Antes de implementar cualquier feature con `"sdd": true` |
| `docs/principles.md`         | Principios de ingeniería no negociables (clean code, POO, SOLID, pragmatismo) | Antes de escribir código |
| `docs/architecture.md`       | Arquitectura del proyecto (greenfield vs brownfield) y estándar de calidad  | Antes de implementar |
| `docs/conventions.md`        | Reglas de estilo, nombres, estructura                                       | Antes de escribir código |
| `docs/git-workflow.md`       | Flujo de Git del proyecto (branches, commits, PRs) según el perfil          | Antes de crear ramas, commitear o mergear |
| `docs/specs.md`              | Proceso SDD: EARS notation, los 3 archivos, puerta de aprobación humana     | Antes de redactar o leer un spec |
| `docs/verification.md`       | Cómo verificar que tu trabajo funciona (incluye trazabilidad requirements)  | Antes de declarar una tarea como `done` |
| `CHECKPOINTS.md`             | Criterios objetivos de "estado final correcto"                              | Para auto-evaluarte |
| `.githooks/`                 | Hooks de git que fuerzan la verificación (agnósticos del agente)            | No los edites a mano |
| `src/` (o tu código)         | Código de la aplicación                                                     | Para implementar |
| `tests/` (o tus tests)       | Tests automáticos                                                           | Para verificar |

## 3. Reglas duras (no negociables)

- **Una sola feature a la vez.** No mezcles cambios de varias tareas en la misma sesión. `init.sh` rechaza más de una feature en `in_progress`.
- **No declares una tarea `done` sin pruebas verdes.** Ejecuta `./init.sh` y asegúrate de que el bloque de tests pasa al 100%.
- **No saltes la fase de spec.** Toda feature con `"sdd": true` debe pasar por la fase de spec y obtener aprobación humana antes de tocar código.
- **No saltes la puerta de aprobación humana.** El flujo se detiene en `spec_ready` y espera.
- **Documenta lo que haces** en `progress/current.md` mientras trabajas, no al final.
- **Deja el repositorio limpio** antes de cerrar la sesión (ver §5).
- **Si no sabes algo, busca en `docs/`** antes de inventarlo.

## 4. Flujo de trabajo (Spec Driven Development)

```
pending → [redactar spec] → spec_ready → ⏸ HUMANO APRUEBA → in_progress → [implementar → revisar] → done
```

1. Detecta la primera feature `pending` con `"sdd": true`.
2. Redacta `specs/<name>/{requirements.md, design.md, tasks.md}` y cambia el
   status a `spec_ready`. **NO toques código todavía.**
3. **Pausa.** El humano lee el spec en `specs/<name>/` y aprueba (o pide cambios).
4. Una vez aprobado, cambia el status a `in_progress` e implementa.
5. Ejecuta las tasks de `tasks.md` una a una, marcándolas `[x]`.
6. Verifica trazabilidad `R<n>` ↔ test y que todas las tasks están completas.
7. Si todo pasa `./init.sh` en verde y la trazabilidad está cubierta, marca
   `done` y mueve el resumen a `progress/history.md`.

### Orquestación multi-agente (opcional, según capacidades del agente)

El proceso anterior funciona con **un solo agente** recorriendo los pasos en
orden. Si tu runtime soporta **subagentes** (p. ej. Claude Code), puedes
delegar cada rol a un subagente aislado para mayor robustez:

- `spec_author` → redacta el spec, no escribe código.
- `implementer` → escribe código y tests de una feature ya aprobada.
- `reviewer` → valida trazabilidad y tasks, no edita código.

Esto es una **mejora**, no un requisito. La disciplina la sostienen los
archivos (`specs/`, `progress/`) y los git hooks, no el runtime. Ver los
adaptadores en el repositorio si tu agente los provee.

## 5. Cierre de sesión (lifecycle)

Antes de terminar:

1. Ejecuta `./init.sh` — todo verde.
2. Si la tarea está acabada: marca `status: "done"` en `feature_list.json`.
3. Mueve el resumen de `progress/current.md` al final de `progress/history.md`.
4. Vacía `progress/current.md` dejando solo la plantilla.
5. No dejes archivos temporales, ni prints de debug, ni TODOs sin contexto.

## 6. Verificación y enforcement (agnóstico del agente)

La verificación NO depende de qué agente seas. Está atornillada en dos sitios
que cualquier agente respeta:

- **`./init.sh`** — valida entorno, invariantes del arnés y corre los tests.
- **git hooks** (`.githooks/`) — `pre-commit` valida los invariantes del arnés
  y `pre-push` ejecuta `./init.sh` completo. Si fallan, git bloquea la
  operación. Esto corre aunque tu agente no tenga hooks propios.

Para activarlos en un clon nuevo: `git config core.hooksPath .githooks`
(el instalador lo hace por ti).

## 7. Si te bloqueas

- Relee la sección relevante de `docs/`.
- Si una herramienta no hace lo que esperas, **no inventes un workaround**:
  documenta el bloqueo en `progress/current.md`, marca la feature como
  `blocked` en `feature_list.json` y para la sesión.
