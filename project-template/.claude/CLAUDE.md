# [Project Name]

## Overview
[1–2 sentence description. What this repo is and what it serves.]

## Stack
[Languages, frameworks, key dependencies — e.g. FastAPI + SQLAlchemy + MariaDB, or Next.js 15 App Router]

## Repository
- GitHub: [org-or-username]/[repo-name]
- Main branch: main
- Base branch for feature work: develop   <!-- or main -->
- Active branches: [list]

## Primary Machine
[Laptop / Mini / other] — this machine owns active development. Other machines pull only.

## Environments
| Env | URL | Host | Notes |
|-----|-----|------|-------|
| dev | | | |
| staging | | | |
| prod | | | |

## Secrets
Pulled from Vault via `make env-<env>`; never hand-edit `.env`. Vault path: `secret/data/<project>/<env>/*`.

## Active Work
[What is currently being worked on. Link tickets.]

## Agent Roles
- `agents/critic.md` — independent auditor (used by `/critique`)
- `agents/code-reviewer.md` — read-only diff reviewer (Haiku)
- `agents/security-auditor.md` — OWASP checklist reviewer (Haiku)

## Rules
- Run /critique before merging to main
- Branch naming: feature/, fix/, chore/ prefixes
- Log all significant changes to logs/updates.md
- Migrations: [tool] is authoritative; flag any raw SQL migrations
