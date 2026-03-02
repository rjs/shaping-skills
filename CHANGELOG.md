# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/).

## [1.0.0] — 2026-03-01

Refactored from a loose collection of skills into a proper Claude Code plugin.

### Added
- `.claude-plugin/plugin.json` manifest for auto-discovery
- `hooks/hooks.json` for automatic hook registration (replaces manual symlink setup)
- Progressive disclosure: reference files for all three skills
- Third-person trigger descriptions on all skill frontmatter
- `CHANGELOG.md`

### Changed
- Moved skills into `skills/` directory (`shaping/`, `breadboarding/`, `breadboard-reflection/`)
- Moved hook script to `hooks/scripts/shaping-ripple.sh`
- Split breadboarding SKILL.md (9,500 words → 2,700 words + 6 reference files)
- Split shaping SKILL.md (3,800 words → 3,000 words + 3 reference files)
- Normalized all skill files to `SKILL.md` (uppercase)
- Converted writing style from second-person to imperative/infinitive form
- Updated README for plugin installation

### Removed
- `scripts/test-gfm.sh` dev utility (not part of plugin functionality)
- Manual hook setup instructions (replaced by auto-registration)
