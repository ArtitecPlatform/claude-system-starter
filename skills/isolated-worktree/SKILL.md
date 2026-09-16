---
name: isolated-worktree
description: Start new branch work in an isolated git worktree off the repo's base branch (develop/main) instead of a shared checkout, so a concurrent Claude session (or teammate) editing the same repo can't clobber your branch, mis-base your PR, or bleed their uncommitted files into your commit. Trigger on "create a branch", "start working on X", or any new feature/fix/chore/perf branch in a repo that may have other active sessions.
---

# Isolated Worktree for Branch Work

Use a dedicated git **worktree** (a second working directory on its own branch) instead of `git checkout -b` in the shared checkout, whenever you start a new branch in a repo that another session might also be editing.

## Why (this has bitten real work)
A plain `git checkout -b` shares ONE working directory and ONE HEAD. A concurrent session that switches branches or leaves uncommitted files will contaminate yours. Concretely, in a real multi-session repo this caused:
- a PR **mis-based on a stale local `develop`**, re-introducing already-merged commits (had to close + redo),
- **stray files** from another session's WIP riding in the working tree and nearly landing in the wrong commit.

A worktree gives you a **separate checkout on its own branch** — fully isolated from the shared one.

## Steps
1. **Pick the base branch for THIS repo.** Typical convention: app repos branch off **`develop`**, tooling repos off **`main`**. When unsure, check the repo's `.claude/CLAUDE.md`.
2. From the main repo dir, fetch the remote base:
   ```bash
   git fetch origin <base> -q
   ```
3. **Create the worktree + branch off `origin/<base>` (the REMOTE, never stale local):**
   ```bash
   WT="$(dirname "$PWD")/$(basename "$PWD")-wt-<short-purpose>"
   git worktree add -b <type>/<slug> "$WT" origin/<base>
   ```
   Branch prefix per convention: `feature/` `fix/` `chore/` `perf/`.
4. **Verify** the new checkout:
   ```bash
   cd "$WT"
   git branch --show-current                 # == <type>/<slug>
   git rev-parse --short HEAD                 # == origin/<base>
   git status --short                         # empty = clean, no bleed-in
   ```
5. **Reuse tooling without copying it** (`.venv`/`node_modules` are gitignored, so a worktree starts without them):
   - **Python:** call the main repo's interpreter by absolute path — deps resolve from the venv, app code from the worktree CWD:
     ```bash
     /path/to/main-repo/.venv/bin/python -m pytest ...
     ```
   - **Node:** run `npm ci` in the worktree (or symlink `node_modules` if huge).
6. Work, commit, push, and open the PR **from inside the worktree dir**.

## Cleanup (after the branch merges or is abandoned)
```bash
cd <main-repo>
git worktree remove <WT>      # add --force if it holds build artifacts
git worktree prune            # tidy stale entries
```
The branch survives worktree removal; delete it separately if unwanted. (A worktree with no changes is auto-cleaned by some harnesses, but remove it explicitly to be safe.)

## Gotchas
- **Always branch off `origin/<base>`, not local `<base>`** — local can be stale and silently mis-base the PR.
- A worktree **cannot** live inside the repo directory — use a sibling path.
- You **cannot** check out the same branch in two worktrees.
- Even in a worktree, run `git branch --show-current` right before every commit as a habit.
- `git add` only your own files; never `git add -A` if the tree might carry another session's WIP.
