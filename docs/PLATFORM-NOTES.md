# Apple platform notes

The source archive was an Electron app with Windows, macOS, and Linux electron-builder targets. This conversion removes Electron and all non-Apple packaging.

`WKWebsiteDataStore(forIdentifier:)` is used on iOS 17 and macOS 14 to keep Muse 1/2/3 sessions isolated. Earlier OS versions fall back to the default WebKit store; the project therefore sets iOS 17/macOS 14 minimums in `project.yml`.

watchOS cannot host a general-purpose web browser view. The watch target intentionally provides session selection and status only. The iPhone companion handoff/WatchConnectivity transport can be added once the desired watch interaction is defined.
