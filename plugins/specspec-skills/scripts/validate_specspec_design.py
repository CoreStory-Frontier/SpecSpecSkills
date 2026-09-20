#!/usr/bin/env python3
"""Validate a top-down SpecSpec design bundle containing layers L3 through L1.

This validator checks ontology structure only. It does not inspect source code,
Git history, content hashes, or line anchors.
"""

from __future__ import annotations

import argparse
import re
import sys
import textwrap
from collections import defaultdict
from dataclasses import dataclass
from pathlib import Path, PurePosixPath


RESERVED_FILES = {"index.md", "log.md"}
PROVENANCE_VALUES = {"observed", "inferred", "supplied"}

TYPE_LAYERS = {
    "Module": "L1",
    "Component": "L2",
    "Data Entity": "L3",
    "Interface": "L3",
    "Decision": "L3",
    "Workflow": "L3",
    "Authorization": "L3",
    "Deployment": "L3",
    "Observability": "L3",
    "Technical Overview": "L3",
}

LAYER_DIRECTORIES = {
    "L1": "modules",
    "L2": "components",
    "L3": "system",
}

ID_PATTERNS = {
    "Module": re.compile(r"MOD-[A-Za-z0-9][A-Za-z0-9-]*"),
    "Component": re.compile(r"CMP-[A-Za-z0-9][A-Za-z0-9-]*"),
    "Data Entity": re.compile(r"ENT-[A-Za-z0-9][A-Za-z0-9-]*"),
    "Interface": re.compile(r"IFC-[A-Za-z0-9][A-Za-z0-9-]*"),
    "Decision": re.compile(r"ADR-\d{4}"),
    "Workflow": re.compile(r"WF-[A-Za-z0-9][A-Za-z0-9-]*"),
    "Authorization": re.compile(r"AUTHZ-[A-Za-z0-9][A-Za-z0-9-]*"),
    "Deployment": re.compile(r"DEPLOY-[A-Za-z0-9][A-Za-z0-9-]*"),
    "Observability": re.compile(r"OBS-[A-Za-z0-9][A-Za-z0-9-]*"),
    "Technical Overview": re.compile(r"TECH-overview"),
}

LINK_RE = re.compile(r"\[[^\]]*\]\(([^)]+)\)")


@dataclass(frozen=True)
class Finding:
    rule: str
    location: str
    message: str

    def render(self) -> str:
        return f"ERROR [{self.rule}] {self.location}: {self.message}"


@dataclass(frozen=True)
class Concept:
    path: Path
    rel: str
    frontmatter: dict[str, str]
    body: str

    @property
    def type(self) -> str:
        return self.frontmatter.get("type", "")

    @property
    def layer(self) -> str:
        return self.frontmatter.get("layer", "")

    @property
    def spec_id(self) -> str:
        return self.frontmatter.get("spec_id", "")


def split_document(text: str) -> tuple[dict[str, str] | None, str]:
    """Parse the scalar top-level frontmatter used by design concepts."""
    lines = text.splitlines()
    if not lines or lines[0].strip() != "---":
        return None, text

    try:
        end = next(i for i in range(1, len(lines)) if lines[i].strip() == "---")
    except StopIteration:
        return None, text

    frontmatter: dict[str, str] = {}
    for line in lines[1:end]:
        if not line.strip() or line.lstrip().startswith("#"):
            continue
        if line.startswith((" ", "\t")) or ":" not in line:
            continue
        key, value = line.split(":", 1)
        value = value.strip()
        if len(value) >= 2 and value[0] == value[-1] and value[0] in {'"', "'"}:
            value = value[1:-1]
        frontmatter[key.strip()] = value
    return frontmatter, "\n".join(lines[end + 1 :])


def section(body: str, heading: str) -> str | None:
    match = re.search(
        rf"^(#{{1,6}})\s+{re.escape(heading)}\s*$", body, re.MULTILINE | re.IGNORECASE
    )
    if not match:
        return None
    level = len(match.group(1))
    start = match.end()
    following = re.search(rf"^#{{1,{level}}}\s", body[start:], re.MULTILINE)
    end = start + following.start() if following else len(body)
    return body[start:end].strip()


