# When to mock

Mock at **system boundaries** only:

- External APIs (payment, email)
- Databases — sometimes; prefer a test database
- Time and randomness
- The file system — sometimes

Do not mock:

- Your own classes and modules
- Internal collaborators
- Anything you control

## Design for mockability

At system boundaries, design interfaces that are easy to mock.

**1. Use dependency injection.** Pass external dependencies in. Do not create them inside.

```typescript
// Easy to mock
function processPayment(order, paymentClient) {
  return paymentClient.charge(order.total);
}

// Hard to mock
function processPayment(order) {
  const client = new StripeClient(process.env.STRIPE_KEY);
  return client.charge(order.total);
}
```

**2. Prefer SDK-style interfaces over generic fetchers.** Make one specific function
per external operation. Do not make one generic function with conditional logic.

```typescript
// GOOD: each function is independently mockable
const api = {
  getUser: (id) => fetch(`/users/${id}`),
  getOrders: (userId) => fetch(`/users/${userId}/orders`),
  createOrder: (data) => fetch("/orders", { method: "POST", body: data }),
};

// BAD: the mock needs conditional logic
const api = {
  fetch: (endpoint, options) => fetch(endpoint, options),
};
```

The SDK approach gives: one shape per mock, no conditional test setup, a clear view of
which endpoints a test exercises, and type safety per endpoint.
