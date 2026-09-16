---
description: Load current sprint context
---

## Current Sprint
!`cat SPRINT.md 2>/dev/null || echo 'No SPRINT.md found — create one in project root'`

## Open Files
!`git status --short`

## Recent Activity
!`git log --oneline -5`

---

You are in **SPRINT mode**. Help me make progress on the tasks above.

If the sprint file exists, focus on those tasks. If it doesn't exist, ask which task to start.

**Tips:**
- Create a `SPRINT.md` file in the project root with your current sprint tasks
- Update it weekly to keep Claude oriented
- Include task descriptions, acceptance criteria, and blockers
