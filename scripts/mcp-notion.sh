#!/usr/bin/env bash
# MCP wrapper: Notion — pulls integration token from Vault at runtime
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
NOTION_TOKEN="$("${SCRIPT_DIR}/vault-fetch.sh" notion token)"

export OPENAPI_MCP_HEADERS="{\"Authorization\":\"Bearer ${NOTION_TOKEN}\",\"Notion-Version\":\"2022-06-28\"}"

exec npx -y @notionhq/notion-mcp-server "$@"
