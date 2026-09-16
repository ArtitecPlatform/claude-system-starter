# Persistent memory (auto-memory)

Claude Code keeps a per-project memory directory at
`~/.claude/projects/<encoded-cwd>/memory/`. `MEMORY.md` there is loaded into every
session; each other file is one fact. This convention is what makes the CTO model
survive across sessions.

## File format
```markdown
---
name: reference-vault-token-scope
description: one line used to decide relevance during recall
metadata:
  type: user | feedback | project | reference
---

The fact. For feedback/project also add:
**Why:** ...
**How to apply:** ...
Link related memories with [[other-memory-name]].
```

## Naming prefixes
| Prefix | Meaning | Lifetime |
|---|---|---|
| `reference_*` | infra facts, gotchas, URLs, "this thing is NOT what CLAUDE.md says" | keep |
| `feedback_*` | corrections / confirmed approaches from the CEO, with the why | keep |
| `project_*` | active work, decisions, constraints not derivable from git | archive ~2 weeks after shipped |
| `user_*` | who the user is, role, preferences | keep |

## Hygiene rules
- `MEMORY.md` = index only, one line per memory: `- [Title](file.md) — hook`. Never put content there.
- Date facts absolutely (`2026-09-06`), never "yesterday".
- Don't save what the repo already records (code structure, git history, CLAUDE.md).
- When a `project_*` pointer goes stale, move the line to `MEMORY_ARCHIVE.md` (not auto-loaded). Never delete the underlying file.
- If a memory turns out wrong, fix or delete it immediately — a stale memory is worse than none.

See `MEMORY.example.md` for what a healthy index looks like.
