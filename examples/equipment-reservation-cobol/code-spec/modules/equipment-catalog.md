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

- Create and read equipment records. Evidence: [app/programs/EQCAT00.cbl](../files/app/programs/EQCAT00.cbl.md).

# Public surface

- `PROGRAM-ID. EQCAT00` — observed in [app/programs/EQCAT00.cbl](../files/app/programs/EQCAT00.cbl.md).
- `MAIN-PARA` — observed in [app/programs/EQCAT00.cbl](../files/app/programs/EQCAT00.cbl.md).
- `ADD-EQUIP` — observed in [app/programs/EQCAT00.cbl](../files/app/programs/EQCAT00.cbl.md).
- `ADD-DONE` — observed in [app/programs/EQCAT00.cbl](../files/app/programs/EQCAT00.cbl.md).
- `LIST-EQUIP` — observed in [app/programs/EQCAT00.cbl](../files/app/programs/EQCAT00.cbl.md).

# Internal structure

- [app/programs/EQCAT00.cbl](../files/app/programs/EQCAT00.cbl.md).
- [app/copybooks/EQSQLCA.cpy](../files/app/copybooks/EQSQLCA.cpy.md).
- [db/schema.sql](../files/db/schema.sql.md).
- [db/reset.sql](../files/db/reset.sql.md).

# Dependencies

- Uses [Scheduling Operations](scheduling-operations.md). Evidence: file-level import or call in L0.
- Uses [Web Interaction](web-interaction.md). Evidence: file-level import or call in L0.
- Uses [Actor Access](actor-access.md). Evidence: file-level import or call in L0.
- Uses [Schedule Management](schedule-management.md). Evidence: file-level import or call in L0.
- Uses [Equipment Use Management](equipment-use-management.md). Evidence: file-level import or call in L0.

# Files

- [app/programs/EQCAT00.cbl](../files/app/programs/EQCAT00.cbl.md).
- [app/copybooks/EQSQLCA.cpy](../files/app/copybooks/EQSQLCA.cpy.md).
- [db/schema.sql](../files/db/schema.sql.md).
- [db/reset.sql](../files/db/reset.sql.md).

# Related

- [Equipment Scheduling](../components/equipment-scheduling.md).

# Decomposition

- [app/programs/EQCAT00.cbl](../files/app/programs/EQCAT00.cbl.md).
- [app/copybooks/EQSQLCA.cpy](../files/app/copybooks/EQSQLCA.cpy.md).
- [db/schema.sql](../files/db/schema.sql.md).
- [db/reset.sql](../files/db/reset.sql.md).

# Evidence

- [app/programs/EQCAT00.cbl](../files/app/programs/EQCAT00.cbl.md).
- [app/copybooks/EQSQLCA.cpy](../files/app/copybooks/EQSQLCA.cpy.md).
- [db/schema.sql](../files/db/schema.sql.md).
- [db/reset.sql](../files/db/reset.sql.md).
