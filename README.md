# SpecSpec Skills Marketplace

This repository provides agent skills for creating a top-down
[SpecSpec](https://github.com/corestory-frontier/specspec) software design. The workflow starts
with product intent at L4. It decomposes the design through the system, component, and module
layers. The design workflow stops at L1. The separate `implement-spec` skill builds a new
reference application, writes one test for every Capability Behavior bullet and Acceptance
criterion, then derives L0 evidence from tested code.

The skills use the portable `SKILL.md` format. The marketplace supports Codex, Claude Code, and
GitHub Copilot CLI.

## Quick start

Install the `specspec-skills` plugin with one of the supported hosts. Then ask the host to run the
master skill.

```text
Use create-specspec to design a small expense approval application.
Employees submit expenses. Managers approve or reject them.
Write the specification to spec/.
```

The skill asks product questions before it writes files. It asks technical questions later, when
the higher layers provide enough context. It does not ask all questions at the start.

## Install the plugin

### Codex

```shell
codex plugin marketplace add CoreStory-Frontier/SpecSpecSkills
codex plugin add specspec-skills@specspec-skills
```

### Claude Code

Run these commands inside Claude Code:

```text
/plugin marketplace add CoreStory-Frontier/SpecSpecSkills
/plugin install specspec-skills@specspec-skills
```

### GitHub Copilot CLI

```shell
copilot plugin marketplace add CoreStory-Frontier/SpecSpecSkills
copilot plugin install specspec-skills@specspec-skills
```

GitHub Copilot CLI supports Agent Plugins 1.0 and also recognizes marketplaces in
`.claude-plugin/marketplace.json`. See the
[Copilot CLI plugin reference](https://docs.github.com/en/copilot/reference/copilot-cli-reference/cli-plugin-reference).

### Install from a local checkout

Clone this repository. Then install the plugin directory directly:

```shell
git clone https://github.com/CoreStory-Frontier/SpecSpecSkills.git
cd SpecSpecSkills
```

Add the checkout as a local marketplace. Then install the plugin:

```shell
codex plugin marketplace add .
codex plugin add specspec-skills@specspec-skills

copilot plugin marketplace add .
copilot plugin install specspec-skills@specspec-skills
```

For Claude Code, run these commands inside Claude Code. Replace the example path with the checkout
path:

```text
/plugin marketplace add /absolute/path/to/AgentSkills
/plugin install specspec-skills@specspec-skills
```

## Design flow

The complete workflow uses this sequence:

```text
Application description
        │
        ▼
L4 Product intent and capabilities
        │
        ▼
L3 System behavior and architecture
        │
        ▼
L2 Component boundaries and ownership
        │
        ▼
L1 Module boundaries and public surfaces
        │
        ▼
Architecture review and correction
```

Each layer uses the approved layer above it. Layer skills run in sequence, not in parallel.

The design workflow does not generate L0 documents. Use `implement-spec` after the design is
approved to build the application and generate L0 from its tested source files and code symbols.

## Layers

| Layer | Purpose | Main documents |
|---|---|---|
| L4 | Define the product boundary and user outcomes. | Product Overview and Capabilities |
| L3 | Define system behavior and architectural views. | Technical Overview, Data Entities, Interfaces, Workflows, Authorization, Decisions, Deployment, and Observability |
| L2 | Define cohesive subsystems and ownership. | Components |
| L1 | Define package or directory responsibilities. | Modules |

The skills create only the L3 document types that the application needs. For example, they do not
create a Deployment document when the input has no deployment requirement.

See [SpecSpec layers and file anatomy](docs/specspec-layers.md) for a diagram of all five layers,
their concept types, and each concept's document sections.

## Included skills

| Skill | Use it when | Input | Result |
|---|---|---|---|
| `create-specspec` | You want the full design from a short description. | Application description | Complete L4-L1 bundle, review, and correction loop |
| `create-specspec-l4` | You need product intent and capability files. | Application description and user answers | Product Overview and Capabilities |
| `create-specspec-l3` | Approved L4 documents already exist. | Complete L4 set | System design and reciprocal L4 links |
| `create-specspec-l2` | Approved L3 documents already exist. | Complete L3 set | Components and reciprocal L3 links |
| `create-specspec-l1` | Approved L2 documents already exist. | Complete L2 set and linked L3 context | Modules and reciprocal L2 links |
| `review-specspec-design` | You need an architecture review without edits. | L4-L1 bundle and, when available, the original input | Numbered findings with severity and correction criteria |
| `correct-specspec-design` | A reviewer report contains valid findings. | Bundle and reviewer report | Corrected documents and a repeated review |
| `implement-spec` | You want a new reference application from an approved design. | L4-L1 bundle and stack approval | Runnable code, one marked test per Behavior and Acceptance criterion, L0 evidence, and independent L0-L4 review |

You can start with a layer-specific skill when the required higher layer already exists. Do not
use a lower-layer skill when its input layer is incomplete.

## Example prompts

Create the complete design:

```text
Use create-specspec for a shared equipment reservation application.
Employees reserve equipment. Custodians manage availability and maintenance periods.
Write the result to spec/.
```

Continue an existing design:

```text
Use create-specspec-l2 to decompose the approved L3 documents in spec/.
```

Review without changing files:

```text
Use review-specspec-design to review spec/.
Use the original application brief in docs/product-brief.md as the source packet.
Do not correct the files.
```

Correct a review:

```text
Use correct-specspec-design to resolve the findings in review.md against spec/.
Ask me before you change supplied product intent or a major architecture choice.
```

## Generated bundle

### Design bundle

A complete bundle has this general structure:

```text
spec/
├── product/
│   ├── index.md
│   ├── overview.md
│   └── capabilities/
│       └── <capability>.md
├── system/
│   ├── index.md
│   ├── technical-overview.md
│   ├── data/
│   ├── interfaces/
│   ├── workflows/
│   ├── authorization/
│   ├── decisions/
│   ├── deployment/
│   └── observability/
├── components/
│   ├── index.md
│   └── <component>.md
└── modules/
    ├── index.md
    └── <module>.md
```

The `system/` directory contains only the concept directories used by the design.

### Implement a design

```text
Use implement-spec with examples/equipment-reservation/spec/.
Build a new reference application in equipment-reservation-app/.
Propose the stack for my approval before coding.
```

The skill builds a small runnable user journey first. It writes one marked test for every
Capability Behavior bullet and Acceptance criterion, then continues until all criteria pass.
The test markers and `implementation-record.md` form the traceability record. It pauses for specification gaps or conflicts. Local dependencies are permitted;
commits, pushes, and deployment need separate authorization.

After tests pass, the skill checks criterion coverage, copies the design to a separate
implementation bundle, adds `files/` for L0, and links Modules to observed source evidence. An independent agent reviews the code and
the complete L0-L4 bundle. The input design remains available for design-only tools.

New or modified files without a matching Git revision use explicitly uncommitted L0 evidence.
The skill reports pending Git pinning and does not claim full upstream code-spec conformance.
An unavailable independent reviewer or required test blocks completion.

## Examples

The repository contains three reference implementations of the same approved design:

- `examples/equipment-reservation/` — Python, Flask, and SQLite. The full 90-test suite passes,
  the code-derived L0 bundle is present, and the independent L0-L4 review passed.
- `examples/equipment-reservation-cobol/` — IBM Enterprise COBOL, CICS, and DB2 for z/OS.
  The COBOL source, schema, browser shell, JCL, and 50 marked criterion tests are present.
  The workstation has no mainframe runtime, so execution and L0 derivation are blocked.
- `examples/equipment-reservation-foxpro/` — Microsoft Visual FoxPro 9 and DBF tables.
  The VFP source, data setup, browser shell, and 50 marked criterion tests are present.
  The workstation has no VFP9 runtime, so execution and L0 derivation are blocked.

Both examples use the same six Capabilities, three Components, and six Modules.

## Questions and assumptions

Each layer creation skill asks only questions that can change that layer. The skill waits for the
answers before it writes documents.

If the user tells the skill to continue without an answer, the skill records important uncertain
choices as `[NEEDS CONFIRMATION]`. It does not silently convert an assumption into a supplied
fact.

The skills use these provenance rules:

- Supplied facts have no inline marker.
- Model-added design content uses `[inferred]`.
- Uncertain or high-impact assumptions use `[NEEDS CONFIRMATION]`.
- Design documents do not use `provenance: observed`.

The agent can use general software knowledge to find missing questions and possible boundaries.
It cannot treat that knowledge as evidence about the application.

## Review and correction

Each layer creation skill requests an independent review before it completes. The layer review
checks structure, meaning, traceability, provenance, and writing clarity.

The complete workflow also runs `review-specspec-design` after L1. This review operates as a
software architect. It checks the complete path from each Capability to its Modules. It also
checks the reverse path from each Module to product intent.

The reviewer does not edit files. It returns stable finding IDs, severity, evidence, impact, and
correction criteria.

The correcter handles findings in three ways:

- It fixes unambiguous structural defects directly.
- It uses the owning layer skill for semantic or boundary changes.
- It asks the user before it changes supplied intent or makes a major design choice.

After a correction, the correcter runs the validator and repeats the architecture review. It
stops after three correction cycles if material findings remain.

If the host cannot start a separate agent, the skills perform a separate self-review. The final
report states that the review was not independent.

## Ontology validation

The plugin includes an L3-L1 validator:

```shell
python3 plugins/specspec-skills/scripts/validate_specspec_design.py <spec-bundle>
```

The validator checks:

- L3, L2, and L1 types, layers, identifiers, and provenance values.
- Direct L3-to-L2 and L2-to-L1 decomposition.
- Reciprocal parent and child links.
- Orphan Components and Modules.
- Complete paths from L3 concepts to L1 Modules.

The validator does not check L4 product meaning, architectural quality, source code, Git history,
hashes, or line anchors. The architecture reviewer checks semantic consistency across L4-L1.

## Repository layout

```text
.
├── .claude-plugin/
│   └── marketplace.json
├── .github/
│   └── workflows/release-plugins.yml
├── plugins/
│   └── specspec-skills/
│       ├── plugin.json
│       ├── .claude-plugin/plugin.json
│       ├── .codex-plugin/plugin.json
│       ├── scripts/
│       └── skills/
├── scripts/
│   └── prepare_plugin_release.py
└── tests/
```

The root `plugin.json` uses Agent Plugins 1.0. The host-specific manifests add Claude and Codex
metadata. All three manifests describe the same plugin version.

## Development and verification

Run all unit tests:

```shell
python3 -m unittest discover -s tests -v
```

Validate the L3-L1 graph for a generated bundle:

```shell
python3 plugins/specspec-skills/scripts/validate_specspec_design.py spec/
```

Validate the Claude marketplace and plugin when Claude Code is installed:

```shell
claude plugin validate --strict .claude-plugin/marketplace.json
claude plugin validate --strict plugins/specspec-skills
```

## Releases

The release workflow runs when a pushed tag starts with `v`. The text after `v` must match the
version in all plugin and marketplace manifests.

Before a release, update these files:

- `.claude-plugin/marketplace.json`.
- `plugins/specspec-skills/plugin.json`.
- `plugins/specspec-skills/.claude-plugin/plugin.json`.
- `plugins/specspec-skills/.codex-plugin/plugin.json`.

Run the tests. Then test packaging with the same version:

```shell
release_dir=$(mktemp -d)
python3 scripts/prepare_plugin_release.py --tag v0.2.0 --output "$release_dir"
```

Create and push the tag:

```shell
git tag v0.2.0
git push origin v0.2.0
```

The workflow performs these actions:

1. It runs the repository tests.
2. It verifies that the tag, marketplace, and plugin versions match.
3. It creates one ZIP archive for each directory under `plugins/`.
4. It creates `SHA256SUMS`.
5. It publishes a GitHub Release with generated notes and all release assets.

A tag that contains a hyphen, such as `v0.3.0-beta.1`, creates a prerelease.

## Design boundaries

- The skills create a proposed design. They do not claim that code implements it.
- The skills do not create source-file plans, code symbols, hashes, or path-and-line anchors.
- The skills do not invent named vendors, legal duties, service levels, or numeric targets.
- L1 is the terminal layer for the design skills. `implement-spec` extends an implementation copy
  to L0 after tests pass.
- `implement-spec` supports new reference applications. Existing application changes are outside
  its current scope.
