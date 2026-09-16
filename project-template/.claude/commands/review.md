---
description: Pre-merge quality check on current branch diff
---

## Files Changed
!`git diff --name-only $(git merge-base HEAD origin/develop 2>/dev/null || git merge-base HEAD origin/main)...HEAD`

## Full Diff
!`git diff $(git merge-base HEAD origin/develop 2>/dev/null || git merge-base HEAD origin/main)...HEAD`

Review the above for:

1. **Code quality and consistency with existing patterns**
   - Follows this project's framework conventions (see `.claude/CLAUDE.md`)
   - Business logic separated from transport/UI layers
   - Reuses existing utilities instead of duplicating

2. **Security issues**
   - Parameterized queries only (no string interpolation into SQL)
   - No exposed secrets or API keys
   - Input validated at boundaries
   - Auth/authz checks on protected routes

3. **Data validation**
   - Request/response models are typed and validated
   - Required vs optional fields clearly defined

4. **Error handling**
   - Errors caught and logged, not swallowed
   - Correct status codes / error shapes

5. **Performance concerns**
   - No N+1 queries
   - Indexes used where appropriate
   - No unnecessary refetches or re-renders

6. **Testing**
   - New behavior has tests
   - Edge cases covered

Give specific, actionable feedback per file with line numbers.
