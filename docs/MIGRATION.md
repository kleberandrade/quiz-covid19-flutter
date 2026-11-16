# Migration from the 2020 app

Version 2 requires Flutter 3.50.0 and Dart 3.14.0 with null safety. Material widgets now come from the official `material_ui` package, replacing the deprecated `package:flutter/material.dart` import. Run `flutter clean` followed by `flutter pub get` after switching SDKs. The lockfile is committed; do not restore the old dependencies.

## Code and data

- `models/question.dart` becomes `domain/question.dart`. Replace nullable `question`, `answer1`, `answer2` fields and `fromMap`/`toMap` calls with explicit `id`, `prompt`, `options`, `correctIndex`, `explanation`, `source` and `reviewedOn` constructor arguments. No JSON/Sheets loader is retained.
- `controllers/quiz_controller.dart` becomes `domain/quiz_session.dart`. A session receives a nonempty list of validated questions; it has no asynchronous initialization or network loading/error state.
- Call `answer(index)` once, show feedback, then `advance()`. The return value means **accepted**, not **correct**; read `isCorrect` after an accepted answer. Repeated/late answers return false without changing score. Invalid indexes on an unanswered question throw `RangeError`; advancing before an answer or after completion throws `StateError`.
- `progress` counts submitted answers, including the final answer while feedback is visible. `isComplete` becomes true after advancing from final feedback. `restart()` clears score and selection. A fixed bank order makes review and classroom demonstrations reproducible.
- `pages/` and overlapping `components/` become `presentation/`. The single entry point is still `lib/main.dart`; `QuizApp` in `lib/app.dart` accepts an optional custom question list.
- Removed HTTP, sharing, automatic text shrinking and icon-generation plugins. Existing icons are preserved. No scores persist between app launches, and no share dialog is provided.

## Platforms and signing

Android now uses the Flutter plugin loader and Kotlin Gradle scripts instead of obsolete imperative Gradle scripts/JCenter. Android's application ID stays `com.kleberandrade.quiz_covid19`. iOS's bundle ID stays `com.example.quizCovid19`; change it deliberately only when setting up a different distribution identity. The minimum iOS version is 15 for compatibility with the Xcode used for validation. See `VALIDATION.md` for actual build results.

`android/key.properties` was tracked in the original repository and has been removed and ignored. Release builds are unsigned by default; configure your private signing separately before distribution. If those historical credentials or their keystore are still used, rotate them through the appropriate distribution process. Deleting the file does not remove it from Git history. This update did not rewrite published history, revoke credentials or submit anything to an app store.

Web is a new build target. Serve its generated directory over HTTP(S); do not open `index.html` using `file://`. Use the documented `--no-web-resources-cdn` build flag to bundle the rendering engine locally. Browser offline caching/PWA installation is not implemented.
