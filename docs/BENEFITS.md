# Benefits — what each piece buys you

## The operating model (CLAUDE.md + 5 commands)
**Claude behaves like a CTO, not an autocomplete.**
- Reads the project's `.claude/CLAUDE.md` before touching code → fewer "it ignored our conventions" moments.
- `/push` physically refuses to push to `main` and enforces `feature/|fix/|chore/` → no accidental direct-to-main.
- `/sync` before work → fewer mis-based branches and stale-develop PRs.
- `/critique` scores the repo 1–10 with concrete file:line findings and blocks main merges on criticals → an independent reviewer that never gets tired.
- `/status` = one screen: branch, dirty files, ahead/behind, last critique score, open criticals.
- Every push/sync/critique is logged to `.claude/logs/` (trimmed to 30 / 10 entries) → Claude has a memory of what happened last week without you re-explaining.

## Per-project `.claude/` (project-template + /init-project)
**Global config stays tiny; each repo carries its own truth.**
- `CLAUDE.md` per repo: stack, envs, base branch, primary machine, active work.
- `agents/critic.md` with "Known Issues to Track" → the critic re-checks *your* recurring smells every run, not generic lint.
- `code-reviewer` + `security-auditor` on Haiku, read-only → cheap second opinions before every merge.
- `commands/review.md` diffs against the base branch automatically; `debug.md` forces reproduce → localize → reduce → fix → guard.
- `settings.json` allow/ask/deny → `sudo`, force-push, `rm -rf /` are denied outright.

## Token discipline (caveman + RTK + GitNexus + routing)
**Same work, a fraction of the tokens. On a subscription that means more sessions before the cap; on API it's money.**
- **Caveman**: replies drop articles and filler, keep every path, number and error string verbatim. Auto-switches to full prose for security warnings and irreversible actions. Typical savings 40–60 % of output tokens.
- **RTK**: `git status`, `ls`, test output etc. compressed before they hit context. Up to 90 % on chatty commands.
- **GitNexus**: a code knowledge graph. "What calls X / what breaks if I change Y / show me the auth flow" is one MCP call instead of 5–20 grep/Read rounds. `impact` is mandatory before renames → fewer broken callers.
- **Model routing**: research fan-outs on Sonnet, verification on Haiku, Opus only for hard reasoning. Whole-file reads delegated to subagents so only conclusions enter main context.
- **Fail-fast rule**: two junk tool responses → pivot. No burning tokens retrying a hung browser.

## Superpowers plugin
**Process discipline Claude follows without being asked.**
- Brainstorming before building, TDD before implementation, systematic debugging before "fixes", written plans for multi-step work, verification before claiming done.
- Git worktrees per branch (`isolated-worktree` skill) → concurrent sessions can't clobber each other's working tree. This one alone saved a mis-based PR and a stray-file commit in production use.

## Secrets pattern (scripts/ + Vault)
**No token ever lives in Claude's config.**
- MCP wrappers fetch credentials at launch from Vault (or 1Password/keychain, same shape).
- `vault-fetch.sh` fails loud instead of falling back to a stale token — a stale fallback once silently returned Python tracebacks as "secrets".
- Rotate in one place; every machine picks it up on next launch.

## Memory convention
**Claude remembers across sessions without you re-pasting context.**
- One fact per file, typed (`reference_` / `feedback_` / `project_` / `user_`), dated absolutely.
- `MEMORY.md` index is loaded every session; archive shipped work after ~2 weeks so the index stays cheap.
- Corrections you give once (`feedback_*`) stick: "ssh timeout doesn't kill the remote process" never has to be relearned.

## Design system builder
**Pages stop looking like Tailwind templates.**
- Brand intake → tokens → a live `/design-plate` with every primitive and its code → a sweep script → a generated `<brand>-design-system` skill.
- Two-color discipline, three typefaces max, a *named* NEVER list (hero + 3 gradient cards, avatar grids, "John Doe", tricolon headlines).
- Claude reads the plate before any design request, composes from primitives, and runs the sweep before committing. New patterns must land on the plate first, so the system can't drift.

## Bundled third-party skills
- `claude-api`, `mcp-builder`, `skill-creator`, `webapp-testing`, `frontend-design` (Anthropic) — build MCP servers, new skills, Playwright test flows, and non-generic UI without hunting docs.
- `vercel-react-best-practices`, `vercel-composition-patterns` — 40+ prioritized React/Next.js perf rules Claude applies while writing.
- `ui-ux-pro-max` — palettes, font pairings, chart types, per-stack guidance.
- `copywriting`, `seo-audit`, `launch-strategy`, `product-marketing-context` — marketing tasks with a persistent product-context file so you never re-explain positioning.
- `doc-coauthoring` — structured spec / proposal writing.

## Net effect (observed, not theoretical)
- Zero direct-to-main pushes since `/push` enforcement.
- Critique log gives a health-score trend per repo.
- GitNexus + caveman + routing cut per-session context burn enough that 1M-context sessions last a full working day.
- New machines reach parity in one `install.sh` + four plugin commands.
