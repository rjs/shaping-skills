---
name: breadboarding
description: This skill should be used when the user asks to "breadboard a system", "map affordances", "create an affordance table", "trace wiring", "slice a breadboard", "map an existing system", or mentions UI/Code affordances, wiring diagrams, place-based modeling, or converting workflows into affordance tables.
---

# Breadboarding

Breadboarding transforms a workflow description into a complete map of affordances and their relationships. The output is always a set of tables showing numbered UI and Code affordances with their Wires Out and Returns To relationships. The tables are the truth. Mermaid diagrams are optional visualizations for humans.

---

## Use Cases

### 1. Mapping an Existing System

The concrete details of an existing system are not understood. There is a workflow to trace — explaining how something happens or why something does not happen.

**Input:**
- Code repo(s) to analyze
- Workflow description (always from the perspective of an operator trying to make an effect happen — through UI or as a caller)

**Output:**
- UI Affordances table
- Code Affordances table
- (Optional) Mermaid visualization

**Note:** If the workflow spans multiple applications (frontend + backend), create ONE breadboard that tells the full story. Label places to show which system they belong to.

### 2. Designing from Shaped Parts

A new system is sketched as an assembly of parts (mechanisms) per shaping. The concrete mechanism needs to be detailed out to show how those parts interact as a system.

**Input:**
- Parts list (mechanisms from shaping)
- The R (requirement/outcome) the parts are meant to achieve
- Existing system (optional) — if the new parts must interoperate with existing code

**Output:**
- UI Affordances table
- Code Affordances table
- (Optional) Mermaid visualization

### Mixtures

Often both exist: an existing system that must remain as-is, plus new pieces or changes defined in a shape. In this case, breadboard both together — the existing affordances and the new ones — showing how they connect.

### 3. Reading a Whiteboard Breadboard

Hand-drawn or whiteboard breadboards use a visual stacking format rather than tables. The same concepts apply (Places, affordances, wiring) but the layout conventions differ. Consult **`references/whiteboard-reading.md`** for visual conventions and translation procedures.

---

## Core Concepts

### Places

A Place is a **bounded context of interaction**. While in a Place:
- A specific set of affordances is available
- Affordances outside that boundary **cannot** be interacted with
- An action must be taken to leave

**Place is perceptual, not technical.** It is not about URLs or components — it is about what the user experiences as their current context. A Place is "where you are" in terms of what you can do right now.

#### The Blocking Test

The simplest test for whether something is a different Place: **Can the user interact with what's behind?**

| Answer | Meaning |
|--------|---------|
| **No** | Different Place |
| **Yes** | Same Place, with local state changes |

#### Examples

| UI Element | Blocking? | Place? | Why |
|------------|-----------|--------|-----|
| Modal | Yes | Yes | Can't interact with page behind |
| Confirmation popover | Yes | Yes | Must respond before returning (limit case of modal) |
| Edit mode (whole screen transforms) | Yes | Yes | All affordances changed |
| Checkbox reveals extra fields | No | No | Surroundings unchanged |
| Dropdown menu | No | No | Can click away, non-blocking |
| Tooltip | No | No | Informational, non-blocking |

#### Local State vs Place Navigation

When a control changes state, ask: did *everything* change, or just a subset while the surroundings stayed the same?

| Type | What happens | How to model |
|------|--------------|--------------|
| **Local state** | Subset of UI changes, surroundings unchanged | Same Place, conditional N → dependent Us |
| **Place navigation** | Entire screen transforms, or blocking overlay | Different Places |

#### Mode-Based Places

When a mode (like "edit mode") transforms the entire screen — different buttons, different affordances everywhere — model as separate Places:

```
PLACE: CMS Page (Read Mode)
PLACE: CMS Page (Edit Mode)
```

The state flag (e.g., `editMode$`) that switches between them is a **navigation mechanism**, not a data store. Do not include it as an S in either Place.

#### Three Questions for Any Control

For any UI affordance, ask:
1. Where did I come from to see this?
2. Where am I now?
3. Where do I go if I act on it?

If the answer to #3 is "everything changes" or "I can't interact with what's behind until I respond," that is navigation to a different Place.

#### Labeling Conventions

| Pattern | Use |
|---------|-----|
| `PLACE: Page Name` | Standard page/route |
| `PLACE: Page Name (Mode)` | Mode-based variant of a page |
| `PLACE: Modal Name` | Modal dialog |
| `PLACE: Backend` | API/database boundary |

When spanning multiple systems, label with the system: `PLACE: Checkout Page (frontend)`, `PLACE: Payment API (backend)`.

For advanced place modeling (Place IDs, Place References, Subplaces, Navigation Wiring), consult **`references/advanced-places.md`**.

### Affordances

Things that can be acted upon:
- **UI affordances (U)**: inputs, buttons, displayed elements, scroll regions
- **Code affordances (N)**: methods, subscriptions, data stores, framework mechanisms