def markdown_links(text: str | None) -> list[str]:
    return LINK_RE.findall(text or "")


def load_concepts(root: Path) -> tuple[list[Concept], list[Finding]]:
    concepts: list[Concept] = []
    findings: list[Finding] = []
    for path in sorted(root.rglob("*.md")):
        if path.name in RESERVED_FILES:
            continue
        rel = path.relative_to(root).as_posix()
        if PurePosixPath(rel).parts[0] not in set(LAYER_DIRECTORIES.values()):
            continue
        frontmatter, body = split_document(path.read_text(encoding="utf-8"))
        if frontmatter is None:
            findings.append(Finding("frontmatter", rel, "concept file has no frontmatter"))
            continue
        concepts.append(Concept(path, rel, frontmatter, body))
    return concepts, findings


def resolve_concept_link(
    root: Path, concept: Concept, target: str, by_rel: dict[str, Concept]
) -> tuple[Concept | None, str | None]:
    raw = target.split("#", 1)[0].strip()
    if not raw or raw.startswith(("http://", "https://", "mailto:")):
        return None, None
    if raw.startswith("/"):
        resolved = root / raw.lstrip("/")
    else:
        resolved = root / (PurePosixPath(concept.rel).parent / raw).as_posix()
    try:
        rel = resolved.resolve().relative_to(root.resolve()).as_posix()
    except ValueError:
        return None, raw
    return by_rel.get(rel), rel


