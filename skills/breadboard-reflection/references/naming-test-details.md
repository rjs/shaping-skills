# Naming Test — Detailed Patterns

Expanded examples and patterns for the naming test. Consult this when applying the naming test to specific affordances.

---

## Step-Level vs Chain-Level Effects

Name what THIS step does, not the downstream cascade.

**Chain-level** (wrong): An orchestrator that calls validate, find, extract, and insert is named `add_locale` — but it does not add anything itself. Adding is the chain's effect.

**Step-level** (right): The orchestrator's own effect is handling/dispatching → `handle_place_locale`. The adding happens downstream.

How to check:
1. List everything the affordance calls downstream
2. Remove all of that — what's left?
3. Name what's left

If what is left is just sequencing and branching, it is a handler. Name it as such.

## Caller-Perspective Naming

Names should reflect what the affordance affords from the caller's perspective — the effect the caller achieves by using it.

| Perspective | Question | Example |
|-------------|----------|---------|
| **Caller** | "What can I achieve by calling this?" | N3 calls N4 → "handle place_locale tool call" |
| **Step** | "What does this function do, not its callees?" | N4 itself → "dispatch to validate, resolve, insert" |
| **Effect** | "What changes in the system after this runs?" | N15 → "locale is extracted from its position" |

## External Tools vs Internal Handlers

A tool exposed to an external caller (like an LLM) should be named for the effect the caller wants: `place_locale` — the caller wants to place a locale.

The internal handler that processes that tool call should be named for its own role: `handle_place_locale` — it handles the dispatch, delegating work to sub-steps.

## Example: Naming Resistance as a Signal

A function `resolve_locale` either pops an existing locale from a list OR creates a new dict:

- "Take" fits the pop path but "take into existence" is not idiomatic English
- "Create" fits the new path but not the pop
- Need "or" → split into two affordances: `extract_locale` (pop) and `create_locale` (new)

The inability to find one idiomatic verb was the signal that this was two distinct operations forced into one function.
