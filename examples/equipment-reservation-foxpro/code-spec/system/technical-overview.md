---
type: "Technical Overview"
title: "Technical Overview"
description: "The application combines browser access, scheduling, and handoff records."
spec_id: "TECH-overview"
layer: "L3"
provenance: "inferred"
generator: "agent"
---

# Summary

[inferred] The application combines browser access, scheduling, and handoff records.

# Context

- Visual FoxPro 9 with DBF tables and an embedded browser. Source: `app/programs/EQWEB.PRG:1`.

# Components

- [Web Access](../components/web-access.md).
- [Equipment Scheduling](../components/equipment-scheduling.md).
- [Equipment Handoff](../components/equipment-handoff.md).

# Data

- [equipment](data/equipment.md).
- [reservation](data/reservation.md).
- [maintenance period](data/maintenance-period.md).
- [equipment use](data/equipment-use.md).

# Interfaces

- [employee equipment](interfaces/employee-equipment.md).
- [custodian equipment](interfaces/custodian-equipment.md).

# Workflows

- [reserve equipment](workflows/reserve-equipment.md).
- [manage maintenance](workflows/manage-maintenance.md).
- [record equipment pickup](workflows/record-equipment-pickup.md).
- [record equipment return](workflows/record-equipment-return.md).
- [Cancel invalid reservation](workflows/cancel-invalid-reservation.md).

# Cross-cutting concerns

- [Equipment access](authorization/equipment-access.md) limits operations.
- Runtime: [Application runtime](deployment/application-runtime.md).

# Key decisions

No source-backed decision rationale was found. The code shows an implementation choice, not why it was made.

# Related

- [Product Overview](../product/overview.md).

# Decomposition

- [Web Access](../components/web-access.md).
- [Equipment Scheduling](../components/equipment-scheduling.md).
- [Equipment Handoff](../components/equipment-handoff.md).

# Evidence

- [Web Access](../components/web-access.md).
- [Equipment Scheduling](../components/equipment-scheduling.md).
- [Equipment Handoff](../components/equipment-handoff.md).
- [app/programs/EQWEB.PRG](../files/app/programs/EQWEB.PRG.md); source `app/programs/EQWEB.PRG:1`.
