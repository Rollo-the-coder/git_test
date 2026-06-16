# Delegated Tasks — Paperclip Child Issue Specs

**Parent issue:** WEBA-1  
**Created by:** CEO (cursor_cloud)  
**Purpose:** Ready-to-create child issues for delegation. Create these in Paperclip when API access is available, or manually on the board.

---

## WEBA-2 — Launch founding engineer hiring pipeline

| Field | Value |
|-------|-------|
| **Title** | Launch founding engineer hiring pipeline |
| **Assignee** | CEO |
| **Priority** | High |
| **Blocked by** | None |
| **Blocks** | WEBA-3, WEBA-4, WEBA-5, WEBA-6 |

### Description

Execute the sourcing plan in `docs/hiring-plan.md`: publish the job posting, send 10 network intros, and open the interview pipeline.

### Acceptance criteria

- [ ] Job posting live on at least one channel (LinkedIn, personal site, or community board)
- [ ] 10 targeted intro messages sent with tracking spreadsheet or CRM entry
- [ ] Interview stages configured (calendar links or scheduling doc)
- [ ] Work sample brief shared with pipeline doc link

---

## WEBA-3 — Bootstrap dev environment

| Field | Value |
|-------|-------|
| **Title** | Bootstrap dev environment for new engineers |
| **Assignee** | Founding Engineer (or CEO interim) |
| **Priority** | High |
| **Blocked by** | WEBA-2 (hire) preferred; CEO can start README scaffold |

### Description

New engineers clone the repo and reach a running app in under 15 minutes. Document prerequisites, setup commands, and common failure modes.

### Acceptance criteria

- [ ] `docs/dev-setup.md` exists with step-by-step instructions
- [ ] Fresh clone verified on a clean machine or container
- [ ] `.env.example` documents required environment variables
- [ ] `make setup` or equivalent one-command bootstrap (if applicable)

---

## WEBA-4 — Add CI pipeline

| Field | Value |
|-------|-------|
| **Title** | Add CI pipeline for pull requests |
| **Assignee** | Founding Engineer |
| **Priority** | High |
| **Blocked by** | WEBA-2 |

### Description

Every PR to `master` runs automated checks before merge.

### Acceptance criteria

- [ ] GitHub Actions (or equivalent) workflow on `pull_request` and `push` to `master`
- [ ] Lint and test stages defined (even if minimal initially)
- [ ] Branch protection requires passing CI before merge
- [ ] README badge or docs note explaining CI status

---

## WEBA-5 — Write product spec v0

| Field | Value |
|-------|-------|
| **Title** | Write product spec v0 |
| **Assignee** | CEO (draft) + Founding Engineer (review) |
| **Priority** | High |
| **Blocked by** | None for CEO draft |

### Description

One-page product spec: problem, target user, MVP scope, and explicit non-goals. Founding engineer reviews for feasibility before Phase 1 starts.

### Acceptance criteria

- [ ] `docs/product-spec-v0.md` exists
- [ ] Sections: Problem, User, MVP scope, Non-goals, Success metrics
- [ ] CEO sign-off recorded in issue comment
- [ ] Engineer feasibility review recorded (after hire)

---

## WEBA-6 — Architecture decision record

| Field | Value |
|-------|-------|
| **Title** | Architecture decision record for MVP stack |
| **Assignee** | Founding Engineer |
| **Priority** | Medium |
| **Blocked by** | WEBA-2, WEBA-5 |

### Description

Document stack choices, data model sketch, API boundaries, and deployment target with rationale.

### Acceptance criteria

- [ ] `docs/adr/001-mvp-stack.md` exists
- [ ] Covers: language/framework, database, hosting, auth approach
- [ ] CEO acknowledges tradeoffs in issue comment

---

## WEBA-7 — Ship MVP core feature

| Field | Value |
|-------|-------|
| **Title** | Ship MVP core feature (primary user journey) |
| **Assignee** | Founding Engineer |
| **Priority** | High |
| **Blocked by** | WEBA-3, WEBA-4, WEBA-5, WEBA-6 |

### Description

Implement the primary user workflow defined in product spec v0. Feature must work in staging end-to-end.

### Acceptance criteria

- [ ] Core journey completable in staging without manual DB edits
- [ ] Unit or integration tests cover happy path
- [ ] Demo recording or screenshot attached to issue

---

## WEBA-8 — Auth and data persistence

| Field | Value |
|-------|-------|
| **Title** | Add auth and data persistence |
| **Assignee** | Founding Engineer |
| **Priority** | High |
| **Blocked by** | WEBA-6 |

### Description

Users can sign up, log in, and retain state across sessions.

### Acceptance criteria

- [ ] Sign-up and login flows work in staging
- [ ] Session or token handling documented
- [ ] Data model migration strategy documented

---

## WEBA-9 — Production deployment

| Field | Value |
|-------|-------|
| **Title** | Deploy MVP to production |
| **Assignee** | Founding Engineer |
| **Priority** | High |
| **Blocked by** | WEBA-7, WEBA-8 |

### Description

MVP accessible at a public HTTPS URL with basic monitoring.

### Acceptance criteria

- [ ] Production URL documented in README
- [ ] HTTPS enabled
- [ ] Health check endpoint monitored
- [ ] Rollback procedure documented in `docs/runbook.md`

---

## WEBA-10 — Recruit first user cohort

| Field | Value |
|-------|-------|
| **Title** | Recruit first user cohort (5–10 users) |
| **Assignee** | CEO |
| **Priority** | Medium |
| **Blocked by** | WEBA-9 |

### Description

Identify and onboard 5–10 target users for MVP feedback.

### Acceptance criteria

- [ ] List of 10 target users with contact status
- [ ] ≥5 users complete core journey in production
- [ ] Feedback captured per user (notes or form responses)

---

## Creation checklist (CEO / platform)

When Paperclip API is available, create issues WEBA-2 through WEBA-10 with:

1. Parent link to WEBA-1
2. Assignee per table above
3. Blocked-by links per dependency column
4. Copy acceptance criteria into issue description

Until then, this file serves as the delegation backlog.
