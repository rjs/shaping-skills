---
name: kickoff-doc
description: Turn a shaped project kickoff transcript into a reference document for the builder. Use when the user has a transcript (VTT, etc.) from a kickoff call and wants to produce a document that captures what was shaped and agreed.
---

# Kickoff Document from Transcript

Turn a kickoff call transcript into a builder-facing reference document for a shaped project.

---

## Before You Start

Ask the user:

1. **Who is the primary audience?** (Usually the builder who will implement the work.)
2. **What other inputs are there?** (Visuals, screenshots, mockups, breadboards from the session.)

The transcript is your source material. The document is NOT a summary of the call — it's a **map of the territory** that was shaped.

---

## Organizing Principle: Territory, Not Timeline

A kickoff transcript is sequential — people talk through things in the order they come up, circle back, go on tangents, get sidetracked by browser issues. Your job is to reconstruct the **territory they were describing**, not replay the conversation.

**Organize by the thing being built.** Each section should describe one area of the system fully — so the builder can look up "how does the Criteria tab work?" and find everything in one place.

**Do NOT organize by build sequence.** If the team identified slices (a sequence of vertical slices to build in order), those belong at the end as a short list — the path through the map, not the map itself.

---

## Structure

### 1. Frame

The strategic context and boundary conditions. This is NOT fluff — the builder needs this to make judgment calls when they hit ambiguity. Include:

- Why this project, why now — what depends on it being done
- The specific outcomes expected by the deadline
- What prepares what (this piece prepares us for X, that stub prepares us for Y)
- What is NOT in scope

### 2. The Territory (multiple sections)

One section per area of the system. For each area, describe:

- What it is and what's on the screen (affordances, components, data displayed)
- How it relates to other areas
- Design decisions that belong to THIS area — inline, not in a separate section
- Edge cases or flags that were called out
- What's temporary/placeholder vs. what's a real commitment

### 3. Build Sequence (at the end)

If slices were identified, list them briefly. Each slice name + one line. This is just a path through the territory described above.

---

## Voice: Use Their Words

The document is a record of shared understanding from the kickoff call.

### Do

- Use the actual words and phrases people used on the call
- Synthesize scattered discussion into clearer form (taking something said across several turns and stating it cleanly)
- Capture the reasoning people gave for decisions ("we're doing X because Y")

### Don't

- Put new ideas or conclusions in people's mouths
- Add motivational framing they didn't express ("each piece is a foundation, not a throwaway")
- Editorialize about importance or quality beyond what was said

### The Test

For every sentence, you should be able to point to a moment in the transcript where someone said it or clearly meant it. If you can't, either cut it or flag it as your own synthesis.

**Exception:** Editorializing that clarifies or synthesizes what was said IS fine. "The criteria screen is how filtering is expressed in the new world" — nobody said that exact sentence, but it accurately captures a point made across several turns. That's the job: make scattered discussion legible without adding your own conclusions.

---

## Design Decisions: Vertical, Not Horizontal

Do NOT create a grab-bag "Design Decisions" section. Instead, put each decision inline in the section where it matters.

- "Matches stored in DB not Redis" → goes in the section about matching
- "Candidates must be materialized before attachment" → goes in the section about attaching
- "Per-ICP match data as value objects" → goes in the section about match results

If a decision only matters when building one specific area, it belongs in that area's section. The builder shouldn't have to cross-reference a separate decisions list while working on a specific screen.

---

## Process

1. **Read the full transcript.** Don't start writing after reading part of it.
2. **Identify the areas of the system** that were discussed — these become your sections.
3. **Draft the Frame** from the framing/outcomes discussion (usually near the start of the call).
4. **Write each territory section**, pulling from wherever in the transcript that area was discussed. A single section may draw from moments scattered across the whole call.
5. **Place design decisions inline** in the section they belong to.
6. **List the build sequence** at the end if slices were discussed (usually near the end of the call).
7. **Review against the transcript** — can you point to where each claim was said?
