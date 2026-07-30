# Wayfinder on GitHub

The exact commands for each wayfinder operation on GitHub. All commands use the `gh` CLI,
version 2.94.0 or higher. See `docs/github/GITHUB-SETUP.md` in this repo for the setup.

## Create the map

```bash
gh issue create \
  --title "Map: <effort name>" \
  --body-file map-body.md \
  --label "wayfinder:map"
```

Write the map body to a temp file first. Heredocs also work for short bodies.

## Create a decision ticket

```bash
gh issue create \
  --title "<question, as a name>" \
  --body "## Question

<the decision this ticket resolves>" \
  --label "wayfinder:grilling" \
  --parent <map-number>
```

Select the label by type: `wayfinder:research`, `wayfinder:prototype`,
`wayfinder:grilling`, or `wayfinder:task`.

## Wire blocking edges (second pass)

```bash
gh issue edit <ticket-number> --add-blocked-by <blocker-number>
```

Repeat per edge. To remove an edge: `--remove-blocked-by <n>`.

## Claim a ticket

```bash
gh issue edit <ticket-number> --add-assignee @me
```

Claim before any work. The assignee is the claim.

## Query the frontier

The frontier is the set of open, unblocked, unclaimed children of the map.

```bash
gh issue list --state open \
  --json number,title,assignees,parent,blockedBy \
  --jq '[.[]
    | select(.parent.number == <map-number>)
    | select(.assignees | length == 0)
    | select((.blockedBy // []) | map(select(.state == "OPEN")) | length == 0)
    | {number, title}]'
```

If a field name differs in your `gh` version, run `gh issue list --json` to list the
available fields, and adjust.

## Resolve a ticket

1. Post the answer:

   ```bash
   gh issue comment <ticket-number> --body "## Resolution

   <the decision, and the reasons>"
   ```

2. Close the ticket:

   ```bash
   gh issue close <ticket-number>
   ```

3. Append the index line to the map:

   ```bash
   gh issue view <map-number> --json body --jq .body > map-body.md
   # Append under "## Decisions so far":
   # - [<ticket title>](<ticket url>) — <one-line gist>
   gh issue edit <map-number> --body-file map-body.md
   ```

## Rule a ticket out of scope

1. Comment with the reason. 2. Close the ticket. 3. Add one line under the map's
`## Out of scope` section, with a link to the closed ticket.

## Inspect a map from the UI

Open the map issue in the browser. The sub-issue list shows all children and their state.
Blocked tickets show their dependency in the issue sidebar. This is the visual frontier.
