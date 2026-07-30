# Deep modules

From "A Philosophy of Software Design":

**A deep module** has a small interface and a large implementation.

```
┌─────────────────────┐
│   Small interface   │  <- few methods, simple parameters
├─────────────────────┤
│                     │
│ Deep implementation │  <- complex logic, hidden
│                     │
└─────────────────────┘
```

**A shallow module** has a large interface and a thin implementation. Avoid it.

```
┌─────────────────────────────────┐
│        Large interface          │  <- many methods, complex parameters
├─────────────────────────────────┤
│      Thin implementation        │  <- passes through
└─────────────────────────────────┘
```

When you design an interface, ask:

- Can I reduce the number of methods?
- Can I simplify the parameters?
- Can I hide more complexity inside?
