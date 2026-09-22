---
name: implement-spec
description: Build a new reference application from approved SpecSpec L4-L1 documents. Obtain stack approval, deliver a runnable first version, test every Capability behavior and acceptance criterion, derive L0 from tested code, and obtain an independent L0-L4 review. Use for new applications, not changes to an existing application.
---

# Implement Spec

Build a runnable reference implementation of a SpecSpec design. Deliver one working user journey
first. Then add tested increments until every acceptance criterion passes. A runnable first
version is a milestone, not completion.

One test proves one criterion. Every Behavior bullet and every Acceptance criterion in every L4
Capability gets its own test with a criterion marker. The tests are the traceability record from
Capability to code. Read [references/criterion-traceability.md](references/criterion-traceability.md)
before you write tests.

## Inputs and scope

Require a bundle with `product/`, `system/`, `components/`, and `modules/`. Read every document,
including indexes, and any supplied source packet or prior review. Resolve all linked concepts.

Confirm the new application destination. Inspect it before writing. An empty directory, or a
repository containing only the design and project instructions, is suitable. If application code
already exists, pause: this skill does not support changing an existing application. On resume,
code created during this skill's own run is allowed; inspect the recorded progress first.

Local dependency installation and local test services are permitted within the approved plan.
Use project-local environments and synthetic data. Bind development services to localhost.
Commits, pushes, deployment, paid services, and changes to external systems require separate
authorization. Preserve authorization already given in the session.

Reference scope limits operational hardening. It does not relax specified behavior, access
control, data integrity, or acceptance criteria. Do not add production infrastructure unless the
specification requires it.

## 1. Check the design and obtain stack approval

Run the bundled design validator before implementation:

```shell
python3 <plugin-root>/scripts/validate_specspec_design.py <input-bundle>
```

Resolve the plugin root two directories above this skill. Run the sibling
`../review-specspec-design/SKILL.md` on the input bundle to check semantic coverage. Its scope is
the input design only; it does not validate code or the later L0 bundle.

If input is missing, contradictory, or has an unresolved material choice, pause for the user's
decision. Cite the files and explain the effect. This includes `[NEEDS CONFIRMATION]` items and
unclear acceptance criteria. Do not silently correct the design or choose a convenient meaning.
After a decision, record it and make only the authorized specification changes before continuing.

Write a phased implementation plan outside the SpecSpec concept directories before writing
application code. Default to `implementation-plan.md` beside the input bundle. Present its path
and a phase summary for user approval. Include:

- Language, framework, runtime, storage, package manager, and compatible versions.
- Test tools and how to run the application locally.
- How packages map to the approved Components and Modules.
- The smallest complete user journey for the first runnable version.
- Later increments and the acceptance criteria covered by each increment.
- External integration needs and any proposed local substitutes.
- Application, implementation-record, and implementation-bundle destinations.

Give each phase a stable ID, outcome, scope, dependencies, observable acceptance criteria,
source-criterion IDs, verification methods, status, and evidence links. Include phases for the
first runnable journey, remaining behavior, final regression checks, L0 generation, and independent
review. Define success as observable results, not activities such as "write tests".

Map every L4 Behavior bullet, every L4 acceptance criterion, and every mandatory lower-layer
rule to a phase before coding. Keep full criterion text or precise source references in the
acceptance record; do not drop negative cases while summarizing. Cross-cutting criteria may span
phases. They pass only after all required checks pass. Label proposed behavior separately from
approved requirements. State the test that will prove each criterion.

Obtain approval of the phase plan as well as the stack. Pending specification decisions may be
listed in a proposed plan, but dependent implementation remains blocked until resolved.
Plan approval permits progression through its phases without repeated approval. Ask again only
for material scope, criterion, stack, or dependency changes. Preserve prior approval otherwise.

Explain trade-offs briefly. Obtain explicit approval of the stack. An instruction to use defaults
does not approve an undisclosed stack. Do not install the proposed stack before approval.
If the user already approved a concrete stack, record that decision without asking again.

A local substitute must be explicitly approved. Mark its scope and test limits. Tests against a
substitute do not prove a real integration works. If a required criterion needs the real system,
keep it blocked until tested or until the user explicitly changes the specification.

## 2. Record acceptance and build the first version

Read [references/criterion-traceability.md](references/criterion-traceability.md) now. Assign one
stable criterion ID to every Behavior bullet and every Acceptance criterion in every L4 Capability.
Write one test per criterion. Put the criterion ID in a marker inside the test, so the test file is
the traceability record.

Keep a durable implementation record outside the SpecSpec concept directories. Record the input
baseline, approved decisions, destinations, increments, blockers, and exact verification commands.
Use one criterion table per layer group, with these columns:

| Criterion ID | Source file and full criterion | Test node ID | Phase ID | Result | Evidence |
|---|---|---|---|---|---|

