# Behavior and intent audit

Use this audit after the source-derived layers exist. Read it earlier when selecting L3 Workflows
or writing L4 Capabilities. Its purpose is to find behavior that a source-file inventory misses.

## Inputs

Inventory user actions from every reachable entry point: browser controls, routes, command-line
commands, jobs, message consumers, and public APIs. Read test bodies and assertions, not only
test names, comments, or criterion markers. Read supplied requirements and project documents as
intent evidence. When the user requests an independent comparison with an existing spec, finish
the code-only bundle before reading that spec; then use it for this audit.

For each claimed or expected outcome, follow the full path:

1. Entry input and actor context.
2. Authorization, validation, and dispatch.
3. Domain operation and stored state.
4. Response construction and error handling.
5. What the caller or user can actually receive or see.
6. The test assertion and whether that test ran and passed.

A callable function does not prove an entry point reaches it. A returned object does not prove
the user sees its fields. A test marker does not prove the test asserts the expected result. A
passing unit test does not prove an untested interface presents that result.
For each test, name the entry point it exercises. A direct domain-function test cannot verify a
browser route or its response formatter. Check the interface path separately before crediting the
test to a user-visible outcome.

## Coverage table

Keep one row per material Behavior bullet or Acceptance criterion in a supplied spec. Add rows for
other user-visible actions and important negative paths found in code or tests. If no supplied
spec exists, use the code and tests to propose candidate outcomes, and mark inferred intent.

| Outcome and origin | Entry-to-output source trail | Test assertion and run result | Status | Gap or limit |
|---|---|---|---|---|

Use these statuses:

- `verified`: The reachable path produces the claimed observable result, and a relevant test ran
  and passed on the documented snapshot.
- `source-supported`: The source contains the full reachable path, but execution is unavailable
  or no relevant test ran. Do not call it verified.
- `partial`: Part of the outcome exists, but a field, state, error, or presentation step is absent.
- `missing`: No reachable path implements the outcome.
- `contradicted`: The reachable path produces a different result.
- `unknown`: The evidence cannot settle the result.

Check all claims in the Product Overview and each Capability, including role rules, ownership,
failure cases, state changes, returned IDs, and history content. Check every supplied non-goal,
success measure, ADR rationale, external Interface, and Observability concept separately. These
can be valid intent even when code has no implementation evidence.

## Output and provenance

For a full `code2specspec` run, save `code2specspec-gap-report.md` beside the concept directories.
Give each material gap a stable ID, expected outcome and origin, observed source path, test result,
classification, impact, and correction target (`code`, `spec`, or `user decision`). State whether
the gap is an implementation mismatch or intent that source alone cannot establish. If no gap
exists, say so. Do not edit application code as part of specification generation.

Keep unsupported intended behavior out of the observed L0-L3 graph. A source-derived L4 claim
must not say an unmet outcome is implemented. Put the intended criterion and its provenance in
the gap report. If the user asks for a reconciled design, use the existing design skills to make
a separate design bundle; mark supplied intent and preserve its unimplemented status.
