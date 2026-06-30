# Adaptador Codex / GPT (CLI)

Codex CLI lee **`AGENTS.md` de la raíz del repo de forma nativa**, así que no
necesita ningún archivo extra a nivel de proyecto: al instalar el arnés ya
queda `AGENTS.md` en la raíz y Codex lo respeta.

## Diferencias frente a Claude

- **Sin subagentes.** Codex recorre el flujo SDD (spec → aprobación → implementación → revisión) de forma **secuencial, en un solo contexto**. El proceso es el mismo; lo que cambia es que no hay roles aislados en paralelo.
- **Enforcement.** Igual que en cualquier agente: lo garantizan los **git hooks** (`.githooks/`) y `./init.sh`, no el runtime de Codex.

## Pointer global (opcional)

Para que "configura mi harness" funcione desde Codex en cualquier repo, añade
el pointer a tu config global de Codex (`~/.codex/AGENTS.md`). El instalador
del template puede hacerlo por ti (`install.sh --pointer`).
