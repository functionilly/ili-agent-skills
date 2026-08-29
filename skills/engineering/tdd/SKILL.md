---
name: tdd
description: Test-driven development with a red-green-refactor loop. Use when the user wants to build features or fix bugs with TDD, mentions red-green-refactor, or asks for test-first development.
---

# Test-Driven Development

## Philosophy

**Core principle**: tests verify behavior through public interfaces, not implementation
details. The code can change completely. The tests must not.

**Good tests** are integration-style. They exercise real code paths through public APIs.
They describe what the system does, not how. A good test reads like a specification:
"user can checkout with valid cart". These tests survive refactors, because they ignore
internal structure.

**Bad tests** couple to the implementation. They mock internal collaborators, test
private methods, or verify through external means. The warning sign: a refactor breaks
the test, but the behavior did not change. Such a test tested the implementation.

See [tests.md](tests.md) for examples and [mocking.md](mocking.md) for mock rules.

## Anti-pattern: horizontal slices

Do not write all tests first and all code second. That is a horizontal slice:
RED as "write all tests", GREEN as "write all code". It produces bad tests:

- Bulk tests test imagined behavior, not real behavior.
- They test the shape of things — data structures, signatures — not behavior.
- They pass when behavior breaks, and fail when behavior is fine.
- You commit to a test structure before you understand the implementation.

**The correct approach**: vertical slices. One test, then one implementation. Repeat.
Each test responds to what the previous cycle taught you.

```
WRONG (horizontal):
  RED:   test1, test2, test3
  GREEN: impl1, impl2, impl3

RIGHT (vertical):
  RED→GREEN: test1→impl1
  RED→GREEN: test2→impl2
```

## Workflow

### 1. Plan

Explore the codebase with the glossary vocabulary, so test names match the project
language. Read the ADRs in the area you touch. List the ADRs that bind this work.

When the work comes from an issue with an agent brief, map each acceptance criterion
to one test behavior.

Before any code:

- [ ] Confirm the interface changes with the user
- [ ] Show the proposed interface as a code block, with one example call and its result
- [ ] Confirm which behaviors to test, in priority order
- [ ] Look for chances to make [deep modules](deep-modules.md)
- [ ] Design the interfaces for [testability](interface-design.md)
- [ ] List the behaviors to test — not the implementation steps
- [ ] List the binding ADRs, each with its local rule in one line
- [ ] Get the user's approval of the plan

Ask: "What does the public interface look like? Which behaviors matter most?"
You cannot test everything. Focus on critical paths and complex logic.

### 2. Tracer bullet

Write ONE test that confirms ONE thing:

```
RED:   Write the test for the first behavior. It fails.
GREEN: Write minimal code. It passes.
```

This proves the path works end to end.

### 3. Incremental loop

For each remaining behavior:

```
RED:   Write the next test. It fails.
GREEN: Minimal code. It passes.
```

Rules:

- One test at a time.
- Only enough code to pass the current test.
- Do not anticipate future tests.
- Keep the tests on observable behavior.

### 4. Refactor

After all tests pass, look for [refactor candidates](refactoring.md):

- [ ] Extract duplication
- [ ] Deepen modules: move complexity behind simple interfaces
- [ ] Apply SOLID principles where natural
- [ ] Write the file header and the interface docstrings, per docs/agents/code-docs.md
- [ ] Ask what the new code reveals about the old code
- [ ] Run the tests after each refactor step

Never refactor while RED. Get to GREEN first.

## Checklist per cycle

```
[ ] The test describes behavior, not implementation
[ ] The test uses the public interface only
[ ] The test survives an internal refactor
[ ] The code is minimal for this test
[ ] No speculative features
```
