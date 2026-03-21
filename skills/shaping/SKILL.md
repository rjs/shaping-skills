---
name: shaping
description: Use this methodology when collaboratively shaping a solution with the user - iterating on problem definition (requirements) and solution options (shapes).
---

# Shaping Methodology

A structured approach for collaboratively defining problems and exploring solution options.

---

## Multi-Level Consistency (Critical)

Shaping produces documents at different levels of abstraction. **Truth must stay consistent across all levels.**

### The Document Hierarchy (high to low)

1. **Shaping doc** — ground truth for R's, shapes, parts, fit checks
2. **Slices doc** — ground truth for slice definitions, breadboards
3. **Individual slice plans** (V1-plan, etc.) — ground truth for implementation details

### The Principle

Each level summarizes or provides a view into the level(s) below it. Lower levels contain more detail; higher levels are designed views that help acquire context quickly.

**Changes ripple in both directions:**

- **Change at high level → trickles down:** If you change the shaping doc's parts table, update the slices doc too.
- **Change at low level → trickles up:** If a slice plan reveals a new mechanism or changes the scope of a slice, the Slices doc and shaping doc must reflect that.

### The Practice

Whenever making a change:

1. **Identify which level you're touching**
2. **Ask: "Does this affect documents above or below?"**
3. **Update all affected levels in the same operation**
4. **Never let documents drift out of sync**

The system only works if the levels are consistent with each other.

---

## Starting a Session

When kicking off a new shaping session, offer the user both entry points:

- **Start from R (Requirements)** — Describe the problem, pain points, or constraints. Build up requirements and let shapes emerge.
- **Start from S (Shapes)** — Sketch a solution already in mind. Capture it as a shape and extract requirements as you go.

There is no required order. Shaping is iterative — R and S inform each other throughout.

## Working with an Existing Shaping Doc

When the shaping doc already has a selected shape:

1. **Display the fit check for the selected shape only** — Show R × [selected shape] (e.g., R × F), not all shapes
2. **Summarize what is unsolved** — Call out any requirements that are Undecided, or where the selected shape has ❌

This gives the user immediate context on where the shaping stands and what needs attention.

---

## Core Concepts

### R: Requirements
A numbered set defining the problem space.

- **R0, R1, R2...** are members of the requirements set
- Requirements are negotiated collaboratively - not filled in automatically
- Track status: Core goal, Undecided, Leaning yes/no, Must-have, Nice-to-have, Out
- Requirements extracted from fit checks should be made standalone (not dependent on any specific shape)
- **R states what's needed, not what's satisfied** — satisfaction is always shown in a fit check (R × S)
- **Chunking policy:** Never have more than 9 top-level requirements. When R exceeds 9, group related requirements into chunks with sub-requirements (R3.1, R3.2, etc.) so the top level stays at 9 or fewer. This keeps the requirements scannable and forces meaningful grouping.

### S: Shapes (Solution Options)
Letters represent mutually exclusive solution approaches.

- **A, B, C...** are top-level shape options (you pick one)
- **C1, C2, C3...** are components/parts of Shape C (they combine)
- **C3-A, C3-B, C3-C...** are alternative approaches to component C3 (you pick one)

### Shape Titles
Give shapes a short descriptive title that characterizes the approach. Display the title when showing the shape:

```markdown
## E: Modify CUR in place to follow S-CUR

| Part | Mechanism |
|------|-----------|
| E1 | ... |
```

Good titles capture the essence of the approach in a few words:
- ✅ "E: Modify CUR in place to follow S-CUR"
- ✅ "C: Two data sources with hybrid pagination"
- ❌ "E: The solution" (too vague)
- ❌ "E: Add search to widget-grid by swapping..." (too long)

### Notation Hierarchy

| Level | Notation | Meaning | Relationship |
|-------|----------|---------|--------------|
| Requirements | R0, R1, R2... | Problem constraints | Members of set R |
| Shapes | A, B, C... | Solution options | Pick one from S |
| Components | C1, C2, C3... | Parts of a shape | Combine within shape |
| Alternatives | C3-A, C3-B... | Approaches to a component | Pick one per component |

