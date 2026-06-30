# CHECKPOINTS — Evaluación del estado final

> En sistemas multi-agente no se evalúa el camino, se evalúa el destino.
> Estos son los checkpoints objetivos que un juez (humano o IA) puede usar
> para decidir si el proyecto está sano.

## C1 — El arnés está completo

- [ ] Existen los archivos base: `AGENTS.md`, `init.sh`, `feature_list.json`, `progress/current.md`.
- [ ] Existen los docs: `docs/architecture.md`, `docs/conventions.md`, `docs/specs.md`, `docs/verification.md`.
- [ ] `./init.sh` termina con exit code 0.

## C2 — El estado es coherente

- [ ] Como mucho una feature en `in_progress` en `feature_list.json`.
- [ ] Toda feature `done` tiene tests asociados que pasan.
- [ ] `progress/current.md` está vacío o describe la sesión activa (sin basura de sesiones anteriores).

## C3 — El código respeta la arquitectura

- [ ] El código respeta la estructura prevista en `docs/architecture.md`.
- [ ] No hay dependencias externas no justificadas.
- [ ] No hay prints de debug sueltos, ni TODOs sin contexto.

## C4 — La verificación es real

- [ ] Hay al menos un test por unidad lógica del código.
- [ ] Los tests se ejecutan contra entornos aislados reales, no mocks innecesarios.
- [ ] El comando de tests muestra > 0 tests y todos verdes.

## C5 — La sesión se cerró bien

- [ ] No hay archivos temporales sospechosos sin trackear.
- [ ] `progress/history.md` tiene una entrada por la última sesión.
- [ ] La última feature trabajada está reflejada en su estado correcto.

## C6 — Spec Driven Development

- [ ] Toda feature `"sdd": true` en estado `spec_ready`/`in_progress`/`done` tiene `specs/<name>/` con los 3 archivos.
- [ ] `requirements.md` usa EARS estricto (ver `docs/specs.md`).
- [ ] Toda feature `done` con `"sdd": true` tiene todas sus tasks marcadas `[x]`.
- [ ] Cada `R<n>` está cubierto por al menos un test concreto.

---

**Cómo usar este archivo:** un revisor (humano o agente) recorre cada
checkbox, marca `[x]` o `[ ]`, y rechaza el cierre de sesión si quedan boxes
vacíos en C1-C6.
