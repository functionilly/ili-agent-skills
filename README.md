# Agent Skills

A collection of agent skills for daily engineering work. The ideology comes from
[mattpocock/skills](https://github.com/mattpocock/skills) (MIT). This version rewrites each
skill in [ASD-STE100 Simplified Technical English](https://www.asd-ste100.org/) (Issue 9).

The skills are small, composable, and easy to change. They do not own your process.
You stay in control.

## Why these skills exist

Coding agents fail in four common ways. Each skill in this repo prevents one failure.

### 1. The agent did not build what you want

There is a communication gap between you and the agent. Close the gap before the work
starts. Use a grilling session: the agent asks you questions until you agree.

Use [`/grill-me`](./skills/productivity/grill-me/SKILL.md) for general work.
Use [`/grill-with-docs`](./skills/engineering/grill-with-docs/SKILL.md) for code work.

### 2. The agent uses too many words

The agent does not know the project language. It uses 20 words where one word is sufficient.
The fix is a glossary. The glossary lives in `CONTEXT.md`. The agent reads it in each session.

[`/grill-with-docs`](./skills/engineering/grill-with-docs/SKILL.md) builds the glossary.
It also records hard decisions in ADR files.

### 3. The code does not work

The agent has no feedback on how the code runs. Give the agent feedback loops:
types, tests, and browser access.

Use [`/tdd`](./skills/engineering/tdd/SKILL.md) for a red-green-refactor loop.
Use [`/diagnose`](./skills/engineering/diagnose/SKILL.md) for hard bugs.

### 4. The codebase became a ball of mud

Agents write code fast. Thus, complexity also grows fast. Care about the design each day.

Use [`/improve-codebase-architecture`](./skills/engineering/improve-codebase-architecture/SKILL.md)
to find and repair shallow modules.

### 5. The work is too large for one session

Some work is larger than one agent session can hold. Do not attack it directly.
Chart it as a map of decision tickets on GitHub.

Use [`/wayfinder`](./skills/engineering/wayfinder/SKILL.md) to chart the map and to work
through it, one decision at a time.

## Quickstart

1. Install the skills into your agent. Point your agent at this repo, or copy the
   `skills/` folders into `~/.claude/skills/`.
2. Complete the GitHub integration. Follow [docs/github/GITHUB-SETUP.md](./docs/github/GITHUB-SETUP.md).
3. Run [`/setup-skills`](./skills/engineering/setup-skills/SKILL.md) once in each repo.
   It records your issue tracker, your triage labels, and your document layout.

## Skill reference

### Engineering

| Skill | Function |
| --- | --- |
| [setup-skills](./skills/engineering/setup-skills/SKILL.md) | Configure a repo for the other skills. Run once per repo. |
| [grill-with-docs](./skills/engineering/grill-with-docs/SKILL.md) | Interview the user about a plan. Update `CONTEXT.md` and ADRs during the session. |
| [wayfinder](./skills/engineering/wayfinder/SKILL.md) | Chart large work as decision tickets on the issue tracker. Resolve them one at a time. |
| [to-prd](./skills/engineering/to-prd/SKILL.md) | Turn the conversation into a PRD. Publish it to the issue tracker. |
| [to-issues](./skills/engineering/to-issues/SKILL.md) | Break a plan into vertical-slice issues. |
| [triage](./skills/engineering/triage/SKILL.md) | Move issues through a small state machine of triage roles. |
| [tdd](./skills/engineering/tdd/SKILL.md) | Build features with a red-green-refactor loop. |
| [diagnose](./skills/engineering/diagnose/SKILL.md) | Find hard bugs with a disciplined diagnosis loop. |
| [improve-codebase-architecture](./skills/engineering/improve-codebase-architecture/SKILL.md) | Find modules to deepen. Make the codebase testable and navigable. |
| [zoom-out](./skills/engineering/zoom-out/SKILL.md) | Get a map of the modules around unfamiliar code. |
| [prototype](./skills/engineering/prototype/SKILL.md) | Build throwaway code that answers one design question. |

### Productivity

| Skill | Function |
| --- | --- |
| [grill-me](./skills/productivity/grill-me/SKILL.md) | Interview the user about a plan until agreement. |
| [handoff](./skills/productivity/handoff/SKILL.md) | Compact the conversation into a document for the next session. |
| [caveman](./skills/productivity/caveman/SKILL.md) | Compressed output mode. Fewer tokens, same substance. |
| [write-a-skill](./skills/productivity/write-a-skill/SKILL.md) | Create a new skill with the correct structure. |

## Writing standard

All documents in this repo obey ASD-STE100 (Issue 9), applied pragmatically.
See [docs/STE-GUIDE.md](./docs/STE-GUIDE.md) for the rules this repo enforces.
Software terms are Technical Names and are permitted.

## Credits

The skill designs come from [Matt Pocock](https://github.com/mattpocock/skills), MIT license.
This repo rewrites them and adds GitHub-native issue hierarchy support.
