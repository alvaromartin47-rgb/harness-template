# Verificación — Cómo demostrar que el trabajo funciona

> Regla de oro: **el agente no dice "funciona", lo demuestra**.
> Toda feature termina con evidencia ejecutable, no con afirmaciones.

## Principio: tests no negociables, nivel según el proyecto

**Ningún cambio se cierra sin tests** que ejerciten su comportamiento (ver
`principles.md` §7). Lo que **se decide por proyecto** es el *nivel* donde vive
la red de seguridad, según dónde estén el valor y el riesgo:

- **TDD estricto + unit por responsabilidad** cuando el valor está en lógica de
  dominio rica (orquestación, reglas de negocio). Red-Green-Refactor.
- **Integración + e2e contra dependencias reales** cuando el valor está en la
  interacción con infraestructura (DB, APIs); los unit pasan a ser opcionales.
- Lo habitual es una combinación. **Documenta abajo la estrategia elegida.**

> Estrategia de testing de ESTE proyecto: _RELLENA_

## Niveles de verificación

### Nivel 1 — Tests automáticos (obligatorio)

Toda unidad con comportamiento tiene al menos un test que:

1. Cubre el camino feliz.
2. Cubre al menos un camino de error si puede fallar.

Comando: el configurado en `init.sh` (`TEST_CMD`).

### Nivel 2 — Test de integración (obligatorio para features de interfaz)

Las features que añaden interfaz (CLI, API, UI) se verifican ejecutando el
sistema real contra un entorno aislado (directorio temporal, BD efímera).

### Nivel 3 — Trazabilidad de requirements (obligatorio para features `"sdd": true`)

Cada `R<n>` de `specs/<name>/requirements.md` debe poder mapearse a al menos
un test concreto. La revisión rechaza si falta cobertura. El mapa se
documenta en `progress/impl_<name>.md`:

```markdown
## Trazabilidad
- R1 → `test_...`
- R2 → `test_...`
```

## Anti-patrones (no hacer)

- ❌ "Lo añadí, debería funcionar." → falta test ejecutable.
- ❌ Test que solo verifica que no lanza excepción. → comprueba el resultado concreto.
- ❌ Marcar la feature como `done` sin pasar `./init.sh`.

## Verificación final antes de cerrar

```bash
./init.sh   # debe terminar con [OK] Entorno listo
```

Si `./init.sh` está rojo, **no** marques nada como `done`. Anota el bloqueo
en `progress/current.md` y el estado `blocked` en `feature_list.json`.
