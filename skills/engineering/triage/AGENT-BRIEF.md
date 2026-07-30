# Agent briefs

An agent brief is a structured comment on an issue that moves to `ready-for-agent`.
It is the specification that an AFK agent works from. The issue body and the discussion
are context. The brief is the contract.

## Principles

### Durability over precision

The issue can wait for weeks. The codebase changes in that time. Write the brief so it
stays useful after renames, moves, and refactors.

- **Do** describe interfaces, types, and behavioral contracts.
- **Do** name the types, signatures, and config shapes to find or modify.
- **Do not** reference file paths. They go stale.
- **Do not** reference line numbers.
- **Do not** assume the current structure stays the same.

### Behavioral, not procedural

Describe what the system must do, not how to build it. The agent explores the codebase
fresh and makes its own implementation decisions.

- **Good:** "The `SkillConfig` type accepts an optional `schedule` field of type `CronExpression`."
- **Bad:** "Open src/types/skill.ts and add a schedule field on line 42."

### Complete acceptance criteria

The agent must know when it is done. Write concrete, testable criteria.
Each criterion is independently verifiable.

- **Good:** "`gh issue list --label needs-triage` returns the issues that passed classification."
- **Bad:** "Triage works correctly."

### Explicit scope boundaries

State what is out of scope. This stops the agent from gold-plating and from assumptions
about adjacent features.

## Template

```markdown
## Agent brief

**Category:** bug / enhancement
**Summary:** one line: what must happen

**Current behavior:**
What happens now. For a bug, the broken behavior. For an enhancement, the status quo.

**Desired behavior:**
What happens after the work is complete. Be specific about edge cases and errors.

**Key interfaces:**
- `TypeName` — what changes, and why
- `functionName()` — the current return type, and the target return type
- Config shape — new options, if any

**Acceptance criteria:**
- [ ] Specific, testable criterion 1
- [ ] Specific, testable criterion 2

**Out of scope:**
- What must NOT change in this issue
- The adjacent feature that looks related but is separate
```

## Example: a good brief (bug)

```markdown
## Agent brief

**Category:** bug
**Summary:** Description truncation cuts mid-word and produces broken output

**Current behavior:**
A description longer than 1024 characters is cut at exactly 1024 characters.
The cut ignores word boundaries. Output ends mid-word, e.g. "Use when the user wants to confi".

**Desired behavior:**
The cut breaks at the last word boundary before 1024 characters, and appends "...".

**Key interfaces:**
- The `SkillMetadata` type's `description` field — no type change; the logic that
  populates it must respect word boundaries
- Any function that reads SKILL.md frontmatter and extracts the description

**Acceptance criteria:**
- [ ] A description under 1024 characters stays unchanged
- [ ] A longer description breaks at the last word boundary before 1024 characters
- [ ] A cut description ends with "..."
- [ ] The total length, with "...", stays at or under 1024 characters

**Out of scope:**
- A change to the 1024-character limit
- Multi-line description support
```

## Example: a bad brief

```markdown
## Agent brief

**Summary:** Fix the triage bug

**What to do:**
The triage thing is broken. Look at the main file and fix it.
The function around line 150 has the issue.
```

The faults: no category, a vague description, stale file references, no acceptance
criteria, no scope boundaries, no current-versus-desired behavior.
