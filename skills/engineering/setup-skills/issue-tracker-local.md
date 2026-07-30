# Issue tracker: local markdown

Issues for this repo live as markdown files under `.scratch/`. Use this tracker for solo
projects or repos without a remote.

## Layout

```
.scratch/
├── <feature-name>/
│   ├── 001-first-issue.md
│   └── 002-second-issue.md
└── wayfinder/
    └── <map-name>/
        ├── MAP.md
        └── tickets/
            ├── 001-<slug>.md
            └── 002-<slug>.md
```

## Operations

- **Create an issue**: write a new numbered file. Increment the highest number.
- **Read an issue**: read the file.
- **Comment**: append a `## Update <date>` section to the file.
- **Labels**: write a `labels:` line in the file's frontmatter.
- **Close**: move the file into a `closed/` subfolder.

## Wayfinding operations

- **The map** is `MAP.md` in the map's folder.
- **A decision ticket** is a file under `tickets/`.
- **Blocking**: write a `blocked-by:` line in the ticket's frontmatter.
- **A claim**: write an `assignee:` line in the ticket's frontmatter.
- **The frontier query**: list open tickets with no `assignee` and no open `blocked-by` target.