Preserve the full meaning of each criterion. Include every L4 Behavior bullet, every L4 acceptance
criterion, and every mandatory L3-L1 rule. Write a test node ID, not a test description. Use
`pending`, `pass`, `fail`, or `blocked`; a skipped test is not a pass. A criterion can require
several test node IDs.

Run the bundled coverage check after you write the tests:

```shell
python3 <plugin-root>/scripts/check_criterion_coverage.py --bundle <input-bundle> --tests <test-root> --aliases <alias-file>
```

The check fails while any criterion has no test. Record its output in the implementation record.
The check proves that a test exists; it does not prove that the test is correct or that it passed.
Run the tests to prove that.

Build a small end-to-end path through the actual interface, application behavior, and storage
when storage is required. Include the access controls needed by that path. Avoid a UI-only shell
or a stub response as the first runnable version.

Start the application with the documented command. Exercise the first journey and run its tests.
Report the runnable milestone and remaining coverage, then continue without another approval gate.

## 3. Complete the implementation

Maintain the saved plan throughout execution. Use `proposed`, `pending`, `in_progress`, `blocked`,
or `complete` for phase status. Record approval before changing proposed phases to pending.
Update the plan when a phase starts, completes, becomes blocked, or is reopened. Completion
requires every phase criterion to pass with recorded verification evidence. Record the completion
date, checks run, results, remaining work, and next phase. Keep a dated change history.

After a code or specification change, reopen any affected completed phase, invalidate stale
evidence, and rerun its checks. Do not remove failed criteria to close a phase. Routine task
adjustments can be recorded without approval; material plan changes require user approval.

For each remaining phase:

1. Select uncovered criteria and their lower-layer rules.
2. Implement behavior within the approved Module boundaries.
3. Write the criterion tests for this phase. Give each test one marker and one asserted outcome.
   Cover rejection, authorization, state, ownership, and concurrency behavior. Use real
   application paths where integration matters.
4. Run the criterion tests and the full suite. Fix failures. Update the criterion tables and the
   saved plan with the observed results and the test node IDs.
5. Report the phase result, then continue to the next approved phase.

Keep expected test results grounded in the specification. Do not weaken tests or criteria to
match a defect. If implementation reveals a specification gap or contradiction, pause for a
decision. Code defects with a clear specified result can be fixed directly.

Finish with the full test suite, the criterion coverage check, the build and static checks
provided by the selected stack, and a fresh local startup check. For a browser application, exercise the actual user journeys in a
browser when available. Document setup, configuration, test commands, sample data, and known
reference-implementation limits in the application README.

Continue until all criteria pass. If required tools, credentials, or user decisions prevent a
check, record the blocker and pause. Never report completion based on unrun tests or mock-only
coverage of a required real integration.

## 4. Derive L0 from the tested code

After all acceptance checks pass, read [references/l0-concepts.md](references/l0-concepts.md).
Create a separate implementation bundle by copying the approved L4-L1 input to the agreed
destination. Preserve IDs and supplied intent. Add observed L0 documents from the actual code.

Replace L1 terminal placeholders in the implementation copy with reciprocal L0 links as the
reference specifies. Preserve the original design bundle for the design-only workflow.
The existing L3-L1 validator and design reviewer require terminal L1 documents. Do not run them
against the expanded implementation bundle or weaken them to accept it.

Record source coverage and exclusions. Never invent Git metadata. The L0 reference defines the
distinction between a tested working-tree snapshot and a revision-pinned code-spec bundle.

## 5. Require an independent full-stack review

Read [references/implementation-review.md](references/implementation-review.md). Start a separate
review agent with that brief, the source code, both bundles, approved decisions, acceptance record,
and test results. The reviewer runs the tests, runs the criterion coverage check, and verifies
traceability across L0 through L4. It must not edit files.

Fix code or evidence defects whose intended result is clear. Pause for a user decision on
specification conflicts. After code changes, rerun affected tests and the final suite, regenerate
affected L0 documents and reverse links, and repeat the independent review on the final state.
Continue until no inconsistency remains. If the same finding persists after three correction
attempts without progress, report its evidence and blocker instead of claiming completion.

If the host cannot run an independent agent, retain the work and report that review is blocked.
A self-review does not satisfy this skill's independent-review requirement.

## Completion and resume

Before completion, require every planned phase to be complete, every Behavior bullet and
Acceptance criterion to have a passing marked test, complete L0 coverage, valid links and anchors,
and an independent review with no unresolved findings or specification decisions.
Report Git pinning status separately. Working-tree evidence can pass semantic review without
being an upstream-conformant revision-pinned bundle; never equate these verdicts.

Provide the run command, output paths, criterion coverage results, executed checks, review
verdict, reference limits, the final phase-plan path, and any pending Git pinning. Report criterion
coverage as the count of criteria with a passing marked test over the total count. On resume, read the saved plan,
implementation record, and current files. Resume at the first incomplete phase whose dependencies
are complete. Invalidate evidence affected by changes.

Use ASD-STE100 principles throughout: simple words, active voice, short sentences, and consistent
terms. State observed results separately from proposed work.
