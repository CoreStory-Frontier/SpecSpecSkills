---
type: "Source File"
title: "index.html"
description: "HTML config file at equipment_reservation/web_access/templates/index.html."
spec_id: "FILE-equipment-reservation-web-access-templates-index-html"
layer: "L0"
provenance: "observed"
generator: "agent"
source_path: "equipment_reservation/web_access/templates/index.html"
language: "HTML"
role: "config"
git_blob: "8611c1b9327cbf15b0938b68c898b9842a7a3b0e"
source_ref: "b49ac9d318000495dffc599116320a75fd08fd91"
git_commit: "b49ac9d318000495dffc599116320a75fd08fd91"
---

# Purpose

[inferred] index.html supports the Web Interaction responsibility. The source starts: `<!doctype html>`.

# Responsibilities

- Owns the declarations and behavior listed under Symbols. Evidence: `equipment_reservation/web_access/templates/index.html:1`.
- Its direct owning Module is [Web Interaction](../../../../modules/web-interaction.md).

# Symbols

- `viewport` — <html lang="en"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width, initi Evidence: `equipment_reservation/web_access/templates/index.html:2`.
- `result` — {% if result is defined and result is not none %}<section aria-label="Result"><h2>Result</h2><pre id Evidence: `equipment_reservation/web_access/templates/index.html:14`.
- `workspace` — <form id="workspace" method="post" action="/action/search"> Evidence: `equipment_reservation/web_access/templates/index.html:16`.
- `csrf` — <input type="hidden" name="csrf" value="{{ csrf }}"> Evidence: `equipment_reservation/web_access/templates/index.html:17`.
- `identity` — <label>Demo identity <select name="identity"><option value="">No identity</option>{% for name,roles  Evidence: `equipment_reservation/web_access/templates/index.html:18`.
- `name` — <label>Equipment name <input name="name"></label><label>Description <input name="description"></labe Evidence: `equipment_reservation/web_access/templates/index.html:19`.
- `equipment_id` — <label>Equipment ID <input name="equipment_id" type="number" min="1"></label> Evidence: `equipment_reservation/web_access/templates/index.html:20`.
- `start` — <label>Start (UTC) <input name="start" type="datetime-local" step="1"></label> Evidence: `equipment_reservation/web_access/templates/index.html:21`.
- `end` — <label>End (UTC) <input name="end" type="datetime-local" step="1"></label> Evidence: `equipment_reservation/web_access/templates/index.html:22`.
- `reason` — <label>Maintenance reason <input name="reason"></label> Evidence: `equipment_reservation/web_access/templates/index.html:23`.
- `reservation_id` — <label>Reservation ID <input name="reservation_id" type="number" min="1"></label> Evidence: `equipment_reservation/web_access/templates/index.html:24`.
- `use_id` — <label>Equipment Use ID <input name="use_id" type="number" min="1"></label> Evidence: `equipment_reservation/web_access/templates/index.html:25`.
- `pickup_time` — <label>Pickup time (UTC) <input name="pickup_time" type="datetime-local" step="1"></label> Evidence: `equipment_reservation/web_access/templates/index.html:26`.
- `return_time` — <label>Return time (UTC) <input name="return_time" type="datetime-local" step="1"></label> Evidence: `equipment_reservation/web_access/templates/index.html:27`.

# Dependencies

No internal file dependency identified.

# Errors

- Error handling or error outputs occur in the source. Evidence: `equipment_reservation/web_access/templates/index.html:8`.

# Configuration

- Configuration or environment input is defined or read here. Evidence: `equipment_reservation/web_access/templates/index.html:1`. Secret values are omitted.

# Related

- [Web Interaction](../../../../modules/web-interaction.md).

# Evidence

- `equipment_reservation/web_access/templates/index.html:1` — file start.
- `git_blob: 8611c1b9327cbf15b0938b68c898b9842a7a3b0e` — source content hash.
