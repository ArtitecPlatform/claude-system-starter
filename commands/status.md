# /status

Show a full status snapshot of the current project.

## Output

Display the following in a clean, readable format:

### 1. Git Status
- Current branch
- Uncommitted changes (files modified, added, deleted)
- Commits ahead/behind remote (`git rev-list --left-right --count origin/[branch]...HEAD`)

### 2. Recent Activity
- Last 5 entries from `.claude/logs/updates.md`
- If file doesn't exist: note that the project hasn't been initialized with /init-project

### 3. Critic Health
- Date of last critique from `.claude/logs/critique.md`
- Last overall health score (e.g., `Health Score: 7/10`)
- Count of unresolved Critical Issues 🔴 and Warnings 🟡 from the last report
- If no critique has been run: show "No critique on record — run /critique"

### 4. Project Info (from `.claude/CLAUDE.md`)
- Project name
- Primary machine
- Active branches

## Example Output

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
PROJECT: my-web-app
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

GIT
  Branch:   feature/dashboard-redesign
  Changes:  3 modified, 1 new
  Remote:   2 commits ahead of origin

RECENT ACTIVITY
  2026-04-14  Push — feature/dashboard-redesign
  2026-04-13  Sync — feature/dashboard-redesign
  2026-04-12  Push — feature/auth-refactor

CRITIC HEALTH
  Last run:  2026-04-10
  Score:     7/10
  Open:      1 critical 🔴  2 warnings 🟡

PRIMARY MACHINE: MacBook Pro
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```
