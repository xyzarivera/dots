---
name: pr-reviewer
description: Review a GitHub pull request given only its link. Reads the PR description, finds the linked Asana ticket, follows Asana and Notion links from the ticket, then performs the code review. Use when given a GitHub PR URL and asked to review it.
---

# PR Reviewer

Input: a GitHub PR link. Everything else (Asana ticket, specs) is discovered from the PR itself.

If no PR link is given, ask for it. If the PR description has no Asana link, ask the user for the ticket before continuing.

## Permission rules (mandatory)

- **Read-only calls are allowed by default** — no need to ask first. This covers: `gh pr view`, `gh pr diff`, `gh pr checks`, `gh api` (GET only), Asana MCP reads (get task, stories, attachments, search), and Notion MCP reads (fetch, search).
- **Any call that creates, edits, or otherwise mutates state requires explicit user approval before running it.** This covers posting comments, approving, requesting changes, merging, or editing anything in GitHub, Asana, or Notion. Never assume consent for these; confirm again right before doing it, with the exact text/action shown.
- If a read-only call fails or is denied, continue with the remaining sources and note the gap in the report.

(Adjust the `asana_*` / `notion_*` patterns to match your configured MCP server names.)

## Workflow

Follow the steps in order. Do the context gathering (steps 1-3) fully before reading any code (step 4).

### 1. Review the PR description
Run:

```zsh
gh pr view <url> --json title,body,author,baseRefName,headRefName,labels,files,additions,deletions,reviews,comments
```

Extract from the title and body:
- Purpose, summary of changes, testing notes, screenshots, caveats
- **Asana ticket link(s) or ID(s)** (match `app.asana.com` URLs and any ticket-ID patterns)
- Any Notion links or other referenced docs

Also check the PR comments and branch name for ticket references if the body has none.

### 2. Review the Asana ticket
Use the Asana MCP to fetch the ticket: title, description, acceptance criteria, subtasks, comments/stories, attachments, parent task, and dependencies.

Extract:
- Goal, acceptance criteria, scope boundaries and non-goals
- Decisions or changes of scope made in comments
- **All Asana links** (parent, related, dependent tasks) and **all Notion links**

### 3. Review linked Asana and Notion items
For each Asana link and Notion link found in the ticket (and the PR description), fetch it:
- Asana tasks via the Asana MCP (read the description and key comments)
- Notion pages via the Notion MCP (specs, designs, ADRs, API contracts)

Follow links one level deep by default. Go deeper only if a linked item is clearly essential (e.g. the main spec points to a sub-spec). Skip unrelated links (e.g. general company docs) and list them as skipped.

Summarize the combined context before moving on:
- What should be built, and why
- Requirements, constraints, and acceptance criteria
- Open questions or contradictions between PR description, ticket, and specs

### 4. Code review
Run (read-only):

```zsh
gh pr diff <url>
gh pr checks <url>
```

For large diffs, review file by file. Use `gh api` GET calls to read surrounding file contents at the head ref when the diff lacks context.

Evaluate the PR against the context from steps 1-3:

1. **Requirements fit**: Does each acceptance criterion and spec requirement have corresponding code? Anything missing, or out of scope?
2. **Correctness**: Logic bugs, edge cases, error handling, null/undefined, concurrency, off-by-one.
3. **Security**: Input validation, authn/authz, secrets, injection, unsafe dependencies.
4. **Tests**: Coverage of new behavior and edge cases; CI status.
5. **Design and maintainability**: Naming, duplication, complexity, consistency with codebase conventions.
6. **Performance**: N+1 queries, needless loops, large payloads, blocking calls.
7. **Compatibility**: Breaking API/schema changes, migrations, feature flags, rollback safety.
8. **PR hygiene**: Description accuracy versus the actual diff, ticket linked, reasonable size, no stray debug code or unrelated changes.

Cite findings as `path/to/file.ext:line`. Don't invent issues; if unsure, label it a question.

### 5. Report
Output in this format:

```
## PR Review: <PR title>
**PR**: <url>  |  **Ticket**: <asana title / link>  |  **CI**: <pass/fail/pending>

### Context Reviewed
- PR description: <one-line takeaway>
- Asana ticket: <one-line takeaway>
- Linked Asana/Notion: <list of items read, with one-line takeaway each>
- Skipped / unavailable: <items, or "none">

### Summary
<2-3 sentences: what the PR does and overall verdict>

### Requirements Check
| Requirement (source) | Status | Notes |
|---|---|---|
| ... | Met / Partial / Missing | ... |

### Findings
**Blocking**
- `file:line` - issue, why it matters, suggested fix

**Non-blocking**
- `file:line` - suggestion

**Questions**
- ...

### Positives
- ...

### Verdict
Approve / Approve with comments / Request changes
```

Omit empty sections.

### 6. Follow-up (only if asked)
Offer, but do not perform unprompted: posting the review to GitHub (`gh pr review` / `gh pr comment`) or commenting on the Asana ticket. Show the exact text and ask permission before sending.