### Notation Persistence
Keep notation throughout as an audit trail. When finalizing, compose new options by referencing prior components (e.g., "Shape E = C1 + C2 + C3-A").

## Phases

Shaping moves through two phases:

```
Shaping → Slicing
```

| Phase | Purpose | Output |
|-------|---------|--------|
| **Shaping** | Explore the problem and solution space, select and detail a shape | Shaping doc with R, shapes, fit checks, breadboard |
| **Slicing** | Break down for implementation | Vertical slices with demo-able UI |

### Phase Transition

**Shaping → Slicing** happens when:
- A shape is selected (passes fit check, feels right)
- The shape has been breadboarded into concrete affordances
- We need to plan implementation order

You can't slice without a breadboarded shape.

---

## Fit Check (Decision Matrix)

THE fit check is the single table comparing all shapes against all requirements. Requirements are rows, shapes are columns. This is how we decide which shape to pursue.

### Format

```markdown
## Fit Check

| Req | Requirement | Status | A | B | C |
|-----|-------------|--------|---|---|---|
| R0 | Make items searchable from index page | Core goal | ✅ | ✅ | ✅ |
| R1 | State survives page refresh | Must-have | ✅ | ❌ | ✅ |
| R2 | Back button restores state | Must-have | ❌ | ✅ | ✅ |

**Notes:**
- A fails R2: [brief explanation]
- B fails R1: [brief explanation]
```

### Conventions
- **Always show full requirement text** — never abbreviate or summarize requirements in fit checks
- **Fit check is BINARY** — Use ✅ for pass, ❌ for fail. No other values.
- **Shape columns contain only ✅ or ❌** — no inline commentary; explanations go in Notes section
- **Never use ⚠️ or other symbols in fit check** — ⚠️ belongs only in the Parts table's flagged column
- Keep notes minimal — just explain failures

### Comparing Alternatives Within a Component

When comparing alternatives for a specific component (e.g., C3-A vs C3-B), use the same format but scoped to that component:

```markdown
## C3: Component Name

| Req | Requirement | Status | C3-A | C3-B |
|-----|-------------|--------|------|------|
| R1 | State survives page refresh | Must-have | ✅ | ❌ |
| R2 | Back button restores state | Must-have | ✅ | ✅ |
```

### Missing Requirements
If a shape passes all checks but still feels wrong, there's a missing requirement. Articulate the implicit constraint as a new R, then re-run the fit check.

### Macro Fit Check

A separate tool from the standard fit check, used when working at a high level with chunked requirements and early-stage shapes where most mechanisms are still ⚠️. Use when explicitly requested.

The macro fit check has two columns per shape instead of one:

- **Addressed?** — Does some part of the shape seem to speak to this requirement at a high level?
- **Answered?** — Can you trace the concrete how? Is the mechanism actually spelled out?

**Format:**

```markdown
## Macro Fit Check: R × A

| Req | Requirement | Addressed? | Answered? |
|-----|-------------|:----------:|:---------:|
| R0 | Core goal description | ✅ | ❌ |
| R1 | Guided workflow | ✅ | ❌ |
| R2 | Agent boundary | ⚠️ | ❌ |
```

**Conventions:**
- Only show top-level requirements (R0, R1, R2...), not sub-requirements
- **No notes column** — keep the table narrow and scannable
- Use ✅ (yes), ⚠️ (partially), ❌ (no) for Addressed
- Use ✅ (yes) or ❌ (no) for Answered
- Follow the macro fit check with a separate **Gaps** table listing specific missing parts and their related sub-requirements

## Possible Actions

These can happen in any order:

- **Populate R** - Gather requirements as they emerge
- **Sketch a shape** - Propose a high-level approach (A, B, C...)
- **Detail (components)** - Break a shape into components (B1, B2...)
- **Detail (affordances)** - Expand a selected shape into concrete UI/Non-UI affordances and wiring
- **Explore alternatives** - For a component, identify options (C3-A, C3-B...)
- **Check fit** - Build a fit check (decision matrix) playing options against R
- **Extract Rs** - When fit checks reveal implicit requirements, add them to R as standalone items
- **Breadboard** - Map the system to understand where changes happen and make the shape more concrete
- **Spike** - Investigate unknowns to identify concrete steps needed
- **Decide** - Pick alternatives, compose final solution
- **Slice** - Break a breadboarded shape into vertical slices for implementation

