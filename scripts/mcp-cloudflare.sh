#!/usr/bin/env bash
# MCP wrapper: Cloudflare — pulls API token + account ID from Vault at runtime
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
export CLOUDFLARE_API_TOKEN="$("${SCRIPT_DIR}/vault-fetch.sh" cloudflare tunnel_api_token)"
ACCOUNT_ID="$("${SCRIPT_DIR}/vault-fetch.sh" cloudflare account_id)"

exec npx -y @cloudflare/mcp-server-cloudflare@latest run "${ACCOUNT_ID}" "$@"