def validate_bundle(root: Path) -> list[Finding]:
    root = root.resolve()
    findings: list[Finding] = []

    concepts, load_findings = load_concepts(root)
    findings.extend(load_findings)
    if not concepts:
        findings.append(
            Finding("bundle", ".", "bundle contains no L1-L3 design concepts")
        )
    by_rel = {concept.rel: concept for concept in concepts}

    by_id: dict[str, list[Concept]] = defaultdict(list)
    for concept in concepts:
        location = concept.rel
        for field in ("type", "spec_id", "layer", "provenance"):
            if not concept.frontmatter.get(field):
                findings.append(
                    Finding("frontmatter", location, f"missing `{field}`")
                )

        expected_layer = TYPE_LAYERS.get(concept.type)
        if expected_layer is None:
            findings.append(
                Finding("type", location, f"unsupported design concept type `{concept.type}`")
            )
        elif concept.layer != expected_layer:
            findings.append(
                Finding(
                    "layer",
                    location,
                    f"type `{concept.type}` belongs to {expected_layer}, not {concept.layer or 'an empty layer'}",
                )
            )

        expected_directory = LAYER_DIRECTORIES.get(concept.layer)
        first_part = PurePosixPath(concept.rel).parts[0]
        if expected_directory and first_part != expected_directory:
            findings.append(
                Finding(
                    "location",
                    location,
                    f"{concept.layer} concepts must be under `{expected_directory}/`",
                )
            )

        provenance = concept.frontmatter.get("provenance")
        if provenance and provenance not in PROVENANCE_VALUES:
            findings.append(
                Finding("provenance", location, f"invalid provenance `{provenance}`")
            )

        if concept.spec_id:
            by_id[concept.spec_id].append(concept)
            pattern = ID_PATTERNS.get(concept.type)
            if pattern and not pattern.fullmatch(concept.spec_id):
                findings.append(
                    Finding(
                        "identifier",
                        location,
                        f"`{concept.spec_id}` is invalid for type `{concept.type}`",
                    )
                )

    for spec_id, matches in by_id.items():
        if len(matches) > 1:
            locations = ", ".join(concept.rel for concept in matches)
            findings.append(
                Finding("identifier", locations, f"duplicate spec_id `{spec_id}`")
            )

    edges: dict[str, set[str]] = defaultdict(set)
    parents: dict[str, set[str]] = defaultdict(set)

    for concept in concepts:
        decomposition = section(concept.body, "Decomposition")
        links = markdown_links(decomposition)

        if concept.layer in {"L2", "L3"} and not links:
            findings.append(
                Finding(
                    "decomposition",
                    concept.rel,
                    f"{concept.layer} concept has no links under `# Decomposition`",
                )
            )
            continue

        if concept.layer == "L1" and links:
            findings.append(
                Finding(
                    "decomposition",
                    concept.rel,
                    "L1 is terminal and must not decompose into another concept",
                )
            )

        expected_child_layer = {"L3": "L2", "L2": "L1"}.get(concept.layer)
        for target in links:
            child, resolved_rel = resolve_concept_link(root, concept, target, by_rel)
            if resolved_rel is None:
                continue
            if child is None:
                findings.append(
                    Finding(
                        "decomposition",
                        concept.rel,
                        f"decomposition link does not resolve to a concept: {target}",
                    )
                )
                continue
            if expected_child_layer is None or child.layer != expected_child_layer:
                findings.append(
                    Finding(
                        "decomposition",
                        concept.rel,
                        f"{concept.layer} must decompose directly to {expected_child_layer}; `{child.rel}` is {child.layer}",
                    )
                )
                continue
            edges[concept.rel].add(child.rel)
            parents[child.rel].add(concept.rel)

    for parent_rel, children in edges.items():
        parent = by_rel[parent_rel]
        for child_rel in children:
            child = by_rel[child_rel]
            related_targets: set[str] = set()
            for target in markdown_links(section(child.body, "Related")):
                related, resolved_rel = resolve_concept_link(root, child, target, by_rel)
                if related is not None and resolved_rel is not None:
                    related_targets.add(resolved_rel)
            if parent_rel not in related_targets:
                findings.append(
                    Finding(
                        "backlink",
                        child_rel,
                        f"missing `# Related` backlink to `{parent.rel}`",
                    )
                )

    for concept in concepts:
        if concept.layer == "L2" and not parents.get(concept.rel):
            findings.append(
                Finding("orphan", concept.rel, "L2 component is not used by any L3 concept")
            )
        if concept.layer == "L1" and not parents.get(concept.rel):
            findings.append(
                Finding("orphan", concept.rel, "L1 module is not used by any L2 component")
            )

    def reaches_l1(start: str) -> bool:
        pending = list(edges.get(start, ()))
        seen: set[str] = set()
        while pending:
            current = pending.pop()
            if current in seen:
                continue
            seen.add(current)
            target = by_rel.get(current)
            if target and target.layer == "L1":
                return True
            pending.extend(edges.get(current, ()))
        return False

    for concept in concepts:
        if concept.layer == "L3" and not reaches_l1(concept.rel):
            findings.append(
                Finding(
                    "reachability",
                    concept.rel,
                    "L3 concept has no complete decomposition path to L1",
                )
            )

    return findings


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(
        description="Validate ontology consistency in a top-down SpecSpec L3-L1 design bundle.",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog=textwrap.dedent(
            """
            Expected graph:
              system/*.md    (L3) # Decomposition -> components/*.md (L2)
              components/*.md (L2) # Decomposition -> modules/*.md (L1)
              each child           # Related       -> every direct parent

            This command checks ontology structure only. It does not inspect source
            code, Git revisions, hashes, or path:line anchors.
            """
        ),
    )
    parser.add_argument("bundle", type=Path, help="path to the design bundle")
    args = parser.parse_args(argv)

    if not args.bundle.is_dir():
        parser.error(f"bundle directory does not exist: {args.bundle}")

    findings = validate_bundle(args.bundle)
    if not findings:
        print("OK — L3-L1 ontology is consistent.")
        return 0

    for finding in sorted(findings, key=lambda item: (item.location, item.rule)):
        print(finding.render())
    print(f"\n{len(findings)} error(s).")
    return 1


if __name__ == "__main__":
    sys.exit(main())
