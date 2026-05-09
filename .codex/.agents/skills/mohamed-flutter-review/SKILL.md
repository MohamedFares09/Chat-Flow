---
name: mohamed-flutter-review
description: Run a self-review checklist before completing a Flutter task. Trigger on "task done", "finished", "review this", "/review", "راجع". Checks Mohamed Flutter style, analyze/test, git diff, and safety before approval.
---

# Mohamed Flutter Review Skill

Use this before marking work as done.

## Checklist

- UI follows View / ViewBodyBlocConsumer / ViewBody split.
- No feature UI in `main.dart`.
- Major screens are not combined in one file.
- Existing custom widgets are reused where available.
- Cubit and state are in separate files with `part` / `part of`.
- Cubit emits LoadingState / SuccessState / ErrorState.
- Cubit does not access Firebase/API/database directly.
- Repo returns `Either<Failure, Entity>` when using dartz.
- Error messages reach UI through failure -> Cubit error state.
- Controllers are disposed if used.
- No unrelated refactor.

## Commands

Run when possible:

```bash
flutter analyze
flutter test
git status
git diff --stat
```

## Output

Summarize:
1. what changed
2. why it changed
3. analyze/test results
4. risks or follow-up fixes
