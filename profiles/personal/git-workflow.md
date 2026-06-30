# Flujo de Git — perfil **personal**

> Instalado por el harness según el perfil elegido. Reemplázalo solo si este
> proyecto necesita un flujo distinto.

## Reglas universales

- **Una feature → una unidad de trabajo coherente.** No mezclar cambios de
  varias features en el mismo commit/merge.
- **Estado final = `develop`.** Al terminar se deja el repo posicionado en
  `develop`; no se deja parado en una rama suelta.
- **El merge (o cambiar de rama) se consulta antes de ejecutarlo. Nunca
  automático.** (Acción difícil de revertir; ver `principles.md` §3.)
- **Commits:** en español, concisos y enfocados en lo más importante; sin
  mención a IA / asistencia automática.
- **PRs:** en inglés, descripción concisa del QUÉ.

## Modelo de ramas

Solo **dos ramas** por defecto:

- **`main`** — lo estable / publicable.
- **`develop`** — base de trabajo; acá se integra el día a día.

El trabajo se hace sobre `develop` y se mergea a `main` cuando hay algo
estable para publicar.

**Ramas adicionales** (`feature/<n>`, `release/*`, `hotfix/*`, etc.) **solo se
crean si se piden explícitamente.** Por defecto no se abren feature branches:
se trabaja directo en `develop`.
