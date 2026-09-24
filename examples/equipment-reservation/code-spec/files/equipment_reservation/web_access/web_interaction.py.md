---
type: "Source File"
title: "web_interaction.py"
description: "Python source file at equipment_reservation/web_access/web_interaction.py."
spec_id: "FILE-equipment-reservation-web-access-web-interaction-py"
layer: "L0"
provenance: "observed"
generator: "agent"
source_path: "equipment_reservation/web_access/web_interaction.py"
language: "Python"
role: "source"
git_blob: "ec66148efdce379427d57bab57196cd25d4cdd09"
source_ref: "b49ac9d318000495dffc599116320a75fd08fd91"
git_commit: "b49ac9d318000495dffc599116320a75fd08fd91"
---

# Purpose

[inferred] web_interaction.py supports the Web Interaction responsibility. The source starts: `"""Serve browser forms and coordinate policy checks before domain transactions."""`.

# Responsibilities

- Owns the declarations and behavior listed under Symbols. Evidence: `equipment_reservation/web_access/web_interaction.py:1`.
- Its direct owning Module is [Web Interaction](../../../modules/web-interaction.md).

# Symbols

- `create_app(config)` — Create a localhost reference app; initialize persistent storage and request handlers. Evidence: `equipment_reservation/web_access/web_interaction.py:15`.
- `home()` — Render a demo selector and forms; never disclose domain records on page load. Evidence: `equipment_reservation/web_access/web_interaction.py:29`.
- `action(operation)` — Authorize a form action, execute atomically, and return HTML or explicit JSON. Evidence: `equipment_reservation/web_access/web_interaction.py:35`.

# Control flow

- `def create_app(config=None)` checks a condition, returns a result. Entry: `equipment_reservation/web_access/web_interaction.py:15`.

# Data & side effects

- database read `pathlib` at `equipment_reservation/web_access/web_interaction.py:6`.
- database read `flask` at `equipment_reservation/web_access/web_interaction.py:8`.

# Dependencies

- Uses [equipment_use_management.py](../equipment_handoff/equipment_use_management.py.md).
- Uses [scheduling_operations.py](../equipment_scheduling/scheduling_operations.py.md).
- Uses [actor_access.py](actor_access.py.md).

# Errors

- `raise PermissionError("Refresh the page before submitting this form.")` at `equipment_reservation/web_access/web_interaction.py:40`.

# Configuration

- Configuration or environment input is defined or read here. Evidence: `equipment_reservation/web_access/web_interaction.py:1`. Secret values are omitted.

# Tests

- [test_application.py](../../tests/test_application.py.md) documents test source; test execution status is in the bundle record.
- [test_browser.py](../../tests/test_browser.py.md) documents test source; test execution status is in the bundle record.

# Related

- [Web Interaction](../../../modules/web-interaction.md).

# Evidence

- `equipment_reservation/web_access/web_interaction.py:1` — file start.
- `git_blob: ec66148efdce379427d57bab57196cd25d4cdd09` — source content hash.
