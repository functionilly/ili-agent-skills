# Issue tracker: GitHub

Issues for this repo live in GitHub Issues. Use the `gh` CLI for all operations.
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

## Question-issue operations

- **A question issue** is a child of the effort's parent issue, labeled `ready-for-human`.
  Create it with `--parent <number>`.
- **The open questions of one effort**: list the open children of the parent that
  carry the label:

  ```bash
  gh issue list --state open --label ready-for-human \
    --json number,title,parent \
    --jq '[.[] | select(.parent.number == PARENT)]'
  ```

  If your `gh` version does not expose these JSON fields, run `gh issue list --json`
  to list the available fields.

## Phrase mappings

- "Publish to the issue tracker" = create a GitHub issue.
- "Fetch the issue" = `gh issue view <number> --comments`.
