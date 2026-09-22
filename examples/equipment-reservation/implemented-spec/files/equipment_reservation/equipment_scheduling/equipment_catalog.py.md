---
type: "Source File"
title: "equipment_reservation/equipment_scheduling/equipment_catalog.py"
description: "Own Equipment records; provide catalog operations on the caller's transaction."
spec_id: "FILE-equipment-reservation-equipment-scheduling-equipment-catalog-py"
layer: "L0"
provenance: "observed"
generator: "agent"
source_path: "equipment_reservation/equipment_scheduling/equipment_catalog.py"
git_blob: "9b2a724d9811c673719a9c9c20fe58c603037c2e"
language: "python"
role: "source"
revision_status: "uncommitted"
---

# Purpose

Own Equipment records; provide catalog operations on the caller's transaction.

# Responsibilities

- Yield an isolated SQLite write transaction; commit success or roll back failure.
- Create the Equipment table if absent without changing existing records.
- Create one distinct asset; reject blank names with ValueError.
- Return one asset or raise ValueError for an unknown identity.
- Return catalog records in stable identity order.

# Symbols

## `transaction(path)`

Yield an isolated SQLite write transaction; commit success or roll back failure.

Calls: `db.close`, `db.commit`, `db.execute`, `db.rollback`, `sqlite3.connect`.

Evidence: `equipment_reservation/equipment_scheduling/equipment_catalog.py:8-21`.

## `initialize(db)`

Create the Equipment table if absent without changing existing records.

Calls: `db.execute`.

Evidence: `equipment_reservation/equipment_scheduling/equipment_catalog.py:24-26`.

## `add(db, name, description)`

Create one distinct asset; reject blank names with ValueError.

Calls: `ValueError`, `db.execute`, `description.strip`, `get`, `name.strip`.

Branch conditions: `not name.strip()`.

Evidence: `equipment_reservation/equipment_scheduling/equipment_catalog.py:29-34`.

## `get(db, equipment_id)`

Return one asset or raise ValueError for an unknown identity.

Calls: `ValueError`, `db.execute`, `db.execute('SELECT * FROM equipment WHERE id = ?', (equipment_id,)).fetchone`, `dict`.

Branch conditions: `row is None`.

Evidence: `equipment_reservation/equipment_scheduling/equipment_catalog.py:37-42`.

## `all_equipment(db)`

Return catalog records in stable identity order.

Calls: `db.execute`, `dict`.

Evidence: `equipment_reservation/equipment_scheduling/equipment_catalog.py:45-47`.


# Control flow

transaction opens a SQLite connection, enables foreign keys, and starts BEGIN IMMEDIATE. It yields to the caller, commits on success, rolls back on any exception, and always closes. add checks the name before insert. get rejects a missing row. all_equipment orders rows by identity.

# Data & side effects

Owns the SQLite connection lifecycle and equipment table. Creates the schema, inserts equipment, and reads records. No event logging occurs in this file.

# Dependencies

- External/standard-library imports: contextlib, sqlite3.
- Used by [equipment_reservation/equipment_scheduling/schedule_management.py](schedule_management.py.md).
- Used by [equipment_reservation/equipment_scheduling/scheduling_operations.py](scheduling_operations.py.md).

# Errors

Validation raises ValueError as described by each operation. SQLite and other unexpected failures propagate; transaction owners roll back.

# Configuration

See the named declarations or artifact units above. No secret configuration values are recorded.

# Tests

- [test_application.py](../../tests/test_application.py.md) — application integration and browser coverage.
- [test_browser.py](../../tests/test_browser.py.md) — application integration and browser coverage.

# Related

- [equipment-catalog](../../../modules/equipment-catalog.md)

# Evidence

- `equipment_reservation/equipment_scheduling/equipment_catalog.py:8-21`
- `equipment_reservation/equipment_scheduling/equipment_catalog.py:24-26`
- `equipment_reservation/equipment_scheduling/equipment_catalog.py:29-34`
- `equipment_reservation/equipment_scheduling/equipment_catalog.py:37-42`
- `equipment_reservation/equipment_scheduling/equipment_catalog.py:45-47`

# Notes

Working-tree snapshot. Git revision pinning is pending; this is not a fully conformant upstream code-spec.
