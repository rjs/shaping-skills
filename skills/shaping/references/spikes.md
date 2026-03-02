# Spikes

A spike is an investigation task to learn how the existing system works and what concrete steps are needed to implement a component. Use spikes when there is uncertainty about mechanics or feasibility.

---

## File Management

**Always create spikes in their own file** (e.g., `spike.md` or `spike-[topic].md`). Spikes are standalone investigation documents that may be shared or worked on independently from the shaping doc.

## Purpose

- Learn how the existing system works in the relevant area
- Identify **what would need to be done** to achieve a result
- Enable informed decisions about whether to proceed
- Not about effort — effort is implicit in the steps themselves
- **Investigate before proposing** — discover what already exists; the system may already satisfy requirements

## Structure

```markdown
## [Component] Spike: [Title]

### Context
Why this investigation is needed. What problem is being solved.

### Goal
What is being learned or identified.

### Questions

| # | Question |
|---|----------|
| **X1-Q1** | Specific question about mechanics |
| **X1-Q2** | Another specific question |

### Acceptance
Spike is complete when all questions are answered and [the understanding we'll have] can be described.
```

## Acceptance Guidelines

Acceptance describes the **information/understanding** that will be gained, not a conclusion or decision:

- "...the steps to implement [component] can be described"
- "...how users set their language and where non-English titles appear can be described"
- X "...whether this is a blocker can be answered" (that is a decision, not information)
- X "...whether to proceed can be decided" (decision comes after the spike)

The spike gathers information; decisions are made afterward based on that information.

## Question Guidelines

Good spike questions ask about mechanics:
- "Where is the [X] logic?"
- "What changes are needed to [achieve Y]?"
- "How is [Z] performed?"
- "Are there constraints that affect [approach]?"

Avoid:
- Effort estimates ("How long will this take?")
- Vague questions ("Is this hard?")
- Yes/no questions that do not reveal mechanics
