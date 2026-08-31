# Issue tracker: local markdown

Issues for this repo live as markdown files under `.scratch/`. Use this tracker for solo
projects or repos without a remote.

## Layout

```
.scratch/
└── <feature-name>/
    ├── 001-first-issue.md
    └── 002-second-issue.md
```

## Operations

- **Create an issue**: write a new numbered file. Increment the highest number.
- **Read an issue**: read the file.
- **Comment**: append a `## Update <date>` section to the file.
- **Labels**: write a `labels:` line in the file's frontmatter.
- **Close**: move the file into a `closed/` subfolder.
- **Blocking**: write a `blocked-by:` line in the file's frontmatter.
- **Assign**: write an `assignee:` line in the file's frontmatter.

## Question issues

A question issue is a numbered file with `labels: ready-for-human` in the frontmatter.
List the open questions: open files with that label and no open `blocked-by` target.
