# Codex Starter Kit — CEO/CTO operating model

Codex equivalent of this repository's Claude Code starter. Installs shared instructions and five reusable workflow skills, without overwriting existing files or touching `~/.codex/config.toml`.

## Install

```bash
git clone https://github.com/ArtitecPlatform/claude-system-starter.git ~/claude-system-starter
cd ~/claude-system-starter/codex
./install.sh
```

Review `~/.codex/AGENTS.md` and replace placeholders. Skills install to `~/.agents/skills/` and appear as `$sync`, `$status`, `$push`, `$critique`, and `$init-project`.

## Per-project setup

In a repository, run `$init-project`. It creates `AGENTS.md` and `.Codex/logs/`. Customize `AGENTS.md` with project stack, branch, environment, and active-work facts. Commit `AGENTS.md`; keep local logs ignored.

## Codex mapping

| Claude Code | Codex |
|---|---|
| `~/.claude/CLAUDE.md` | `~/.codex/AGENTS.md` |
| `.claude/CLAUDE.md` | `AGENTS.md` |
| slash command | Agent Skill (`$name`) |
| plugin/MCP config | Codex plugin UI or `~/.codex/config.toml` |
| Claude hooks/settings | Codex-native configuration; configure separately |

The installer deliberately does not migrate MCP credentials, permission settings, hooks, models, plugins, or status-line commands. Those are machine-specific. Codex reads skills as needed; no startup hook is required.