### Wiring

How affordances connect to each other:

**Wires Out** — What an affordance triggers or calls (control flow):
- Call wires: one affordance calls another
- Write wires: code writes to a data store
- Navigation wires: routing to a different place

**Returns To** — Where an affordance's output flows (data flow):
- Return wires: function returns value to its caller
- Read wires: data store is read by another affordance

This separation makes data flow explicit. Wires Out show control flow (what triggers what). Returns To show data flow (where output goes).

### Containment vs Wiring

| Relationship | Meaning | Where Captured |
|--------------|---------|----------------|
| **Containment** | Affordance belongs to / lives in a Place | **Place column** (set membership) |
| **Wiring** | Affordance triggers / calls something | **Wires Out column** (control flow) |

**Containment** is set membership: `U1 ∈ P1` means U1 is a member of Place P1. Every affordance belongs to exactly one Place.

**Wiring** is control flow: `U1 → N1` means U1 triggers N1. An affordance can wire to anything — other affordances or Places.

---

## The Output: Affordance Tables

The tables are the truth. Every breadboard produces these:

### Places Table

| # | Place | Description |
|---|-------|-------------|
| P1 | Search Page | Main search interface |
| P2 | Detail Page | Individual result view |

### UI Affordances Table

| # | Place | Component | Affordance | Control | Wires Out | Returns To |
|---|-------|-----------|------------|---------|-----------|------------|
| U1 | P1 | search-detail | search input | type | → N1 | — |
| U2 | P1 | search-detail | loading spinner | render | — | — |
| U3 | P1 | search-detail | results list | render | — | — |
| U4 | P1 | search-detail | result row | click | → P2 | — |

### Code Affordances Table

| # | Place | Component | Affordance | Control | Wires Out | Returns To |
|---|-------|-----------|------------|---------|-----------|------------|
| N1 | P1 | search-detail | `activeQuery.next()` | call | → N2 | — |
| N2 | P1 | search-detail | `activeQuery` subscription | observe | → N3 | — |
| N3 | P1 | search-detail | `performSearch()` | call | → N4, → N5, → N6 | — |
| N4 | P1 | search.service | `searchOneCategory()` | call | → N7 | → N3 |
| N5 | P1 | search-detail | `loading` | write | store | → U2 |
| N6 | P1 | search-detail | `results` | write | store | → U3 |
| N7 | P1 | typesense.service | `rawSearch()` | call | — | → N4 |

### Data Stores Table

| # | Place | Store | Description |
|---|-------|-------|-------------|
| S1 | P1 | `results` | Array of search results |
| S2 | P1 | `loading` | Boolean loading state |

### Column Definitions

| Column | Description |
|--------|-------------|
| **#** | Unique ID (P1, P2... for Places; U1, U2... for UI; N1, N2... for Code; S1, S2... for Stores) |
| **Place** | Which Place this affordance belongs to (containment) |
| **Component** | Which component/service owns this |
| **Affordance** | The specific thing that can be acted upon |
| **Control** | The triggering event: click, type, call, observe, write, render |
| **Wires Out** | What this triggers: `→ N4`, `→ P2` (control flow, including navigation) |
| **Returns To** | Where output flows: `→ N3` or `→ U2, U3` (data flow) |

---

## Procedures

### For Mapping an Existing System

**Step 1: Identify the flow to analyze** — Pick a specific user journey. Always frame it as an operator trying to do something.

**Step 2: List all places involved** — Walk through the journey and identify each distinct place the user visits or system boundary crossed.

**Step 3: Trace through the code to find components** — Starting from the entry point (route, API endpoint), trace through the code to find every component touched by that flow.

**Step 4: For each component, list its affordances** — Read the code. Identify UI (what can the user see and interact with?) and Code (what methods, subscriptions, stores are involved?).

**Step 5: Name the actual thing, not an abstraction** — If writing "DATABASE", stop. What is the actual method? (`userRepo.save()`). Every affordance name must be something real that can be pointed to in the code.

**Step 6: Fill in Control column** — For each affordance, what triggers it? (click, type, call, observe, write, render)

**Step 7: Fill in Wires Out** — For each affordance, what does it trigger? Read the code — what does this method call? What does this button's handler invoke?

**Step 8: Fill in Returns To** — For each affordance, where does its output flow? Functions that return values → list the callers that receive the return. Data stores → list the affordances that read from them. No meaningful output → use `—`.

**Step 9: Add data stores as affordances** — When code writes to a property that is later read by another affordance, add that property as a Code affordance with control type `write`.

**Step 10: Add framework mechanisms as affordances** — Include things like `cdr.detectChanges()` that bridge between code and UI rendering. These show how state changes actually reach the UI.

**Step 11: Verify against the code** — Read the code again. Confirm every affordance exists and the wiring matches reality.

