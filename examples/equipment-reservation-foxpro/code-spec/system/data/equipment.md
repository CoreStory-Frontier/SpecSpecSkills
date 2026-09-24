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
| `equip_id` | I |
| `equip_name` | C(40) |
| `equip_desc` | C(120) |

Source: `app/setup.prg:1`.

# Relationships

Equipment is referenced by reservation, maintenance, and use records; use records refer to reservations.

# Lifecycle

- A custodian adds equipment. Catalog and search operations read it. Evidence: `app/programs/EQCAT.PRG:4`.

# Invariants

- A named equipment record has a stable ID. A missing equipment ID is rejected by catalog or schedule operations. Evidence: `app/programs/EQCAT.PRG:4`.

# Related

- [Find equipment](../../product/capabilities/find-equipment.md).
- [Manage equipment availability](../../product/capabilities/manage-equipment-availability.md).

# Decomposition

- [Equipment Scheduling](../../components/equipment-scheduling.md).

# Evidence

- [Equipment Scheduling](../../components/equipment-scheduling.md).
- [app/programs/EQCAT.PRG](../../files/app/programs/EQCAT.PRG.md); source `app/programs/EQCAT.PRG:1`.
