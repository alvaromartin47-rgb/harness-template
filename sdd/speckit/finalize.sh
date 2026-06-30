#!/usr/bin/env bash
# finalize.sh — Handoff spec-kit → harness.
#
# Spec-kit trabaja en su propia rama (p.ej. `001-mi-feature`) y la deja
# terminada. Este script toma esa versión final y la clona a una rama con la
# convención del perfil del harness (ver docs/git-workflow.md), opcionalmente la
# etiqueta, y DEJA LISTO el merge/PR — sin ejecutarlo. El merge se consulta con
# el desarrollador y se hace siguiendo docs/git-workflow.md.
#
# Uso:
#   .harness/finalize.sh <rama-destino> [--tag <tag>] [--from <rama-origen>]
#
# Ejemplos:
#   .harness/finalize.sh feature/CAL-1234 --tag CAL-1234
#   .harness/finalize.sh feature/buscador --from 003-buscador

set -euo pipefail

DEST=""; TAG=""; SRC=""
while [ $# -gt 0 ]; do
  case "$1" in
    --tag)  TAG="$2"; shift 2;;
    --from) SRC="$2"; shift 2;;
    -*) echo "opción desconocida: $1"; exit 1;;
    *) DEST="$1"; shift;;
  esac
done

[ -n "$DEST" ] || { echo "uso: .harness/finalize.sh <rama-destino> [--tag <tag>] [--from <rama-origen>]"; exit 1; }
SRC="${SRC:-$(git rev-parse --abbrev-ref HEAD)}"

git rev-parse --verify "$SRC" >/dev/null 2>&1 || { echo "rama origen inexistente: $SRC"; exit 1; }
if git show-ref --verify --quiet "refs/heads/$DEST"; then
  echo "la rama destino ya existe: $DEST (elegí otro nombre o borrala)"; exit 1
fi

# Clon del estado final de spec-kit en la rama con la convención del perfil
git branch "$DEST" "$SRC"
echo "✓ rama '$DEST' creada como clon del estado final de '$SRC'"

if [ -n "$TAG" ]; then
  git tag "$TAG" "$DEST"
  echo "✓ tag '$TAG' creado en '$DEST'"
fi

cat <<EOF

Listo el handoff. Próximos pasos (según docs/git-workflow.md del perfil):
  1. git switch $DEST
  2. Abrí el PR (en inglés) hacia la rama de integración (develop/dev).
  3. El MERGE SE CONSULTA antes de ejecutarlo — nunca automático.
  4. Estado final esperado = rama de integración.
EOF
