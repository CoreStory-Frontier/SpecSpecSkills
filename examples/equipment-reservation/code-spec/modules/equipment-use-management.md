---
type: "Module"
title: "Equipment Use Management"
description: "Record pickup, return, and equipment-use history."
spec_id: "MOD-equipment-use-management"
layer: "L1"
provenance: "observed"
generator: "agent"
---

# Purpose

[inferred] Record pickup, return, and equipment-use history. This boundary groups the linked source files.

# Responsibilities

- Record pickup, return, and equipment-use history. Evidence: [equipment_reservation/equipment_handoff/equipment_use_management.py](../files/equipment_reservation/equipment_handoff/equipment_use_management.py.md).

# Public surface

- `initialize(db)` — observed in [equipment_reservation/equipment_handoff/equipment_use_management.py](../files/equipment_reservation/equipment_handoff/equipment_use_management.py.md).
- `pickup(db, reservation_id, pickup_time)` — observed in [equipment_reservation/equipment_handoff/equipment_use_management.py](../files/equipment_reservation/equipment_handoff/equipment_use_management.py.md).
- `record_return(db, use_id, return_time)` — observed in [equipment_reservation/equipment_handoff/equipment_use_management.py](../files/equipment_reservation/equipment_handoff/equipment_use_management.py.md).
- `history(db, equipment_id)` — observed in [equipment_reservation/equipment_handoff/equipment_use_management.py](../files/equipment_reservation/equipment_handoff/equipment_use_management.py.md).
- `execute(db, operation, values)` — observed in [equipment_reservation/equipment_handoff/equipment_use_management.py](../files/equipment_reservation/equipment_handoff/equipment_use_management.py.md).

# Internal structure

- [equipment_reservation/equipment_handoff/equipment_use_management.py](../files/equipment_reservation/equipment_handoff/equipment_use_management.py.md).

# Dependencies

- Uses [Scheduling Operations](scheduling-operations.md). Evidence: file-level import or call in L0.
- Uses [Web Interaction](web-interaction.md). Evidence: file-level import or call in L0.

# Files

- [equipment_reservation/equipment_handoff/equipment_use_management.py](../files/equipment_reservation/equipment_handoff/equipment_use_management.py.md).

# Related

- [Equipment Handoff](../components/equipment-handoff.md).

# Decomposition

- [equipment_reservation/equipment_handoff/equipment_use_management.py](../files/equipment_reservation/equipment_handoff/equipment_use_management.py.md).

# Evidence

- [equipment_reservation/equipment_handoff/equipment_use_management.py](../files/equipment_reservation/equipment_handoff/equipment_use_management.py.md).
