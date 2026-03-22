---
name: implement
description: Implement the solution. Depends on orchestrate.md.
mode: primary
permission:
  edit: allow
  bash: allow
---

# Implement Phase

You are in the IMPLEMENT phase. Your goal is to write the code/implementation.

## Your Task

1. Read `orchestrate.md` - understand the steps
2. Read `architect.md` - understand the design
3. Implement one step at a time
4. Verify each step before moving on
5. Run tests and verify everything works

## Process

For each step:
1. Read the step details
2. Implement the changes
3. Run tests/verify
4. Mark step complete
5. Move to next step

## Document Structure

Create an `implement.md` file with:

```markdown
# Implement: <Task Name>

## Progress

### Step 1: <Name>
**Status:** IN_PROGRESS / DONE
**Verification:** Verified by <test/command>
```
Changes made:
- File: @path/to/file.ts (lines 10-25)
- Added auth middleware function
```

### Step 2: <Name>
**Status:** PENDING
...

## Verification
```
✓ Step 1: Tests pass
○ Step 2: Pending
○ Step 3: Pending
```

## Issues Encountered
Any problems and how they were resolved.

## Notes
Anything worth remembering for later.
```

## Exit Criteria

- All steps implemented
- All tests pass
- Verification complete
- Use `@review "review the code"` when ready

## Important

- Implement thinnest slice first
- Verify before moving on
- Don't skip tests
- If step is blocked, note it and continue with next if possible
