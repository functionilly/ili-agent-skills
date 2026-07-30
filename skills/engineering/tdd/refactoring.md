# Refactor candidates

After a TDD cycle, look for:

- **Duplication** — extract a function or class.
- **Long methods** — break into private helpers. Keep the tests on the public interface.
- **Shallow modules** — combine or deepen them.
- **Feature envy** — move the logic to where the data lives.
- **Primitive obsession** — introduce value objects.
- **Old code** that the new code exposes as a problem.
