# Convenciones de código

> Homogeneidad extrema: un agente (y un humano) predicen mejor cuando el
> repositorio se parece a sí mismo en todas partes. Los principios de fondo
> están en `principles.md`; acá van las reglas concretas de forma.

## Reglas transversales (aplican a cualquier proyecto)

- **Idioma del código:** identificadores, métodos, clases y variables en
  español. (Los nombres de librerías y rutas siguen en inglés.)
- **Comentarios:** en español, breves (1-2 líneas), solo cuando el código no
  se entiende por sí solo. Sin comentarios obvios, redundantes ni referencias
  a estados históricos. Tono natural, como los escribiría un dev del equipo.
- **Tipado estricto:** sin escapes de tipo. Una sola fuente de verdad para los
  tipos del contrato; validar en el borde lo que viene de afuera.
- **Errores:** nombrados y centralizados; no se hardcodean strings de mensajes
  dispersos por el código.
- **Sin secretos en el repo:** credenciales fuera del código y de archivos
  versionados.

## Estilo (específico del lenguaje/stack)

<!-- RELLENA según el stack: versión del lenguaje, formateador, longitud de
línea, comillas, orden de imports, etc. -->

- _Lenguaje / versión:_
- _Formato / linter:_
- _Imports:_

## Nombres

| Tipo                    | Convención        | Ejemplo               |
|-------------------------|-------------------|-----------------------|
| Módulos / archivos      |                   |                       |
| Clases / tipos          |                   |                       |
| Funciones / variables   |                   |                       |
| Constantes              |                   |                       |
| Privadas                |                   |                       |

## Flujo de Git (branches, commits, PRs)

Reglas que aplican siempre:

- **Una feature, una branch.** Cada feature se trabaja en su propia rama
  `feature/<descripcion>` (con prefijo de ticket si el equipo lo usa, ej.
  `feature/CAL-123-...`), partiendo de la rama de integración del proyecto.
- **Estado final = rama de integración.** Terminada la feature se mergea a la
  rama de integración y se deja el repo posicionado allí; no se deja el repo
  parado en una feature branch suelta.
- **El merge se consulta con el desarrollador antes de ejecutarlo. Nunca
  automático.** (Es una acción difícil de revertir; ver `principles.md` §3.)
- **Las ramas que disparan pipeline/deploy se mantienen siempre desplegables.**
- **Commits:** en español, concisos y enfocados en lo más importante; si hay
  muchos cambios se sintetizan en un mensaje cohesivo en vez de listar cada
  detalle. Sin mención a IA/asistencia automática.
- **PRs:** en inglés, descripción concisa del QUÉ; se amplía solo si el cambio
  es significativo.

Específico del proyecto (RELLENA):

<!-- - Rama de integración: develop | main | ...
     - Ramas protegidas / que despliegan: develop, release/*, master | ...
     - Prefijo de ticket en branch y commit: CAL-XXX, ME-XXX | ninguno
     - Ambientes: sbx → dev → qa → prod | ... -->

- _Rama de integración:_
- _Ramas que despliegan:_
- _Prefijo de ticket:_

## Tests

- Un archivo de test por unidad lógica.
- Se testea comportamiento (entrada→salida), no estructura interna.
- Dobles inyectados por constructor; se mockea en los bordes, no el dominio.
- Nombres de test declarativos (evitar el prefijo "debe": "retorna X cuando…").
- El nivel de testing del proyecto se define en `verification.md`.

## Manejo de errores

<!-- RELLENA: jerarquía de errores del dominio, cómo se presentan al usuario,
códigos de salida / status. -->
