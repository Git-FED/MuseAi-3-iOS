# Desktop Buddy — Apple platforms

Apple-native conversion of the uploaded Electron Desktop Buddy source. The project targets **iOS, macOS, and watchOS only**; Android, Windows, Linux, and Electron packaging are intentionally excluded.

## What is included

- iPhone and iPad iOS, plus macOS SwiftUI apps with three isolated `WKWebView` sessions for Muse 3, Muse 2, and Muse 1.
- Per-session website data stores on iOS 17/macOS 14 and later, keeping cookies and local storage separated.
- A watchOS companion app for selecting the active session. watchOS does not support embedding arbitrary `WKWebView` content, so the watch target is a controller/status surface rather than a full Muse browser.
- App icons, watch icon metadata, source SVG, a web favicon, XcodeGen project definition, and GitHub Actions CI.

## Build locally

Install Xcode 15 or newer, then install XcodeGen (`brew install xcodegen`). From the repository root:

```bash
xcodegen generate
open DesktopBuddy.xcodeproj
```

Select `DesktopBuddy-iOS`, `DesktopBuddy-macOS`, or `DesktopBuddy-watchOS` as the scheme. Set your Apple Development Team in Xcode signing settings. The repository intentionally has no Android or Electron build scripts.

## GitHub Actions

The workflow is `.github/workflows/build.yml`. It runs `xcodegen generate`, builds unsigned iOS Simulator, macOS, and watchOS Simulator apps, packages them as ZIP files, and uploads them as a GitHub Actions artifact named `desktop-buddy-apple-builds`. App Store distribution still requires your own Apple Developer signing certificates and provisioning profiles.

## Security and product note

The app loads `https://muse.ai` in WebKit. If Muse requires an OAuth provider that blocks embedded web authentication, move that provider flow to `ASWebAuthenticationSession` in a future iteration rather than adding arbitrary external navigation.
