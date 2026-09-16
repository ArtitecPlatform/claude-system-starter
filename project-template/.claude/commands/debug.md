---
description: Structured debug session for a failing behavior
argument-hint: [describe the failing behavior or paste the error]
---

## Bug Report
$ARGUMENTS

## Current Branch
!`git branch --show-current`

## Recent Changes
!`git log --oneline -10`

## Environment
!`python --version 2>/dev/null; node --version 2>/dev/null`

Follow the 5-step debug process:

1. **REPRODUCE** — confirm the failure is consistent
   - Can you reproduce the error reliably?
   - What are the exact steps to trigger it?
   - Does it happen in all environments or just one?

2. **LOCALIZE** — narrow to the smallest failing unit
   - Which route/service/model is involved?
   - What's the entry point where things go wrong?
   - Isolate the problem to a specific function or module

3. **REDUCE** — strip down to a minimal repro
   - Remove unrelated code
   - Create a minimal test case that demonstrates the issue
   - Identify the simplest input that triggers the failure

4. **FIX** — make the targeted change
   - Address the root cause, not symptoms
   - Verify the fix resolves the issue
   - Ensure no side effects or regressions

5. **GUARD** — add a test that would have caught this
   - Write a regression test
   - Add validation or assertions to prevent recurrence
   - Update documentation if needed

**Do not fix symptoms. Find the root cause first.**
