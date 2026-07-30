# Good and bad tests

## Good tests

**Integration-style**: test through real interfaces, not through mocks of internal parts.

```typescript
// GOOD: tests observable behavior
test("user can checkout with valid cart", async () => {
  const cart = createCart();
  cart.add(product);
  const result = await checkout(cart, paymentMethod);
  expect(result.status).toBe("confirmed");
});
```

Characteristics:

- Tests behavior that callers care about
- Uses the public API only
- Survives internal refactors
- Describes WHAT, not HOW
- One logical assertion per test

## Bad tests

**Implementation-detail tests**: coupled to internal structure.

```typescript
// BAD: tests implementation details
test("checkout calls paymentService.process", async () => {
  const mockPayment = jest.mock(paymentService);
  await checkout(cart, payment);
  expect(mockPayment.process).toHaveBeenCalledWith(cart.total);
});
```

Red flags:

- Mocks of internal collaborators
- Tests of private methods
- Assertions on call counts or call order
- A refactor breaks the test without a behavior change
- The test name describes HOW, not WHAT
- Verification that bypasses the interface

```typescript
// BAD: bypasses the interface to verify
test("createUser saves to database", async () => {
  await createUser({ name: "Alice" });
  const row = await db.query("SELECT * FROM users WHERE name = ?", ["Alice"]);
  expect(row).toBeDefined();
});

// GOOD: verifies through the interface
test("createUser makes user retrievable", async () => {
  const user = await createUser({ name: "Alice" });
  const retrieved = await getUser(user.id);
  expect(retrieved.name).toBe("Alice");
});
```
