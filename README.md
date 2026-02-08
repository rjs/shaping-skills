# Shaping Skills

[Claude Code](https://claude.com/claude-code) skills for shaping and breadboarding — the methodology from [Shape Up](https://basecamp.com/shapeup) adapted for working with an LLM.

**Case study:** [Shaping 0-1 with Claude Code](https://x.com/rjs/status/2020184079350563263) walks through the full process of building a project from scratch using these skills. The source for that project is at [rjs/tick](https://github.com/rjs/tick).

## Skills

**`/shaping`** — Iterate on both the problem (requirements) and solution (shapes) before committing to implementation. Separates what you need from how you might build it, with fit checks to see what's solved and what isn't.

**`/breadboarding`** — Map a system into UI affordances, code affordances, and wiring. Shows what users can do and how it works underneath — in one view. Good for slicing into vertical scopes.

## Install

### Plugin (recommended)

```bash
claude plugin marketplace add rjs/shaping-skills
claude plugin install shaping-skills
```

### Manual (symlinks)

```bash
git clone https://github.com/rjs/shaping-skills.git ~/.local/share/shaping-skills
ln -s ~/.local/share/shaping-skills/plugins/shaping-skills/skills/breadboarding ~/.claude/skills/breadboarding
ln -s ~/.local/share/shaping-skills/plugins/shaping-skills/skills/shaping ~/.claude/skills/shaping
```

---

This README was written by [Claude Code](https://claude.com/claude-code).