## Communication

### Show Full Tables

When displaying R (requirements) or any S (shapes), always show every row — never summarize or abbreviate. The full table is the artifact; partial views lose information and break the collaborative process.

- Show all requirements, even if many
- Show all shape parts, including sub-parts (E1.1, E1.2...)
- Show all alternatives in fit checks

### Why This Matters

Shaping is collaborative negotiation. The user needs to see the complete picture to:
- Spot missing requirements
- Notice inconsistencies
- Make informed decisions
- Track what's been decided

Summaries hide detail and shift control away from the user.

### Mark Changes with 🟡

When re-rendering a requirements table or shape table after making changes, mark every changed or added line with a 🟡 so the user can instantly spot what's different. Place the 🟡 at the start of the changed cell content. This makes iterative refinement easy to follow — the user should never have to diff the table mentally.

## Spikes

A spike is an investigation task to learn how the existing system works and what concrete steps are needed to implement a component. Use spikes when there's uncertainty about mechanics or feasibility.

### File Management

**Always create spikes in their own file** (e.g., `spike.md` or `spike-[topic].md`). Spikes are standalone investigation documents that may be shared or worked on independently from the shaping doc.

### Purpose

- Learn how the existing system works in the relevant area
- Identify **what we would need to do** to achieve a result
- Enable informed decisions about whether to proceed
- Not about effort — effort is implicit in the steps themselves
- **Investigate before proposing** — discover what already exists; you may find the system already satisfies requirements

### Structure

```markdown
## [Component] Spike: [Title]

### Context
Why we need this investigation. What problem we're solving.

### Goal
What we're trying to learn or identify.

### Questions

| # | Question |
|---|----------|
| **X1-Q1** | Specific question about mechanics |
| **X1-Q2** | Another specific question |

### Acceptance
Spike is complete when all questions are answered and we can describe [the understanding we'll have].
```

### Acceptance Guidelines

Acceptance describes the **information/understanding** we'll have, not a conclusion or decision:

