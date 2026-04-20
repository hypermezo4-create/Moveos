# MoveOS Control

A premium Flutter control center for MoveOS with a polished neon UI and a GitHub Actions workflow for Android APK builds.

## Included in this starter

- Bottom navigation: Home, System, Visual, Gaming, Security
- Extra routes: Status Bar, Notifications, Plugins, Launcher, Themes, QS Panel, Lockscreen
- Adopted MoveOS logo included as a branding asset
- Dark cyberpunk UI direction for the first V1 shell
- GitHub Actions workflow that builds a release APK on push

## Important note

This repo is a **UI-first starter** prepared to be connected to your real MoveOS framework/SystemUI bridge.
The screens, structure, navigation, and brand are ready.
The privileged system actions are still represented as UI placeholders until they are wired to your ROM-side services.

## Suggested next wiring steps

1. Add a native bridge for your existing XML keys and intents.
2. Connect settings writes to `Settings.System`, `Settings.Secure`, overlays, or your privileged service.
3. Replace demo toggles/sliders with live values from framework/SystemUI.
4. Add signing/release secrets to GitHub if you want signed release APKs.

## Build locally

```bash
flutter pub get
flutter run
```

## Build on GitHub

Push this repo to GitHub, then run the workflow in:

```text
.github/workflows/android-release.yml
```

The generated APK artifact will be uploaded in GitHub Actions.
