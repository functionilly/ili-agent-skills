# Deepening

How to deepen a cluster of shallow modules safely. Uses the SKILL.md vocabulary:
**module**, **interface**, **seam**, **adapter**.

## Dependency categories

Classify the dependencies of each candidate. The category decides how the deepened
module is tested across its seam.

### 1. In-process

Pure computation, in-memory state, no I/O. Always deepenable. Merge the modules.
Test through the new interface directly. No adapter.

### 2. Local-substitutable

Dependencies with local test stand-ins (PGLite for Postgres, an in-memory file system).
Deepenable when the stand-in exists. Test with the stand-in in the suite. The seam stays
internal. No port at the external interface.

### 3. Remote but owned (ports and adapters)

Your own services across a network. Define a **port** at the seam. The deep module owns
the logic. Inject the transport as an **adapter**. Tests use an in-memory adapter.
Production uses an HTTP, gRPC, or queue adapter.

The recommendation shape: "Define a port at the seam. Implement an HTTP adapter for
production and an in-memory adapter for tests. The logic sits in one deep module."

### 4. True external (mock)

Third-party services you do not control (Stripe, Twilio). The deepened module takes the
dependency as an injected port. Tests provide a mock adapter.

## Seam discipline

- **One adapter means a hypothetical seam. Two adapters mean a real seam.** Do not
  introduce a port without at least two justified adapters — typically production plus
  test. A single-adapter seam is indirection.
- **Internal seams versus external seams.** A deep module can have internal seams,
  private to its implementation and its tests. Do not expose internal seams through the
  interface because tests use them.

## Test strategy: replace, do not layer

- Old unit tests on the shallow modules become waste when interface tests exist. Delete them.
- Write the new tests at the deepened module's interface. The interface is the test surface.
- Assert on observable outcomes through the interface, not on internal state.
- The tests must survive internal refactors. A test that changes with the implementation
  tests past the interface.
