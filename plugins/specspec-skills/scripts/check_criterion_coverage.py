#!/usr/bin/env python3
"""Check that every L4 Behavior bullet and Acceptance criterion has a test.

This tool reads a SpecSpec bundle and one or more test roots. It derives one
stable criterion ID per bullet in each Capability's Behavior and Acceptance
sections, then looks for that ID in a test marker:

    Criterion: CE-A1

A marker may list several IDs, separated by commas. A test file may hold several
markers. The tool does not run the tests. It reports coverage and exits non-zero
while any criterion has no marker.

ID derivation
-------------
Default: <CAPABILITY>-B<n> for the nth Behavior bullet and <CAPABILITY>-A<n> for
the nth Acceptance criterion. <CAPABILITY> is the file stem in capitals, so
find-equipment.md gives FIND-EQUIPMENT-A1.

An optional alias file shortens the capability prefix:

    FE = FIND-EQUIPMENT

A test marker may use the short form (FE-A1) or the full form
(FIND-EQUIPMENT-A1). Both name the same criterion.

Exit codes: 0 when every criterion is covered, 1 when a criterion has no test,
2 on a usage error.
"""

import argparse
import re
import sys
from pathlib import Path

SKIP_DIRS = {".git", ".venv", "__pycache__", ".pytest_cache", "node_modules",
             "target", "build", "dist", "test-results"}
MARKER = re.compile(r"Criterion:[ \t]*([^.\n]+)")
TOKEN = re.compile(r"[A-Za-z][A-Za-z0-9]*(?:-[A-Za-z0-9]+)*")
HEADING = re.compile(r"^#\s+(\S.*)$")
BULLET = re.compile(r"^-[ \t]+(\S.*)$")
ALIAS = re.compile(r"^\s*([A-Za-z][A-Za-z0-9]*)\s*=\s*([A-Za-z][A-Za-z0-9-]*)\s*$")
CRITERION = re.compile(r"^(?P<prefix>.+)-(?P<letter>[AB])(?P<number>\d+)$")


def capability_files(bundle):
    """Return the capability documents in a bundle, in a stable order."""
    root = Path(bundle) / "product" / "capabilities"
    if not root.is_dir():
        sys.exit(f"error: no capability directory at {root}")
    files = sorted(path for path in root.glob("*.md") if path.name != "index.md")
    if not files:
        sys.exit(f"error: no capability documents in {root}")
    return files


def sections(text):
    """Split a document into heading name and body lines."""
    found = {}
    name, body = None, []
    for line in text.splitlines():
        match = HEADING.match(line)
        if match:
            if name is not None:
                found.setdefault(name.lower(), body)
            name, body = match.group(1), []
        elif name is not None:
            body.append(line)
    if name is not None:
        found.setdefault(name.lower(), body)
    return found


def criteria(bundle):
    """Derive one record per Behavior bullet and Acceptance criterion."""
    records = []
    for path in capability_files(bundle):
        parts = sections(path.read_text(encoding="utf-8"))
        stem = re.sub(r"[^A-Za-z0-9]+", "-", path.stem).strip("-").upper()
        for section, letter in (("behavior", "B"), ("acceptance", "A")):
            body = parts.get(section)
            if body is None:
                sys.exit(f"error: {path} has no '{section.title()}' section")
            number = 0
            for line in body:
                bullet = BULLET.match(line)
                if not bullet:
                    continue
                number += 1
                records.append({
                    "id": f"{stem}-{letter}{number}",
                    "kind": section,
                    "prefix": stem,
                    "source": path.name,
                    "section": f"# {section.title()}",
                    "text": re.sub(r"\s+", " ", bullet.group(1)).strip(),
                })
    return records


def aliases(path):
    """Read short-prefix mappings, ordered longest short key first. Optional."""
    if path is None:
        return []
    table = []
    for number, line in enumerate(Path(path).read_text(encoding="utf-8").splitlines(), 1):
        if not line.strip() or line.lstrip().startswith("#"):
            continue
        match = ALIAS.match(line)
        if not match:
            sys.exit(f"error: {path}:{number}: expected 'SHORT = CAPABILITY'")
        table.append((match.group(1).upper(), match.group(2).upper()))
    table.sort(key=lambda item: -len(item[0]))
    return table


def canonical(token, table):
    """Return the full criterion ID for a marker token."""
    upper = token.upper()
    for short, prefix in table:
        if upper == short or upper.startswith(short + "-"):
            return prefix + upper[len(short):]
    return upper


def short_label(identifier, table):
    """Return the shortest spelling of a criterion ID."""
    for short, prefix in table:
        if identifier == prefix or identifier.startswith(prefix + "-"):
            return short + identifier[len(prefix):]
    return identifier


def test_files(roots):
    """Return the test files under every supplied root."""
    found = []
    for root in roots:
        path = Path(root)
        if path.is_file():
            found.append(path)
            continue
        if not path.is_dir():
            sys.exit(f"error: no such test path: {path}")
        for candidate in sorted(path.rglob("*")):
            if candidate.is_file() and not SKIP_DIRS.intersection(candidate.parts):
                found.append(candidate)
    return found


def markers(files, table):
    """Return covered IDs, an example location per ID, and malformed tokens."""
    covered, where, malformed = {}, {}, set()
    for path in files:
        lines = path.read_text(encoding="utf-8", errors="replace").splitlines()
        for number, line in enumerate(lines, 1):
            match = MARKER.search(line)
            if not match:
                continue
            for token in TOKEN.findall(match.group(1)):
                identifier = canonical(token, table)
                if not CRITERION.match(identifier):
                    malformed.add(token)
                    continue
                covered[identifier] = covered.get(identifier, 0) + 1
                where.setdefault(identifier, f"{path}:{number}")
    return covered, where, malformed


def main(argv=None):
    parser = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    parser.add_argument("--bundle", required=True, help="bundle with product/capabilities/")
    parser.add_argument("--tests", required=True, action="append", help="test root; repeatable")
    parser.add_argument("--aliases", help="optional 'SHORT = CAPABILITY' file")
    parser.add_argument("--list", action="store_true", help="print every criterion and its state")
    args = parser.parse_args(argv)

    table = aliases(args.aliases)
    records = criteria(args.bundle)
    files = test_files(args.tests)
    covered, where, malformed = markers(files, table)

    known = {record["id"] for record in records}
    missing = [record for record in records if record["id"] not in covered]
    unknown = sorted(set(malformed) | {identifier for identifier in covered if identifier not in known})

    if args.list:
        for record in records:
            state = "covered" if record["id"] in covered else "MISSING"
            label = short_label(record["id"], table)
            print(f"{state:8} {label:12} {record['source']} {record['section']} {record['text'][:70]}")
        print()

    behaviour = sum(1 for record in records if record["kind"] == "behavior")
    print(f"Bundle: {args.bundle}")
    print(f"Tests scanned: {len(files)} files")
    print(f"Criteria: {len(records)} ({behaviour} behavior, {len(records) - behaviour} acceptance)")
    print(f"Markers: {sum(covered.values())}")
    print(f"Covered: {len(records) - len(missing)}/{len(records)}")
    if unknown:
        print("Unknown markers: " + ", ".join(sorted(unknown)))
    if missing:
        print("Missing:")
        for record in missing:
            label = short_label(record["id"], table)
            print(f"  MISSING  {label:12} {record['source']} {record['section']} {record['text'][:70]}")
        print("FAIL: a criterion has no test marker.")
        return 1
    print("PASS: every Behavior bullet and Acceptance criterion has a test marker.")
    return 0


if __name__ == "__main__":
    sys.exit(main())
