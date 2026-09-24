---
type: "Source File"
title: "test_browser.py"
description: "Python test file at tests/test_browser.py."
spec_id: "FILE-tests-test-browser-py"
layer: "L0"
provenance: "observed"
generator: "agent"
source_path: "tests/test_browser.py"
language: "Python"
role: "test"
git_blob: "f5f0d7feb368e0b82092a06441daa27afc0bb41a"
source_ref: "b49ac9d318000495dffc599116320a75fd08fd91"
git_commit: "b49ac9d318000495dffc599116320a75fd08fd91"
---

# Purpose

[inferred] test_browser.py supports the Web Interaction responsibility. The source starts: `"""Exercise the real HTML forms with Chromium against a localhost server."""`.

# Responsibilities

- Owns the declarations and behavior listed under Symbols. Evidence: `tests/test_browser.py:1`.
- Its direct owning Module is [Web Interaction](../../modules/web-interaction.md).

# Symbols

- `submit(page, identity, button)` — Select a demo actor, fill labelled form fields, submit, and read the visible result. Evidence: `tests/test_browser.py:12`.
- `test_browser_journey(tmp_path)` — P1: start the application and reserve persisted equipment through browser forms. Evidence: `tests/test_browser.py:23`.

# Control flow

- `def submit(page, identity, button, **values)` checks a condition, iterates over records, reads rows, returns a result. Entry: `tests/test_browser.py:12`.
- `def test_browser_journey(tmp_path)` defines a contract or declaration. Entry: `tests/test_browser.py:23`.

# Data & side effects

- database read `playwright` at `tests/test_browser.py:6`.
- database read `werkzeug` at `tests/test_browser.py:7`.
- database read `equipment_reservation` at `tests/test_browser.py:9`.

# Dependencies

No internal file dependency identified.

# Errors

- `assert results[0]['available'] is True` at `tests/test_browser.py:36`.
- `assert reservation['state'] == 'confirmed'` at `tests/test_browser.py:38`.
- `assert len(submit(page, 'alice', 'My reservations')) == 1` at `tests/test_browser.py:39`.
- `assert submit(page, 'bob', 'My reservations') == []` at `tests/test_browser.py:40`.
- `assert maintenance['invalid_reservations'] == [reservation['id']]` at `tests/test_browser.py:43`.
- `assert cancelled['state'] == 'cancelled'` at `tests/test_browser.py:45`.
- `assert returned['return_time'] is not None` at `tests/test_browser.py:47`.
- `assert history['reservations'][0]['state'] == 'cancelled'` at `tests/test_browser.py:49`.
- `assert len(history['uses']) == 1` at `tests/test_browser.py:50`.
- `assert 'error' in submit(page, 'alice', 'Equipment history', equipment_id=item['id'])` at `tests/test_browser.py:51`.

# Configuration

- Configuration or environment input is defined or read here. Evidence: `tests/test_browser.py:1`. Secret values are omitted.

# Related

- [Web Interaction](../../modules/web-interaction.md).

# Evidence

- `tests/test_browser.py:1` — file start.
- `git_blob: f5f0d7feb368e0b82092a06441daa27afc0bb41a` — source content hash.
