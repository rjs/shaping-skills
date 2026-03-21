---
name: breadboard-reflection
description: Reflect on a breadboard by syncing it to the implementation, then finding and fixing design smells. Works on existing breadboards built with the /breadboarding skill.
---

# Breadboard Analysis

Reflect on a breadboard by syncing it to the implementation, then finding and fixing design smells. Works on existing breadboards built with the `/breadboarding` skill.

---

## What a Breadboard Is

A breadboard should be a legible explanation of how the system produces its effects. When you look at it, you should be able to account for every behavior — not just see that an effect happens, but understand *how* it happens through the wiring.

When someone's mental model of how the system behaves doesn't match what the breadboard shows, either their model is wrong or the breadboard is incomplete. A smell is that gap — you expect to see work being done (data transformed, decisions made, state managed) and the breadboard doesn't show it. Each question that probes the gap ("what generates this data?", "where is this defined?", "who calls this?") is testing the mental model against the artifact.

The breadboard is complete when it can explain every behavior without hidden steps.

---

## Core Checklist

Reflection is a two-phase loop: **SEE, then REFLECT.** Always in this order.

### Phase 1: SEE — Sync breadboard to the implementation

The code is ground truth. The breadboard may have drifted or been built from a conceptual shape that doesn't match what was actually implemented. Before looking for design problems, make the breadboard accurate.

1. **Read the implementation code.** Find the relevant source files. Don't rely on the breadboard's current description of what the code does.
2. **Inspect the seams.** Walk the code using the checklist in "Reading Seams from the Implementation" below — module boundaries, module-level definitions, function signatures, full call chains, decorators, state co-access.
3. **Update the breadboard to match.** Add missing nodes, stores, and places. Fix wrong wiring. Remove stale affordances. The goal is: the breadboard now accurately reflects the code's actual structure — even if that structure has problems.

After Phase 1, the breadboard shows what IS, not what should be.

### Phase 2: REFLECT — Find and fix design smells

Phase 1 is preparation. Phase 2 is the point. Do not skip it.

Now that the breadboard is accurate, inspect it for design problems. The code's names might be wrong. The split of responsibilities might not be ideal. The wiring might reveal unnecessary coupling or missing abstractions. Walk through each of these concrete checks:

1. **Trace user stories through the wiring.** Does the path tell a coherent story? Can you explain every behavior without hidden steps?
2. **Run the naming test on every affordance.** For each node: who is the caller, what is the step-level effect, can you name it with one idiomatic verb? Flag any that resist naming. (See "The Naming Test" in Phase 2 details below.)
3. **Check for hidden data stores.** For every module-level constant, config object, or template that an affordance reads: is it in the Data Stores table? If code reads it to produce effects, it's a store — even if it's static. Ask: "what does this affordance need to know in order to do its job?" If the answer references something not in the breadboard, it's missing.
4. **Question the places.** For each place: does everything in it share a single responsibility? Do state and affordances within it co-access each other and stay isolated from other places? If a cluster of affordances, state, and UI elements all serve one job (e.g., "turn natural language into structured commands"), they might deserve their own place — even if the code doesn't separate them yet.
5. **Check the smells table.** Unexplained behavior, incoherent wiring, naming resistance, etc.
6. **Fix smells.** Split, merge, rename, or rewire affordances. Update the breadboard.
7. **Optionally update the code.** If the breadboard reveals a better design, refactor the implementation to match.

The loop: SEE what the code actually does → REFLECT on whether that design is right → fix the breadboard → optionally fix the code → repeat.

---

## Phase 1: SEE — Read Seams from the Implementation

The code is ground truth. Read it before judging the breadboard.

### What to Look For

**1. Module boundaries are seams.** Each file or module is a boundary the code has already chosen. Check what crosses it — that's a public interface, and the breadboard should show it. If a module exists (e.g., `llm.py` separate from `app.py`), the breadboard shouldn't reach through it to grab internals. The module's public function is the affordance; what it calls internally is behind the boundary.

**2. Module-level definitions are data stores.** Constants, configurations, and templates at the top of a module — `TOOLS`, `SYSTEM_PROMPT`, `DEFAULTS` — are static state that shapes behavior. If code reads them to produce effects, they belong in the breadboard as stores. They're easy to miss because they don't change at runtime, but they define what the system can do.

**3. Function signatures are contracts.** The types tell you what data flows across boundaries. When a function's return type differs from what its downstream dependency returns (e.g., `send_command` returns `list[dict]` but `ollama.chat` returns a Response object), there's a transformation happening. That transformation is work the breadboard should account for. Name it.

**4. Trace the full call chain, not just endpoints.** Don't jump from the UI event to the external service to the executor. Walk every function in the chain. Each one exists for a reason — orchestration, state management, data transformation, error handling. The ones that do real work (not just forwarding) are affordances. Skipping intermediate functions because they look like "glue" hides the explanation.

**5. Decorators and patterns signal architectural roles.** `@work(thread=True)` means background worker. `try/except` wrappers mean error boundary. `async` means concurrency management. These aren't just implementation details — they tell you a function has a specific role in the system's architecture. An event handler that delegates to a `@work` function is two distinct things: a trigger and an orchestrator.

**6. State that co-accesses suggests places.** Which functions and state are used together but don't touch other parts of the system? If `loading`, `TOOLS`, and `SYSTEM_PROMPT` are all accessed by the command input flow and never by the table display, they cluster into a candidate place. Places emerge from co-access patterns, not just from UI layout.

### The Underlying Principle

