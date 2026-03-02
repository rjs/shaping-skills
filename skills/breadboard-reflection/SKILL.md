---
name: breadboard-reflection
description: This skill should be used when the user asks to "review a breadboard", "find design smells", "check breadboard quality", "run the naming test", "analyze affordance boundaries", or mentions fixing wiring issues, stale affordances, or breadboard design quality.
---

# Breadboard Reflection

Find design smells in a breadboard and fix them. Works on existing breadboards built with the `/breadboarding` skill.

---

## Finding Smells

### Entry Point: Trace User Stories Through the Wiring

Take a user story from the requirements or frame. Trace it through the breadboard wiring. Ask: does the path tell a coherent story that produces the expected effect?

Example: "User says 'add Tokyo after Detroit' → Tokyo appears after Detroit in the table, and persists across restarts."

Trace: U4 (input) → N1 → N2 (LLM) → N3 (dispatch) → N4 (handle) → ... → S1 (locales updated) → N12 (persist) → S4 (config written).

At each link, ask: does this step logically lead to the next? Does the wiring make sense as a story about how the effect happens?

### What Smells Look Like

| Smell | What you notice |
|-------|-----------------|
| **Incoherent wiring** | A node writes to S1 AND triggers the thing that writes to S1 — redundant or contradictory |
| **Missing path** | The user story requires an effect, but no wiring path produces it |
| **Diagram-only nodes** | Nodes in the diagram that are not in the affordance tables — decoration, not real affordances |
| **Naming resistance** | An affordance cannot be named with one idiomatic verb (see Naming Test below) |
| **Stale affordances** | The breadboard shows something that no longer exists in the code or has changed |
| **Wrong causality** | The wiring shows A calls B, but the code shows C calls B |
| **Implementation mismatch** | The code has logic paths, functions, or call chains that are not represented in the breadboard |

The first three are visible from the breadboard and requirements alone. The last four require comparing to the implementation — read the actual code and check each affordance: does it exist? Does the wiring match what the code actually calls and returns? Is anything missing?

---

## Fixing Smells

### The Naming Test

The primary tool for finding and fixing affordance boundary problems.

For each affordance:

1. **Who is the caller?** Identify the user of this affordance.
2. **What is the step-level effect?** What does THIS affordance do — not the downstream chain, just its own direct effect?
3. **Name it with one verb.** Describe the step-level effect with a single, idiomatic English verb.

| Signal | Meaning |
|--------|---------|
| One verb covers all code paths | Boundary is correct |
| Need "or" to connect two verbs | Likely two affordances bundled together |
| Name doesn't feel idiomatic | Boundary is wrong |
| Name matches a downstream effect, not this step | The chain is being named, not the step |

Key distinction: name what THIS step does, not the downstream cascade. If stripping away all callees leaves just sequencing and branching, it is a handler — name it as such.

For detailed patterns (step-level vs chain-level effects, caller-perspective naming, external tools vs internal handlers, worked examples), consult `references/naming-test-details.md`.

### Splitting Affordances

When the naming test reveals a bundled affordance:

1. **Split in the code first.** Extract distinct operations into separate functions. Even one-liners are valid if they represent a distinct step-level effect.
2. **Then update the tables.** Add rows for new affordances with proper IDs, Wires Out, and Returns To.
3. **Then update the diagram.** The diagram renders the tables.

Never split only in the diagram (e.g., adding unnamed sub-nodes in a subgraph). If it is not a named function in the code and a row in the table, it is not a real affordance.

### Fixing Wiring

When the causality is wrong (A → B in the breadboard but C → B in the code):

1. Read the code to understand the actual call chain
2. Update the table first — move the wire to the correct source
3. Update the diagram to match
4. Re-trace the user story to confirm the wiring now tells a coherent story

---

## Verification

After any changes:

1. **Re-trace user stories.** Does the wiring now tell a coherent story for each requirement?
2. **Describe the wiring in prose.** Trace every claim against the tables and diagram. If the prose says "N4 calls N13" but the diagram does not show that wire, something was missed.
3. **Check wiring consistency:**
   - Every Wires Out target must exist in the tables
   - Every Returns To source must have a corresponding Wires Out from its caller
   - Solid lines for writes/calls (Wires Out), dashed for returns/reads (Returns To)
   - Every node in the diagram has a row in the affordance tables

---

## Additional Resources

### Reference Files

- **`references/naming-test-details.md`** — Step-level vs chain-level effects, caller-perspective naming, external vs internal handlers, worked naming resistance example

### Cross-Skill References

For the full element catalog (affordance types, relationship types, verification checks), consult the breadboarding skill's **`references/catalog.md`**. For Mermaid diagram conventions, consult **`references/visualization.md`**.
