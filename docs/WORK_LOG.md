# Modernization work log

Date: 2026-11-16. Scope: this repository only; local commits, no push or deployment.

- Cloned the requested repository; `master` was clean at `6daaa3c`. Confirmed the original author and existing MIT grant in the README. No local AGENTS.md was present.
- Read the requested reduced-principles instructions plus testing and security guidance. Inspected the original model, controller, HTTP service, widget flow, platform projects and signing configuration without logging secret values.
- Identified repeat scoring, untyped nullable legacy data, a remote Google Apps Script dependency and an unrelated counter test. Wrote behavior tests first. Initial compilation failed because the new API was not implemented; after creating the model/session, the repeated-answer test failed on accepting a second answer. Added a single acceptance guard; the behavior then passed.
- Replaced the remote bank with six local educational questions paraphrased from the WHO fact sheet, reviewed on 2026-11-16. Added review dates, explanations and a source screen; no remote question service or telemetry remains.
- Separated domain, data and presentation. Added immutable question inputs, validation at construction, one score per question, explicit answer/review/advance states, completion and restart.
- Added Portuguese Material localization, scrolling layouts, native buttons, semantic headings/feedback, progress and software licenses. Widget tests caught invalid progress semantics; corrected the numeric value. Tested large text and touch targets.
- Regenerated Android, iOS and web scaffolding from Flutter templates, preserving app artwork and existing Android application ID/iOS bundle ID. Removed tracked private signing properties; did not rewrite history or access a keystore.
- Initial Flutter 3.41.9 web build passed. Initial iOS simulator build found that installed Xcode requires iOS 15; raised the minimum accordingly. Checked the official archive and started an isolated stable Flutter installation to avoid changing shared tooling.
- Bundled Roboto font assets with their Apache 2.0 license to avoid font downloads for Portuguese content; retained third-party license boundaries.
- Ran crapper, dryer and mutator against `lib`: each reported no supported source files. Their published language lists exclude Dart, so no CRAP, duplication or mutation score is claimed.
- Applied and read back GitHub About: “Offline Flutter quiz about COVID-19 with sourced questions, accessible feedback, and educational explanations.” No code was pushed.

Final validation results and remaining limitations are recorded in `VALIDATION.md`.
- Confirmed official stable Flutter 3.50.0 / Dart 3.14.0 from the isolated SDK, pinned `.flutter-version`, upgraded compatible dependencies and regenerated matching platform settings (AGP 9.3.1, Kotlin 2.4.20, Gradle 9.5.0). The shared Homebrew Flutter installation was not upgraded.
- The first 3.50.0 web build and iOS simulator build passed. Ten behavior tests passed, including the complete local bank. Static analysis identified the newly deprecated legacy Material import; migrated to Flutter's official `material_ui` 1.11.0 package; analysis then passed without suppressing deprecations.
- Added a runnable custom-question example, English content/migration/third-party documentation, a real MIT license file retaining original authorship, supported-target/version badges, pinned CI actions and monthly dependency checks.
- Removed temporary platform templates/backups after regeneration; no unrelated worktree or project was changed.

- Cancelled one preliminary Android build (exit 130) to finish the Material dependency migration, then rebuilt successfully. Already-accepted licenses allowed the Android build to install the required Build-Tools 36; no new license agreement was accepted interactively.
- Final dependency review found all direct/dev dependencies current. Only SDK-constrained transitive `material_color_utilities` and `test_api` have newer incompatible releases; no dependency overrides were added.
- Browser smoke check of the release web build confirmed question rendering, answer feedback, source navigation and the Roboto license entry. Saved an actual screenshot in `docs/screenshots/quiz-feedback.jpg`.
- Browser accessibility inspection exposed an unlabeled selectable source URL. Added a failing semantics assertion, confirmed the failure, then supplied an explicit source label. The complete 10-test suite and static analysis passed again.
- Local commits so far: `2ed0e35` (offline app/domain/content/tests), `79f384b` (platform migration and CI). `aae0171` records the source-label correction; the final documentation commit contains this log and the validation record.

- Repeated the three platform builds after the source-label fix: web release passed (28.6 s), Android debug passed (7.0 s), and iOS simulator debug passed (10.4 s). These are observed build durations, not performance benchmarks.
- Verified the lockfile with enforcement, formatting, YAML parsing, documentation links and `git diff --check`. Recorded measured domain line counts and remaining coverage/device/CI/security limits in `VALIDATION.md`.
- Prepared the English README with current commands, supported-version/target/license badges and the actual local screenshot. Final work is committed locally on `master`; push, hosted CI and release distribution remain pending separate authorization.
