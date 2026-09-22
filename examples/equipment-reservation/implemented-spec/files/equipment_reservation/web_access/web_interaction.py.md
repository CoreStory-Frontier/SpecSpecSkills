---
type: "Source File"
title: "equipment_reservation/web_access/web_interaction.py"
description: "Serve browser forms and coordinate policy checks before domain transactions."
spec_id: "FILE-equipment-reservation-web-access-web-interaction-py"
layer: "L0"
provenance: "observed"
generator: "agent"
source_path: "equipment_reservation/web_access/web_interaction.py"
git_blob: "ec66148efdce379427d57bab57196cd25d4cdd09"
language: "python"
role: "source"
revision_status: "uncommitted"
---

# Purpose

Serve browser forms and coordinate policy checks before domain transactions.

# Responsibilities

- Create a localhost reference app; initialize persistent storage and request handlers.

# Symbols

## `create_app(config=None)`

Create a localhost reference app; initialize persistent storage and request handlers.

Calls: `Flask`, `Path`, `Path(app.config['DATABASE']).parent.mkdir`, `PermissionError`, `actor_access.authorize`, `app.config.update`, `app.get`, `app.post`, `handoff.execute`, `handoff.initialize`, `jsonify`, `logging.basicConfig`, `os.environ.get`, `render_template`, `request.form.get`, `scheduling.execute`, `scheduling.initialize`, `scheduling.transaction`, `secrets.compare_digest`, `secrets.token_hex`, `session.get`, `session.setdefault`, `str`.

Branch conditions: `not session.get('csrf') or not secrets.compare_digest(session['csrf'], request.form.get('csrf', ''))`; `operation in ('pickup', 'return', 'history')`; `wants_json`.

Evidence: `equipment_reservation/web_access/web_interaction.py:15-57`.

## `home()`

Render a demo selector and forms; never disclose domain records on page load.

Calls: `app.get`, `render_template`, `secrets.token_hex`, `session.setdefault`.

Evidence: `equipment_reservation/web_access/web_interaction.py:29-32`.

## `action(operation)`

Authorize a form action, execute atomically, and return HTML or explicit JSON.

Calls: `PermissionError`, `actor_access.authorize`, `app.post`, `handoff.execute`, `jsonify`, `render_template`, `request.form.get`, `scheduling.execute`, `scheduling.transaction`, `secrets.compare_digest`, `session.get`, `str`.

Branch conditions: `not session.get('csrf') or not secrets.compare_digest(session['csrf'], request.form.get('csrf', ''))`; `operation in ('pickup', 'return', 'history')`; `wants_json`.

Evidence: `equipment_reservation/web_access/web_interaction.py:35-55`.


# Control flow

create_app reads environment and test overrides, creates the database directory, and initializes both domain stores in one transaction. GET / creates a session CSRF token and renders no protected records. POST checks CSRF and Actor Access before the serialized transaction. It dispatches scheduling or handoff, then returns JSON or HTML. PermissionError becomes 403; ValueError becomes 400. Transaction errors roll back before the response.

# Data & side effects

Starts Flask storage and request handling; reads environment configuration, uses signed sessions, and renders the template.

# Dependencies

- Uses [equipment_reservation/equipment_handoff/equipment_use_management.py](../equipment_handoff/equipment_use_management.py.md).
- Uses [equipment_reservation/equipment_scheduling/scheduling_operations.py](../equipment_scheduling/scheduling_operations.py.md).
- Uses [equipment_reservation/web_access/actor_access.py](actor_access.py.md).
- Uses [equipment_reservation/web_access/templates/index.html](templates/index.html.md).
- External/standard-library imports: flask, logging, os, pathlib, secrets.
- Used by [tests/test_application.py](../../tests/test_application.py.md).
- Used by [tests/test_browser.py](../../tests/test_browser.py.md).

# Errors

PermissionError produces HTTP 403. ValueError produces HTTP 400. Unexpected errors are not presented as success.

# Configuration

EQUIPMENT_DATABASE selects the database file. EQUIPMENT_SECRET optionally fixes the session secret. Tests override configuration with isolated paths and test-only secrets. No secret values are documented.

# Tests

- [test_application.py](../../tests/test_application.py.md) — application integration and browser coverage.
- [test_browser.py](../../tests/test_browser.py.md) — application integration and browser coverage.

# Related

- [web-interaction](../../../modules/web-interaction.md)

# Evidence

- `equipment_reservation/web_access/web_interaction.py:15-57`
- `equipment_reservation/web_access/web_interaction.py:29-32`
- `equipment_reservation/web_access/web_interaction.py:35-55`

# Notes

Working-tree snapshot. Git revision pinning is pending; this is not a fully conformant upstream code-spec.
