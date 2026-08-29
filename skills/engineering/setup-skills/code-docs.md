# Code documentation

How this repo documents source files. Skills that write code follow these rules.

## File headers

Start each source file with a purpose comment of one to three lines. State what the
file does and which module it serves.

When an ADR binds a file, add one constraint line per ADR under the purpose:

```ts
// Purpose: computes trainer earnings for the sessions view.
// Constraints:
// - ADR-0006: "earned" means a row in trainer_earning_sessions. Do not re-derive it.
```

A constraint line states the local rule in one line and names the ADR. The reason
stays in the ADR. Do not copy ADR prose into the header.

The string `ADR-NNNN` is a grep token. It must match a file in `docs/adr/`. A grep
of the number must find each file that the decision binds.

## Docstrings

Write a docstring on each exported function, class, and module interface. State the
contract. State the constraints that the signature does not show. Do not write
docstrings on private helpers. Do not restate the code.

Use the docstring style of the language:

| Language | Style |
| --- | --- |
| Python | Google style |
| TypeScript / JavaScript | TSDoc |
| Other | The dominant style of the codebase |

Google style example:

```python
def earned_sessions(trainer_id: str) -> list[Session]:
    """Return the sessions a trainer has earned.

    "Earned" means a row in trainer_earning_sessions (ADR-0006).

    Args:
        trainer_id: The trainer to query.

    Returns:
        The earned sessions, newest first.
    """
```

## Maintenance

- When you change a file, verify its header. Update the header when the purpose changed.
- When an ADR is superseded, grep its number. Update each header that carries it.

## Exceptions

Test files and one-off scripts do not need headers. A prototype states its assumption
at the top instead. A promoted logic module gets a full header at promotion time.
