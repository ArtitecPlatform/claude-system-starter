#!/usr/bin/env bash
# Non-destructive Codex kit installer. Existing files get a .kit-new sibling.
set -euo pipefail

SRC="$(cd "$(dirname "$0")" && pwd)"
CODEX_DIR="$HOME/.codex"
SKILLS_DIR="$HOME/.agents/skills"
mkdir -p "$CODEX_DIR" "$SKILLS_DIR"

copy() {
  local src="$1" dst="$2"
  if [[ -e "$dst" ]]; then
    local candidate="$dst.kit-new" suffix=1
    while [[ -e "$candidate" ]]; do
      candidate="$dst.kit-new.$suffix"
      suffix=$((suffix + 1))
    done
    cp -R "$src" "$candidate"
    printf 'exists; wrote %s\n' "$candidate"
  else
    cp -R "$src" "$dst"
    printf 'installed %s\n' "$dst"
  fi
}

copy "$SRC/AGENTS.md" "$CODEX_DIR/AGENTS.md"
copy "$SRC/project-template" "$CODEX_DIR/project-template"
for skill in "$SRC"/skills/*; do
  [[ -d "$skill" ]] || continue
  copy "$skill" "$SKILLS_DIR/$(basename "$skill")"
done
printf '\nReview %s/AGENTS.md and replace placeholders.\n' "$CODEX_DIR"