A breadboard designed from a conceptual shape ("user types, LLM processes, app executes") will be a flat pipeline. The code is more specific — it has already decided where the seams are through module splits, function extractions, and static configuration. When a breadboard exists alongside code, read the code's seams and check that the breadboard accounts for them. Not every function needs a node, but every module boundary, every data transformation, and every piece of static configuration that shapes behavior should show up somewhere.

### Updating the Breadboard

After inspecting the code, update the breadboard to match what IS:
- Add missing nodes for functions the breadboard skipped
- Add missing stores for constants and configuration the breadboard ignored
- Fix wiring to match actual call chains
- Add or restructure places based on state co-access

Do NOT fix design problems yet. The goal of Phase 1 is an accurate picture, even if the design has issues.

---

## Phase 2: REFLECT — Find and Fix Design Smells

Now the breadboard is accurate. The code's names might be wrong, the split of responsibilities might not be ideal, the wiring might reveal unnecessary coupling. This is where you judge the design.

### Trace User Stories Through the Wiring

Take a user story from the requirements or frame. Trace it through the breadboard wiring. Ask: does the path tell a coherent story that produces the expected effect?

Example: "User says 'add Tokyo after Detroit' → Tokyo appears after Detroit in the table, and persists across restarts."

Trace: U4 (input) → N1 → N2 (LLM) → N3 (dispatch) → N4 (handle) → ... → S1 (locales updated) → N12 (persist) → S4 (config written).

At each link, ask: does this step logically lead to the next? Does the wiring make sense as a story about how the effect happens?

### What Smells Look Like

| Smell | What you notice |
|-------|-----------------|
| **Unexplained behavior** | You know the system does something (transforms data, makes decisions) but the breadboard doesn't show how — the explanation is missing |
| **Incoherent wiring** | A node writes to S1 AND triggers the thing that writes to S1 — redundant or contradictory |
| **Missing path** | The user story requires an effect, but no wiring path produces it |
| **Diagram-only nodes** | Nodes in the diagram that aren't in the affordance tables — decoration, not real affordances |
| **Naming resistance** | You can't name an affordance with one idiomatic verb (see Naming Test below) |
| **Stale affordances** | The breadboard shows something that no longer exists in the code — should have been caught in Phase 1 |
| **Wrong causality** | The wiring shows A calls B, but the code shows C calls B — should have been caught in Phase 1 |

The first five are design smells — the code works but the design could be better. The last two are accuracy problems that Phase 1 should have caught; if you find them here, go back to Phase 1.

### Fixing Smells

#### The Naming Test

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
| Name matches a downstream effect, not this step | You're naming the chain, not the step |

#### Step-Level vs Chain-Level Effects

Name what THIS step does, not the downstream cascade.

**Chain-level** (wrong): An orchestrator that calls validate, find, extract, and insert is named `add_locale` — but it doesn't add anything itself. Adding is the chain's effect.

**Step-level** (right): The orchestrator's own effect is handling/dispatching → `handle_place_locale`. The adding happens downstream.

How to check:
1. List everything the affordance calls downstream
2. Remove all of that — what's left?
3. Name what's left

If what's left is just sequencing and branching, it's a handler. Name it as such.

#### Caller-Perspective Naming

Names should reflect what the affordance affords from the caller's perspective — the effect the caller achieves by using it.

| Perspective | Question | Example |
|-------------|----------|---------|
| **Caller** | "What can I achieve by calling this?" | N3 calls N4 → "handle place_locale tool call" |
| **Step** | "What does this function do, not its callees?" | N4 itself → "dispatch to validate, resolve, insert" |
| **Effect** | "What changes in the system after this runs?" | N15 → "locale is extracted from its position" |

#### External Tools vs Internal Handlers

A tool exposed to an external caller (like an LLM) should be named for the effect the caller wants: `place_locale` — the caller wants to place a locale.

The internal handler that processes that tool call should be named for its own role: `handle_place_locale` — it handles the dispatch, delegating work to sub-steps.

#### Example: Naming Resistance as a Signal

A function `resolve_locale` either pops an existing locale from a list OR creates a new dict:

- "Take" fits the pop path but "take into existence" isn't idiomatic English
- "Create" fits the new path but not the pop
- Need "or" → split into two affordances: `extract_locale` (pop) and `create_locale` (new)

The inability to find one idiomatic verb was the signal that this was two distinct operations forced into one function.

#### Splitting Affordances

When the naming test reveals a bundled affordance:

1. **Split in the code first.** Extract distinct operations into separate functions. Even one-liners are valid if they represent a distinct step-level effect.
2. **Then update the tables.** Add rows for new affordances with proper IDs, Wires Out, and Returns To.
3. **Then update the diagram.** The diagram renders the tables.

Never split only in the diagram (e.g., adding unnamed sub-nodes in a subgraph). If it's not a named function in the code and a row in the table, it's not a real affordance.

#### Fixing Wiring

When the causality is wrong (A → B in the breadboard but C → B in the code):

1. Read the code to understand the actual call chain.
2. Update the table first — move the wire to the correct source.
3. Update the diagram to match.
4. Re-trace the user story to confirm the wiring now tells a coherent story.

---

## Verification

After any changes:

1. **Re-trace user stories.** Does the wiring now tell a coherent story for each requirement?
2. **Describe the wiring in prose.** Trace every claim against the tables and diagram. If the prose says "N4 calls N13" but the diagram doesn't show that wire, something was missed.
3. **Check wiring consistency:**
   - Every Wires Out target must exist in the tables
   - Every Returns To source must have a corresponding Wires Out from its caller
   - Solid lines for writes/calls (Wires Out), dashed for returns/reads (Returns To)
   - Every node in the diagram has a row in the affordance tables
