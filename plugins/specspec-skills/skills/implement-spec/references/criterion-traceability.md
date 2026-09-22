# Criterion traceability

Read this reference before you write tests. Tests are the traceability record for the product
specification. Every Behavior bullet and every Acceptance criterion in an L4 Capability needs at
least one test that asserts it.

## Criterion IDs

Give every bullet in a Capability `# Behavior` section and every criterion in its `# Acceptance`
section one stable ID. Use this default form:

| Section | ID form | Example |
|---|---|---|
| `# Behavior`, bullet n | `<CAPABILITY>-B<n>` | `FIND-EQUIPMENT-B3` |
| `# Acceptance`, criterion n | `<CAPABILITY>-A<n>` | `FIND-EQUIPMENT-A1` |

`<CAPABILITY>` is the file stem in capitals, for example `find-equipment`. Number bullets in
source order, from 1. Number Behavior and Acceptance independently. Do not renumber an ID after
the first recorded test. If a later specification change inserts a bullet, give it the next free
number and record the new ID.

Short IDs help readability for long capability names. Write an optional alias file beside the
implementation record. Each line maps a short alias to the full ID:

```
FE = FIND-EQUIPMENT
```

A test marker may use either form.

## Test markers

Each test that covers a criterion carries a marker in its docstring or in a comment:

```python
def test_free_item_is_available(app):
    """Criterion: FE-A1. A free item is shown as available."""
```

List several IDs in one marker when one test asserts several criteria:

```python
    """Criterion: FE-A1, FE-B3. Availability follows the selected period."""
```

Use one test per criterion by default. A single test that asserts several criteria hides which
outcome failed. Combine criteria only when the same action proves both, such as a rule and its
restatement in Acceptance.

Name each test for the outcome. Keep the criterion ID in the marker. Do not put the ID in the
test name alone: the marker is the searchable record.

## Write the tests

1. List every Behavior bullet and Acceptance criterion from every Capability.
2. Assign IDs. Record the source section and the full text for each ID.
3. Write at least one test per ID. Assert the specified result, including rejection, state,
   ownership, and role outcomes. A test that only checks a status code is not enough when the
   criterion names a state or a record.
4. Keep tests independent. Do not let one test depend on another test's left-over data.
5. Run the full suite. Record the test node ID, the result, and the exact command for each ID.

A criterion that needs a real external system stays blocked when the run uses a substitute. Mark
the substitute and its limit in the record. Do not mark the criterion as passing.

## Record the mapping

Keep the mapping in the implementation record. Use two tables, one for Acceptance criteria and one
for Behavior bullets:

| Criterion ID | Source file and full text | Test node ID | Phase ID | Result | Evidence |
|---|---|---|---|---|---|

`Test node ID` is the runnable identity of the test, for example
`app/tests/test_criteria.py::test_free_item_is_available`. One criterion can list several test
node IDs. Write `pending`, `pass`, `fail`, or `blocked` in `Result`.

Lower-layer rules from L3 through L1 keep their own rows. A lower-layer rule may map to the same
test as its L4 criterion. Record that test.

## Check coverage

Run the bundled checker after you write the tests:

```shell
python3 <plugin-root>/scripts/check_criterion_coverage.py \
  --bundle <input-bundle> --tests <test-root> [--tests <test-root>]... [--aliases <file>]
```

The checker derives the default IDs, reads the test markers, and reports every criterion that has
no test. It does not run the tests. Add `--list` to print every ID with its source bullet and
coverage state.

The check exits non-zero while any criterion has no test. Fix the gap or record the criterion as
blocked with the reason. Do not remove a criterion to make the check pass.
