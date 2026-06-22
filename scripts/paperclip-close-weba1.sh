#!/usr/bin/env bash
# Close WEBA-1 on Paperclip: post closure comment, mark done, create WEBA-2 child issue.
# Requires PAPERCLIP_API_KEY (Agent API Key or Agent JWT) in environment.
set -euo pipefail

API_URL="${PAPERCLIP_API_URL:?PAPERCLIP_API_URL required}"
ISSUE_ID="${PAPERCLIP_TASK_ID:?PAPERCLIP_TASK_ID required}"
AGENT_ID="${PAPERCLIP_AGENT_ID:?PAPERCLIP_AGENT_ID required}"
API_KEY="${PAPERCLIP_API_KEY:?PAPERCLIP_API_KEY required — add to CLOUD_AGENT_INJECTED_SECRET_NAMES}"

AUTH_HEADER="Authorization: Bearer ${API_KEY}"

echo "==> Posting WEBA-1 closure comment"
CLOSURE_BODY=$(cat <<'EOF'
## WEBA-1 complete — hiring plan and delegation ready

All WEBA-1 deliverables are on `master` at github.com/Rollo-the-coder/git_test.

### Deliverables
- `docs/hiring-plan.md` — founding engineer hiring plan
- `docs/roadmap.md` — 90-day engineering roadmap
- `docs/delegated-tasks.md` — child issue specs (WEBA-2 through WEBA-10)
- `docs/job-posting.md` — publish-ready job posting
- `docs/hiring/outreach-templates.md` — 4 outreach templates
- `docs/hiring/pipeline-tracker.md` — pipeline tracker + acceptance checklist
- `docs/paperclip-child-issues.json` — API-ready import spec

### Disposition
**done** — planning and delegation prep complete. Actual hire continues under WEBA-2.

### Next
Hiring channel live: github.com/Rollo-the-coder/git_test/issues/1
CEO: send 10 intros, fill calendar links → WEBA-2
EOF
)

curl -sf -X POST "${API_URL}/api/issues/${ISSUE_ID}/comments" \
  -H "${AUTH_HEADER}" \
  -H "Content-Type: application/json" \
  -d "$(jq -n \
    --arg body "$CLOSURE_BODY" \
    '{body: $body, authorType: "agent", presentation: {kind: "message", tone: "success"}}')"

echo "==> Marking WEBA-1 done"
curl -sf -X PATCH "${API_URL}/api/issues/${ISSUE_ID}" \
  -H "${AUTH_HEADER}" \
  -H "Content-Type: application/json" \
  -d '{"status": "done", "comment": {"body": "WEBA-1 planning complete. See closure comment for deliverables."}}'

echo "==> Creating WEBA-2 child issue"
curl -sf -X POST "${API_URL}/api/issues/${ISSUE_ID}/children" \
  -H "${AUTH_HEADER}" \
  -H "Content-Type: application/json" \
  -d "$(jq -n \
    --arg agentId "$AGENT_ID" \
    '{
      title: "Launch founding engineer hiring pipeline",
      description: "Execute docs/hiring-plan.md: publish job posting, send 10 network intros, configure interview pipeline. Artifacts: docs/job-posting.md, docs/hiring/outreach-templates.md, docs/hiring/pipeline-tracker.md",
      status: "todo",
      priority: "high",
      assigneeAgentId: $agentId
    }')"

echo "==> WEBA-1 closure sync complete"
