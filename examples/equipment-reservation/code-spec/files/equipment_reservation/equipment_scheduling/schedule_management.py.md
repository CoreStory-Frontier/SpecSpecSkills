---
type: "Source File"
title: "schedule_management.py"
description: "Python source file at equipment_reservation/equipment_scheduling/schedule_management.py."
spec_id: "FILE-equipment-reservation-equipment-scheduling-schedule-management-py"
layer: "L0"
provenance: "observed"
generator: "agent"
source_path: "equipment_reservation/equipment_scheduling/schedule_management.py"
language: "Python"
role: "source"
git_blob: "f3de4211155e07aa39b0076d27a425808b7b1480"
source_ref: "b49ac9d318000495dffc599116320a75fd08fd91"
git_commit: "b49ac9d318000495dffc599116320a75fd08fd91"
---

# Purpose

[inferred] schedule_management.py supports the Schedule Management responsibility. The source starts: `"""Own schedule records, UTC periods, conflict rules, and schedule outcome signals."""`.

# Responsibilities

- Owns the declarations and behavior listed under Symbols. Evidence: `equipment_reservation/equipment_scheduling/schedule_management.py:1`.
- Its direct owning Module is [Schedule Management](../../../modules/schedule-management.md).

# Symbols

- `initialize(db)` — Create reservation and maintenance tables; foreign keys protect asset references. Evidence: `equipment_reservation/equipment_scheduling/schedule_management.py:11`.
- `instant(value)` — Normalize an ISO timestamp to UTC; naive form inputs explicitly mean UTC. Evidence: `equipment_reservation/equipment_scheduling/schedule_management.py:17`.
- `period(start, end)` — Return normalized half-open bounds, rejecting non-positive durations. Evidence: `equipment_reservation/equipment_scheduling/schedule_management.py:28`.
- `unavailable_reason(db, equipment_id, start, end)` — Report maintenance or confirmed-reservation overlap; adjacent bounds are free. Evidence: `equipment_reservation/equipment_scheduling/schedule_management.py:36`.
- `availability(db, start, end)` — Return each asset with availability and emit the decision context. Evidence: `equipment_reservation/equipment_scheduling/schedule_management.py:45`.
- `reservation(db, reservation_id)` — Return the authoritative reservation context or reject an unknown identity. Evidence: `equipment_reservation/equipment_scheduling/schedule_management.py:57`.
- `reserve(db, equipment_id, employee, start, end)` — Confirm one conflict-free request within the caller's serialized transaction. Evidence: `equipment_reservation/equipment_scheduling/schedule_management.py:65`.
- `reservations(db, employee, equipment_id)` — Read reservations with optional owner and asset filters; retain all states. Evidence: `equipment_reservation/equipment_scheduling/schedule_management.py:78`.
- `maintenance(db, equipment_id, start, end, reason)` — Block a period and atomically invalidate only overlapping confirmed reservations. Evidence: `equipment_reservation/equipment_scheduling/schedule_management.py:83`.
- `cancel(db, reservation_id)` — Cancel only an invalid reservation with overlapping maintenance; otherwise reject. Evidence: `equipment_reservation/equipment_scheduling/schedule_management.py:95`.
- `complete_return(db, reservation_id)` — Complete a confirmed reservation; preserve invalid and cancelled historical states. Evidence: `equipment_reservation/equipment_scheduling/schedule_management.py:105`.

# Control flow

