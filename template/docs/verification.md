# Verificación — Cómo demostrar que el trabajo funciona

> Regla de oro: **el agente no dice "funciona", lo demuestra**.
> Toda feature termina con evidencia ejecutable, no con afirmaciones.

## Niveles de verificación

### Nivel 1 — Tests automáticos (obligatorio)

Toda función pública tiene al menos un test que:

1. Cubre el camino feliz.
2. Cubre al menos un camino de error si la función puede fallar.

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
