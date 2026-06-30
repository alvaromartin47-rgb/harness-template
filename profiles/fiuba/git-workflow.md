# Flujo de Git — perfil **fiuba**

> Instalado por el harness según el perfil elegido. Refleja el workflow de los
> proyectos de FIUBA (patrimonio-backend / patrimonio-frontend).

## Reglas universales

- **Una feature → una branch.** No mezclar cambios de varias features.
- **Estado final = `dev`.** La feature se trabaja en su rama, pero al terminar
  **siempre se mergea a `dev`** y se deja el repo posicionado allí.
- **El merge (o cambiar de rama) se consulta antes de ejecutarlo. Nunca
  automático.** (Ver `principles.md` §3.)
- **PRs:** en inglés, descripción concisa del QUÉ.

## Modelo de ramas

- **`main`** → producción.
- **`dev`** → base de trabajo.
- **`feature/<n>`**, **`bugfix/<n>`**, **`hotfix/<n>`**, **`refactor/<n>`** →
  desde `dev`, según el tipo de cambio.

## Commits

- En español, **resumidos y poco técnicos**, enfocados en lo más importante
  (un mensaje cohesivo, no una lista de detalles).
- **Conventional Commits:** `feat:` / `fix:` / `refactor:` (etc.).
- Sin mención a IA / asistencia automática.
