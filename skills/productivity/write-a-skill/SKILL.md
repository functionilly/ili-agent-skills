---
name: write-a-skill
description: Create new agent skills with the correct structure, progressive disclosure, and bundled resources. Use when the user wants to create, write, or build a new skill.
---

# Write a Skill

## Process

1. **Gather requirements.** Ask the user:
   - Which task or domain does the skill cover?
   - Which specific use cases must it handle?
   - Does it need scripts, or only instructions?
   - Are there reference materials to include?

2. **Draft the skill.** Create:
   - A `SKILL.md` with concise instructions
   - Additional reference files, if the content exceeds 500 lines
   - Utility scripts, if deterministic operations exist

   Write all prose in the repo's STE style. See `docs/STE-GUIDE.md`.

3. **Review with the user.** Present the draft. Ask:
   - Does this cover the use cases?
   - Is anything absent or unclear?
   - Does any section need more or less detail?

## Structure

```
skill-name/
├── SKILL.md           # Main instructions (required)
├── REFERENCE.md       # Detailed docs (if needed)
├── EXAMPLES.md        # Usage examples (if needed)
└── scripts/           # Utility scripts (if needed)
    └── helper.js
```

## SKILL.md template

```md
---
name: skill-name
description: What the skill does. Use when [specific triggers].
---

# Skill Name

## Quick start

[A minimal working example]

## Workflows

[Step-by-step processes, with checklists for complex tasks]

## Advanced features

[Links to separate files: See [REFERENCE.md](REFERENCE.md)]
```

## The description

The description is the only thing the agent sees when it selects a skill. The agent
reads all installed descriptions and picks by relevance.

Give the agent two facts:

1. What capability the skill provides.
2. When to trigger it: keywords, contexts, file types.

Format:

- Maximum 1024 characters.
- Third person.
- First sentence: what it does. Second sentence: "Use when [triggers]".

**Good:**

```
Extract text and tables from PDF files, fill forms, merge documents. Use when working
with PDF files or when the user mentions PDFs, forms, or document extraction.
```

**Bad:**

```
Helps with documents.
```

The bad example gives the agent no way to separate this skill from other document skills.

## When to add scripts

Add scripts when the operation is deterministic, when the same code repeats, or when
errors need explicit handling. Scripts save tokens and beat generated code on reliability.

## When to split files

Split when `SKILL.md` exceeds 100 lines, when the content has distinct domains, or when
advanced features are rare. Keep references one level deep.

## Review checklist

- [ ] The description includes triggers ("Use when…")
- [ ] `SKILL.md` stays under 100 lines
- [ ] No time-sensitive information
- [ ] Consistent terminology
- [ ] Concrete examples included
- [ ] References go one level deep
- [ ] The prose passes the checks in `docs/STE-GUIDE.md`
