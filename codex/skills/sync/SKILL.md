---
name: sync
description: Safely sync the current project branch with its remote before work.
---

1. Confirm repository, current branch, remote, and working tree.
2. If uncommitted changes exist, preserve them. Do not stash, discard, or overwrite without an explicit request; report them and stop before pulling.
3. Fetch the current branch and fast-forward when possible. If histories diverged, explain and ask before creating a merge/rebase.
4. Report remote, branch, and commits pulled. Log significant syncs only when project instructions require it.