- ✅ "...we can describe how users set their language and where non-English titles appear"
- ✅ "...we can describe the steps to implement [component]"
- ❌ "...we can answer whether this is a blocker" (that's a decision, not information)
- ❌ "...we can decide if we should proceed" (decision comes after the spike)

The spike gathers information; decisions are made afterward based on that information.

### Question Guidelines

Good spike questions ask about mechanics:
- "Where is the [X] logic?"
- "What changes are needed to [achieve Y]?"
- "How do we [perform Z]?"
- "Are there constraints that affect [approach]?"

Avoid:
- Effort estimates ("How long will this take?")
- Vague questions ("Is this hard?")
- Yes/no questions that don't reveal mechanics

## Breadboards

Use the `/breadboarding` skill to map existing systems or detail a shape into concrete affordances. Breadboarding produces:
- UI Affordances table
- Non-UI Affordances table
- Wiring diagram grouped by Place

Invoke breadboarding when you need to:
- Map existing code to understand where changes land
- Translate a high-level shape into concrete affordances
- Reveal orthogonal concerns (parts that are independent of each other)

### Tables Are the Source of Truth

The affordance tables (UI and Non-UI) define the breadboard. The Mermaid diagram renders them.

When receiving feedback on a breadboard:
1. **First** — update the affordance tables (add/remove/modify affordances, update Wires Out)
2. **Then** — update the Mermaid diagram to reflect those changes

Never treat the diagram as the primary artifact. Changes flow from tables → diagram, not the reverse.

### CURRENT as Reserved Shape Name

Use **CURRENT** to describe the existing system. This provides a baseline for understanding where proposed changes fit.

## Shape Parts

### Flagged Unknown (⚠️)

A mechanism can be described at a high level without being concretely understood. The **Flag** column tracks this:

| Part | Mechanism | Flag |
|------|-----------|:----:|
| **F1** | Create widget (component, def, register) | |
| **F2** | Magic authentication handler | ⚠️ |

- **Empty** = mechanism is understood — we know concretely how to build it
- **⚠️** = flagged unknown — we've described WHAT but don't yet know HOW

**Why flagged unknowns fail the fit check:**

1. **✅ is a claim of knowledge** — it means "we know how this shape satisfies this requirement"
2. **Satisfaction requires a mechanism** — some part that concretely delivers the requirement
3. **A flag means we don't know how** — we've described what we want, not how to build it
4. **You can't claim what you don't know** — therefore it must be ❌

Fit check is always binary — ✅ or ❌ only. There is no third state. A flagged unknown is a failure until resolved.

This distinguishes "we have a sketch" from "we actually know how to do this." Early shapes (A, B, C) often have many flagged parts — that's fine for exploration. But a selected shape should have no flags (all ❌ resolved), or explicit spikes to resolve them.

### Parts Must Be Mechanisms

Shape parts describe what we BUILD or CHANGE — not intentions or constraints:

- ✅ "Route `childType === 'letter'` to `typesenseService.rawSearch()`" (mechanism)
- ❌ "Types unchanged" (constraint — belongs in R)

### Avoid Tautologies Between R and S

**R** states the need/constraint (what outcome). **S** describes the mechanism (how to achieve it). If they say the same thing, the shape part isn't adding information.

- ❌ R17: "Admins can bulk request members to sign" + C6.3: "Admin can bulk request members to sign"
- ✅ R17: "Admins can bring existing members into waiver tracking" + C6.3: "Bulk request UI with member filters, creates WaiverRequests in batch"

The requirement describes the capability needed. The shape part describes the concrete mechanism that provides it. If you find yourself copying text from R into S, stop — the shape part should add specificity about *how*.

### Parts Should Be Vertical Slices

Avoid horizontal layers like "Data model" that group all tables together. Instead, co-locate data models with the features they support:

- ❌ **B4: Data model** — Waivers table, WaiverSignatures table, WaiverRequests table
- ✅ **B1: Signing handler** — includes WaiverSignatures table + handler logic
- ✅ **B5: Request tracking** — includes WaiverRequests table + tracking logic

Each part should be a vertical slice containing the mechanism AND the data it needs.

### Extract Shared Logic

When the same logic appears in multiple parts, extract it as a standalone part that others reference:

- ❌ Duplicating "Signing handler: create WaiverSignature + set boolean" in B1 and B2
- ✅ Extract as **B1: Signing handler**, then B2 and B3 say "→ calls B1"

```markdown
| **B1** | **Signing handler** |
| B1.1 | WaiverSignatures table: memberId, waiverId, signedAt |
| B1.2 | Handler: create WaiverSignature + set member.waiverUpToDate = true |
| **B2** | **Self-serve signing** |
| B2 | Self-serve purchase: click to sign inline → calls B1 |
| **B3** | **POS signing via email** |
| B3.1 | POS purchase: send waiver email |
| B3.2 | Passwordless link to sign → calls B1 |
```

### Hierarchical Notation

Start with flat notation (E1, E2, E3...). Only introduce hierarchy (E1.1, E1.2...) when:

- There are too many parts to easily understand
- You're reaching a conclusion and want to show structure
- Grouping related mechanisms aids communication

| Notation | Meaning |
|----------|---------|
| E1 | Top-level component of shape E |
| E1.1, E1.2 | Sub-parts of E1 (add later if needed) |

Example of hierarchical grouping (used when shape is mature):

| Part | Mechanism |
|------|-----------|
| **E1** | **Swap data source** |
| E1.1 | Modify backend indexer |
| E1.2 | Route letters to new service |
| E1.3 | Route posts to new service |
| **E2** | **Add search input** |
| E2.1 | Add input with debounce |

## Detailing a Shape

When a shape is selected, you can expand it into concrete affordances. This is called **detailing**.

### Notation

Use "Detail X" (not a new letter) to show this is a breakdown of Shape X, not an alternative:

```markdown
## A: First approach
(shape table)

## B: Second approach
(shape table)

## Detail B: Concrete affordances
(affordance tables + wiring)
```

### What Detailing Produces

Use the `/breadboarding` skill to produce:
- **UI Affordances table** — Things users see and interact with (inputs, buttons, displays)
- **Non-UI Affordances table** — Data stores, handlers, queries, services
- **Wiring diagram** — How affordances connect across places

### Why "Detail X" Not "C"

Shape letters (A, B, C...) are **mutually exclusive alternatives** — you pick one. Detailing is not an alternative; it's a deeper breakdown of the selected shape. Using a new letter would incorrectly suggest it's a sibling option.

```
A, B, C = alternatives (pick one)
Detail B = expansion of B (not a choice)
```

## Documents

Shaping produces up to four documents. Each has a distinct role:

| Document | Contains | Purpose |
|----------|----------|---------|
| **Frame** | Source, Problem, Outcome | The "why" — concise, stakeholder-level |
| **Shaping doc** | Requirements, Shapes (CURRENT/A/B/...), Affordances, Breadboard, Fit Check | The working document — exploration and iteration happen here |
| **Slices doc** | Slice details, affordance tables per slice, wiring diagrams | The implementation plan — how to build incrementally |
| **Slice plans** | V1-plan.md, V2-plan.md, etc. | Individual implementation plans for each slice |

### Document Lifecycle

```
Frame (problem/outcome)
    ↓
Shaping (explore, detail, breadboard)
    ↓
Slices (plan implementation)
```

**Frame** can be written first — it captures the "why" before any solution work begins. It contains:
- **Source** — Original requests, quotes, or material that prompted the work (verbatim)
- **Problem** — What's broken, what pain exists (distilled from source)
- **Outcome** — What success looks like (high-level, not solution-specific)

### Capturing Source Material

When the user provides source material during framing (user requests, quotes, emails, slack messages, etc.), **always capture it verbatim** in a Source section at the top of the frame document.

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

**Shaping doc** is where active work happens. All exploration, requirements gathering, shape comparison, breadboarding, and fit checking happens here. This is the working document and ground truth for R, shapes, parts, and fit checks.

**Slices doc** is created when the selected shape is breadboarded and ready to build. It contains the slice breakdown, affordance tables per slice, and detailed wiring.

### File Management

- **Shaping doc**: Update freely as you iterate — this is the ground truth
- **Slices doc**: Created when ready to slice, updated as slice scope clarifies
- **Slice plans**: Individual files (V1-plan.md, etc.) with implementation details

### Frontmatter

Every shaping document (shaping doc, frame, slices doc) must include `shaping: true` in its YAML frontmatter. This enables tooling hooks (e.g., ripple-check reminders) that help maintain consistency across documents.

```markdown
---
shaping: true
---

# [Feature Name] — Shaping
...
```

### Keeping Documents in Sync

See **Multi-Level Consistency** at the top of this document. Changes at any level must ripple to affected levels above and below.

## Slicing

After a shape is breadboarded, slice it into vertical implementation increments. Use the `/breadboarding` skill for the slicing process — it defines what vertical slices are, the procedure for creating them, and visualization formats.

**The flow:**
1. **Parts** → high-level mechanisms in the shape
2. **Breadboard** → concrete affordances with wiring (use `/breadboarding`)
3. **Slices** → vertical increments that can each be demoed (use `/breadboarding` slicing section)

**Key principle:** Every slice must end in demo-able UI. A slice without visible output is a horizontal layer, not a vertical slice.

**Document outputs:**
- **Slices doc** — slice definitions, per-slice affordance tables, sliced breadboard
- **Slice plans** — individual implementation plans (V1-plan.md, V2-plan.md, etc.)

## Example

User is shaping a search feature:

```markdown
---
shaping: true
---

## Requirements (R)

| ID | Requirement | Status |
|----|-------------|--------|
| R0 | Make items searchable from index page | Core goal |
| R1 | State survives page refresh | Undecided |
| R2 | Back button restores state | Undecided |

---

## C2: State Persistence

| Req | Requirement | Status | C2-A | C2-B | C2-C |
|-----|-------------|--------|------|------|------|
| R0 | Make items searchable from index page | Core goal | — | — | — |
| R1 | State survives page refresh | Undecided | ✅ | ✅ | ❌ |
| R2 | Back button restores state | Undecided | ✅ | ✅ | ✅ |

**Notes:**
- C2-C fails R1: in-memory state lost on refresh
- C2-B satisfies R2 but requires custom popstate handler
```
