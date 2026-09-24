---
type: "Component"
title: "Equipment Handoff"
description: "Equipment Handoff subsystem of the equipment reservation application."
spec_id: "CMP-equipment-handoff"
layer: "L2"
provenance: "observed"
generator: "agent"
---

# Purpose

[inferred] The source groups Equipment Use Management into the Equipment Handoff subsystem.

# Responsibilities

- Record pickup, return, and equipment-use history. Evidence: [Equipment Use Management](../modules/equipment-use-management.md).

# Interfaces

- Uses or exposes [Custodian Equipment](../system/interfaces/custodian-equipment.md).

# Dependencies

- Uses [Equipment Scheduling](equipment-scheduling.md) through the linked Module calls.
- Uses [Web Access](web-access.md) through the linked Module calls.

# Modules

- [Equipment Use Management](../modules/equipment-use-management.md).

# Runtime notes

- Enterprise COBOL, CICS, and DB2 for z/OS. Evidence: [app/programs/EQWEB00.cbl](../files/app/programs/EQWEB00.cbl.md).

# Related

- [Technical Overview](../system/technical-overview.md).
- [Equipment Use](../system/data/equipment-use.md).
- [Custodian Equipment](../system/interfaces/custodian-equipment.md).
- [Record Equipment Pickup](../system/workflows/record-equipment-pickup.md).
- [Record Equipment Return](../system/workflows/record-equipment-return.md).
- [Application Runtime](../system/deployment/application-runtime.md).

# Decomposition

- [Equipment Use Management](../modules/equipment-use-management.md).

# Evidence

- [Equipment Use Management](../modules/equipment-use-management.md).
