#!/usr/bin/env bash
# Resolve WEBA-1 recovery: sync closure to Paperclip board when API key is available.
# Handles source_scoped_recovery_action wake for blocked WEBA-1.
set -euo pipefail

API_URL="${PAPERCLIP_API_URL:?PAPERCLIP_API_URL required}"
ISSUE_ID="${PAPERCLIP_TASK_ID:?PAPERCLIP_TASK_ID required}"

if [[ -z "${PAPERCLIP_API_KEY:-}" ]]; then
  cat >&2 <<EOF
BLOCKED: PAPERCLIP_API_KEY not set.

Owner: Paperclip/Cursor cloud platform
Action: Add PAPERCLIP_API_KEY to CLOUD_AGENT_INJECTED_SECRET_NAMES

Repo work is complete on master (75b3394). GitHub tracking:
- Apply: https://github.com/Rollo-the-coder/git_test/issues/1
- WEBA-2: https://github.com/Rollo-the-coder/git_test/issues/2

Re-run this script after API key injection.
EOF
  exit 2
fi

AUTH_HEADER="Authorization: Bearer ${PAPERCLIP_API_KEY}"

echo "==> Running WEBA-1 closure sync"
bash "$(dirname "$0")/paperclip-close-weba1.sh"

echo "==> Resolving recovery action (if any)"
ACTIONS=$(curl -sf -H "${AUTH_HEADER}" "${API_URL}/api/issues/${ISSUE_ID}/recovery-actions" || echo '{}')
ACTION_ID=$(echo "$ACTIONS" | jq -r '.actions[0].id // .items[0].id // empty')

if [[ -n "$ACTION_ID" ]]; then
  curl -sf -X POST "${API_URL}/api/issues/${ISSUE_ID}/recovery-actions/resolve" \
    -H "${AUTH_HEADER}" \
    -H "Content-Type: application/json" \
    -d "$(jq -n \
      --arg actionId "$ACTION_ID" \
      '{
        actionId: $actionId,
        outcome: "restored",
        sourceIssueStatus: "blocked",
        resolutionNote: "WEBA-1 deliverables complete on master. Closure synced via API."
      }')"
  echo "==> Recovery action resolved"
else
  echo "==> No pending recovery action found (closure sync may be sufficient)"
fi

echo "==> WEBA-1 recovery complete"
