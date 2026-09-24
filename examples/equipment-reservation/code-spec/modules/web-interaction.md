---
type: "Module"
title: "Web Interaction"
description: "Accept user actions, coordinate authorization, and show results."
spec_id: "MOD-web-interaction"
layer: "L1"
provenance: "observed"
generator: "agent"
---

# Purpose

[inferred] Accept user actions, coordinate authorization, and show results. This boundary groups the linked source files.

# Responsibilities

- Accept user actions, coordinate authorization, and show results. Evidence: [README.md](../files/README.md.md).

# Public surface

- `create_app(config=None)` — observed in [equipment_reservation/web_access/web_interaction.py](../files/equipment_reservation/web_access/web_interaction.py.md).

# Internal structure

- [README.md](../files/README.md.md).
- [pyproject.toml](../files/pyproject.toml.md).
- [equipment_reservation/web_access/templates/index.html](../files/equipment_reservation/web_access/templates/index.html.md).
- [equipment_reservation/web_access/web_interaction.py](../files/equipment_reservation/web_access/web_interaction.py.md).
- [tests/test_application.py](../files/tests/test_application.py.md).
- [tests/test_browser.py](../files/tests/test_browser.py.md).

# Dependencies

- Uses [Equipment Use Management](equipment-use-management.md). Evidence: file-level import or call in L0.
- Uses [Scheduling Operations](scheduling-operations.md). Evidence: file-level import or call in L0.
- Uses [Actor Access](actor-access.md). Evidence: file-level import or call in L0.

# Files

- [.gitignore](../files/.gitignore.md).
- [README.md](../files/README.md.md).
- [pyproject.toml](../files/pyproject.toml.md).
- [equipment_reservation/web_access/templates/index.html](../files/equipment_reservation/web_access/templates/index.html.md).
- [equipment_reservation/web_access/web_interaction.py](../files/equipment_reservation/web_access/web_interaction.py.md).
- [tests/test_application.py](../files/tests/test_application.py.md).
- [tests/test_browser.py](../files/tests/test_browser.py.md).

# Related

- [Web Access](../components/web-access.md).

# Decomposition

- [.gitignore](../files/.gitignore.md).
- [README.md](../files/README.md.md).
- [pyproject.toml](../files/pyproject.toml.md).
- [equipment_reservation/web_access/templates/index.html](../files/equipment_reservation/web_access/templates/index.html.md).
- [equipment_reservation/web_access/web_interaction.py](../files/equipment_reservation/web_access/web_interaction.py.md).
- [tests/test_application.py](../files/tests/test_application.py.md).
- [tests/test_browser.py](../files/tests/test_browser.py.md).

# Evidence

- [.gitignore](../files/.gitignore.md).
- [README.md](../files/README.md.md).
- [pyproject.toml](../files/pyproject.toml.md).
- [equipment_reservation/web_access/templates/index.html](../files/equipment_reservation/web_access/templates/index.html.md).
- [equipment_reservation/web_access/web_interaction.py](../files/equipment_reservation/web_access/web_interaction.py.md).
- [tests/test_application.py](../files/tests/test_application.py.md).
- [tests/test_browser.py](../files/tests/test_browser.py.md).
