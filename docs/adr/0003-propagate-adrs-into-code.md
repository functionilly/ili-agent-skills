# Propagate ADRs into code with constraint lines

Agents follow the shape of the code they grep more than the documents they did not
load. Thus each source file starts with a purpose header, and each ADR that binds a
file adds one constraint line: `ADR-NNNN: <local rule>`. The header points, it does
not paraphrase: the rule takes one line, the reason stays in the ADR. The ADR number
is a grep token that links code, issues, and `docs/adr/`. The cost: headers need an
update when an ADR is superseded. A grep of the number finds each site.
