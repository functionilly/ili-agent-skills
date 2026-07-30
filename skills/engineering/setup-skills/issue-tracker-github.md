# Issue tracker: GitHub

Issues and PRDs for this repo live in GitHub Issues. Use the `gh` CLI for all operations.
The CLI infers the repo from `git remote -v`.

## Operations

- **Create an issue**: `gh issue create --title "..." --body "..."`. Use a heredoc for long bodies.
- **Create a child issue**: add `--parent <number>` to `gh issue create`.
- **Read an issue**: `gh issue view <number> --comments`
- **List issues**: `gh issue list --state open --json number,title,labels,assignees`
- **Comment**: `gh issue comment <number> --body "..."`
- **Apply or remove labels**: `gh issue edit <number> --add-label "..."` / `--remove-label "..."`
- **Add a dependency**: `gh issue edit <number> --add-blocked-by <other-number>`
- **Assign**: `gh issue edit <number> --add-assignee @me`
- **Close**: `gh issue close <number> --comment "..."`

## Wayfinding operations

The wayfinder skill needs these mappings:

- **The map** is an issue with the label `wayfinder:map`.
- **A decision ticket** is a child issue of the map. Create it with `--parent <map-number>`.
- **Blocking** uses native dependencies: `gh issue edit <n> --add-blocked-by <m>`.
- **A claim** is an assignee: `gh issue edit <n> --add-assignee @me`.
- **The frontier query**: list the open children of the map. Keep only issues with no
  assignee and no open blocker:

  ```bash
  gh issue list --state open \
    --json number,title,labels,assignees,parent,blockedBy \
    --jq '[.[] | select(.parent.number == MAP) | select(.assignees | length == 0)]'
  ```

  Then remove issues that have an open entry in `blockedBy`. If your `gh` version does not
  expose these JSON fields, run `gh issue list --json` to list the available fields.

## Phrase mappings

- "Publish to the issue tracker" = create a GitHub issue.
- "Fetch the ticket" = `gh issue view <number> --comments`.
