---
type: "Data Entity"
title: "Equipment"
description: "Equipment has an identity, name, and description."
spec_id: "ENT-equipment"
layer: "L3"
provenance: "observed"
generator: "agent"
---

# Purpose

Equipment has an identity, name, and description.

# Schema

| Field | Observed shape |
|---|---|
| `id` | INTEGER PRIMARY KEY |
| `name` | TEXT NOT NULL |
| `description` | TEXT NOT NULL |

Source: `equipment_reservation/equipment_scheduling/equipment_catalog.py:1`.

# Relationships

Equipment is referenced by reservation, maintenance, and use records; use records refer to reservations.

# Lifecycle

- A custodian adds equipment. Catalog and search operations read it. Evidence: `equipment_reservation/equipment_scheduling/equipment_catalog.py:29`.

# Invariants

- A named equipment record has a stable ID. A missing equipment ID is rejected by catalog or schedule operations. Evidence: `equipment_reservation/equipment_scheduling/equipment_catalog.py:29`.

# Related

- [Find equipment](../../product/capabilities/find-equipment.md).
- [Manage equipment availability](../../product/capabilities/manage-equipment-availability.md).

# Decomposition

- [Equipment Scheduling](../../components/equipment-scheduling.md).

# Evidence

- [Equipment Scheduling](../../components/equipment-scheduling.md).
- [equipment_reservation/equipment_scheduling/equipment_catalog.py](../../files/equipment_reservation/equipment_scheduling/equipment_catalog.py.md); source `equipment_reservation/equipment_scheduling/equipment_catalog.py:1`.
