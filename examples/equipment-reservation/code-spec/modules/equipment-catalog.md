---
type: "Module"
title: "Equipment Catalog"
description: "Create and read equipment records."
spec_id: "MOD-equipment-catalog"
layer: "L1"
provenance: "observed"
generator: "agent"
---

# Purpose

[inferred] Create and read equipment records. This boundary groups the linked source files.

# Responsibilities

- Create and read equipment records. Evidence: [equipment_reservation/equipment_scheduling/equipment_catalog.py](../files/equipment_reservation/equipment_scheduling/equipment_catalog.py.md).

# Public surface

- `transaction(path)` — observed in [equipment_reservation/equipment_scheduling/equipment_catalog.py](../files/equipment_reservation/equipment_scheduling/equipment_catalog.py.md).
- `initialize(db)` — observed in [equipment_reservation/equipment_scheduling/equipment_catalog.py](../files/equipment_reservation/equipment_scheduling/equipment_catalog.py.md).
- `add(db, name, description)` — observed in [equipment_reservation/equipment_scheduling/equipment_catalog.py](../files/equipment_reservation/equipment_scheduling/equipment_catalog.py.md).
- `get(db, equipment_id)` — observed in [equipment_reservation/equipment_scheduling/equipment_catalog.py](../files/equipment_reservation/equipment_scheduling/equipment_catalog.py.md).
- `all_equipment(db)` — observed in [equipment_reservation/equipment_scheduling/equipment_catalog.py](../files/equipment_reservation/equipment_scheduling/equipment_catalog.py.md).

# Internal structure

- [equipment_reservation/equipment_scheduling/equipment_catalog.py](../files/equipment_reservation/equipment_scheduling/equipment_catalog.py.md).

# Dependencies

- Uses [Schedule Management](schedule-management.md). Evidence: file-level import or call in L0.
- Uses [Scheduling Operations](scheduling-operations.md). Evidence: file-level import or call in L0.

# Files

- [equipment_reservation/equipment_scheduling/equipment_catalog.py](../files/equipment_reservation/equipment_scheduling/equipment_catalog.py.md).

# Related

- [Equipment Scheduling](../components/equipment-scheduling.md).

# Decomposition

- [equipment_reservation/equipment_scheduling/equipment_catalog.py](../files/equipment_reservation/equipment_scheduling/equipment_catalog.py.md).

# Evidence

- [equipment_reservation/equipment_scheduling/equipment_catalog.py](../files/equipment_reservation/equipment_scheduling/equipment_catalog.py.md).
