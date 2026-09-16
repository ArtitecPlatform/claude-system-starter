# /init-project

Scaffold the standard `.claude/` structure for a project from the template at
`~/.claude/project-template/.claude/`.

## Steps

1. Confirm you are in the project root directory (has `.git/`). If not, ask the user to navigate there first.

2. Ask the user for the following (or infer from existing files if obvious):
   - Project name
   - GitHub account (org or personal — see the global CLAUDE.md accounts block)
   - GitHub repo name
   - Stack (languages, frameworks)
   - Short description (1-2 sentences)
   - Base branch for feature work (`develop` or `main`)
   - Primary machine for this project
   - Which reviewers to keep (`code-reviewer`, `security-auditor`) — default both

3. Copy the template into the repo, then fill placeholders:

```bash
cp -Rn ~/.claude/project-template/.claude .claude
```

Resulting structure:

```
.claude/
├── CLAUDE.md                 ← fill every [placeholder]; this is the repo's source of truth
├── settings.json             ← allow / ask / deny permission tiers
├── agents/
│   ├── critic.md             ← used by /critique; fill "Known Issues to Track"
│   ├── code-reviewer.md      ← read-only Haiku diff reviewer
│   └── security-auditor.md   ← read-only Haiku OWASP checklist
├── commands/
│   ├── review.md             ← diff vs base branch, checklist review
│   ├── debug.md              ← 5-step reproduce → guard
│   └── sprint.md             ← loads SPRINT.md
└── logs/
    ├── updates.md            ← newest first, trim to 30
    └── critique.md           ← newest first, trim to 10
```

4. Edit `.claude/CLAUDE.md`: replace `[Project Name]`, `[org-or-username]/[repo-name]`, stack, base branch, primary machine, envs table. Edit `.claude/agents/critic.md` header and replace the example "Known Issues to Track" with real ones (or leave the list empty).

5. If `review.md` needs a different base branch than `develop`/`main`, edit the `git merge-base` line.

6. Add `.claude/logs/` to `.gitignore` if a `.gitignore` exists (logs are local context, not source code). Commit the rest of `.claude/` — agents and commands are shared with teammates.

7. Log the initialization to `.claude/logs/updates.md`:

```markdown
## [YYYY-MM-DD] Init — [branch]
- Project initialized with /init-project
```

8. Tell the user: next run `/critique` for a baseline score.

---

## Fallback (template directory missing)

If `~/.claude/project-template/` does not exist, create the tree above by hand. Minimum viable `CLAUDE.md`:

```markdown
# [Project Name]

## Overview
[Short description]

## Stack
[Languages, frameworks, key dependencies]

## Repository
- GitHub: [org-or-username]/[repo-name]
- Main branch: main
- Base branch for feature work: develop
- Active branches: [list]

## Primary Machine
[machine] — this machine owns active development

## Active Work
[What is currently being worked on]

## Rules
- Run /critique before merging to main
- Branch naming: feature/, fix/, chore/ prefixes
- Log all significant changes to logs/updates.md
```

Minimum viable `agents/critic.md`: the "Default Critic Rules" section of `/critique`.
