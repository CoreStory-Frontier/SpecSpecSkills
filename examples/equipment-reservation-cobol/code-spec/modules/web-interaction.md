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

- `PROGRAM-ID. EQWEB00` — observed in [app/programs/EQWEB00.cbl](../files/app/programs/EQWEB00.cbl.md).
- `MAIN-PARA` — observed in [app/programs/EQWEB00.cbl](../files/app/programs/EQWEB00.cbl.md).
- `PARSE-REQUEST` — observed in [app/programs/EQWEB00.cbl](../files/app/programs/EQWEB00.cbl.md).
- `PROCESS-LINE` — observed in [app/programs/EQWEB00.cbl](../files/app/programs/EQWEB00.cbl.md).
- `DONE` — observed in [app/programs/EQWEB00.cbl](../files/app/programs/EQWEB00.cbl.md).

# Internal structure

- [README.md](../files/README.md.md).
- [app/programs/EQWEB00.cbl](../files/app/programs/EQWEB00.cbl.md).
- [app/tests/EQTEST00.cbl](../files/app/tests/EQTEST00.cbl.md).
- [web/index.html](../files/web/index.html.md).
- [web/app.js](../files/web/app.js.md).
- [web/styles.css](../files/web/styles.css.md).
- [jcl/BUILD.jcl](../files/jcl/BUILD.jcl.md).
- [jcl/RUNTESTS.jcl](../files/jcl/RUNTESTS.jcl.md).
- [jcl/CICSRES.txt](../files/jcl/CICSRES.txt.md).

# Dependencies

- Uses [Scheduling Operations](scheduling-operations.md). Evidence: file-level import or call in L0.
- Uses [Equipment Catalog](equipment-catalog.md). Evidence: file-level import or call in L0.
- Uses [Actor Access](actor-access.md). Evidence: file-level import or call in L0.
- Uses [Equipment Use Management](equipment-use-management.md). Evidence: file-level import or call in L0.

# Files

- [README.md](../files/README.md.md).
- [app/programs/EQWEB00.cbl](../files/app/programs/EQWEB00.cbl.md).
- [app/tests/EQTEST00.cbl](../files/app/tests/EQTEST00.cbl.md).
- [web/index.html](../files/web/index.html.md).
- [web/app.js](../files/web/app.js.md).
- [web/styles.css](../files/web/styles.css.md).
- [jcl/BUILD.jcl](../files/jcl/BUILD.jcl.md).
- [jcl/RUNTESTS.jcl](../files/jcl/RUNTESTS.jcl.md).
- [jcl/CICSRES.txt](../files/jcl/CICSRES.txt.md).

# Related

- [Web Access](../components/web-access.md).

# Decomposition

- [README.md](../files/README.md.md).
- [app/programs/EQWEB00.cbl](../files/app/programs/EQWEB00.cbl.md).
- [app/tests/EQTEST00.cbl](../files/app/tests/EQTEST00.cbl.md).
- [web/index.html](../files/web/index.html.md).
- [web/app.js](../files/web/app.js.md).
- [web/styles.css](../files/web/styles.css.md).
- [jcl/BUILD.jcl](../files/jcl/BUILD.jcl.md).
- [jcl/RUNTESTS.jcl](../files/jcl/RUNTESTS.jcl.md).
- [jcl/CICSRES.txt](../files/jcl/CICSRES.txt.md).

# Evidence

- [README.md](../files/README.md.md).
- [app/programs/EQWEB00.cbl](../files/app/programs/EQWEB00.cbl.md).
- [app/tests/EQTEST00.cbl](../files/app/tests/EQTEST00.cbl.md).
- [web/index.html](../files/web/index.html.md).
- [web/app.js](../files/web/app.js.md).
- [web/styles.css](../files/web/styles.css.md).
- [jcl/BUILD.jcl](../files/jcl/BUILD.jcl.md).
- [jcl/RUNTESTS.jcl](../files/jcl/RUNTESTS.jcl.md).
- [jcl/CICSRES.txt](../files/jcl/CICSRES.txt.md).
