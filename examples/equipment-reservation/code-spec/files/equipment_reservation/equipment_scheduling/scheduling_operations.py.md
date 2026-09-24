---
type: "Source File"
title: "scheduling_operations.py"
description: "Python source file at equipment_reservation/equipment_scheduling/scheduling_operations.py."
spec_id: "FILE-equipment-reservation-equipment-scheduling-scheduling-operations-py"
layer: "L0"
provenance: "observed"
generator: "agent"
source_path: "equipment_reservation/equipment_scheduling/scheduling_operations.py"
language: "Python"
role: "source"
git_blob: "2b5a780f736fe45fc37957095cd350579f450cc1"
source_ref: "b49ac9d318000495dffc599116320a75fd08fd91"
git_commit: "b49ac9d318000495dffc599116320a75fd08fd91"
---

# Purpose

[inferred] scheduling_operations.py supports the Scheduling Operations responsibility. The source starts: `"""Expose protocol-neutral scheduling contracts and the shared transaction boundary."""`.

# Responsibilities

- Owns the declarations and behavior listed under Symbols. Evidence: `equipment_reservation/equipment_scheduling/scheduling_operations.py:1`.
- Its direct owning Module is [Scheduling Operations](../../../modules/scheduling-operations.md).

# Symbols

- `transaction(path)` — Provide the application transaction without exposing storage through HTTP contracts. Evidence: `equipment_reservation/equipment_scheduling/scheduling_operations.py:7`.
- `initialize(db)` — Initialize catalog and schedule storage in dependency order. Evidence: `equipment_reservation/equipment_scheduling/scheduling_operations.py:12`.
- `execute(db, operation, actor, values)` — Dispatch an authorized scheduling operation; propagate validation errors. Evidence: `equipment_reservation/equipment_scheduling/scheduling_operations.py:18`.
- `handoff_context(db, reservation_id)` — Supply reservation and asset context owned by Scheduling for handoff checks. Evidence: `equipment_reservation/equipment_scheduling/scheduling_operations.py:39`.
- `complete_return(db, reservation_id)` — Ask Schedule Management to complete a still-confirmed reservation after return. Evidence: `equipment_reservation/equipment_scheduling/scheduling_operations.py:45`.
- `history_context(db, equipment_id)` — Supply asset identity and all reservation states for use-history composition. Evidence: `equipment_reservation/equipment_scheduling/scheduling_operations.py:50`.
- `timestamp(value)` — Expose the scheduling UTC time shape to handoff consumers. Evidence: `equipment_reservation/equipment_scheduling/scheduling_operations.py:55`.

# Control flow

- `def transaction(path)` returns a result. Entry: `equipment_reservation/equipment_scheduling/scheduling_operations.py:7`.
- `def initialize(db)` defines a contract or declaration. Entry: `equipment_reservation/equipment_scheduling/scheduling_operations.py:12`.
- `def execute(db, operation, actor, values)` checks a condition, returns a result. Entry: `equipment_reservation/equipment_scheduling/scheduling_operations.py:18`.
- `def handoff_context(db, reservation_id)` iterates over records, returns a result. Entry: `equipment_reservation/equipment_scheduling/scheduling_operations.py:39`.
- `def complete_return(db, reservation_id)` returns a result. Entry: `equipment_reservation/equipment_scheduling/scheduling_operations.py:45`.
- `def history_context(db, equipment_id)` iterates over records, returns a result. Entry: `equipment_reservation/equipment_scheduling/scheduling_operations.py:50`.
- `def timestamp(value)` returns a result. Entry: `equipment_reservation/equipment_scheduling/scheduling_operations.py:55`.

# Dependencies

- Uses [equipment_catalog.py](equipment_catalog.py.md).
- Uses [schedule_management.py](schedule_management.py.md).
- Used by [web_interaction.py](../web_access/web_interaction.py.md).
- Used by [equipment_use_management.py](../equipment_handoff/equipment_use_management.py.md).
- Used by [test_application.py](../../tests/test_application.py.md).

# Errors

- `raise ValueError("Unknown scheduling operation.")` at `equipment_reservation/equipment_scheduling/scheduling_operations.py:36`.

# Tests

- [test_application.py](../../tests/test_application.py.md) documents test source; test execution status is in the bundle record.
- [test_browser.py](../../tests/test_browser.py.md) documents test source; test execution status is in the bundle record.

# Related

- [Scheduling Operations](../../../modules/scheduling-operations.md).

# Evidence

- `equipment_reservation/equipment_scheduling/scheduling_operations.py:1` — file start.
- `git_blob: 2b5a780f736fe45fc37957095cd350579f450cc1` — source content hash.
