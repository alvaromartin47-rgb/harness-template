# Spec Driven Development (SDD)

> Flujo: requirements → design → tasks → code.
> El código no se escribe hasta que el spec está aprobado por un humano.

## Estructura

Cada feature con `"sdd": true` en `feature_list.json` tiene una carpeta
dedicada en cuanto deja `pending`:

```
specs/<feature-name>/
├── requirements.md   # QUÉ se necesita (EARS notation)
├── design.md         # CÓMO se construirá (decisiones técnicas)
└── tasks.md          # PASOS concretos a implementar
```

El `feature-name` coincide con el campo `name` de `feature_list.json`.

## Estados de una feature

| Estado         | Significado                                                    |
|----------------|----------------------------------------------------------------|
| `pending`      | Sin spec. Lo primero es redactar el spec.                     |
| `spec_ready`   | Spec drafted. Esperando aprobación humana. NO se toca código.  |
| `in_progress`  | Spec aprobado. Implementación en curso.                       |
| `done`         | Código verde, revisado, sesión cerrada.                       |
| `blocked`      | Atascado. Razón en `progress/current.md`.                     |

## La puerta de aprobación humana

El flujo automático se detiene **una vez**: cuando el spec (los tres
archivos) está listo, la feature pasa a `spec_ready` y se para. El humano
lee `specs/<feature>/` y dice "aprobado" (o pide cambios). Solo entonces se
transiciona `spec_ready → in_progress` y se implementa.

```
pending → [spec] → spec_ready → ⏸ HUMANO → in_progress → [implementar → revisar] → done
```

## requirements.md — EARS estricto

Las requirements se redactan en **EARS** (Easy Approach to Requirements
Syntax). Cada requirement es un párrafo numerado con uno de estos patrones:

| Patrón         | Plantilla                                                   |
|----------------|-------------------------------------------------------------|
| **Ubicuo**     | `El sistema DEBE <acción>.`                                 |
| **Evento**     | `CUANDO <disparador>, el sistema DEBE <acción>.`            |
| **Estado**     | `MIENTRAS <estado>, el sistema DEBE <acción>.`              |
| **Opcional**   | `DONDE <feature opcional>, el sistema DEBE <acción>.`       |
| **No deseado** | `SI <evento no deseado> ENTONCES el sistema DEBE <acción>.` |

Reglas duras:

- Cada requirement tiene un id estable: `R1`, `R2`, ...
- Cada requirement DEBE ser verificable por al menos un test concreto.
- No mezcles varios `DEBE` en un mismo requirement. Si hay más de uno, parte.
- No uses verbos blandos ("podría", "puede", "soporta"). Solo `DEBE` / `NO DEBE`.

## design.md — decisiones técnicas

Captura **antes** de tocar código:

- Qué archivos se crean / modifican.
- Qué firmas nuevas aparecen (funciones, clases, comandos).
- Qué excepciones se reutilizan o se añaden.
- Qué alternativa se descartó y por qué (mínimo una).

Apóyate en `docs/architecture.md` y `docs/conventions.md`. El `design.md`
documenta los puntos donde tu feature roza la frontera de esas reglas.

## tasks.md — checklist ejecutable

Pasos discretos en orden, cada uno con checkbox y los `R<n>` que cubre:

```markdown
- [ ] T1 — <paso>. Cubre: R1, R3.
- [ ] T2 — <paso>. Cubre: R2.
- [ ] T3 — Añadir test <nombre>. Cubre: R1.
```

Se marca `[x]` cada task al completarla. La revisión rechaza si queda
alguna `[ ]` sin justificación documentada.

## Trazabilidad (regla dura)

- Cada test debe poder mapearse a un `R<n>` de su spec.
- Cada `R<n>` debe tener al menos un test concreto.
- La revisión comprueba esta correspondencia explícitamente y rechaza si falta.

Documenta el mapa en `progress/impl_<name>.md`:

```markdown
## Trazabilidad
- R1 → `test_...`
- R2 → `test_...`
```

## Cuándo NO aplica SDD

Las features con `"sdd": false` o sin el campo `sdd` NO tienen spec. SDD
solo se aplica a las features marcadas.
