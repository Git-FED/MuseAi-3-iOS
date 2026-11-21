# Signing and App Store setup

1. Open the generated project in Xcode.
2. Replace the blank `DEVELOPMENT_TEAM` value with your Apple Developer Team ID, or set it in each target's Signing & Capabilities tab.
3. Use unique bundle identifiers if `com.fedos.desktopbuddy.*` is unavailable.
4. Add the App Groups and WatchConnectivity capabilities only when cross-device state transfer is implemented.
5. Archive each shipping target from Xcode; GitHub Actions in this starter repository is build validation only and does not contain certificates.
