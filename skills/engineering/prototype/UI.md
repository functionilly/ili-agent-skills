# UI prototype

Generate several radically different UI variations on one route. The user flips between
them in the browser with a floating bottom bar, selects one (or steals parts of each),
and throws the rest away.

If the question is about logic or state, use [LOGIC.md](LOGIC.md).

## When this is the right shape

- "What does this page look like?"
- "Show me options for this dashboard."
- "Try a different layout for the settings screen."

## Two sub-shapes — prefer sub-shape A

A UI prototype is easier to judge inside the real app: real header, real data, real
density. A route in a vacuum makes every variant look fine.

### Sub-shape A — a change to an existing page (preferred)

The route exists. Render the variants on the same route, gated by a `?variant=` search
parameter. Keep the existing data fetches, parameters, and auth. Only the rendering swaps.
A new section inside an existing page is still sub-shape A: mount the variants in the host page.

### Sub-shape B — a new page (last resort)

Use only when the prototype has no existing page to live inside. Create a throwaway
route in the project's routing convention. Put "prototype" in the path or file name.
Use the same `?variant=` pattern. Before you commit to B, check again: is there really
no host page? An empty route hides design problems.

## Process

### 1. State the question and select N

Default to 3 variants. Cap at 5 — more stops being different and starts being noise.
Write the plan in one line at the top of the file:

> "Three variants of the settings page, switchable via `?variant=`, on the existing
> `/settings` route."

### 2. Generate radically different variants

Hold each variant to: the page's purpose and data, the project's component and styling
system, and a clear exported name (`VariantA`, `VariantB`, `VariantC`).

Variants must differ in structure — layout, information hierarchy, primary affordance.
Not colors. Three near-identical card grids are wallpaper, not a prototype. If two
drafts converge, redo one with an explicit constraint: "do not use a card grid".

### 3. Wire them together

One switcher component on the route:

```tsx
// pseudo-code — adapt to the project's framework
const variant = searchParams.get("variant") ?? "A";
return (
  <>
    {variant === "A" && <VariantA {...data} />}
    {variant === "B" && <VariantB {...data} />}
    {variant === "C" && <VariantC {...data} />}
    <PrototypeSwitcher variants={["A", "B", "C"]} current={variant} />
  </>
);
```

Sub-shape A: keep the data fetches above the switcher. Sub-shape B: mount the same
switcher on the throwaway route.

### 4. Build the floating switcher

A small fixed bar at the bottom center, with three parts: a left arrow (previous
variant, wraps), the variant label (`B — Sidebar layout`), and a right arrow (next,
wraps).

Behavior:

- An arrow click updates the URL search parameter through the framework router.
  The variant stays shareable and reload-stable.
- The left and right arrow keys also cycle. Do not intercept keys when an input,
  textarea, or contenteditable element has focus.
- Make the bar visually distinct from the page, so it is clearly not part of the design.
- Hide the bar in production builds. Gate on the environment, so a stray merge cannot
  ship it.

Put the switcher in one shared component, wherever shared UI lives.

### 5. Hand it over

Give the user the URL and the `?variant=` keys. The valuable feedback is usually
"the header from B with the sidebar from C" — that is the design they want.

### 6. Capture the answer and clean up

Record the winner and the reason (commit message, ADR, issue, or `NOTES.md`). Then:

- **Sub-shape A** — delete the losers and the switcher. Fold the winner into the page.
- **Sub-shape B** — promote the winner to a real route. Delete the throwaway route.

Do not leave variants or the switcher in the repo. They rot fast.

## Anti-patterns

- **Variants that differ only in color or copy.** That is a tweak.
- **Too much shared code.** A shared header is fine. A shared layout defeats the point.
- **Variants wired to real mutations.** Read-only is fine. Point mutations at a stub.
- **Promotion of prototype code to production.** It was written without tests or error
  handling. Rewrite it when you fold it in.
