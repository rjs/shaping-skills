---
name: framing-doc
description: Create a framing document from conversation transcripts. Use when the user has transcripts (VTT, call notes, etc.) and wants to produce a frame that captures the problem worth solving and why it was chosen over alternatives.
---

# Framing from Conversation Transcripts

Produce a frame document from one or more conversation transcripts. The frame captures the "why" — what problem to solve and why this one, not the others.

---

## Before You Start

Ask the user:

1. **Which transcripts?** Get specific file paths. Read them in the order the user specifies — conversation order often matters because ideas build across calls.
2. **What's the topic area?** A rough sense of what these conversations were about (e.g., "AI features," "onboarding redesign") so you know what to listen for.

---

## What a Frame Document Contains

A frame has three sections:

### 1. Source — What was actually said

Capture verbatim quotes from the transcripts. This is ground truth. Everything else in the document is interpretation of this material.

- Attribute quotes to speakers
- Include enough context that the quote makes sense standalone
- Add brief connective tissue between quotes where needed, but keep your voice minimal

### 2. Pre-work — What options surfaced and why this one

Survey the landscape of options that came up across conversations. This is not background — it's the argument for why we're framing this particular problem.

For each option that surfaced:
- What is it?
- Who benefits?
- How strong is the signal? (How many people raised it independently? Did others pick it up or let it drop?)

Then make the case for the one to pursue now:
- Why is it more urgent or important than the others?
- Why not the others *right now*? (This is "why not now," not "why not ever" — don't dismiss ideas, just explain why they aren't the priority.)

**Do not invent a roadmap or sequence for the other options.** Whether and when they happen is a future decision. The only claim you're making is: this one first, for these reasons.

### 3. Problem / Outcome — The specific frame

**Problem:** What's broken, what pain exists. Render as bullets for easy scanning.

**Outcome:** What success looks like. Also bullets. Stay high-level — this is not solution-specific.

### 4. Less about / More about — Boundary on the solution space (optional)

A guardrail that orients the reader toward what kind of solution fits and away from what kind doesn't. It sits after Problem/Outcome as a separate section. Same format — two symmetric bullet lists.

**What it does:** Prevents someone from reading the Problem and Outcome correctly but proposing the wrong kind of solution. For example, a problem about getting programs into the system could reasonably lead someone to propose "AI that advises coaches on what to program" — which technically addresses the problem but completely misses the point.

**When to include it:** When there's a common misunderstanding or an obvious-but-wrong direction that people could easily head toward. The signal is that people in the conversations are actively drawing a line — saying what this is NOT. If nobody felt the need to draw that line, you probably don't need the section.

**How it surfaces:** This probably won't emerge mechanically from a first pass through the transcripts. It's more likely to surface during review — either the shaper notices a pattern of people saying "not about X," or someone reading the frame proposes something that fits the Problem/Outcome but misses the point. That's the moment where you realize the boundary needs to be made explicit.

**What it looks like:**

```markdown
## Less about

- [What this project is NOT trying to solve]
- [The wrong direction people might naturally head toward]

## More about

- [What kind of solution actually fits]
- [The real nature of the problem being addressed]
```

No quotes or attribution needed — it's a synthesis. Keep it to the key points.

---

## The Key Discipline: Evidence, Not Editorializing

After writing each line in Problem and Outcome, ask: **who said this, and where?**

- If you can point to a specific person and moment → keep it, cite it
- If it's directly implied by what someone said → keep it, mark it as implied with your reasoning
- If you can't trace it back → drop it

### Common traps to avoid

**Don't connect dots and present inferences as facts.** "Coaches bounce during trials because data entry is too hard" sounds plausible but if nobody said it, don't write it as established truth.

**Don't embellish for vividness.** Adding specificity that nobody stated ("every exercise, set, rep, and percentage") to make the problem sound more concrete is editorializing.

**Don't inflate the options list.** An idea that one person mentioned and nobody picked up is not an "option with traction." Be honest about signal strength. Ask yourself: did multiple people raise this independently? Did others build on it or let it die?

**Don't editorialize in the Problem statement.** Phrases like "TB has to earn the switch" or "the single biggest friction point" are rhetoric, not evidence. Make the case using what was said.

**Don't present your framing as their words.** Keep your interpretive voice separate from what was actually said. The Source section is theirs. Problem/Outcome are your distillation — and should be traceable back to Source.

---

## Reviewing the Frame

After drafting, examine every line in Problem and Outcome:

1. Read each bullet
2. Ask: what's my evidence for this claim?
3. If the evidence is a direct quote — cite it parenthetically
4. If the evidence is implied — say so explicitly
5. If there's no evidence — drop the line

Do the same for the pre-work options table. For each option listed, verify:
- Did it actually get traction in the conversations? (Multiple people, independently?)
- Or was it one person's idea that others didn't pick up?

Be willing to shrink the options list. Fewer real options are better than a padded list.

---

## Document Format

```markdown
---
shaping: true
---

# [Topic] — Frame

## Source

### [Speaker] ([Date])

> "Verbatim quote..."

> "Another quote..."

[Brief connective context where needed.]

### [Speaker] ([Date])

> "Verbatim quote..."

---

## Pre-work: [Topic] Options Landscape

[N] options surfaced with real traction across conversations:

| Option | What it does | Who benefits | Signal strength |
|--------|-------------|--------------|-----------------|
| **A. [Name]** | ... | ... | ... |
| **B. [Name]** | ... | ... | ... |

([Note on ideas that were mentioned but didn't get traction — dropped.])

**Why A now:** [Evidence-based argument for urgency/importance.]

---

## Problem

- [Bullet — traceable to source]
- [Bullet — traceable to source]

## Outcome

- [Bullet — high-level, not solution-specific]
- [Bullet — high-level, not solution-specific]

---

## Less about

- [What this is not]

## More about

- [What this is]
```

---

## What This Skill Does NOT Do

- **Does not shape solutions.** The frame is the "why." Shapes (the "how") come after, in a separate shaping doc.
- **Does not sequence future work.** It picks one thing as the priority now. It does not roadmap the rest.
- **Does not summarize conversations.** The Source section captures key quotes. The rest of the document is a distillation, not a summary.
