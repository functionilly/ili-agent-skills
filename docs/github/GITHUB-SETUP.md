# GitHub Integration Setup

This document configures GitHub for the skills in this repo. The `triage`, `to-issues`,
`to-prd`, and `wayfinder` skills read and write GitHub issues. Complete each step in order.
Complete steps 1 to 4 once per machine. Complete steps 5 to 7 once per repo.

## 1. Install the GitHub CLI

The skills use the `gh` CLI for all issue operations.

1. Install `gh`:
   - macOS: `brew install gh`
   - Windows: `winget install GitHub.cli`
   - Linux: see https://github.com/cli/cli#installation
2. Check the version: `gh --version`

**Requirement**: version 2.94.0 or higher. This version adds the `--parent`,
`--blocked-by`, and `--blocking` flags. Wayfinder needs these flags.
If your version is lower, update: `brew upgrade gh` (macOS).

## 2. Authenticate

1. Run: `gh auth login`
2. Select `GitHub.com`, then `HTTPS`, then `Login with a web browser`.
3. Complete the browser flow.
4. Check the result: `gh auth status`

## 3. Verify the token scopes

Sub-issue and dependency operations need the `repo` scope.

1. Run: `gh auth status`
2. Read the "Token scopes" line. Make sure `repo` is present.
3. If `repo` is not present, run: `gh auth refresh -s repo`

## 4. Verify native hierarchy support

1. Run: `gh issue create --help | grep -E "parent|blocked"`
2. Make sure the output shows `--parent` and `--blocked-by`.
3. Run: `gh issue list --json 2>&1 | grep -iE "parent|blocked"` in any repo.
   This lists the JSON fields that your `gh` version exposes.

If the flags are absent, update `gh`. As a fallback, the REST endpoints are:

- Sub-issues: `POST /repos/{owner}/{repo}/issues/{number}/sub_issues`
- Dependencies: `POST /repos/{owner}/{repo}/issues/{number}/dependencies/blocked_by`

Call them with `gh api`. Both endpoints take the internal issue `id`, not the issue number.
Get the id with: `gh api repos/{owner}/{repo}/issues/{number} --jq .id`

## 5. Create the labels

The skills use two label sets. Run the script from the repo you want to configure:

```bash
bash scripts/setup-github-labels.sh
```

The script creates these labels:

Triage roles (used by `/triage`, `/to-issues`, `/to-prd`):

| Label | Meaning |
| --- | --- |
| `needs-triage` | A maintainer must evaluate the issue. |
| `needs-info` | The issue waits on the reporter. |
| `ready-for-agent` | The issue is fully specified. An AFK agent can take it. |
| `ready-for-human` | The issue needs human implementation. |
| `wontfix` | The issue will not be actioned. |

Wayfinder (used by `/wayfinder`):

| Label | Meaning |
| --- | --- |
| `wayfinder:map` | The issue is a map. It indexes one large effort. |
| `wayfinder:research` | The ticket resolves through reading. AFK. |
| `wayfinder:prototype` | The ticket resolves through a cheap artifact. HITL. |
| `wayfinder:grilling` | The ticket resolves through conversation. HITL. |
| `wayfinder:task` | The ticket is manual work that unblocks a decision. |

GitHub creates `bug` and `enhancement` by default. The triage skill uses them as
category roles. Do not delete them.

## 6. Wire the repo configuration

Run `/setup-skills` in your agent, inside the target repo. It writes:

- An `## Agent skills` block in `CLAUDE.md` or `AGENTS.md`
- `docs/agents/issue-tracker.md` — the GitHub conventions
- `docs/agents/triage-labels.md` — the label mapping
- `docs/agents/domain.md` — the glossary and ADR layout

## 7. Verify the integration

Run these checks from the repo:

1. Create a test issue: `gh issue create --title "Integration test" --body "Delete me." --label "needs-triage"`
2. Create a child issue: `gh issue create --title "Child test" --body "Delete me." --parent <number-from-step-1>`
3. Add a dependency: `gh issue edit <child-number> --add-blocked-by <parent-number>`
4. Read the links back: `gh issue view <child-number> --json parent,blockedBy`
5. Open the parent issue in the browser. Make sure the sub-issue list shows the child.
6. Close both issues: `gh issue close <n> --comment "Integration test complete."`

If step 2 or 3 fails, repeat steps 1 to 4 of this document.

## Issue and decision flows

The table below shows which skill owns which GitHub operation.

| Flow | Skill | GitHub artifact |
| --- | --- | --- |
| Plan a large effort | `/wayfinder` | A map issue plus child decision tickets |
| Record one decision | `/wayfinder` | A resolution comment; a closed ticket; a map index line |
| Record a hard technical decision | `/grill-with-docs` | An ADR file in `docs/adr/` (committed, not an issue) |
| Turn a plan into work | `/to-issues` | Vertical-slice issues with `needs-triage` |
| Publish a PRD | `/to-prd` | One PRD issue with `needs-triage` |
| Process incoming issues | `/triage` | Labels, comments, agent briefs, closures |
| Record a rejection | `/triage` | A `.out-of-scope/*.md` file plus a `wontfix` closure |

Wayfinder command details live in
[skills/engineering/wayfinder/GITHUB-OPERATIONS.md](../../skills/engineering/wayfinder/GITHUB-OPERATIONS.md).
