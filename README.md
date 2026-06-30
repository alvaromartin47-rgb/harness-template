# harness-template

Plantilla portable de **Harness Engineering** con flujo **Spec Driven
Development (SDD)**. La montas en cualquier proyecto con un comando y funciona
con cualquier agente (Claude Code, Codex/GPT). El proceso vive en archivos
versionados, no en el runtime del agente.

## Idea

- **Opt-in por proyecto:** un repo solo tiene arnés si corres el instalador ahí. Cero contaminación de tus otros proyectos.
- **Agnóstico del agente:** la fuente de verdad es `AGENTS.md` (estándar que leen Claude, Codex, Cursor, Gemini…). Los archivos por-agente son adaptadores finos.
- **Enforcement agnóstico:** la verificación la garantizan **git hooks** + `init.sh`, no el agente. Corre lo edite quien lo edite.
- **Estado en disco:** `specs/`, `progress/`, `feature_list.json` sobreviven a reinicios y context windows.

## Instalación

Desde la raíz del proyecto donde quieres el arnés:

```bash
rm -rf /tmp/harness-template \
  && git clone --depth 1 https://github.com/alvaromartin47-rgb/harness-template /tmp/harness-template \
  && bash /tmp/harness-template/install.sh
```

Opciones: `--agents claude,codex,gemini,cursor` · `--profile personal|comafi|fiuba` · `--dir <ruta>` · `--force` · `--pointer`

Adaptadores disponibles: `claude` (CLAUDE.md + subagentes), `codex` (usa
`AGENTS.md` nativo), `gemini` (GEMINI.md), `cursor` (`.cursor/rules/`).

**Perfiles** (definen el flujo de Git en `docs/git-workflow.md`):
- `personal` (default) — solo `main` + `develop`; más ramas a pedido.
- `comafi` — `feature/CAL-XXX` desde `develop`, `release/*`, `master`; pipeline CDK.
- `fiuba` — `main`/`dev` + `feature|bugfix|hotfix|refactor/<n>`; Conventional Commits.

## Gatillo "configura mi harness"

Para disparar la instalación con una frase desde cualquier agente, instala el
**pointer** en tu config global (una sola vez por PC):

```bash
bash /tmp/harness-template/pointer.sh
```

Esto añade un bloque idempotente a `~/.claude/CLAUDE.md` y `~/.codex/AGENTS.md`
que enseña al agente a clonar este repo y correr `install.sh`. A partir de
ahí, decir **"configura mi harness"** en un proyecto monta todo.

## Qué instala

```
<proyecto>/
├── AGENTS.md            # fuente de verdad del proceso (todos los agentes)
├── init.sh             # verificación (configura TEST_CMD)
├── feature_list.json   # backlog: una feature a la vez
├── CHECKPOINTS.md      # criterios de "estado final correcto"
├── docs/               # architecture, conventions, specs, verification
├── progress/           # current.md + history.md (estado en disco)
├── specs/              # specs por feature (requirements/design/tasks)
├── .githooks/          # pre-commit + pre-push (enforcement agnóstico)
├── CLAUDE.md           # adaptador Claude (solo si --agents incluye claude)
└── .claude/agents/     # subagentes leader/spec_author/implementer/reviewer
```

## Flujo

```
pending → [spec] → spec_ready → ⏸ HUMANO APRUEBA → in_progress → [implementar → revisar] → done
```

En Claude se reparte en subagentes aislados; en Codex/GPT lo recorre un solo
agente en secuencia. El rigor lo sostienen los archivos y los git hooks.

## Estructura del template

```
harness-template/
├── install.sh          # instala el arnés en un proyecto
├── pointer.sh          # instala el gatillo en config global
├── template/           # núcleo portable (se copia tal cual)
└── adapters/           # shims por agente (claude, codex)
```
