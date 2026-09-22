---
type: "Source File"
title: "equipment_reservation/web_access/actor_access.py"
description: "Local demo identity adapter and server-side employee/custodian policy."
spec_id: "FILE-equipment-reservation-web-access-actor-access-py"
layer: "L0"
provenance: "observed"
generator: "agent"
source_path: "equipment_reservation/web_access/actor_access.py"
git_blob: "3b677ffcc1ad582eeed825b20f03525a186a7ea1"
language: "python"
role: "source"
revision_status: "uncommitted"
---

# Purpose

Local demo identity adapter and server-side employee/custodian policy.

# Responsibilities

- Return an allowed fixed identity or raise PermissionError; never trust supplied roles.

# Symbols

## File binding

`IDENTITIES = {'alice': ('employee',), 'bob': ('employee',), 'casey': ('custodian',), 'drew': ('employee', 'custodian')}`

Evidence: `equipment_reservation/web_access/actor_access.py:3-8`.

## File binding

`PERMISSIONS = {'search': 'employee', 'reserve': 'employee', 'mine': 'employee', 'add': 'custodian', 'catalog': 'custodian', 'reservations': 'custodian', 'maintenance': 'custodian', 'cancel': 'custodian', 'pickup': 'custodian', 'return': 'custodian', 'history': 'custodian'}`

Evidence: `equipment_reservation/web_access/actor_access.py:9-14`.

## `authorize(identity, operation)`

Return an allowed fixed identity or raise PermissionError; never trust supplied roles.

Calls: `PERMISSIONS.get`, `PermissionError`.

Branch conditions: `identity not in IDENTITIES or role not in IDENTITIES[identity]`.

Evidence: `equipment_reservation/web_access/actor_access.py:17-22`.


# Control flow

authorize resolves the selected demo identity to its fixed role set, looks up the operation permission, and rejects missing identities, unknown operations, or insufficient roles. It returns the authorized identity. Web Interaction passes this identity to scheduling; mine uses it as the owner filter and reserve uses it as the reservation employee. Client-supplied owner fields cannot change that scope.

# Data & side effects

No direct persistent writes. Policy data and presentation/configuration support the owning Module.

# Dependencies

- Used by [equipment_reservation/web_access/web_interaction.py](web_interaction.py.md).

# Errors

PermissionError denies missing or unauthorized identities.

# Configuration

See the named declarations or artifact units above. No secret configuration values are recorded.

# Tests

- [test_application.py](../../tests/test_application.py.md) — application integration and browser coverage.
- [test_browser.py](../../tests/test_browser.py.md) — application integration and browser coverage.

# Related

- [actor-access](../../../modules/actor-access.md)

# Evidence

- `equipment_reservation/web_access/actor_access.py:3-8`
- `equipment_reservation/web_access/actor_access.py:9-14`
- `equipment_reservation/web_access/actor_access.py:17-22`

# Notes

Working-tree snapshot. Git revision pinning is pending; this is not a fully conformant upstream code-spec.