### For Designing from Shaped Parts

**Step 1: List each part from the shape** — Take each mechanism/part identified in shaping.

**Step 2: Translate parts into affordances** — For each part, identify what UI affordances and Code affordances it requires.

**Step 3: Verify every U has a supporting N** — For each UI affordance, check: what Code affordance provides its data or controls its rendering? If none exists, add the missing N.

**Step 4: Classify places as existing or new** — For each UI affordance, determine whether it lives in an existing place being modified or a new place being created.

**Step 5: Wire the affordances** — Fill in Wires Out and Returns To for each affordance. Trace through the intended behavior.

**Step 6: Connect to existing system (if applicable)** — Identify the existing affordances the new ones must connect to. Add those existing affordances to the tables and wire them.

**Step 7: Check for completeness** — Every U should have an N that feeds it. Every N should have either Wires Out or Returns To (or both). Handlers → should have Wires Out. Queries → should have Returns To. Data stores → should have Returns To.

**Step 8: Treat user-visible outputs as Us** — Anything the user sees (including emails, notifications) is a UI affordance and needs an N wiring to it.

---

## Key Principles

### Never use memory — always check the data

When tracing a flow backwards, do not follow the remembered path. Scan the Wires Out column for ALL affordances that wire to the target. The tables are the source of truth. Memory is unreliable.

### Every affordance name must exist (when mapping)

When mapping existing code, never invent abstractions. Every name must point to something real in the codebase.

### Mechanisms are not affordances

An affordance is something that can be **acted upon** with meaningful identity in the system. Several things look like affordances but are actually implementation mechanisms:

| Type | Example | Why it is not an affordance |
|------|---------|---------------------------|
| Visual containers | `modal-frame wrapper` | Cannot act on a wrapper — it is just a Place boundary |
| Internal transforms | `letterDataTransform()` | Implementation detail of the caller — not separately actionable |
| Navigation mechanisms | `modalService.open()` | Just the "how" of getting to a Place — wire to the destination directly |

```
❌ N8 --> N22 --> P3     (N22 is modalService.open — just mechanism)
✅ N8 --> P3             (handler navigates to modal)

❌ N6 --> N20 --> S2     (N20 is data transform — internal to N6)
✅ N6 --> S2             (callback writes to store)
```

### Two flows: Navigation and Data

A breadboard captures two distinct flows:

| Flow | What it tracks | Wiring |
|------|----------------|--------|
| **Navigation** | Movement from Place to Place | Wires Out → Places |
| **Data** | How state populates displays | Returns To → Us |

When reviewing a breadboard, trace both flows independently.

### Every U that displays data needs a source

A UI affordance that displays data must have something feeding it — either a data store (S) or a code affordance (N) that returns data. If a display U has no data source wiring into it, either the source is missing from the breadboard or the U is not real.

### Every N must connect

If a Code affordance has no Wires Out AND no Returns To, something is wrong. Handlers → should have Wires Out. Queries → should have Returns To. Data stores → should have Returns To.

### Side effects need stores

An N that appears to wire nowhere is suspicious. If it has **side effects outside the system boundary** (browser URL, localStorage, external API, analytics), add a **store node** to represent that external state. Common external stores: `Browser URL`, `localStorage`, `sessionStorage`, `Clipboard`, `Browser History`.

### Separate control flow from data flow

Wires Out = control flow (what triggers what). Returns To = data flow (where output goes). This separation makes the system's behavior explicit.

### Place stores where they enable behavior

A data store belongs in the Place where its data is *consumed* to enable some effect — not where it is produced. Writes from other Places are "reaching into" that Place's state. Trace read/write relationships; the readers determine placement.

### Backend is a Place

The database and resolvers are not floating infrastructure — they are a Place with their own affordances. Database tables (S) belong inside the Backend Place alongside the resolvers (N) that read and write them.

---

## Slicing

After a shape is breadboarded, slice it into vertical implementation increments. For the full slicing procedure, consult **`references/slicing.md`**.

**Key constraint:** Every slice must have visible UI that can be demoed. A slice without UI is a horizontal layer, not a vertical slice.

---

## Additional Resources

### Reference Files

For detailed patterns and techniques, consult:

- **`references/advanced-places.md`** — Place IDs, Place References, Subplaces, Modes as Places, Navigation Wiring
- **`references/catalog.md`** — Complete catalog of elements, relationships, verification checks, chunking
- **`references/visualization.md`** — Mermaid diagram conventions, colors, subgraph labels, workflow annotations
- **`references/slicing.md`** — Full slicing procedure, slice visualization, slice summary format
- **`references/whiteboard-reading.md`** — Visual conventions for hand-drawn breadboards, translation to tables
- **`references/examples.md`** — Example A: Mapping an existing system. Example B: Designing from shaped parts with slicing