- `def initialize(db)` checks a condition. Entry: `equipment_reservation/equipment_scheduling/schedule_management.py:11`.
- `def instant(value)` checks a condition, returns a result. Entry: `equipment_reservation/equipment_scheduling/schedule_management.py:17`.
- `def period(start, end)` checks a condition, returns a result. Entry: `equipment_reservation/equipment_scheduling/schedule_management.py:28`.
- `def unavailable_reason(db, equipment_id, start, end)` checks a condition, reads rows, returns a result. Entry: `equipment_reservation/equipment_scheduling/schedule_management.py:36`.
- `def availability(db, start, end)` iterates over records, returns a result. Entry: `equipment_reservation/equipment_scheduling/schedule_management.py:45`.
- `def reservation(db, reservation_id)` checks a condition, reads rows, returns a result. Entry: `equipment_reservation/equipment_scheduling/schedule_management.py:57`.
- `def reserve(db, equipment_id, employee, start, end)` checks a condition, iterates over records, inserts a row, returns a result. Entry: `equipment_reservation/equipment_scheduling/schedule_management.py:65`.
- `def reservations(db, employee=None, equipment_id=None)` iterates over records, reads rows, returns a result. Entry: `equipment_reservation/equipment_scheduling/schedule_management.py:78`.
- `def maintenance(db, equipment_id, start, end, reason)` iterates over records, inserts a row, updates rows, reads rows. Entry: `equipment_reservation/equipment_scheduling/schedule_management.py:83`.
- `def cancel(db, reservation_id)` checks a condition, updates rows, reads rows, returns a result. Entry: `equipment_reservation/equipment_scheduling/schedule_management.py:95`.
- `def complete_return(db, reservation_id)` updates rows, returns a result. Entry: `equipment_reservation/equipment_scheduling/schedule_management.py:105`.

# Data & side effects

- database read `datetime` at `equipment_reservation/equipment_scheduling/schedule_management.py:4`.
- database write `IF` at `equipment_reservation/equipment_scheduling/schedule_management.py:13`.
- database write `IF` at `equipment_reservation/equipment_scheduling/schedule_management.py:14`.
- database read `None` at `equipment_reservation/equipment_scheduling/schedule_management.py:25`.
- database read `maintenance` at `equipment_reservation/equipment_scheduling/schedule_management.py:38`.
- database read `reservations` at `equipment_reservation/equipment_scheduling/schedule_management.py:40`.
- log event at `equipment_reservation/equipment_scheduling/schedule_management.py:52`.
- database read `reservations` at `equipment_reservation/equipment_scheduling/schedule_management.py:59`.
- log event at `equipment_reservation/equipment_scheduling/schedule_management.py:71`.
- database write `reservations` at `equipment_reservation/equipment_scheduling/schedule_management.py:73`.
- log event at `equipment_reservation/equipment_scheduling/schedule_management.py:74`.
- database read `reservations` at `equipment_reservation/equipment_scheduling/schedule_management.py:80`.
- database write `maintenance` at `equipment_reservation/equipment_scheduling/schedule_management.py:87`.
- database read `reservations` at `equipment_reservation/equipment_scheduling/schedule_management.py:88`.
- database write `reservations` at `equipment_reservation/equipment_scheduling/schedule_management.py:89`.
- log event at `equipment_reservation/equipment_scheduling/schedule_management.py:91`.
- database read `maintenance` at `equipment_reservation/equipment_scheduling/schedule_management.py:98`.
- database write `reservations` at `equipment_reservation/equipment_scheduling/schedule_management.py:101`.
- database write `reservations` at `equipment_reservation/equipment_scheduling/schedule_management.py:108`.

# Dependencies

- Uses [equipment_catalog.py](equipment_catalog.py.md).
- Used by [scheduling_operations.py](scheduling_operations.py.md).

# Errors

- `raise ValueError("Use a valid date and time.") from None` at `equipment_reservation/equipment_scheduling/schedule_management.py:25`.
- `raise ValueError("End time must be after start time.")` at `equipment_reservation/equipment_scheduling/schedule_management.py:32`.
- `raise ValueError("Reservation does not exist.")` at `equipment_reservation/equipment_scheduling/schedule_management.py:61`.
- `raise ValueError("Equipment is unavailable for that period.")` at `equipment_reservation/equipment_scheduling/schedule_management.py:72`.
- `raise ValueError("Only a reservation invalidated by maintenance can be cancelled.")` at `equipment_reservation/equipment_scheduling/schedule_management.py:100`.

# Tests

- [test_application.py](../../tests/test_application.py.md) documents test source; test execution status is in the bundle record.
- [test_browser.py](../../tests/test_browser.py.md) documents test source; test execution status is in the bundle record.

# Related

- [Schedule Management](../../../modules/schedule-management.md).

# Evidence

- `equipment_reservation/equipment_scheduling/schedule_management.py:1` — file start.
- `git_blob: f3de4211155e07aa39b0076d27a425808b7b1480` — source content hash.
