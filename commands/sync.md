# /sync

Pull the latest changes from GitHub remote for the current project and branch.

## Steps

1. Run `git remote -v` to confirm the remote URL and identify which GitHub account this repo belongs to.

2. Run `git status` — if there are uncommitted changes, warn the user and ask:
   - Stash changes and sync, then restore?
   - Commit first, then sync? (redirect to /push)
   - Cancel?

3. Run `git pull origin [current-branch]`.

4. Report:
   - How many commits were pulled
   - Any merge conflicts (and help resolve them if present)
   - If already up to date

5. Append to `.claude/logs/updates.md`:
```
## [YYYY-MM-DD] Sync — [branch-name]
- Pulled latest from origin/[branch-name]
- [X commits pulled / already up to date]
```

6. Trim `logs/updates.md` to 30 entries if it exceeds that.
