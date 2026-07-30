---
name: handoff
description: Compact the current conversation into a handoff document for another agent.
argument-hint: "What will the next session be used for?"
---

Write a handoff document that summarizes this conversation, so a fresh agent can
continue the work. Save it to the temporary directory of the user's OS, not to the
workspace.

Include a "Suggested skills" section: the skills the next agent must invoke.

Do not duplicate content that lives in other artifacts — PRDs, plans, ADRs, issues,
commits, diffs. Reference them by path or URL.

Redact sensitive information: API keys, passwords, personal data.

If the user passed arguments, treat them as the focus of the next session.
Tailor the document to that focus.
