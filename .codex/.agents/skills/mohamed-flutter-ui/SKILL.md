---
name: mohamed-flutter-ui
description: Build UI-only Flutter screens in Mohamed general Flutter style. Trigger on "/ui", "ui only", "screen only", "login screen", "register screen", "UI بس", "اعمل شاشة". Must split View, ViewBodyBlocConsumer, ViewBody, and widgets into separate files, reuse existing custom widgets, and never put feature UI in main.dart.
---

# Mohamed Flutter UI Skill

Use this skill for UI-only screens and forms.

## Required Reference

Read `references/mohamed-flutter-style.md` before writing UI.

## Non-Negotiable Rules

- Never put feature UI code in `main.dart`.
- Never put a full screen flow in one file.
- Use the `View` / `ViewBodyBlocConsumer` / `ViewBody` split.
- Do not create domain, data, repository, API, cache, or use case files unless explicitly requested.
- Reuse existing custom widgets when available.
- Keep validation local to UI.

## Required File Split

```text
features/<feature>/presentation/views/
  <name>_view.dart

features/<feature>/presentation/widgets/
  <name>_view_body_bloc_consumer.dart
  <name>_view_body.dart
```

## Forms

- Use `StatefulWidget`.
- Use `GlobalKey<FormState>`.
- Use `AutovalidateMode.disabled`.
- Prefer `onSaved` over controllers for simple forms.
- On invalid submit, enable autovalidation and call `setState`.

## Finish

- Run `flutter analyze` when possible.
- Summarize created/modified files.
