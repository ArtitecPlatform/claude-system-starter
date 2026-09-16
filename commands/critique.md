# /critique

Run the critic agent on the current project and log a report.

## Usage
- `/critique` — full project audit
- `/critique [scope]` — focused audit (e.g., `/critique backend`, `/critique security`, `/critique tests`)

## Steps

1. Read `.claude/agents/critic.md` for this project's critic agent instructions.
   - If it doesn't exist, use the default critic rules below.

2. Read `.claude/CLAUDE.md` to understand the project's stack, goals, and structure.

3. Read the last critique from `.claude/logs/critique.md` (if it exists) — do NOT repeat issues already flagged unless they remain unresolved.

4. Conduct the audit across these dimensions (or the specified scope):

   **Architecture & Structure**
   - Folder organization, module separation, coupling
   - Are responsibilities clearly divided between agents/areas?

   **Code Quality**
   - Dead code, inconsistent patterns, poor naming
   - Missing error handling or silent failures

   **Test Coverage**
   - What's untested? Missing edge cases?
   - Are tests meaningful or just padding coverage?

   **Security**
   - Exposed secrets, unvalidated inputs, insecure dependencies
   - SQL injection, XSS, or other OWASP risks

   **Performance**
   - O(n²) patterns, missing pagination, unoptimized queries
   - Unnecessary re-renders or redundant network calls

   **Dependencies**
   - Outdated packages, unused dependencies
   - Better alternatives available?

   **GitHub Hygiene**
   - Stale branches, direct commits to main
   - Missing or vague commit messages / PR descriptions

   **Consistency**
   - Does code follow patterns defined in this project's agent files?

5. Write the report and **prepend** it to `.claude/logs/critique.md` using this format:

```markdown
## [YYYY-MM-DD] Critique — [scope or "Full Audit"]

### Critical Issues 🔴
- **[Issue title]**: `[file/location]` — [Why it's a problem] → [Suggested fix]

### Warnings 🟡
- **[Issue title]**: `[file/location]` — [Why it matters] → [Suggested fix]

### Improvements 🔵
- **[Suggestion]**: [What to do and why]

### Positives ✅
- [What's working well — preserve these patterns]

**Overall Health Score: [1–10]**
```

6. Trim `logs/critique.md` to 10 reports. Archive extras to `logs/critique-archive.md`.

7. Print a summary to the user: score, count of critical issues and warnings, and top 2 recommended actions.

---

## Default Critic Rules (used when agents/critic.md is missing)

- Be specific — no vague feedback. Name the file, line, or pattern.
- Be constructive — every problem gets a suggested fix.
- Be honest — a score of 3 means 3, not 7.
- Do not repeat issues from the last critique unless unresolved.
- Always note what's working well so good patterns are preserved.
