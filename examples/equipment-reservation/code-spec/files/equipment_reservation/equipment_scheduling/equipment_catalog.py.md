---
type: "Source File"
title: "equipment_catalog.py"
description: "Python source file at equipment_reservation/equipment_scheduling/equipment_catalog.py."
spec_id: "FILE-equipment-reservation-equipment-scheduling-equipment-catalog-py"
layer: "L0"
provenance: "observed"
generator: "agent"
source_path: "equipment_reservation/equipment_scheduling/equipment_catalog.py"
language: "Python"
role: "source"
git_blob: "9b2a724d9811c673719a9c9c20fe58c603037c2e"
source_ref: "b49ac9d318000495dffc599116320a75fd08fd91"
git_commit: "b49ac9d318000495dffc599116320a75fd08fd91"
---

# Purpose

[inferred] equipment_catalog.py supports the Equipment Catalog responsibility. The source starts: `"""Own Equipment records; provide catalog operations on the caller's transaction."""`.

# Responsibilities

- Owns the declarations and behavior listed under Symbols. Evidence: `equipment_reservation/equipment_scheduling/equipment_catalog.py:1`.
- Its direct owning Module is [Equipment Catalog](../../../modules/equipment-catalog.md).

# Symbols

- `transaction(path)` — Yield an isolated SQLite write transaction; commit success or roll back failure. Evidence: `equipment_reservation/equipment_scheduling/equipment_catalog.py:8`.
- `initialize(db)` — Create the Equipment table if absent without changing existing records. Evidence: `equipment_reservation/equipment_scheduling/equipment_catalog.py:24`.
- `add(db, name, description)` — Create one distinct asset; reject blank names with ValueError. Evidence: `equipment_reservation/equipment_scheduling/equipment_catalog.py:29`.
- `get(db, equipment_id)` — Return one asset or raise ValueError for an unknown identity. Evidence: `equipment_reservation/equipment_scheduling/equipment_catalog.py:37`.
- `all_equipment(db)` — Return catalog records in stable identity order. Evidence: `equipment_reservation/equipment_scheduling/equipment_catalog.py:45`.

# Control flow

- `def transaction(path)` defines a contract or declaration. Entry: `equipment_reservation/equipment_scheduling/equipment_catalog.py:8`.
- `def initialize(db)` checks a condition. Entry: `equipment_reservation/equipment_scheduling/equipment_catalog.py:24`.
- `def add(db, name, description)` checks a condition, inserts a row, returns a result. Entry: `equipment_reservation/equipment_scheduling/equipment_catalog.py:29`.
- `def get(db, equipment_id)` checks a condition, iterates over records, reads rows, returns a result. Entry: `equipment_reservation/equipment_scheduling/equipment_catalog.py:37`.
- `def all_equipment(db)` iterates over records, reads rows, returns a result. Entry: `equipment_reservation/equipment_scheduling/equipment_catalog.py:45`.

# Data & side effects

- database read `contextlib` at `equipment_reservation/equipment_scheduling/equipment_catalog.py:4`.
- database write `IF` at `equipment_reservation/equipment_scheduling/equipment_catalog.py:26`.
- database write `equipment` at `equipment_reservation/equipment_scheduling/equipment_catalog.py:33`.
- database read `equipment` at `equipment_reservation/equipment_scheduling/equipment_catalog.py:39`.
- database read `equipment` at `equipment_reservation/equipment_scheduling/equipment_catalog.py:47`.

# Dependencies

- Used by [schedule_management.py](schedule_management.py.md).
- Used by [scheduling_operations.py](scheduling_operations.py.md).

# Errors

- `raise ValueError("Equipment name is required.")` at `equipment_reservation/equipment_scheduling/equipment_catalog.py:32`.
- `"""Return one asset or raise ValueError for an unknown identity."""` at `equipment_reservation/equipment_scheduling/equipment_catalog.py:38`.
- `raise ValueError("Equipment does not exist.")` at `equipment_reservation/equipment_scheduling/equipment_catalog.py:41`.

# Tests

- [test_application.py](../../tests/test_application.py.md) documents test source; test execution status is in the bundle record.
- [test_browser.py](../../tests/test_browser.py.md) documents test source; test execution status is in the bundle record.

# Related

- [Equipment Catalog](../../../modules/equipment-catalog.md).

# Evidence

- `equipment_reservation/equipment_scheduling/equipment_catalog.py:1` — file start.
- `git_blob: 9b2a724d9811c673719a9c9c20fe58c603037c2e` — source content hash.
