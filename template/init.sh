#!/usr/bin/env bash
# init.sh — Verificación e inicialización del entorno
#
# Lo ejecuta el agente al COMENZAR una sesión y antes de declarar cualquier
# tarea como `done`. Si falla, la sesión no debe avanzar.
#
# Agnóstico del lenguaje: valida los invariantes del arnés y luego corre el
# comando de tests del proyecto. Configura TEST_CMD abajo o expórtalo en el
# entorno. Si no se define, intenta autodetectarlo.

set -u
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[0;33m'; NC='\033[0m'
ok()   { printf "${GREEN}[OK]${NC}    %s\n" "$1"; }
warn() { printf "${YELLOW}[WARN]${NC}  %s\n" "$1"; }
fail() { printf "${RED}[FAIL]${NC}  %s\n" "$1"; }

EXIT_CODE=0

# ── Comando de tests del proyecto ───────────────────────────────────────
# Edita esta línea con el comando que corre tus tests, o expórtalo fuera.
# Ejemplos: "pytest -q" | "npm test --silent" | "go test ./..." | "cargo test"
TEST_CMD="${TEST_CMD:-}"

autodetect_test_cmd() {
  if [ -f "pytest.ini" ] || [ -d "tests" ] && command -v pytest >/dev/null 2>&1; then
    echo "pytest -q"; return
  fi
  if [ -f "package.json" ] && grep -q '"test"' package.json 2>/dev/null; then
    echo "npm test --silent"; return
  fi
  if [ -f "go.mod" ]; then echo "go test ./..."; return; fi
  if [ -f "Cargo.toml" ]; then echo "cargo test"; return; fi
  if [ -d "tests" ]; then echo "python3 -m unittest discover -s tests"; return; fi
  echo ""
}

echo "── 1. Verificando archivos base del arnés ──────────────"
for f in AGENTS.md progress/current.md docs/principles.md docs/architecture.md docs/conventions.md docs/git-workflow.md docs/specs.md docs/verification.md CHECKPOINTS.md; do
  if [ ! -f "$f" ]; then fail "Falta archivo base: $f"; EXIT_CODE=1; else ok "Existe $f"; fi
done

echo ""
echo "── 2. Validando feature_list.json y specs ─────────────"
if [ ! -f feature_list.json ]; then
  ok "Sin feature_list.json (motor spec-kit): validación delegada a spec-kit"
elif ! command -v python3 >/dev/null 2>&1; then
  warn "python3 no disponible: se omite la validación de feature_list.json"
else
python3 - <<'PY'
import json, os, sys
try:
    data = json.load(open("feature_list.json"))
    valid = {"pending", "spec_ready", "in_progress", "done", "blocked"}
    features = data.get("features", [])
    in_progress = [f for f in features if f.get("status") == "in_progress"]
    if len(in_progress) > 1:
        print(f"[FAIL]  Hay {len(in_progress)} features en in_progress (máximo 1)")
        sys.exit(1)
    requires_spec = {"spec_ready", "in_progress", "done"}
    errors = []
    for f in features:
        if f.get("status") not in valid:
            print(f"[FAIL]  Estado inválido en feature {f.get('id')}: {f.get('status')}")
            sys.exit(1)
        if f.get("sdd") and f.get("status") in requires_spec:
            d = os.path.join("specs", f["name"])
            for fn in ("requirements.md", "design.md", "tasks.md"):
                if not os.path.isfile(os.path.join(d, fn)):
                    errors.append(f"feature {f['id']} ({f['name']}) en {f['status']} sin {d}/{fn}")
    if errors:
        for e in errors: print(f"[FAIL]  {e}")
        sys.exit(1)
    print(f"[OK]    feature_list.json válido ({len(features)} features)")
except SystemExit:
    raise
except Exception as e:
    print(f"[FAIL]  feature_list.json o specs inválidos: {e}")
    sys.exit(1)
PY
[ $? -ne 0 ] && EXIT_CODE=1
fi

echo ""
echo "── 3. Ejecutando tests ─────────────────────────────────"
[ -z "$TEST_CMD" ] && TEST_CMD="$(autodetect_test_cmd)"
if [ -z "$TEST_CMD" ]; then
  warn "Sin comando de tests configurado (define TEST_CMD en init.sh)"
else
  echo "→ $TEST_CMD"
  if eval "$TEST_CMD"; then ok "Tests en verde"; else fail "Hay tests rotos"; EXIT_CODE=1; fi
fi

echo ""
echo "── 4. Resumen ──────────────────────────────────────────"
if [ $EXIT_CODE -eq 0 ]; then ok "Entorno listo. Puedes empezar a trabajar."
else fail "Entorno NO está listo. Resuelve los errores antes de avanzar."; fi
exit $EXIT_CODE
