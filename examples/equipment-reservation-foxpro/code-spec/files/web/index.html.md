---
type: "Source File"
title: "index.html"
description: "HTML config file at web/index.html."
spec_id: "FILE-web-index-html"
layer: "L0"
provenance: "observed"
generator: "agent"
source_path: "web/index.html"
language: "HTML"
role: "config"
git_blob: "8d18b548230e49c89772c6f20dd2ec06e1033e97"
source_ref: "b49ac9d318000495dffc599116320a75fd08fd91"
git_commit: "b49ac9d318000495dffc599116320a75fd08fd91"
---

# Purpose

[inferred] index.html supports the Web Interaction responsibility. The source starts: `<!doctype html>`.

# Responsibilities

- Owns the declarations and behavior listed under Symbols. Evidence: `web/index.html:1`.
- Its direct owning Module is [Web Interaction](../../modules/web-interaction.md).

# Symbols

- `actor` — <select name="actor"> Evidence: `web/index.html:14`.
- `action` — <select name="action"> Evidence: `web/index.html:22`.
- `equip_id` — <label>Equipment ID <input name="equip_id" value="1"></label> Evidence: `web/index.html:34`.
- `rsv_id` — <label>Reservation ID <input name="rsv_id" value="1"></label> Evidence: `web/index.html:35`.
- `use_id` — <label>Use ID <input name="use_id" value="1"></label> Evidence: `web/index.html:36`.
- `start` — <label>Start <input name="start" value="2030-01-01 10:00:00"></label> Evidence: `web/index.html:37`.
- `end` — <label>End <input name="end" value="2030-01-01 11:00:00"></label> Evidence: `web/index.html:38`.
- `name` — <label>Name <input name="name" value="Camera"></label> Evidence: `web/index.html:39`.
- `description` — <label>Description <input name="description" value="Shared kit"></label> Evidence: `web/index.html:40`.
- `reason` — <label>Reason <input name="reason" value="Service"></label> Evidence: `web/index.html:41`.
- `result` — <pre id="result">No request sent.</pre> Evidence: `web/index.html:44`.

# Dependencies

- Uses [styles.css](styles.css.md).

# Configuration

- Configuration or environment input is defined or read here. Evidence: `web/index.html:1`. Secret values are omitted.

# Related

- [Web Interaction](../../modules/web-interaction.md).

# Evidence

- `web/index.html:1` — file start.
- `git_blob: 8d18b548230e49c89772c6f20dd2ec06e1033e97` — source content hash.
