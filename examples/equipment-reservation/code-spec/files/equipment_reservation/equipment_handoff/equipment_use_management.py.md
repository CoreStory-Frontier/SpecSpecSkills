---
type: "Source File"
title: "equipment_use_management.py"
description: "Python source file at equipment_reservation/equipment_handoff/equipment_use_management.py."
spec_id: "FILE-equipment-reservation-equipment-handoff-equipment-use-management-py"
layer: "L0"
provenance: "observed"
generator: "agent"
source_path: "equipment_reservation/equipment_handoff/equipment_use_management.py"
language: "Python"
role: "source"
git_blob: "c38529ffa437931729604debee56165b4d31d398"
source_ref: "b49ac9d318000495dffc599116320a75fd08fd91"
git_commit: "b49ac9d318000495dffc599116320a75fd08fd91"
---

# Purpose

[inferred] equipment_use_management.py supports the Equipment Use Management responsibility. The source starts: `"""Own Equipment Use records, eligibility checks, handoff events, and composed history."""`.

# Responsibilities

- Owns the declarations and behavior listed under Symbols. Evidence: `equipment_reservation/equipment_handoff/equipment_use_management.py:1`.
- Its direct owning Module is [Equipment Use Management](../../../modules/equipment-use-management.md).

# Symbols

- `initialize(db)` — Create Equipment Use storage with one-use-per-reservation and asset references. Evidence: `equipment_reservation/equipment_handoff/equipment_use_management.py:10`.
- `pickup(db, reservation_id, pickup_time)` — Record one pickup for a confirmed reservation or reject ineligible/duplicate requests. Evidence: `equipment_reservation/equipment_handoff/equipment_use_management.py:15`.
- `record_return(db, use_id, return_time)` — Record an ordered, unique return and update scheduling in the same transaction. Evidence: `equipment_reservation/equipment_handoff/equipment_use_management.py:28`.
- `history(db, equipment_id)` — Compose all reservation and use records for exactly one known Equipment item. Evidence: `equipment_reservation/equipment_handoff/equipment_use_management.py:42`.
- `execute(db, operation, values)` — Dispatch a previously authorized handoff request, rejecting unknown operations. Evidence: `equipment_reservation/equipment_handoff/equipment_use_management.py:49`.

# Control flow

- `def initialize(db)` checks a condition. Entry: `equipment_reservation/equipment_handoff/equipment_use_management.py:10`.
- `def pickup(db, reservation_id, pickup_time)` checks a condition, iterates over records, inserts a row, reads rows. Entry: `equipment_reservation/equipment_handoff/equipment_use_management.py:15`.
- `def record_return(db, use_id, return_time)` checks a condition, updates rows, reads rows, returns a result. Entry: `equipment_reservation/equipment_handoff/equipment_use_management.py:28`.
- `def history(db, equipment_id)` iterates over records, reads rows, returns a result. Entry: `equipment_reservation/equipment_handoff/equipment_use_management.py:42`.
- `def execute(db, operation, values)` checks a condition, returns a result. Entry: `equipment_reservation/equipment_handoff/equipment_use_management.py:49`.

# Data & side effects

- database write `IF` at `equipment_reservation/equipment_handoff/equipment_use_management.py:12`.
- database read `equipment_use` at `equipment_reservation/equipment_handoff/equipment_use_management.py:21`.
- database write `equipment_use` at `equipment_reservation/equipment_handoff/equipment_use_management.py:23`.
- log event at `equipment_reservation/equipment_handoff/equipment_use_management.py:24`.
- database read `equipment_use` at `equipment_reservation/equipment_handoff/equipment_use_management.py:25`.
- database write `scheduling` at `equipment_reservation/equipment_handoff/equipment_use_management.py:29`.
- database read `equipment_use` at `equipment_reservation/equipment_handoff/equipment_use_management.py:30`.
- database write `equipment_use` at `equipment_reservation/equipment_handoff/equipment_use_management.py:36`.
- log event at `equipment_reservation/equipment_handoff/equipment_use_management.py:38`.
- database read `equipment_use` at `equipment_reservation/equipment_handoff/equipment_use_management.py:39`.
- database read `equipment_use` at `equipment_reservation/equipment_handoff/equipment_use_management.py:45`.

# Dependencies

- Uses [scheduling_operations.py](../equipment_scheduling/scheduling_operations.py.md).
- Used by [web_interaction.py](../web_access/web_interaction.py.md).

# Errors

- `raise ValueError("Pickup requires a confirmed reservation.")` at `equipment_reservation/equipment_handoff/equipment_use_management.py:20`.
- `raise ValueError("Pickup is already recorded.")` at `equipment_reservation/equipment_handoff/equipment_use_management.py:22`.
- `raise ValueError("Return requires one pickup and no previous return.")` at `equipment_reservation/equipment_handoff/equipment_use_management.py:33`.
- `raise ValueError("Return time cannot precede pickup.")` at `equipment_reservation/equipment_handoff/equipment_use_management.py:35`.
- `raise ValueError("Unknown handoff operation.")` at `equipment_reservation/equipment_handoff/equipment_use_management.py:57`.

# Tests

- [test_application.py](../../tests/test_application.py.md) documents test source; test execution status is in the bundle record.
- [test_browser.py](../../tests/test_browser.py.md) documents test source; test execution status is in the bundle record.

# Related

- [Equipment Use Management](../../../modules/equipment-use-management.md).

# Evidence

- `equipment_reservation/equipment_handoff/equipment_use_management.py:1` — file start.
- `git_blob: c38529ffa437931729604debee56165b4d31d398` — source content hash.
