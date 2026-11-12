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

- **iPhone / iPad:** open the web app link (repo **About** box → website, `https://codyanay123411.github.io/OmniCalc/`) in **Safari**, tap **Share → Add to Home Screen**. It gets its own icon, opens full-screen and works offline.
- **Any browser:** the same link works on any device, or download `index.html` and open it.

Everything runs on your device; nothing is sent anywhere. The **Self-test** button (bottom-left) checks every feature.

## Repo layout
- `index.html`: the whole app.
- `android/`: a small WebView wrapper. GitHub Actions copies `index.html` in and builds the APK on every push to `main` (see `.github/workflows/build.yml`).
- `manifest.webmanifest`, `sw.js`, `icons/`: make the GitHub Pages site installable and offline (iPhone Add to Home Screen, Android/Chrome Install app).
- `windows/`: install/uninstall and default-calculator scripts bundled into the Windows zip.

## Vault (password manager)
A separate app in `vault/`, live at `https://codyanay123411.github.io/OmniCalc/vault/`: encrypted logins, cards and notes, 2FA codes, passkey unlock, NordPass import, and optional sync through a private GitHub repo. Everything is encrypted on the device (AES-256-GCM, PBKDF2 600k); this public repo only holds the app's code, never anyone's data.
