# Instructions — from zero to a working CTO in ~30 minutes

Assumes macOS or Linux, Node 20+, git, and Claude Code installed (`npm i -g @anthropic-ai/claude-code`, then `claude` once to log in).

## Step 0 — Get the kit
```bash
git clone git@github.com:<owner>/claude-system-starter.git ~/claude-system-starter
# or: tar -xzf claude-system-starter.tgz -C ~
```

## Step 1 — Install into ~/.claude
```bash
cd ~/claude-system-starter && ./install.sh
```
Non-destructive: anything already in `~/.claude` is left alone and the kit's copy lands beside it as `*.kit-new` for you to diff.

## Step 2 — Fill the global CLAUDE.md
Open `~/.claude/CLAUDE.md` and replace:
- `<org-name>` / `<personal-handle>` in **GitHub Accounts**
- `<vault-host>` in **Infrastructure**, or delete the Vault section entirely
- the indexed-repo list under **Code Intelligence**

Keep it under ~150 lines. Anything project-specific goes in the project's own `.claude/CLAUDE.md` (step 6).

## Step 3 — Plugins
```bash
claude plugin marketplace add obra/superpowers
claude plugin marketplace add JuliusBrussee/caveman
claude plugin install superpowers@superpowers-dev
claude plugin install caveman@caveman
```
Restart `claude`. You should see "CAVEMAN MODE ACTIVE" and "You have superpowers" at session start. Say `normal mode` any time to get full prose back; `/caveman` to return.

## Step 4 — GitNexus (code knowledge graph)
```bash
npm i -g gitnexus
cd ~/path/to/your-repo && gitnexus analyze
```
Repeat per repo. Re-run after big merges. The hook in `~/.claude/hooks/gitnexus/` is already wired by `settings.json`; it enriches searches with graph context and nags when the index is stale.

## Step 5 — MCP servers
Open `~/claude-system-starter/mcp-servers.example.json`. Copy the `mcpServers` entries you want into `~/.claude.json` (create the key if missing). Replace `/Users/<you>/`.

Credentialed servers (GitHub, Notion, MySQL, Cloudflare) go through `~/.claude/scripts/mcp-*.sh`, which call `vault-fetch.sh` at launch. If you don't run Vault, edit each wrapper and swap the `vault-fetch.sh` line for whatever you use:
```bash
export GITHUB_PERSONAL_ACCESS_TOKEN="$(op read 'op://Private/GitHub PAT/token')"   # 1Password
export GITHUB_PERSONAL_ACCESS_TOKEN="$(security find-generic-password -s github-pat -w)" # macOS keychain
```
Rule: no secret ever sits in `~/.claude.json` or `settings.json`.

## Step 6 — Per-project setup
```bash
cd ~/path/to/your-repo
claude
> /init-project
```
Answer the prompts. Then open `.claude/agents/critic.md` and write 2–3 real "Known Issues to Track". Commit `.claude/` (except `logs/`).

## Step 7 — Brand design system (web projects)
In the repo, ask Claude: **"create a design system for this project"**. The `design-system-builder` skill runs a brand intake (fonts, colors, voice, reference sites), encodes tokens, builds a `/design-plate` page that renders every primitive with copy-pastable code, adds `scripts/brand-sweep.sh`, and generates `.claude/skills/<brand>-design-system/` so future "design / redesign / polish" requests stay on-brand automatically.

## Step 8 — Optional extras
- **RTK** (compresses bash output ~90 %): install from its repo, add its hook; otherwise delete the `@RTK.md` line from `CLAUDE.md`.
- **Model / permissions**: `settings.json` ships `"model": "opus"`, `effortLevel: high`, `defaultMode: acceptEdits`. Tighten or loosen there.
- **Status line**: `statusline-command.sh` needs `jq` (`brew install jq`).

## Daily loop
```
/sync            pull latest before touching anything
… work …         Claude reads .claude/CLAUDE.md first, uses GitNexus before grep
/status          branch, changes, last critique score
/critique        before any merge to main — criticals block
/push            refuses on main; enforces feature/ fix/ chore/ prefixes; logs to .claude/logs/updates.md
```

## Troubleshooting
| Symptom | Fix |
|---|---|
| Hook error `Cannot find module gitnexus` | `npm i -g gitnexus`, or delete the `hooks` block from `settings.json` |
| MCP server "Connection closed" | run the wrapper script by hand: `~/.claude/scripts/mcp-github.sh` — usually a missing token |
| `vault-fetch: no VAULT_TOKEN` | `echo <token> > ~/.vault-token && chmod 600 ~/.vault-token`, or replace vault-fetch calls (step 5) |
| Status line blank | `brew install jq` |
| Caveman too terse for a task | say `normal mode`; it resumes next session |
