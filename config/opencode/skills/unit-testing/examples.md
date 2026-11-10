# Unit testing examples (Vitest / TypeScript)

Patterns aligned with this monorepo. Adapt imports and paths to the package under test.

## Good: public API, one behavior, explicit data

```typescript
import { describe, it, expect } from "vitest";
import { findUpcomingCalculationJobs } from "@/dispatch-planner-task-creator/application/findJob";
import {
  TEST_SITE_1_CM_SCHEDULE_FINAL,
  TEST_SITE_1_CM_SCHEDULE_PAST,
} from "spec/fixtures";

describe(findUpcomingCalculationJobs.name, () => {
  it("should return final and preliminary jobs within the calculation window", () => {
    const inputSchedules = [
      TEST_SITE_1_CM_SCHEDULE_PAST,
      TEST_SITE_1_CM_SCHEDULE_FINAL,
    ];

    const result = findUpcomingCalculationJobs(
      inputSchedules,
      staticDataFixture,
    );

    expect(result).toEqual([expectedFinalJob, expectedPreliminaryJob]);
  });
});
```

## Good: Given / When / Then structure

```typescript
it("should reject withdrawal when balance is insufficient", () => {
  // Given accounts with known balances
  processor.setAccountBalance("sender", 50);
  processor.setAccountBalance("recipient", 20);

  // When transferring more than the sender balance
  processor.processTransaction(transaction({ sender: "sender", amount: 100 }));

  // Then balances are unchanged
  expect(processor.getAccountBalance("sender")).toBe(50);
  expect(processor.getAccountBalance("recipient")).toBe(20);
});
```

## Bad: tests implementation details

```typescript
// ❌ Calls private method; breaks on rename/refactor
expect((processor as any).isValid(tx)).toBe(false);
```

```typescript
// ✅ Same coverage via public API
processor.processTransaction(invalidTx);
expect(processor.getAccountBalance("sender")).toBe(50);
```

## Bad: interaction test

```typescript
// ❌ Brittle — fails if storage layer refactored
await accounts.createUser("foobar");
verify(database).put("foobar");
```

```typescript
// ✅ State test
await accounts.createUser("foobar");
expect(await accounts.getUser("foobar")).not.toBeNull();
```

## Bad: logic in expected value

```typescript
// ❌ Bug in concatenation is easy to miss
const baseUrl = "http://example.com";
expect(nav.getCurrentUrl()).toBe(baseUrl + "/albums");
```

```typescript
// ✅ Literal expected value
expect(nav.getCurrentUrl()).toBe("http://example.com/albums");
```

## Bad: one test, multiple behaviors

```typescript
// ❌ Hard to diagnose which behavior failed
it("testDisplayTransactionResults", () => {
  processor.displayTransactionResults(user, transaction);
  expect(ui.getText()).toContain("You bought a");
  expect(ui.getText()).toContain("balance is low");
});
```

```typescript
// ✅ Split by behavior
it("should show item name after purchase", () => {
  /* ... */
});
it("should show low balance warning when below threshold", () => {
  /* ... */
});
```

## Bad: too DRY, unclear

```typescript
// ❌ Reader must jump to helpers to understand intent
it("should allow multiple users", () => {
  const users = createUsers(false, false);
  const forum = createForumAndRegisterUsers(users);
  validateForumAndUsers(forum, users);
});
```

## Good: DAMP — verbose but obvious

```typescript
it("should register multiple normal users", () => {
  const user1 = newUser().setState(State.NORMAL).build();
  const user2 = newUser().setState(State.NORMAL).build();
  const forum = new Forum();

  forum.register(user1);
  forum.register(user2);

  expect(forum.hasRegisteredUser(user1)).toBe(true);
  expect(forum.hasRegisteredUser(user2)).toBe(true);
});
```

## Builders with meaningful overrides

```typescript
// ✅ Only specify fields the behavior depends on
const contact = newContact()
  .setFirstName("Ada")
  .setLastName("Lovelace")
  .build();
expect(contact.getFullName()).toBe("Ada Lovelace");
```

## Bug fix: add regression test

```typescript
it("should not treat schedule ending at window boundary as upcoming", () => {
  const schedules = [scheduleEndingExactlyAtWindowEnd];

  expect(findUpcomingCalculationJobs(schedules, staticData)).toEqual([]);
});
```
