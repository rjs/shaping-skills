# Reading Whiteboard Breadboards

Hand-drawn or whiteboard breadboards use a visual stacking format rather than tables. The same concepts apply (Places, affordances, wiring) but the layout conventions differ.

## Visual Conventions

| Element | How it appears |
|---------|---------------|
| **Place** | Colored block (often pink/purple) at the **top** of a vertical stack |
| **Affordances in a place** | Blocks stacked **underneath** the place block — containment is shown by vertical position in the stack |
| **Code affordances** | Typically float **between** place stacks, not inside them |
| **Place loader** | A code affordance positioned at the **top-left** of the place block — describes the data/inputs needed to render that place |
| **Wires Out** | Solid arrows between blocks |
| **Returns To** | Dashed arrows between blocks |
| **Conditionals** | Indented blocks within a stack, often a different color (e.g., green), showing if/else branches |
| **Place references** | `_` prefix on a place name within a stack (same as `_PlaceName` convention) |
| **Uncertain/tentative** | `?` prefix or `~` prefix on an affordance name, or dashed borders — indicates the affordance is speculative |
| **Containing box** | A large boundary drawn around multiple stacks — groups affordances by system or responsibility boundary (e.g., "HireEZ" box) |
| **Notes/annotations** | Freeform text near elements — context, open questions, or rationale |

## How to Read a Whiteboard Breadboard

1. **Identify places** — Find the colored header blocks at the top of each stack
2. **Read each stack top-to-bottom** — Everything stacked under a place belongs to that place
3. **Find loaders** — Code affordances at the top-left of a place block describe what data is needed to render
4. **Trace wiring** — Follow arrows between stacks for control flow (solid) and data flow (dashed)
5. **Note conditionals** — Indented blocks with different colors show branching logic within a place
6. **Check containing boxes** — Large boundaries indicate system/responsibility boundaries
7. **Flag speculative items** — `?` and `~` prefixed items are uncertain and may not survive shaping

## Translating to Tables

When converting a whiteboard breadboard to standard affordance tables, map each stack to its Place, enumerate the affordances top-to-bottom, and capture the arrows as Wires Out / Returns To relationships. Loaders become code affordances with Returns To pointing at the UI affordances they feed.
