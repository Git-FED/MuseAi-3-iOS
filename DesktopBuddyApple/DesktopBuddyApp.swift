import SwiftUI

@main
struct DesktopBuddyApp: App {
    @StateObject private var selection = SessionSelection()

    var body: some Scene {
        WindowGroup {
            DesktopBuddyContentView()
                .environmentObject(selection)
        }
        #if os(macOS)
        .commands {
            CommandGroup(after: .textEditing) {
                Button("Reload Current Session") {
                    NotificationCenter.default.post(name: .desktopBuddyReload, object: nil)
                }
                .keyboardShortcut("r", modifiers: [.command])
            }
        }
        #endif
    }
}

extension Notification.Name {
    static let desktopBuddyReload = Notification.Name("desktopBuddyReload")
}
