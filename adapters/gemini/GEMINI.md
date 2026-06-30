# Instrucciones para Gemini (adaptador del arnés)

> Adaptador fino. La fuente de verdad del proceso es `AGENTS.md` en la raíz
> del repo. Léelo y obedécelo.

## Activación del arnés

En **este** repositorio trabajas bajo el arnés Spec Driven Development de
`AGENTS.md`. Antes de cualquier tarea de código:

1. Lee `AGENTS.md`, `feature_list.json` y `progress/current.md`.
2. Ejecuta `./init.sh`. Si falla, paras y reportas.
3. Sigue el flujo SDD de `AGENTS.md` §4.

## Flujo (sin subagentes)

Gemini recorre el flujo de forma **secuencial, en un solo contexto**:

```
pending → [redactar spec] → spec_ready → ⏸ HUMANO APRUEBA → in_progress → [implementar → revisar] → done
```

- No saltes la fase de spec ni la puerta de aprobación humana.
- No marques `done` sin `./init.sh` en verde.
- Escribe resultados en archivos (`specs/<name>/`, `progress/`), no solo en chat.

El enforcement (tests + invariantes) lo garantizan los **git hooks**
(`.githooks/`) y `./init.sh`, no este archivo.
