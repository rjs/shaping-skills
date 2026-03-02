# Shaping Documents

Shaping produces up to four documents. Each has a distinct role.

---

## Document Types

| Document | Contains | Purpose |
|----------|----------|---------|
| **Frame** | Source, Problem, Outcome | The "why" — concise, stakeholder-level |
| **Shaping doc** | Requirements, Shapes (CURRENT/A/B/...), Affordances, Breadboard, Fit Check | The working document — exploration and iteration happen here |
| **Slices doc** | Slice details, affordance tables per slice, wiring diagrams | The implementation plan — how to build incrementally |
| **Slice plans** | V1-plan.md, V2-plan.md, etc. | Individual implementation plans for each slice |

## Document Lifecycle

```
Frame (problem/outcome)
    ↓
Shaping (explore, detail, breadboard)
    ↓
Slices (plan implementation)
```

**Frame** can be written first — it captures the "why" before any solution work begins. It contains:
- **Source** — Original requests, quotes, or material that prompted the work (verbatim)
- **Problem** — What is broken, what pain exists (distilled from source)
- **Outcome** — What success looks like (high-level, not solution-specific)

## Capturing Source Material

When source material is provided during framing (user requests, quotes, emails, slack messages, etc.), **always capture it verbatim** in a Source section at the top of the frame document.

```markdown
## Source

> I'd like to ask again for your thoughts on a user scenario...
>
> Small reminder: at the moment, if I want to keep my country admin rights
> for Russia and Crimea while having Europe Center as my home center...

> [Additional source material added as received]

---

## Problem
...
```

**Why this matters:**
- The source is the ground truth — Problem/Outcome are interpretations
- Preserves context that may be relevant later
- Allows revisiting the original request if the distillation missed something
- Multiple sources can be added as they arrive during framing

**When to capture:**
- User pastes a request or quote
- User shares an email or message from a stakeholder
- User describes a scenario they were told about
- Any raw material that informs the frame

## Document Roles

**Shaping doc** is where active work happens. All exploration, requirements gathering, shape comparison, breadboarding, and fit checking happens here. This is the working document and ground truth for R, shapes, parts, and fit checks.

**Slices doc** is created when the selected shape is breadboarded and ready to build. It contains the slice breakdown, affordance tables per slice, and detailed wiring.

## File Management

- **Shaping doc**: Update freely during iteration — this is the ground truth
- **Slices doc**: Created when ready to slice, updated as slice scope clarifies
- **Slice plans**: Individual files (V1-plan.md, etc.) with implementation details

## Frontmatter

Every shaping document (shaping doc, frame, slices doc) must include `shaping: true` in its YAML frontmatter. This enables tooling hooks (e.g., ripple-check reminders) that help maintain consistency across documents.

```markdown
---
shaping: true
---

# [Feature Name] — Shaping
...
```

## Keeping Documents in Sync

See **Multi-Level Consistency** in the main shaping skill. Changes at any level must ripple to affected levels above and below.
