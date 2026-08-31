# Propagate ADRs into code with constraint lines

**Scope:** repo-wide — and every repo the skills configure
**Rule:** Start each source file with a purpose header. For each ADR that binds the file, add one constraint line: `ADR <slug>: <local rule>`. The header points; it does not paraphrase.
**Why:** Agents follow the shape of the code they grep more than the documents they did not load. The slug is the grep token that links code, issues, and `docs/adr/`. The cost: headers need an update when an ADR is superseded. A grep of the slug finds each site.
