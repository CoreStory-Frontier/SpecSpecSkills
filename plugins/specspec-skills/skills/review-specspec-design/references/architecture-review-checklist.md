# SpecSpec Architecture Review Checklist

Use this checklist for each complete L4-L1 review. A missing item is a finding only when the
application needs that item.

## L4 product intent

- The Product Overview states the product purpose, users, goals, and non-goals.
- Each supplied user and outcome appears in a Capability.
- Each Capability describes one coherent user outcome.
- Rules, limits, failure cases, and success measures are testable.
- The Capability set has no unexplained gap or overlap.
- L4 does not contain system, component, module, or code design.

## L4 to L3 coverage

- Every Capability links to sufficient L3 concepts.
- Every L3 concept supports at least one Capability or a necessary cross-cutting concern.
- Product terms keep the same meaning in L3.
- L3 does not narrow or expand supplied product intent without a marker.

## L3 system model

- The Technical Overview defines the system boundary and external actors.
- Data Entity documents define ownership, identity, relationships, lifecycle, and invariants.
- Interface documents define operations, inputs, outputs, errors, and trust boundaries.
- Workflow documents define triggers, ordered steps, state changes, and failure behavior.
- Authorization documents define actors, resources, actions, and decision points.
- Business validation does not appear as authorization policy.
- Deployment documents identify runtime units, data stores, networks, and external services.
- Observability documents cover signals for important outcomes and failures.
- Decision documents explain important choices, alternatives, and consequences.
- Workflows, interfaces, data rules, and authorization rules agree.
- Runtime and observability designs cover all important workflows.

## L3 to L2 decomposition

- Each L3 responsibility has an owning or supporting Component.
- Each Component has one cohesive purpose and a clear boundary.
- Data, contract, and workflow ownership are explicit.
- Shared concerns have one owner. Other Components depend on that owner.
- Component dependencies have a clear direction.
- Dependency cycles are absent or supplied and justified.
- External systems are not misrepresented as internal Components.

## L2 to L1 decomposition

- Each Component responsibility maps to at least one Module.
- Each Module has one cohesive purpose inside its Component.
- Cross-Module contracts have one owning Module.
- Module dependencies have a clear direction.
- Dependency cycles are absent or supplied and justified.
- Generic utility Modules do not hide unrelated responsibilities.
- L1 does not contain source files, symbols, code paths, or implementation claims.

## Cross-layer integrity

- Each concept has the required frontmatter, type, layer, stable ID, path, and sections from its
  layer concept reference.
- Each layer index lists every concept in that layer once. It lists no missing concept.
- The completed bundle follows this final-state table:

| Relationship or layer | Final state |
|---|---|
| Product navigation | The Product Overview and product index list the same Capability set. |
| L4 to L3 | A Capability has the same direct L3 set in `Realized by` and `Evidence`. Each linked L3 concept has that Capability in `Related`. No L3 `Related` backlink exists without both downward links. |
| L3 to L2 | An L3 concept has the same direct L2 set in `Decomposition` and `Evidence`. Each linked Component has that L3 concept in `Related`. No Component backlink exists without both downward links. |
| Technical Overview | `Components` lists every direct L2 Component that realizes the overview. |
| L2 to L1 | A Component has the same direct L1 set in `Modules`, `Decomposition`, and `Evidence`. Each linked Module has that Component in `Related`. No Module backlink exists without all three downward links. |
| L1 terminal state | Each Module contains the exact required statements in `Files`, `Decomposition`, and `Evidence`. These sections contain no links. |

- Completed lower-layer links replace temporary planning placeholders from the layer references.
- No replaced planning placeholder remains beside final links.
- Decomposition links go only to the next lower layer.
- Parent-to-child and child-to-parent relationship sets are equal at every layer boundary.
- Navigation and concept links resolve.
- Identifiers, filenames, titles, and concept types are stable and unique.
- No lower-layer concept introduces a new product rule without provenance.
- A higher-layer change is reflected in every affected lower layer.
- Removed or renamed concepts leave no stale links.
- Every L3 concept reaches L1.
- Every L2 and L1 concept has a parent.

## Provenance and decisions

- Supplied facts have no inline provenance marker.
- Model additions use `[inferred]`.
- Uncertain or high-impact assumptions use `[NEEDS CONFIRMATION]`.
- No design claim uses `provenance: observed`.
- Restated inferred claims keep their marker.
- Each open confirmation appears where a decision affects the design.
- Contradictory open confirmations are reported.

## Clarity

- One term identifies one concept across all layers.
- Definitions precede product-specific terms.
- Sentences use active voice and simple words.
- Tables and lists have consistent labels.
- Placeholders do not remain where direct links now exist.
- The text separates current supplied facts from proposed design.
