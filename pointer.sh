#!/usr/bin/env bash
# pointer.sh — Añade el gatillo "configura mi harness" a las configs globales
# de los agentes, de forma idempotente. Es la ÚNICA pieza que vive en local.
#
# Uso: bash pointer.sh [--repo URL]

set -euo pipefail
REPO_URL="https://github.com/alvaromartin47-rgb/harness-template"

while [ $# -gt 0 ]; do
  case "$1" in
    --repo) REPO_URL="$2"; shift 2;;
    *) shift;;
  esac
done

MARK_BEGIN="<!-- harness-pointer:begin -->"
MARK_END="<!-- harness-pointer:end -->"

block() {
cat <<EOF
$MARK_BEGIN
## Gatillo: "configura mi harness"

Cuando el usuario diga **"configura mi harness"** (o equivalente) en un
proyecto, monta el arnés Spec Driven Development clonando la plantilla y
ejecutando su instalador en el directorio del proyecto actual:

\`\`\`bash
rm -rf /tmp/harness-template \\
  && git clone --depth 1 $REPO_URL /tmp/harness-template \\
  && bash /tmp/harness-template/install.sh
\`\`\`

Luego sigue \`AGENTS.md\` del proyecto. La fuente de verdad del proceso vive
en ese repo, no en esta config.
$MARK_END
EOF
}

add_pointer() { # add_pointer FILE
  local file="$1"
  mkdir -p "$(dirname "$file")"
  touch "$file"
  if grep -qF "$MARK_BEGIN" "$file" 2>/dev/null; then
    # Reemplaza el bloque existente
    python3 - "$file" "$MARK_BEGIN" "$MARK_END" <<'PY'
import sys, re
f, b, e = sys.argv[1], sys.argv[2], sys.argv[3]
txt = open(f, encoding="utf-8").read()
txt = re.sub(re.escape(b)+r".*?"+re.escape(e), "", txt, flags=re.S).rstrip()+"\n"
open(f, "w", encoding="utf-8").write(txt)
PY
  fi
  printf "\n%s\n" "$(block)" >> "$file"
  echo "[pointer] actualizado: $file"
}

add_pointer "$HOME/.claude/CLAUDE.md"
add_pointer "$HOME/.codex/AGENTS.md"
echo "[pointer] gatillo apuntando a: $REPO_URL"
