# Shaping Skills

A [Claude Code](https://claude.com/claude-code) plugin for shaping and breadboarding — the methodology from [Shape Up](https://basecamp.com/shapeup) adapted for working with an LLM.

**Case study:** [Shaping 0-1 with Claude Code](https://x.com/rjs/status/2020184079350563263) walks through the full process of building a project from scratch using these skills. The source for that project is at [rjs/tick](https://github.com/rjs/tick).

## Skills

**`/shaping`** — Iterate on both the problem (requirements) and solution (shapes) before committing to implementation. Separates what you need from how you might build it, with fit checks to see what's solved and what isn't.

**`/breadboarding`** — Map a system into UI affordances, code affordances, and wiring. Shows what users can do and how it works underneath — in one view. Good for slicing into vertical scopes.

**`/breadboard-reflection`** — Review a breadboard for design smells. Trace user stories through wiring, apply the naming test, and fix affordance boundary problems.

## Install

Install as a Claude Code plugin:

```bash
claude plugin add -- /path/to/shaping-skills
```

Or clone and install from the repo:

```bash
git clone https://github.com/rjs/shaping-skills.git ~/.local/share/shaping-skills
claude plugin add -- ~/.local/share/shaping-skills
```

## Hook: Ripple Check

The plugin includes a PostToolUse hook that fires after every `Write` or `Edit` tool call. When the edited file is a `.md` with `shaping: true` in its frontmatter, it prompts a ripple-check reminder — update affordance tables, fit checks, work streams, etc.

The hook is registered automatically via `hooks/hooks.json` when the plugin is installed. No manual setup is needed.

## Plugin Structure

```
shaping-skills/
├── .claude-plugin/
│   └── plugin.json
├── skills/
│   ├── shaping/
│   │   ├── SKILL.md
│   │   └── references/
│   ├── breadboarding/
│   │   ├── SKILL.md
│   │   └── references/
│   └── breadboard-reflection/
│       ├── SKILL.md
│       └── references/
├── hooks/
│   ├── hooks.json
│   └── scripts/
│       └── shaping-ripple.sh
└── CHANGELOG.md
```

---

This README was written by [Claude Code](https://claude.com/claude-code).
