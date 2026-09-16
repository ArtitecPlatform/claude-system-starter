#!/usr/bin/env bash
# Install the Claude Code starter kit into ~/.claude (non-destructive).
# Existing files are never overwritten; a *.kit-new copy is placed beside them.
set -euo pipefail

SRC="$(cd "$(dirname "$0")" && pwd)"
DST="${CLAUDE_HOME:-$HOME/.claude}"
mkdir -p "$DST"/{skills,commands,hooks,scripts}

copy() { # copy <src> <dst>
  if [[ -e "$2" ]]; then
    cp -R "$1" "$2.kit-new"; echo "  exists, wrote $2.kit-new"
  else
    cp -R "$1" "$2"; echo "  installed $2"
  fi
}

echo "== global files"
for f in CLAUDE.md RTK.md settings.json statusline-command.sh; do copy "$SRC/$f" "$DST/$f"; done
chmod +x "$DST/statusline-command.sh" 2>/dev/null || true

echo "== commands"; for f in "$SRC"/commands/*.md; do copy "$f" "$DST/commands/$(basename "$f")"; done
echo "== skills";   for d in "$SRC"/skills/*/;   do d=${d%/}; copy "$d" "$DST/skills/$(basename "$d")"; done
echo "== hooks";    copy "$SRC/hooks/gitnexus" "$DST/hooks/gitnexus"
echo "== scripts";  for f in "$SRC"/scripts/*.sh; do copy "$f" "$DST/scripts/$(basename "$f")"; done
chmod +x "$DST"/scripts/*.sh
echo "== project template (used by /init-project)"; copy "$SRC/project-template" "$DST/project-template"

echo
echo "Next steps (see README.md):"
echo "  1. Edit $DST/CLAUDE.md — fill in <org-name>, <vault-host>, indexed repos."
echo "  2. Install plugins:  claude plugin marketplace add obra/superpowers && claude plugin marketplace add JuliusBrussee/caveman"
echo "                       claude plugin install superpowers@superpowers-dev && claude plugin install caveman@caveman"
echo "  3. npm i -g gitnexus && (cd <repo> && gitnexus analyze)"
echo "  4. Merge mcp-servers.example.json into ~/.claude.json; set VAULT_ADDR in scripts/vault-fetch.sh if using Vault."
echo "  5. Optional: install RTK (Rust Token Killer) and its hook, or delete the @RTK.md line from CLAUDE.md."
