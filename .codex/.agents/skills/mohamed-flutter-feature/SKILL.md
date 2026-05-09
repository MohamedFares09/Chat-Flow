---
name: mohamed-flutter-feature
description: Build a full Flutter feature in Mohamed general Flutter style. Trigger on "/feature", "feature", "build feature", "اعمل feature". Uses feature-first layers, dartz Either<Failure,T>, abstract repos, repo implementations, model extends entity, CustomException/ServerFailure flow, getIt when available, Cubit with part state, and View/ViewBodyBlocConsumer/ViewBody UI split.
---

# Mohamed Flutter Feature Skill

Use this skill for complete Flutter features.

## Required Reference

Read `references/mohamed-flutter-style.md` before coding.

## Steps

1. Inspect similar existing feature files.
2. Explain files to create or modify.
3. Preserve the current project's folder spelling and naming style.
4. Build only the requested scope.

## Feature Layers

- Domain: entities and abstract repos.
- Data: models, repo implementations, services/data sources.
- Presentation: cubits, views, widgets.

## Rules

- Use `Either<Failure, T>` for repo results when the project uses `dartz`.
- Model extends entity.
- Repo implementation extends abstract repo.
- Services throw `CustomException`.
- Repo catches `CustomException` and returns `left(ServerFailure(e.message))`.
- Cubit follows `mohamed-flutter-cubit`.
- UI follows `mohamed-flutter-ui`.
- Use `getIt` if the project uses service locator.
- Run `mohamed-flutter-review` before saying the task is done.
