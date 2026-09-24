---
type: "Source File"
title: "CICSRES.txt"
description: "Text infra file at jcl/CICSRES.txt."
spec_id: "FILE-jcl-cicsres-txt"
layer: "L0"
provenance: "observed"
generator: "agent"
source_path: "jcl/CICSRES.txt"
language: "Text"
role: "infra"
git_blob: "9a25270319946d20757b3f38c063498607771d79"
source_ref: "b49ac9d318000495dffc599116320a75fd08fd91"
git_commit: "b49ac9d318000495dffc599116320a75fd08fd91"
---

# Purpose

[inferred] CICSRES.txt supports the Web Interaction responsibility. The source starts: `DEFINE PROGRAM(EQWEB00) GROUP(EQRS)`.

# Responsibilities

- Owns the declarations and behavior listed under Symbols. Evidence: `jcl/CICSRES.txt:1`.
- Its direct owning Module is [Web Interaction](../../modules/web-interaction.md).

# Symbols

No named declarations observed.

# Dependencies

No internal file dependency identified.

# Configuration

- Configuration or environment input is defined or read here. Evidence: `jcl/CICSRES.txt:1`. Secret values are omitted.

# Related

- [Web Interaction](../../modules/web-interaction.md).

# Evidence

- `jcl/CICSRES.txt:1` — file start.
- `git_blob: 9a25270319946d20757b3f38c063498607771d79` — source content hash.
