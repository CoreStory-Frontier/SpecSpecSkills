---
type: Module
title: Equipment Catalog
description: Equipment records and catalog behavior.
spec_id: MOD-equipment-catalog
layer: L1
provenance: supplied
generator: agent
---

# Purpose

Equipment Catalog is the Equipment data owner in Equipment Scheduling. `[inferred]` It provides
equipment identity and catalog behavior to the other scheduling Modules.

# Responsibilities

- `[inferred]` Own Equipment records and their stable identities.
- `[inferred]` Add an Equipment item for a custodian action.
- `[inferred]` Supply Equipment details for search, reservation, maintenance, and handoff context.
- `[inferred]` Keep each physical item as a distinct Equipment item.
- `[inferred]` It does not own Reservations, Maintenance Periods, or Equipment Use records.

# Public surface

| Planned contract | Owner | Consumer | Purpose |
|---|---|---|---|
| `[inferred]` Equipment catalog contract | Equipment Catalog | Scheduling Operations | Add and read Equipment information. |
| `[inferred]` Equipment identity contract | Equipment Catalog | Schedule Management | Validate the Equipment item for schedule changes. |

# Internal structure

- `[inferred]` Equipment record behavior owns identity and descriptive information.
- `[inferred]` Catalog query behavior supplies Equipment information to scheduling behavior.

# Dependencies

- Module dependencies: None.
- `[inferred]` [Schedule Management](schedule-management.md) uses Equipment Catalog.
- `[inferred]` [Scheduling Operations](scheduling-operations.md) uses Equipment Catalog.

# Files

- [equipment_reservation/equipment_scheduling/equipment_catalog.py](../files/equipment_reservation/equipment_scheduling/equipment_catalog.py.md)

# Related

- [Equipment Scheduling](../components/equipment-scheduling.md)

# Decomposition

- [equipment_reservation/equipment_scheduling/equipment_catalog.py](../files/equipment_reservation/equipment_scheduling/equipment_catalog.py.md)

# Evidence

- [equipment_reservation/equipment_scheduling/equipment_catalog.py](../files/equipment_reservation/equipment_scheduling/equipment_catalog.py.md)
