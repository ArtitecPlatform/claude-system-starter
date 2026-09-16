#!/usr/bin/env bash
# MCP wrapper: GitHub — pulls PAT from Vault at runtime
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
export GITHUB_PERSONAL_ACCESS_TOKEN="$("${SCRIPT_DIR}/vault-fetch.sh" github platform_token)"

exec npx -y @modelcontextprotocol/server-github "$@"
