#!/usr/bin/env bash
# Fetch a secret value from HashiCorp Vault (KV v2).
# Usage: vault-fetch.sh <path> <key>
# Example: vault-fetch.sh github platform_token
#
# Token precedence: $VAULT_TOKEN → ~/.vault-token → fail loud.
# Never hardcode a token fallback here: a stale token silently returns
# tracebacks in place of secret values, which is worse than failing.

set -euo pipefail

VAULT_ADDR="${VAULT_ADDR:-http://vault.example.internal:8200}"   # <-- set to your Vault
if [[ -z "${VAULT_TOKEN:-}" ]]; then
  if [[ -r "${HOME}/.vault-token" ]]; then
    VAULT_TOKEN="$(< "${HOME}/.vault-token")"
  else
    echo "vault-fetch: no VAULT_TOKEN env var and no ~/.vault-token file" >&2
    exit 1
  fi
fi

PATH_ARG="$1"
KEY_ARG="$2"

curl -sf \
  -H "X-Vault-Token: ${VAULT_TOKEN}" \
  "${VAULT_ADDR}/v1/secret/data/${PATH_ARG}" \
  | python3 -c \
    "import sys,json; print(json.load(sys.stdin)['data']['data']['${KEY_ARG}'])"
