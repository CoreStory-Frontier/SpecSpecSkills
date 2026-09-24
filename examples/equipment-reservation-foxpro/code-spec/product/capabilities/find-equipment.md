---
type: "Capability"
title: "Find equipment"
description: "An employee sees equipment availability for a requested period."
spec_id: "CAP-find-equipment"
layer: "L4"
provenance: "inferred"
generator: "agent"
---

# Purpose

[inferred] An employee seeks equipment availability. The scheduling function computes item-level values, but the browser message shows only an item count.

# Behavior

- `SearchEquipment` adds an `available` value to each item. Source: `app/programs/EQOPS.PRG:4`.
- `HandleAction` passes the result to `HtmlResult`, which displays success and item count without item fields. Source: `app/programs/EQWEB.PRG:67` and `app/programs/EQWEB.PRG:119`.

# Acceptance

- Given a search returns items, when the browser formats the result, then it shows status and item count only. Source: `app/programs/EQWEB.PRG:119`. The item-level availability outcome is recorded as a gap.

# Realized by

- [Employee Equipment](../../system/interfaces/employee-equipment.md).
- [Equipment](../../system/data/equipment.md).

# Related

- [Product Overview](../overview.md).

# Evidence

- [Employee Equipment](../../system/interfaces/employee-equipment.md).
- [Equipment](../../system/data/equipment.md).
- Source: [app/programs/EQSHED.PRG](../../files/app/programs/EQSHED.PRG.md) at `app/programs/EQSHED.PRG:1`.
