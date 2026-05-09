---
name: mohamed-flutter-pr
description: Generate commit message, branch name, and pull request description for Flutter changes. Trigger after review approval when the user says "create PR", "submit", "push this", "/ship", "اعمل push".
---

# Mohamed Flutter PR Skill

Use only after review passes and the user asks to commit, push, submit, or create PR.

## Verify First

Run when possible:

```bash
flutter analyze
flutter test
git status
git diff --stat
```

Stop if analyze/tests fail unless the user explicitly asks to continue.

## Commit Message

Use conventional commit:

```text
feat(auth): add signin UI
fix(auth): handle login failure
refactor(auth): split signin view widgets
```

## PR Description

```markdown
## Summary
Brief description of what changed and why.

## Changes
- Key change 1
- Key change 2

## Testing
- flutter analyze
- flutter test
```

## Rules

- Stage only relevant files.
- Do not push without explicit user request.
- After pushing, show branch name, commit hash, and changed files summary.
