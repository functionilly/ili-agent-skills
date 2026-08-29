# Interface design for testability

Good interfaces make tests natural.

1. **Accept dependencies. Do not create them.**

   ```typescript
   // Testable
   function processOrder(order, paymentGateway) {}

   // Hard to test
   function processOrder(order) {
     const gateway = new StripeGateway();
   }
   ```

2. **Return results. Do not produce side effects.**

   ```typescript
   // Testable
   function calculateDiscount(cart): Discount {}

   // Hard to test
   function applyDiscount(cart): void {
     cart.total -= discount;
   }
   ```

3. **Keep the surface small.**
   - Fewer methods means fewer tests.
   - Fewer parameters means simpler setup.

## Docstrings are part of the interface

Write the docstring when you design the interface, not after. State the contract and
the constraints that the signature does not show. Follow `docs/agents/code-docs.md`
for the style. A docstring does not excuse a wide interface: reduce the surface
first, then document what remains.
