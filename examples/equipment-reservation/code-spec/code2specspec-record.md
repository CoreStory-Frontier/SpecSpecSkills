# Code-derived bundle record

- Source root: `examples/equipment-reservation/app`.
- Specification root: `examples/equipment-reservation/code-spec`.
- Git source revision: `b49ac9d318000495dffc599116320a75fd08fd91`.
- Included files: 12.
- Runtime: Python 3.13, Flask 3.1, and SQLite.
- Source documents are revision-pinned only where each L0 file records `source_ref` and `git_commit`.
- L4 product purpose is inferred from code; a source repository cannot confirm business intent.

## Exclusions

- `uv.lock` — Generated dependency lock; its dependency constraints are summarized from pyproject.toml.
- `.venv/`, `.pytest_cache/`, `__pycache__/`, `instance/`, and `test-results/` — local environments, caches, runtime data, or test output.

## Runtime verification

- `uv run pytest -q` from `app/`: 90 passed on 2026-09-23.
