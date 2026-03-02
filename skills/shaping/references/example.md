# Shaping Example

A worked example of a shaping document showing requirements, shapes, and fit checks.

---

## Search Feature Shaping

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
