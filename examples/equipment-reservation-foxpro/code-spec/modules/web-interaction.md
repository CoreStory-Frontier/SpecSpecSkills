---
type: "Module"
title: "Web Interaction"
description: "Accept user actions, coordinate authorization, and show results."
spec_id: "MOD-web-interaction"
layer: "L1"
provenance: "observed"
generator: "agent"
---

# Purpose

[inferred] Accept user actions, coordinate authorization, and show results. This boundary groups the linked source files.

# Responsibilities

- Accept user actions, coordinate authorization, and show results. Evidence: [README.md](../files/README.md.md).

# Public surface

- `FUNCTION ExecuteHandoff` — observed in [app/programs/EQWEB.PRG](../files/app/programs/EQWEB.PRG.md).
- `FUNCTION GetParam` — observed in [app/programs/EQWEB.PRG](../files/app/programs/EQWEB.PRG.md).
- `FUNCTION URLDecode` — observed in [app/programs/EQWEB.PRG](../files/app/programs/EQWEB.PRG.md).
- `FUNCTION HtmlResult` — observed in [app/programs/EQWEB.PRG](../files/app/programs/EQWEB.PRG.md).

# Internal structure

- [README.md](../files/README.md.md).
- [app/programs/EQWEB.PRG](../files/app/programs/EQWEB.PRG.md).
- [app/tests/EQTEST.PRG](../files/app/tests/EQTEST.PRG.md).
- [web/index.html](../files/web/index.html.md).
- [web/styles.css](../files/web/styles.css.md).
- [build/EQBUILD.PRG](../files/build/EQBUILD.PRG.md).

# Dependencies

- Uses [Actor Access](actor-access.md). Evidence: file-level import or call in L0.
- Uses [Equipment Catalog](equipment-catalog.md). Evidence: file-level import or call in L0.
- Uses [Scheduling Operations](scheduling-operations.md). Evidence: file-level import or call in L0.
- Uses [Equipment Use Management](equipment-use-management.md). Evidence: file-level import or call in L0.
- Uses [Schedule Management](schedule-management.md). Evidence: file-level import or call in L0.

# Files

- [README.md](../files/README.md.md).
- [app/programs/EQWEB.PRG](../files/app/programs/EQWEB.PRG.md).
- [app/tests/EQTEST.PRG](../files/app/tests/EQTEST.PRG.md).
- [web/index.html](../files/web/index.html.md).
- [web/styles.css](../files/web/styles.css.md).
- [build/EQBUILD.PRG](../files/build/EQBUILD.PRG.md).

# Related

- [Web Access](../components/web-access.md).

# Decomposition

- [README.md](../files/README.md.md).
- [app/programs/EQWEB.PRG](../files/app/programs/EQWEB.PRG.md).
- [app/tests/EQTEST.PRG](../files/app/tests/EQTEST.PRG.md).
- [web/index.html](../files/web/index.html.md).
- [web/styles.css](../files/web/styles.css.md).
- [build/EQBUILD.PRG](../files/build/EQBUILD.PRG.md).

# Evidence

- [README.md](../files/README.md.md).
- [app/programs/EQWEB.PRG](../files/app/programs/EQWEB.PRG.md).
- [app/tests/EQTEST.PRG](../files/app/tests/EQTEST.PRG.md).
- [web/index.html](../files/web/index.html.md).
- [web/styles.css](../files/web/styles.css.md).
- [build/EQBUILD.PRG](../files/build/EQBUILD.PRG.md).
