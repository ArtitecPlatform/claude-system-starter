# Memory Index
- [Prod deploy swaps api only (2026-09-06)](reference_prod_deploy_swaps_api_only.md) — worker keeps its old image across releases; check jobs diff before shipping.
- [Local venv broken (2026-09-06)](reference_backend_local_venv_broken.md) — repo venv is a dead symlink; use `uv venv --python 3.12`.
- [ssh timeout ≠ remote kill](feedback_ssh_timeout_does_not_kill_remote_process.md) — local timeout leaves the remote command running; caused an outage.
- [Research model routing](feedback_directory_research_model.md) — Sonnet research + Haiku verify (not Opus).
- [Branch base rule](feedback_branch_base.md) — app repos branch off develop; tooling repos off main.
- [Main branch protection ENFORCED](project_main_branch_protection.md) — all repos protected; PRs only.

> Trimmed 2026-08-27. Completed one-off work moved to `MEMORY_ARCHIVE.md` (not auto-loaded; Read it if you need an older pointer).
