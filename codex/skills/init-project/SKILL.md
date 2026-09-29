---
name: init-project
description: Add the standard Codex project instructions and local logs to a repository.
---

1. Confirm repository root and inspect existing `AGENTS.md` and `.Codex/`; never overwrite existing project guidance.
2. Copy `AGENTS.md` from the installed template at `~/.codex/project-template/AGENTS.md` only if root `AGENTS.md` is absent. Replace placeholders using repository evidence; ask only for facts that cannot be inferred.
3. Create `.Codex/logs/`; copy `updates.md` and `critique.md` from the installed template only when absent. Add `.Codex/logs/` to `.gitignore` if available.
4. Record initialization in updates log. Keep project-specific facts in root `AGENTS.md`.
