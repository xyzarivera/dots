---
name: unit-testing
description: >-
  Writes maintainable unit tests for production code using Google SWE Book
  practices (Ch. 11–12). Use when adding or updating unit tests, improving test
  coverage for new features or bug fixes, refactoring tests, or when the user
  asks for unit tests, spec files, or test-driven changes alongside production
  code.
---

# Unit testing (production code)

Distilled from Google SWE Book Ch. 11 (Testing Overview) and Ch. 12 (Unit Testing). Optimize for **confidence to change code** and **maintainable tests**, not coverage percentages.

## When to apply

- User adds/changes production code and needs tests.
- User asks for unit tests, specs, or regression tests.
- Fixing a bug → add a test that would have caught it.
- Refactoring → existing unit tests should **not** need changes unless behavior changed.

**Beyoncé rule:** If behavior must not break, add an automated test for it.

## Workflow

1. **Read production code** — identify the unit (class/module/function) and its **public API** (what callers outside the owning team use).
2. **List behaviors** — one guarantee per test (Given / When / Then). Do not mirror methods 1:1.
3. **Check repo conventions** — locate sibling `spec/` or `*.spec.ts` files; match framework (usually **Vitest**: `describe`, `it`, `expect`), import style, fixtures, and path aliases (`@/`, `spec/fixtures`).
4. **Write tests** — follow rules below; colocate under `spec/` mirroring `src/` layout when that is the local pattern.
5. **Run tests** — use the package’s test script (e.g. `npm test`, `vitest run <file>`) and fix failures before finishing.

## Core rules

### Test the public API (“front door”)

- Call the system the way **users/callers** do — exported functions, public class methods, HTTP handlers via their public contract.
- **Do not** test private helpers, internal modules, or implementation details directly.
- **Do not** widen visibility or use test-only hooks solely to test internals.

### One behavior per test

- Split scenarios: happy path, edge cases, errors, boundary values.
- Name tests after **behavior + outcome** (e.g. `should return empty list when no schedules match`).
- Avoid **and** in test names — split into multiple tests.
- Structure: **Given** setup → **When** action → **Then** assert. Do not merge When and Then unless documenting a deliberate multi-step flow.

### Assert state, not interactions

- Prefer assertions on **return values**, persisted state, or observable outcomes.
- Avoid `verify(mock).calledWith(...)` unless interaction order is the actual contract.
- Prefer **real or fake** dependencies when fast and deterministic; use mocks sparingly.

### Unchanging tests

| Change type | Update existing unit tests? |
|-------------|----------------------------|
| Pure refactor (same behavior) | No |
| New feature | No — add new tests only |
| Bug fix | No — add missing case |
| Intentional behavior change | Yes |

If a refactor breaks tests, either behavior changed or tests were too coupled to implementation.

### Clarity: complete, concise, no logic

- Test body contains **everything needed to understand it**; hide only irrelevant boilerplate.
- **No logic in tests**: no loops, conditionals, or computed expected values — use literals so failures are obvious.
- **DAMP over DRY**: duplication in tests is OK if it aids readability; do not hide intent in opaque shared helpers.
- Shared setup (`beforeEach` / `beforeAll`): only default construction; values the test cares about must appear **in the test body**.
- Use **builders/fixtures** with descriptive names (`closedAccount`, `schedulePastWindow`) — not `ACCOUNT_1`.

### Failure messages

- Assertions should make **expected vs actual** obvious without opening the test file.
- Prefer assertion libraries that include the subject in the message (e.g. Vitest/Jest `expect(x).toEqual(y)` with clear objects).

## What to cover

- Happy path and important edge cases for the behavior under change.
- Error paths and invalid inputs where the API defines them.
- Regression for the specific bug or feature being added.

Do **not** treat line coverage % as a goal or stop at a coverage ceiling.

## Anti-patterns (reject or refactor)

| Anti-pattern | Instead |
|--------------|---------|
| One test per production method, many assertions | One test per behavior |
| Testing private functions | Test via public API |
| Heavy interaction mocking | State assertions; fakes |
| Shared `validate()` at end of every test | One concept per assertion block |
| `sleep()` / arbitrary timeouts | Deterministic fakes; poll + timeout only if unavoidable |
| Opaque `createUsers(false, true)` helpers | Inline or named builders in the test |
| Skipping or weakening tests to merge | Fix product or fix test intent |

## Pre-submit checklist

- [ ] Tests use the unit’s **public API**
- [ ] Each test covers **one behavior** with a descriptive name
- [ ] Given / When / Then is clear; no hidden magic in setup
- [ ] No logic in test bodies; expected values are explicit
- [ ] Assertions check **outcomes**, not mock call lists
- [ ] New behavior → **new tests**; existing tests unchanged unless contract changed
- [ ] Tests match local **framework and folder conventions**
- [ ] Tests **pass** when run in the package

## Repo hints

- Tests often live under `spec/` with `*.spec.ts` naming.
- **Vitest** is common: `import { describe, it, expect, beforeAll, afterAll } from 'vitest'`.
- Reuse `spec/fixtures` and builders when they keep tests **descriptive**; override defaults in the test when the value matters.
- Some packages use Jest — follow the nearest existing spec file in that package.

## Additional resources

- Vitest/Jest patterns and templates: [examples.md](examples.md)
