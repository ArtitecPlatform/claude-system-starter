---
name: push
description: Commit and push requested work while enforcing feature-branch hygiene.
---

1. Show changed files and preserve unrelated work. Stage only task-relevant files.
2. Never commit or push directly to `main`/`master`. If there, stop and offer a prefixed feature branch.
3. Use the user's commit message; otherwise derive a concise why-focused message.
4. Commit, push the current feature branch, and report commit SHA and remote URL.
5. Follow project-specific logging rules. Never force-push unless explicitly requested.
