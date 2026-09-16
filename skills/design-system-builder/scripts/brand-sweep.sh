#!/usr/bin/env bash
# Off-brand color/font sweep. Exit 1 on any hit.
# Usage: scripts/brand-sweep.sh [path...]   (default: src)
# Edit the two regexes for your brand (see docs/design/tokens.md).
set -uo pipefail

OFFBRAND_COLORS='(amber|emerald|blue|indigo|violet|rose|orange|fuchsia|lime|teal|cyan|sky|purple|pink)-[0-9]{2,3}'
OFFBRAND_FONTS='font-serif|font-franklin|font-inter|font-roboto'
TARGETS=("${@:-src}")

hits=$(grep -rnE --include='*.tsx' --include='*.jsx' --include='*.ts' --include='*.css' --include='*.html' --include='*.vue' --include='*.svelte' \
  "${OFFBRAND_COLORS}|${OFFBRAND_FONTS}" "${TARGETS[@]}" 2>/dev/null | grep -v 'design-plate' || true)

if [[ -n "$hits" ]]; then
  echo "brand-sweep: off-brand tokens found:" >&2
  echo "$hits" >&2
  echo >&2
  echo "Replace with brand tokens (see docs/design/tokens.md)." >&2
  exit 1
fi
echo "brand-sweep: clean"
