# Validation record

Date: **2026-11-16**. Host: Apple silicon macOS, Xcode 27.2, Android SDK 36 / Build-Tools 36, JDK 21. Commands used the isolated official stable SDK at `/private/tmp/quiz_covid19_flutter_sdk/bin/`: **Flutter 3.50.0**, framework `ab2912035e`, **Dart 3.14.0**. This temporary installation did not upgrade the shared Homebrew Flutter 3.41.9. Select/install the pinned SDK before running the README commands; the temporary path is not a durable installation method.

## Scope and approach

Pure domain tests verify question validation and session transitions independently of the widget tree. Widget tests exercise the app through visible answers and navigation; no external API, database or mock network response is required. Invalid content, bounds, duplicate submissions, progression and completion are covered alongside happy paths. The real bundled bank is completed in a widget test.

TDD evidence: the repeated-answer regression initially failed because a second answer was accepted; a single guard fixed it. Later, an explicit source semantics assertion failed on the missing URL label before that accessibility correction. The unrelated original counter test was removed. Initial scaffolding tests also failed to compile before the new model existed; this is recorded separately from the behavioral failures.

## Results

- `flutter pub get --enforce-lockfile`: passed, with committed package checksums and no overrides.
- `dart format --output=none --set-exit-if-changed lib test example`: passed, no formatting changes required.
- `flutter analyze --fatal-infos`: passed with **no issues** on the current SDK and official Material package.
- `flutter test --coverage`: **10 tests passed**. Tests cover correct/incorrect scores, repeated/stale taps, empty sessions, invalid indexes, malformed questions and metadata, defensive copies, progress, final results, restart, source navigation and the entire offline bank.
- Accessibility checks: a 320 × 568 logical-pixel viewport at 2× text scale remained scrollable without layout exceptions; labeled targets and Android minimum tap targets passed. Source URL semantics are explicitly tested.
- `flutter build web --release --no-web-resources-cdn`: passed. Output: `build/web/`, including local CanvasKit and font assets. Flutter's WebAssembly compilation dry run also succeeded; no WebAssembly runtime test was performed.
- `flutter build apk --debug`: passed. Output: `build/app/outputs/flutter-apk/app-debug.apk`. Android application ID remains `com.kleberandrade.quiz_covid19`.
- `flutter build ios --simulator --debug`: passed. Output: `build/ios/iphonesimulator/Runner.app`. Bundle ID remains `com.example.quizCovid19`; minimum deployment target is iOS 15.
- Browser smoke check: served the web release on a loopback-only HTTP server, visually inspected quiz/feedback, enabled web accessibility, navigated to sources and opened software licenses. Confirmed the bundled Roboto Apache license. The screenshot in `screenshots/quiz-feedback.jpg` is from that real local app, not a mockup. No physical device or iOS simulator was launched.
- `flutter pub outdated`: all direct and development dependencies are current. `material_color_utilities` 0.13.0 and `test_api` 0.7.14 are constrained by the Flutter SDK; newer incompatible transitive releases were deliberately not forced.
- CI and Dependabot YAML parse successfully locally. Git diff whitespace checks and documentation relative links were checked. Remote CI has **not** run for these commits because no push was authorized.

## Coverage and tool limitations

The generated LCOV report measures the loaded Dart files, not native code or every app entry point. `Question` has **16/16** measured lines exercised and `QuizSession` has **31/31**. The bank and app composition are also exercised. Remaining widget coverage gaps include replacing the injected bank during an existing widget lifetime and the software-license callback (checked manually in the browser). `main.dart` license registration was exercised in the browser, but is not in the automated LCOV report. These counts are line coverage, not branch coverage or mutation effectiveness. No coverage badge or coverage gate is asserted.

The installed `crapper`, `dryer` and `mutator` were invoked against `lib`. Each returned “No source files to analyze/mutate”; their supported language lists exclude Dart. No CRAP, duplication-similarity or mutation score is claimed. Automated Dart analysis and behavior tests provide the actual evidence reported above.

## Security and content review

Manual review covered question input validation, score transitions, runtime networking and signing configuration. A narrow local scan for private-key headers, GitHub token patterns and signing/keystore files found none in the current source tree. Dedicated general-purpose secret/SAST tools were unavailable; this is not an exhaustive security audit or a review of all Git history.

The original tracked `android/key.properties` was removed and ignored. Historical values remain in previous commits; any credentials/keystore still in use require owner-managed rotation before distribution. No credential revocation, history rewrite or app-store action was attempted. Android release signing is deliberately not configured. Debug keys used by Android's debug variant are development keys only.

The content source and review date are in `CONTENT.md`. No clinician review, medical efficacy study or medical-device validation was performed. No current question is loaded from the historical Google Apps Script service. No runtime analytics or question-server integration was added.

## Remaining release checks

Run the GitHub workflow after an authorized push; test installed builds on physical devices and actual TalkBack/VoiceOver sessions; review current health sources and Portuguese wording with an appropriate reviewer; configure private release signing and store metadata. Test offline native startup on devices. Web assets require an HTTP(S) server and no PWA/offline caching layer is provided. This update does not claim store approval, release-signing verification, physical testing or a comprehensive browser-compatibility pass.
