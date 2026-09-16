# Claude Code Starter Kit — the "CEO/CTO" operating model

A clean, secret-free copy of a working Claude Code setup. Drop it into `~/.claude`,
fill in a few placeholders, and you get the same operating model: Claude acts as CTO
across all your repos, keeps GitHub hygiene, runs a critic before merges, remembers
things between sessions, and spends as few tokens as possible doing it.

```
claude-system-starter/
├── README.md                  ← you are here
├── install.sh                 ← non-destructive copy into ~/.claude
├── CLAUDE.md                  ← global operating model (fill in <placeholders>)
├── RTK.md                     ← included by CLAUDE.md; bash-output compressor notes
├── settings.json              ← hooks, plugins, statusline, model defaults
├── statusline-command.sh      ← "[model] ████░░ 42% context | $1.23" status bar
├── mcp-servers.example.json   ← merge into ~/.claude.json
├── commands/                  ← global slash commands (5)
├── skills/                    ← global skills (21)
├── hooks/gitnexus/            ← PreToolUse/PostToolUse hook for code-graph context
├── scripts/                   ← Vault-backed MCP wrappers (no secrets on disk)
├── memory/                    ← how the persistent memory convention works
└── project-template/.claude/  ← what /init-project scaffolds inside each repo
```

## 1. The stack, in one paragraph

Four layers, each independent, all optional:

| Layer | What it does | Where |
|---|---|---|
| **Operating model** | Claude = CTO, you = CEO. Feature branches only, sync before work, log changes, `/critique` before main. | `CLAUDE.md` + `commands/` |
| **Per-project context** | Each repo gets `.claude/{CLAUDE.md,agents,commands,logs}` so global stays tiny. | `project-template/` + `/init-project` |
| **Token discipline** | Caveman (terse replies) + RTK (compressed bash output) + GitNexus (graph queries instead of grep) + subagent model routing. | plugins, hook, `CLAUDE.md` §Token Discipline |
| **Memory** | One-fact-per-file memory dir with an index loaded every session. | `memory/README.md` |

## 2. Install

```bash
git clone <this-kit> ~/claude-system-starter   # or unpack the tarball
cd ~/claude-system-starter && ./install.sh     # never overwrites; writes *.kit-new beside existing files
```

Then, in order:

1. **Edit `~/.claude/CLAUDE.md`.** Replace `<org-name>`, `<personal-handle>`, `<vault-host>`, the indexed-repo list. Delete the Vault section if you don't run Vault.
2. **Plugins** (both are on GitHub, user scope):
   ```bash
   claude plugin marketplace add obra/superpowers
   claude plugin marketplace add JuliusBrussee/caveman
   claude plugin install superpowers@superpowers-dev
   claude plugin install caveman@caveman
   ```
   - **superpowers** — process skills: brainstorming, TDD, systematic-debugging, writing-plans, verification-before-completion, git worktrees. Fires automatically via a SessionStart hook.
   - **caveman** — terse response mode + `/caveman-*` commands + cavecrew subagents (compressed investigator/builder/reviewer).
3. **GitNexus** (code knowledge graph, replaces most grep/Read):
   ```bash
   npm i -g gitnexus
   cd <your-repo> && gitnexus analyze      # builds .gitnexus/ index; re-run after big merges
   ```
   The hook in `hooks/gitnexus/` augments Grep/Glob/Bash searches with graph context and nags you to re-index after git mutations. `settings.json` already wires it. `skills/gitnexus-*` are the workflow guides (`gitnexus setup` can regenerate them).
4. **MCP servers.** Merge `mcp-servers.example.json` into `~/.claude.json`. Keep only what you use. The `scripts/mcp-*.sh` wrappers fetch tokens from Vault at launch so nothing secret sits in JSON. If you don't use Vault, replace the `vault-fetch.sh` calls with `security find-generic-password` / 1Password CLI / env vars — the wrapper shape stays the same.
5. **RTK** (optional). Rust Token Killer compresses bash output ~90 %. Install per its README and its hook rewrites `git status` → `rtk git status` transparently. If you skip it, delete the `@RTK.md` line at the bottom of `CLAUDE.md`.
6. **Model.** `settings.json` sets `"model": "opus"` and `effortLevel: high`. Change to taste. Permission mode is `acceptEdits`; we run `bypassPermissions` on trusted machines but that's your call.

