---
name: draft-ticket
description: Create a well-formed engineering ticket (new feature task or bug fix) with Definition of Ready and Definition of Done sections, from a text goal, Notion pages, or both
---

# Create Ticket

Create a ticket that meets the team's Definition of Ready (DoR) and Definition of Done (DoD).

The DoR/DoD criteria are in `references/definition-of-ready-and-done.md`. Read that file and use it as the only source for these criteria. Do NOT search for, fetch, or open any Notion page to get DoR/DoD criteria.

## Workflow

### 1. Ask the ticket type

Ask the user (use the question tool if available) before anything else:

> Is this ticket a **New Feature Task** or a **Bug Fix**?

Do not guess the type. Wait for the answer.

### 2. Gather the goal

The goal can come from any combination of:

- Text typed by the user.
- One or more Notion page URLs or titles provided by the user.

If the user gave a Notion page for the goal, fetch it with the available Notion tool and read it. Only fetch pages the user explicitly provided as goal context. Never fetch the DoR/DoD page.

If no goal has been provided, ask for one. If the goal is unclear after reading, ask at most 2–3 focused clarifying questions. Otherwise, proceed with reasonable assumptions and list them under "Assumptions".

### 3. Load the template

Read `references/dor-dod.md` and select the section for the chosen type:

- New Feature Task: "New Feature Task" DoR and DoD.
- Bug Fix: "Bug Fix / Change Request" DoR and DoD.

### 4. Fill each criterion, and ask about those that do not apply

For every DoR and DoD item in the selected section:

1. Draft the content from the goal and context where you can.
2. If the item clearly applies but you lack the information, mark it `TODO: <what is missing>`. Do not invent facts (payloads, site IDs, owners, dates).
3. If the item may not apply (for example feature flags, deployment strategy, comms, non-functional requirements, runbooks), do not drop it silently. Collect all such items and ask the user ONCE, in a single batched question: for each item, "Include or ignore?"
4. Items the user ignores are omitted from the ticket. List them in a short "Skipped (N/A)" line at the end so the decision is visible.

Never decide on your own that a section is not applicable.

### 5. Draft and confirm

Produce the ticket using the output format below. Show the draft to the user and ask for edits. Only finalize after approval. If the user asks to create it in a tracker (Asana, Jira, Notion, etc.) and a tool for it is available, do so after approval.

### 6. Deliver the final ticket (no files)

Never write the ticket to a file, and never save it anywhere on disk.

After approval, deliver the final ticket so the user can copy it:

1. Copy it to the clipboard by piping it to a clipboard command through stdin (heredoc), for example `pbcopy` (macOS), `wl-copy` or `xclip -selection clipboard` (Linux), or `clip` (Windows). Use the one that exists. Do not create temporary files.
2. Also print the final ticket once, as raw Markdown inside a single fenced code block (use a four-backtick fence so inner fences and checkboxes survive), with no commentary inside the block.
3. Tell the user in one line whether the clipboard copy succeeded. If no clipboard command is available, say so and rely on the code block.


## Output format

```markdown
# <Concise ticket title>

## Summary
<1–3 sentences: what and why>

## Background / Context
<Relevant detail from the goal and source pages>

## Assumptions
- <only if any>

## Scope

## Acceptance Criteria

## Non-functional requirements

## Delivery

## Links
<Notion pages, related tickets, if any>

## Open Questions
- <only if any>

_Skipped (N/A): <items the user chose to ignore>_
```

## Title rules

- Imperative, specific, under ~80 characters.
- Describe the outcome or problem, not the solution.
- Good: `Login fails with 500 when email contains a plus sign`
- Bad: `Fix login`

## Rules for the output:

- Group DoR and DoD items under the sub-headings used in the reference (for example Scope & requirements, Impact analysis, Delivery).
- Acceptance criteria must be specific and testable, written as a checklist.
- For bug fixes, always include reproduction details (steps, payload, relevant IDs, expected vs actual behaviour) or a TODO for them.
- Keep wording concise. No filler.
- Never invent facts, reproduction steps, or versions. Mark unknowns as `TBD`.
- Redact secrets, tokens, credentials, and personal data from logs and snippets.
- Suggest splitting if the request covers several.
