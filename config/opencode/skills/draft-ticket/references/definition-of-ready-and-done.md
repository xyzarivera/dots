# Definition of Ready and Definition of Done (Generic Reference)

It is the single source of truth for the `create-ticket` skill.

- **Definition of Ready (DoR):** criteria that show a ticket is ready for development. These cover ticket attributes, team readiness, external approvals, and blocking prerequisites.
- **Definition of Done (DoD):** criteria that must be met for the work to be considered finished and ready for release. These cover work done on the task: testing, deployment checks, and cross-checking against acceptance criteria.

Items marked *(conditional)* apply only if relevant; ask the user whether to include or ignore them.

---

## New Feature Task

### Definition of Ready

**Scope & requirements**
- Acceptance criteria are written and agreed.
- Non-functional requirements are defined *(conditional)*:
  - Observability requirements are defined and ready to implement (logs, metrics, alerts).
  - Performance requirements are defined and have an agreed validation approach.

**Impact analysis**
- Impact is assessed and documented (blast radius, downstream changes, payload structure).

**Delivery**
- Comms requirements are defined (who, what, when). *(conditional)*
- Feature flag approach is agreed. *(conditional: if required)*
- Deployment strategy is agreed. *(conditional: if applicable)*

### Definition of Done

**Check implementation**
- Feature flag is implemented and verified to function. *(conditional: if required)*
- Acceptance criteria are met for the task.

**Verification**
- Unit tests are written and passing.
- Integration tests are written and passing.
- Non-functional requirements are tested, manual or automated. *(conditional: if applicable)*

**Delivered**
- Code is deployed to development and production environments.

---

## Bug Fix / Change Request

### Definition of Ready

**Documentation**
- Reason for the change request is documented.
- Bug reproduction details are documented (payload, steps, site ID if relevant).

**Requirements**
- Acceptance criteria are written and agreed.

**Impact analysis**
- Impact is assessed and documented (blast radius, downstream changes, payload structure).

**Delivery**
- Comms requirements are defined (who, what, when). *(conditional)*
- Feature flag strategy is planned, covering implementation and cleanup. *(conditional: if required)*
- Deployment strategy is agreed.

### Definition of Done

**Check implementation**
- Feature flag is implemented and verified to function. *(conditional: if required by implementation)*

**Verification**
- Unit tests are written and passing.
- Integration tests are written and passing.
- End-to-end tests are completed for the key user journeys.
- Non-functional requirements are tested. *(conditional: if applicable)*
- Reproduction steps are covered.

**Delivered**
- Code is deployed to development and production environments.

**Operational readiness**
- Stakeholders verify the bug fix. *(conditional: if required)*
- Stakeholders are informed. *(conditional: if required)*

**Documentation**
- Technical and/or user-facing documentation is updated.
- Runbooks are revised or added as needed. *(conditional)*

---

## New Feature Epic

> Reference only. The `create-ticket` skill does not use this section.

### Definition of Ready

**Documentation**
- Project Quality document is created and covers testing ownership and responsibility at each stage.
- Technical Solution Proposal is written and approved by the relevant stakeholders.

**Scope & requirements**
- Client-facing acceptance criteria are written and agreed with stakeholders.
- Non-functional requirements are defined:
  - Observability requirements are defined and ready to implement (logs, metrics, alerts).
  - Performance requirements are defined and have an agreed validation approach.
- Delivery timeline is agreed (milestones, target release window, dependencies).
- Key assumptions are documented and owned for confirmation.
- Key risks are documented with mitigations and owners.
- Release and rollout plan is defined, with a rollback plan (and feature flag plan if needed).

### Definition of Done

**Quality signal**
- KF Wide E2E is completed for the key user journeys.
- Non-functional requirements are tested (manual or automated).

**Documentation**
- Technical and/or user-facing documentation is updated.

**Operational readiness**
- Runbooks are revised or added as needed.
- Stakeholders verify the feature meets expectations.
- Stakeholders are informed of the change and rollout plan.

**Release governance**
- Production Readiness Review (PRR) is completed.
