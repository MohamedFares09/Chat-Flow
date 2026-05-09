---
name: mohamed-flutter-cubit
description: Scaffold Cubit and state files in Mohamed general Flutter style. ALWAYS use before writing any Cubit or state file. Uses part/part of, @immutable, sealed state classes, abstract repo/use case constructor injection, LoadingState, SuccessState, and ErrorState.
---

# Mohamed Flutter Cubit Skill

Use this skill before writing any Cubit or state file.

## Required Reference

Read `references/mohamed-flutter-style.md`, especially Cubit and State Pattern.

## File Structure

```text
features/<feature>/presentation/cubits/<action>/
  <action>_cubit.dart
  <action>_state.dart
```

## Rules

- Use `part` and `part of`.
- Use `@immutable`.
- Use `sealed class` for the base state.
- Use `final class` for concrete states.
- State names end with `State`.
- Cubit receives abstract repo or use case through constructor.
- Prefer abstract repo constructor injection when matching Mohamed style.
- Emit loading before async work.
- Use `result.fold`.
- Error state contains `message`.
- Success state contains entity/data.
- Do not put Cubit and State in the same file.
- Do not put UI code in Cubit.
- Do not call Firebase/API/database directly from Cubit.
- Do not use Freezed, Equatable, or build_runner unless explicitly requested.
