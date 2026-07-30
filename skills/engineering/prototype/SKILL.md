---
name: prototype
description: Build a throwaway prototype that answers one design question - a runnable terminal app for state and logic questions, or several radically different UI variations on one route. Use when the user wants to prototype, check a data model or state machine, mock up a UI, or says "prototype this" or "try a few designs".
---

# Prototype

A prototype is **throwaway code that answers a question**. The question decides the shape.

## Select a branch

Identify the question from the prompt, the surrounding code, or the user:

- **"Does this logic or state model feel right?"** → [LOGIC.md](LOGIC.md).
  Build a small interactive terminal app that pushes the state machine through hard cases.
- **"What does this look like?"** → [UI.md](UI.md).
  Generate several radically different UI variations on one route, switchable by a URL
  search parameter.

The two branches produce very different artifacts. A wrong branch wastes the whole
prototype. If the question is ambiguous and the user is away, match the surrounding code:
a backend module means logic; a page or component means UI. State the assumption at the
top of the prototype.

## Rules for both branches

1. **Throwaway from day one, and marked as such.** Put the prototype next to the module
   or page it serves. Name it so a casual reader sees "prototype". Follow the project's
   routing convention for throwaway routes.
2. **One command to run.** Use the project's task runner. The user must not think.
3. **No persistence by default.** State lives in memory. If the question is about a
   database, use a scratch database with a clear "PROTOTYPE — wipe me" name.
4. **Skip the polish.** No tests. No error handling beyond runnability. No abstractions.
5. **Surface the state.** After every action, or on every variant switch, show the full
   relevant state.
6. **Delete or absorb when done.** Fold the validated decision into the real code, or
   delete the prototype. Do not let it rot in the repo.

## When done

The answer is the only part worth keeping. Record it somewhere durable: a commit
message, an ADR, an issue, or a `NOTES.md` next to the prototype. Record the question
with the answer. If the user is away, leave the placeholder for the verdict.
