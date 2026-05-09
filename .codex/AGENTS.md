# AGENTS.md

<!--
Global project instructions for Codex.
This file should stay short. Detailed workflows live in .agents/skills.
-->

## Mohamed Flutter Coding Style

- Follow Mohamed's Flutter coding style unless the current project has stronger local rules.
- Adapt names, imports, routes, and custom widgets to the current project.
- Keep the same code organization pattern across projects.
- Prefer consistency, readability, and easy future editing.
- Do not copy project-specific names from examples unless they match the current project.

## Core Style

- Use feature-first structure.
- Use Cubit/Bloc for state management.
- Use `getIt` / service locator if the project uses dependency injection.
- Use `Either<Failure, T>` for repository results when the project uses `dartz`.
- Keep UI, Cubit, domain, and data responsibilities separate.
- Reuse existing custom widgets when available.
- If custom widgets do not exist, create small reusable equivalents.

## Mandatory Workflow

- Before coding, inspect similar existing files.
- Before creating UI, use `mohamed-flutter-ui`.
- Before creating Cubit/state, use `mohamed-flutter-cubit`.
- Before creating a complete feature, use `mohamed-flutter-feature`.
- Before marking work done, use `mohamed-flutter-review`.
- After approval and only when requested, use `mohamed-flutter-pr`.

## Never Do

- Never put feature screens in `main.dart`.
- Never put multiple major screens in one file.
- Never mix business logic into UI.
- Never introduce new architecture packages unless explicitly requested.
