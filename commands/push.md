# /push

Commit and push current work to GitHub with branch enforcement.

## Steps

1. Run `git status` to show what has changed.

2. Ask the user for a commit message if they haven't provided one. Keep it meaningful — describe *why*, not just *what*.

3. **Branch enforcement:**
   - Check the current branch name.
   - If on `main` or `master` → **STOP**. Do not push. Tell the user: "Direct pushes to main are not allowed. Create a feature branch first." Offer to create one (`feature/`, `fix/`, or `chore/` prefix).
   - If branch name doesn't follow `feature/`, `fix/`, or `chore/` convention → warn the user and ask if they want to rename or continue anyway.

4. Stage all relevant changes: `git add -A` (or specific files if the user specifies).

5. Commit: `git commit -m "[message]"`

6. Push: `git push origin [branch-name]`
   - If the branch doesn't exist on remote yet, use `git push -u origin [branch-name]`

7. Report the push result (commit hash, branch, remote URL).

8. Append to `.claude/logs/updates.md`:
```
## [YYYY-MM-DD] Push — [branch-name]
- [Commit message]
- Files changed: [brief list or count]
```

9. Trim `logs/updates.md` to 30 entries if it exceeds that.
