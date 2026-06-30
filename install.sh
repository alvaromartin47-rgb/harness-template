#!/usr/bin/env bash
# install.sh — Monta el arnés Spec Driven Development en el proyecto actual.
#
# Uso:
#   bash install.sh [--agents ...] [--profile ...] [--dir TARGET] [--force] [--pointer]
#
#   --agents   Adaptadores a instalar (coma-separados): claude,codex,gemini,cursor
#              Default: claude,codex
#   --profile  Contexto del proyecto (define el flujo de Git): personal|comafi|fiuba
#              Default: personal
#   --dir      Directorio destino. Default: directorio actual ($PWD)
#   --force    Sobrescribe archivos existentes (por defecto NO se pisan)
#   --pointer  Además, añade el gatillo "configura mi harness" a las configs
#              globales del agente (~/.claude/CLAUDE.md, ~/.codex/AGENTS.md)
#
# El enforcement (tests + invariantes) lo dan los git hooks de .githooks/,
# que el instalador activa con `git config core.hooksPath .githooks`.

set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

AGENTS="claude,codex"
TARGET="$PWD"
PROFILE="personal"
FORCE=0
POINTER=0

while [ $# -gt 0 ]; do
  case "$1" in
    --agents) AGENTS="$2"; shift 2;;
    --dir)    TARGET="$2"; shift 2;;
    --profile) PROFILE="$2"; shift 2;;
    --force)  FORCE=1; shift;;
    --pointer) POINTER=1; shift;;
    -h|--help) sed -n '2,20p' "$0"; exit 0;;
    *) echo "Opción desconocida: $1"; exit 1;;
  esac
done

if [ ! -f "$SCRIPT_DIR/profiles/$PROFILE/git-workflow.md" ]; then
  echo "Perfil desconocido: $PROFILE (válidos: personal, comafi, fiuba)"; exit 1
fi

say() { printf "\033[0;36m[harness]\033[0m %s\n" "$1"; }
warn() { printf "\033[0;33m[harness]\033[0m %s\n" "$1"; }

copy() { # copy SRC DST  — no pisa salvo --force
  local src="$1" dst="$2"
  if [ -e "$dst" ] && [ "$FORCE" -ne 1 ]; then
    warn "existe, se conserva: ${dst#$TARGET/}  (usa --force para pisar)"
    return
  fi
  mkdir -p "$(dirname "$dst")"
  cp -R "$src" "$dst"
  say "+ ${dst#$TARGET/}"
}

say "Instalando arnés en: $TARGET"
mkdir -p "$TARGET"

# 1. Núcleo agnóstico (template/) → destino, archivo por archivo
( cd "$SCRIPT_DIR/template" && find . -type f -print0 ) | while IFS= read -r -d '' rel; do
  rel="${rel#./}"
  copy "$SCRIPT_DIR/template/$rel" "$TARGET/$rel"
done

chmod +x "$TARGET/init.sh" 2>/dev/null || true
chmod +x "$TARGET/.githooks/"* 2>/dev/null || true

# 1b. Flujo de Git según el perfil del proyecto
copy "$SCRIPT_DIR/profiles/$PROFILE/git-workflow.md" "$TARGET/docs/git-workflow.md"
say "perfil de Git: $PROFILE"

# Rutas del arnés a ocultar de git (sin rastros). Se acumulan y se vuelcan a
# .git/info/exclude (local, nunca versionado).
EXCLUDES=(
  "/AGENTS.md" "/CHECKPOINTS.md" "/feature_list.json" "/init.sh"
  "/.githooks/" "/progress/" "/specs/"
  "/docs/principles.md" "/docs/architecture.md" "/docs/conventions.md"
  "/docs/git-workflow.md" "/docs/specs.md" "/docs/verification.md"
)

# 2. Adaptadores por agente
IFS=',' read -ra LIST <<< "$AGENTS"
for a in "${LIST[@]}"; do
  case "$a" in
    claude)
      copy "$SCRIPT_DIR/adapters/claude/CLAUDE.md" "$TARGET/CLAUDE.md"
      ( cd "$SCRIPT_DIR/adapters/claude/.claude" && find . -type f -print0 ) | while IFS= read -r -d '' rel; do
        rel="${rel#./}"
        copy "$SCRIPT_DIR/adapters/claude/.claude/$rel" "$TARGET/.claude/$rel"
      done
      EXCLUDES+=("/CLAUDE.md" "/.claude/")
      ;;
    codex)
      say "codex: usa AGENTS.md de la raíz de forma nativa (sin archivos extra)";;
    gemini)
      copy "$SCRIPT_DIR/adapters/gemini/GEMINI.md" "$TARGET/GEMINI.md"
      EXCLUDES+=("/GEMINI.md");;
    cursor)
      ( cd "$SCRIPT_DIR/adapters/cursor/.cursor" && find . -type f -print0 ) | while IFS= read -r -d '' rel; do
        rel="${rel#./}"
        copy "$SCRIPT_DIR/adapters/cursor/.cursor/$rel" "$TARGET/.cursor/$rel"
      done
      EXCLUDES+=("/.cursor/");;
    *) warn "adaptador desconocido: $a (se omite)";;
  esac
done

# 3. Git hooks (enforcement) + ocultar todo rastro del arnés
if [ -d "$TARGET/.git" ]; then
  ( cd "$TARGET" && git config core.hooksPath .githooks )
  say "git hooks activados (core.hooksPath = .githooks)"

  # Sin rastros: las rutas del arnés se ignoran vía .git/info/exclude (local,
  # nunca versionado). No se toca .gitignore, así que no queda diff alguno.
  EXDIR="$TARGET/.git/info"; EXFILE="$EXDIR/exclude"
  mkdir -p "$EXDIR"; touch "$EXFILE"
  B="# >>> harness (sin rastros) — no versionar >>>"
  E="# <<< harness (sin rastros) <<<"
  if grep -qF "$B" "$EXFILE"; then
    python3 - "$EXFILE" "$B" "$E" <<'PY'
import sys, re
f, b, e = sys.argv[1], sys.argv[2], sys.argv[3]
t = open(f, encoding="utf-8").read()
t = re.sub(re.escape(b)+r".*?"+re.escape(e), "", t, flags=re.S).rstrip()
open(f, "w", encoding="utf-8").write(t + ("\n" if t else ""))
PY
  fi
  {
    echo "$B"
    printf '%s\n' "${EXCLUDES[@]}" | sort -u
    echo "$E"
  } >> "$EXFILE"
  say "rastros ocultos: ${#EXCLUDES[@]} rutas en .git/info/exclude (sin tocar .gitignore)"
else
  warn "El destino no es un repo git. Inicialízalo y reejecutá para ocultar rastros:"
  warn "  git init && bash <ruta>/install.sh --profile $PROFILE"
fi

# 4. Pointer global opcional
if [ "$POINTER" -eq 1 ]; then
  bash "$SCRIPT_DIR/pointer.sh" || warn "pointer.sh falló o no existe"
fi

echo ""
say "Listo. Próximos pasos:"
say "  1. Edita feature_list.json (project + tu primera feature real)."
say "  2. Rellena docs/architecture.md y docs/conventions.md."
say "  3. Ajusta TEST_CMD en init.sh si hace falta."
say "  4. Ejecuta ./init.sh — debe terminar verde."
