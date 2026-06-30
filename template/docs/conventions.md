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

El flujo de Git **depende del contexto del proyecto** (banco / personal /
fiuba) y vive en **`docs/git-workflow.md`**, que el harness instala según el
perfil elegido. Consúltalo antes de crear ramas, commitear o mergear.

Lo único universal a todos los perfiles: **el merge (o cambiar de rama) se
consulta antes de ejecutarlo, nunca automático** (ver `principles.md` §3).

## Tests

- Un archivo de test por unidad lógica.
- Se testea comportamiento (entrada→salida), no estructura interna.
- Dobles inyectados por constructor; se mockea en los bordes, no el dominio.
- Nombres de test declarativos (evitar el prefijo "debe": "retorna X cuando…").
- El nivel de testing del proyecto se define en `verification.md`.

## Manejo de errores

<!-- RELLENA: jerarquía de errores del dominio, cómo se presentan al usuario,
códigos de salida / status. -->
