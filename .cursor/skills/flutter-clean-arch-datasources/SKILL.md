---
name: flutter-clean-arch-datasources
description: >-
  Creates Flutter Clean Architecture datasource contracts under lib/domain/datasources
  and concrete implementations under lib/data/datasources, with naming, dependency
  rules, and error-handling patterns. Use when adding or refactoring datasources,
  remote/local data access, API boundaries, repositories backed by datasources, or
  when the user asks to "criar datasource", "criar data source", or "interface de datasource".
---

# Flutter Clean Architecture — Datasources

Follow the project rule [.cursor/rules/clean-architecture-flutter.mdc](../../rules/clean-architecture-flutter.mdc): **interfaces only in Domain**, **implementations only in Data**.

## Naming and files

| Piece | Location | Convention |
|-------|-----------|--------------|
| Contract | `lib/domain/datasources/` | `{feature}_{remote\|local}_data_source.dart` |
| Implementation | `lib/data/datasources/` | `{feature}_{remote\|local}_data_source_impl.dart` |

Use **`abstract interface class`** for contracts (Dart 3). Suffix methods with clear verbs (`fetch`, `get`, `save`, `delete`). Return **domain entities** or primitive/Dart-core types — not Flutter widgets, not `Response` from HTTP packages in the public contract. If entities still live under `lib/domain/` (without `entities/` yet), import those paths until the folder is normalized.

## Dependency rules

- **Domain file**: `dart:` libraries + project `domain/entities` (and other domain types) only. **Never** `package:flutter/*`, `package:http`, `dio`, `shared_preferences`, `firebase_*`, paths to `lib/data/`.
- **Data implementation**: may import `http`, `dio`, `cloud_firestore`, etc. It **implements** the domain interface and maps IO failures to domain-friendly errors (custom exception types defined in `domain/`, or `Result`/Either if the project uses them).

## Workflow (copy checklist)

1. [ ] Identify **feature** name and **remote** vs **local** (or both → two interfaces / two classes).
2. [ ] Add **`abstract interface class`** in `lib/domain/datasources/…_data_source.dart` with the minimal method set.
3. [ ] Add **`class …Impl implements …DataSource`** in `lib/data/datasources/…_data_source_impl.dart`.
4. [ ] If a repository exists, inject the datasource interface into the repository implementation (constructor parameter typed as the interface).
5. [ ] Wire into DI / `Provider` / manual composition in **composition root** (e.g. `main.dart` or a small `injection` module) — **View** never constructs `*Impl` directly; it receives abstractions.

## Remote datasource template

```dart
// lib/domain/datasources/events_remote_data_source.dart
import '../entities/community_event.dart';

abstract interface class EventsRemoteDataSource {
  Future<List<CommunityEvent>> fetchUpcoming();
}
```

```dart
// lib/data/datasources/events_remote_data_source_impl.dart
import 'package:meetup_flutter_caxias/domain/datasources/events_remote_data_source.dart';
import 'package:meetup_flutter_caxias/domain/entities/community_event.dart';

class EventsRemoteDataSourceImpl implements EventsRemoteDataSource {
  EventsRemoteDataSourceImpl({required Uri baseUrl, required Future<String> Function(Uri uri) read});
  @override
  Future<List<CommunityEvent>> fetchUpcoming() async {
    // parse JSON → map to CommunityEvent (mappers in data/models if needed)
  }
}
```

Prefer **constructor injection** for `http.Client`, base URL, and clock — eases tests.

## Local datasource template

Same pattern: contract in `domain/datasources/`, implementation uses `SharedPreferences`, `hive`, `sqflite`, etc., only under `lib/data/datasources/`.

## Testing hint

In `test/`, fake the **`abstract interface class`** with an in-memory fake; do not import `*Impl` from production unless testing the mapper/HTTP layer explicitly.

## Anti-patterns

- Putting HTTP or `BuildContext` inside Domain.
- One giant `ApiDataSource` with dozens of unrelated methods — split by feature or bounded context.
- Returning DTO types from the interface when the app already has domain entities — map in **Data** before returning.
