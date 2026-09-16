#!/usr/bin/env bash
# MCP wrapper: MySQL — pulls credentials from Vault at runtime
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

export MYSQL_HOST="$("${SCRIPT_DIR}/vault-fetch.sh" mcp-servers mysql_host)"
export MYSQL_PORT="$("${SCRIPT_DIR}/vault-fetch.sh" mcp-servers mysql_port)"
export MYSQL_USER="$("${SCRIPT_DIR}/vault-fetch.sh" mcp-servers mysql_user)"
export MYSQL_PASSWORD="$("${SCRIPT_DIR}/vault-fetch.sh" mcp-servers mysql_password)"
export MYSQL_DATABASE="$("${SCRIPT_DIR}/vault-fetch.sh" mcp-servers mysql_database)"
export ALLOW_DDL=true
export ALLOW_DROP=true
export ALLOW_DELETE=true

exec npx -y @liangshanli/mcp-server-mysql "$@"
