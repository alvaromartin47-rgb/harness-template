# Flujo de Git — perfil **comafi** (banco)

> Instalado por el harness según el perfil elegido. Refleja el workflow de los
> proyectos del Banco Comafi.

## Reglas universales

- **Una feature → una branch.** No mezclar cambios de varias features.
- **Estado final = `develop`.** La feature se trabaja en su rama, pero al
  terminar **siempre se mergea a `develop`** y se deja el repo posicionado allí.
- **El merge se consulta con el desarrollador antes de ejecutarlo. Nunca
  automático.** (Ver `principles.md` §3.)
- **PRs:** en inglés, descripción concisa del QUÉ; se amplía solo si el cambio
  es significativo.

## Modelo de ramas

- **`feature/CAL-XXX`** o **`feature/ME-XXX`** → desde `develop` (prefijo del
  ticket de Jira).
- **`release/X.X.X`** → para QA.
- **`master`** → producción.

Push a `develop`, `release/*` o `master` **dispara el pipeline CDK** — esas
ramas se mantienen **siempre desplegables**.

**Ambientes:** sbx → dev → QA → prod (master).

## Commits

- En español, resumidos y enfocados en lo más importante; si hay muchos
  cambios se sintetizan en un mensaje cohesivo en vez de listar cada detalle.
- Se antepone el prefijo **`CAL-XXX`** o **`ME-XXX`** cuando el cambio
  corresponde a un ticket de Jira.
- Sin mención a IA / asistencia automática.
- **Revisar `git log`** para confirmar el patrón vigente antes de commitear.
