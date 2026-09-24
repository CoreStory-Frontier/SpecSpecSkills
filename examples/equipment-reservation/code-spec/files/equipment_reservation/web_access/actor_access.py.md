---
type: "Source File"
title: "actor_access.py"
description: "Python source file at equipment_reservation/web_access/actor_access.py."
spec_id: "FILE-equipment-reservation-web-access-actor-access-py"
layer: "L0"
provenance: "observed"
generator: "agent"
source_path: "equipment_reservation/web_access/actor_access.py"
language: "Python"
role: "source"
git_blob: "3b677ffcc1ad582eeed825b20f03525a186a7ea1"
source_ref: "b49ac9d318000495dffc599116320a75fd08fd91"
git_commit: "b49ac9d318000495dffc599116320a75fd08fd91"
---

# Purpose

[inferred] actor_access.py supports the Actor Access responsibility. The source starts: `"""Local demo identity adapter and server-side employee/custodian policy."""`.

# Responsibilities

- Owns the declarations and behavior listed under Symbols. Evidence: `equipment_reservation/web_access/actor_access.py:1`.
- Its direct owning Module is [Actor Access](../../../modules/actor-access.md).

# Symbols

- `authorize(identity, operation)` — Return an allowed fixed identity or raise PermissionError; never trust supplied roles. Evidence: `equipment_reservation/web_access/actor_access.py:17`.

# Control flow

- `def authorize(identity, operation)` checks a condition, iterates over records, returns a result. Entry: `equipment_reservation/web_access/actor_access.py:17`.

# Dependencies

- Used by [web_interaction.py](web_interaction.py.md).

# Errors

- `"""Return an allowed fixed identity or raise PermissionError; never trust supplied roles."""` at `equipment_reservation/web_access/actor_access.py:18`.
- `raise PermissionError("This action is unavailable for the current identity.")` at `equipment_reservation/web_access/actor_access.py:21`.

# Tests

- [test_application.py](../../tests/test_application.py.md) documents test source; test execution status is in the bundle record.
- [test_browser.py](../../tests/test_browser.py.md) documents test source; test execution status is in the bundle record.

# Related

- [Actor Access](../../../modules/actor-access.md).

# Evidence

- `equipment_reservation/web_access/actor_access.py:1` — file start.
- `git_blob: 3b677ffcc1ad582eeed825b20f03525a186a7ea1` — source content hash.