## 3. Per-project setup

Inside any repo, run `/init-project`. It copies `~/.claude/project-template/.claude/` (installed by `install.sh`) into the repo and walks you through the placeholders. What you get:

- `CLAUDE.md` — repo source of truth (envs, secrets path, base branch, active work).
- `agents/critic.md` — independent auditor used by `/critique`. **Fill in "Known Issues to Track"** — that section is what makes the critic useful over time.
- `agents/code-reviewer.md`, `agents/security-auditor.md` — read-only Haiku reviewers with checklists.
- `commands/review.md` (diff vs base), `commands/debug.md` (5-step repro→guard), `commands/sprint.md` (loads `SPRINT.md`).
- `logs/updates.md` (30 entries) and `logs/critique.md` (10 reports) — add `.claude/logs/` to `.gitignore`.
- `settings.json` — allow/ask/deny permission tiers (deny `sudo`, force-push, `rm -rf /`).

Daily loop: `/sync` → work → `/status` → `/critique` (before main) → `/push` (refuses on main, enforces `feature/|fix/|chore/`).

## 4. Skills included

**Ours (generic, MIT-ish, edit freely)**
- `isolated-worktree` — start every branch in its own git worktree so concurrent sessions can't clobber each other.
- `gitnexus-{guide,cli,exploring,debugging,impact-analysis,pr-review,refactoring}` — task-shaped GitNexus workflows.

**Third-party (bundled for convenience; check upstream for updates)**
| Skill | Source | License |
|---|---|---|
| `claude-api`, `mcp-builder`, `skill-creator`, `frontend-design`, `webapp-testing` | anthropics/skills | Apache-2.0 (LICENSE.txt inside) |
| `vercel-react-best-practices`, `vercel-composition-patterns` | vercel/agent-skills | MIT |
| `ui-ux-pro-max` | yuvalcohenrappaport/claude-skill-ui-ux-pro-max | see README inside |
| `copywriting`, `seo-audit`, `launch-strategy`, `product-marketing-context` | marketing skills pack (`npx skills add`) | see upstream |
| `doc-coauthoring` | anthropics/skills | Apache-2.0 |

Easiest way to keep third-party ones fresh: `npx skills add <repo>` symlinks them into `~/.agents/skills` and `~/.claude/skills`.

**Not included (deliberately)** — ~20 skills and ~20 commands that were specific to our infra (deploy runbooks, NAS health, scraper ops, perf-audit against our Grafana). They follow the same shape: a `SKILL.md` with a trigger-rich `description:` frontmatter plus optional `scripts/`. Write yours with `skill-creator`.

## 5. Conventions worth stealing

- **Secrets never in Claude config.** Vault (or any CLI-fetchable store) + wrapper scripts. `vault-fetch.sh` fails loud rather than falling back to a stale token.
- **Read the project CLAUDE.md before touching a repo.** Global file stays under ~150 lines.
- **Model routing.** Sonnet for research fan-outs, Haiku for verification, Opus only for hard reasoning. Delegate whole-file reads to subagents so only conclusions hit main context.
- **Fail fast on broken tools.** Two junk responses → pivot, no third retry.
- **Memory hygiene.** Index file is pointers only; archive shipped `project_*` entries after ~2 weeks; never delete the fact files.
- **`/critique` scores honestly.** "A 3 means 3, not 7." Unresolved criticals block main.

## 6. What to customise first

1. `CLAUDE.md` placeholders and the GitHub accounts block.
2. `project-template/.claude/agents/critic.md` → Known Issues for your first repo.
3. `settings.json` → model, permission mode, delete the caveman plugin if terse replies aren't your thing (everything else still works).
4. `mcp-servers.example.json` → prune to what you actually use.
