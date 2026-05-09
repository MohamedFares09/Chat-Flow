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
- Use Cubit for state management.
- Use `getIt` / service locator if the project uses dependency injection.
- Use `Either<Failure, T>` for repository results when the project uses `dartz`.
- Keep UI, Cubit, domain, and data responsibilities separate.
- Reuse existing custom widgets when available.
- If custom widgets do not exist, create small reusable equivalents.
- 

## Mandatory Workflow

- Before coding, inspect similar existing files.
- Before creating UI, use `mohamed-flutter-ui`.
- Before creating Cubit/state, use `mohamed-flutter-cubit`.
- Before creating a complete feature, use `mohamed-flutter-feature`.
- Before marking work done, use `mohamed-flutter-review`.
- After approval and only when requested, use `mohamed-flutter-pr`.

## Shared vs Feature-Specific Code Rule

Before creating any widget, constant, helper, validator, extension, color, asset path, style, or component, decide if it is feature-specific or shared.

### Put in `core/` when:
- It is used by 2+ features
- It is part of the app design system
- It is a generic reusable widget
- It is a common validator/helper/extension
- It is a shared color, spacing, text style, icon, or asset path
- It is not tied to one feature's business meaning

Examples:
- `CustomButton`
- `CustomTextFormField`
- `PasswordField`
- `CustomProgressHUD`
- `AppColors`
- `AppImages`
- `AppTextStyles`
- `Validators`
- `buildsnakbar`
- `buildAppBar`

### Put in `features/<feature>/presentation/widgets/` when:
- It is only meaningful inside one feature
- It depends on feature-specific Cubit/state
- It represents a section of one screen
- It is unlikely to be reused elsewhere

Examples:
- `SigninViewBody`
- `SigninViewBodyBlocConsumer`
- `DoNotHaveAnAccount`
- `ForgetPassword`
- `LoginSocialMedia`
- `OrDivider`

### Rule:
- Do not put shared code inside a feature.
- Do not put feature-specific code inside `core/`.
- If a feature widget becomes reused by another feature, move it to `core/`.
- Before creating new shared code, search `core/` first.

## Never Do

- Never put feature screens in `main.dart`.
- Never put multiple major screens in one file.
- Never mix business logic into UI.
- Never introduce new architecture packages unless explicitly requested.
