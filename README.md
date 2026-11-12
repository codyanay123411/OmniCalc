# OmniCalc

A free, offline, all-in-one calculator in a single HTML file.

**Everyday:** calculator (exact fractions, complex numbers, variables), graphing (inequalities, polar, parametric, sliders), unit-aware math and converter, time math and time zones, money, dates.
**Math:** algebra with step-by-step working, calculus, geometry, vectors, probability, statistics, number theory, matrices.
**Tools:** science formulas, projectile motion, molar mass, rifle marksmanship math (mils/MOA, range estimation, wind, drop tables), mortar fire-direction math, programmer calculator.
**Study:** practice problems with worked steps and adaptive difficulty, quizzes, spaced-repetition flashcards, formula sheets, a focus timer and progress tracking.

## Get it
Download from the latest **[Release](../../releases/latest)**:

- **Android:** `OmniCalc.apk`, then open it on your phone. You may need to allow "install unknown apps" for your browser or Files app.
- **Windows / Mac / Linux:** `OmniCalc-Windows.zip`. Extract it and double-click `OmniCalc.html`, or on Windows run `Install OmniCalc.cmd` for a Start-menu app.

Or just download `index.html` and open it in any browser.

Everything runs on your device; nothing is sent anywhere. The **Self-test** button (bottom-left) checks every feature.

## Repo layout
- `index.html`: the whole app.
- `android/`: a small WebView wrapper. GitHub Actions copies `index.html` in and builds the APK on every push to `main` (see `.github/workflows/build.yml`).
- `windows/`: install/uninstall and default-calculator scripts bundled into the Windows zip.
