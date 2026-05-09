# Spikes

A spike is an investigation task to learn how the existing system works and what concrete steps are needed to implement a component. Use spikes when there's uncertainty about mechanics or feasibility.

## File Management

**Always create spikes in their own file** (e.g., `spike.md` or `spike-[topic].md`). Spikes are standalone investigation documents that may be shared or worked on independently from the shaping doc.

## Purpose

- Learn how the existing system works in the relevant area
- Identify **what we would need to do** to achieve a result
- Enable informed decisions about whether to proceed
- Not about effort — effort is implicit in the steps themselves
- **Investigate before proposing** — discover what already exists; you may find the system already satisfies requirements

## Structure

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

## Acceptance Guidelines

Acceptance describes the **information/understanding** we'll have, not a conclusion or decision:

- ✅ "...we can describe how users set their language and where non-English titles appear"
- ✅ "...we can describe the steps to implement [component]"
- ❌ "...we can answer whether this is a blocker" (that's a decision, not information)
- ❌ "...we can decide if we should proceed" (decision comes after the spike)

The spike gathers information; decisions are made afterward based on that information.

## Question Guidelines

Good spike questions ask about mechanics:
- "Where is the [X] logic?"
- "What changes are needed to [achieve Y]?"
- "How do we [perform Z]?"
- "Are there constraints that affect [approach]?"

Avoid:
- Effort estimates ("How long will this take?")
- Vague questions ("Is this hard?")
- Yes/no questions that don't reveal mechanics
