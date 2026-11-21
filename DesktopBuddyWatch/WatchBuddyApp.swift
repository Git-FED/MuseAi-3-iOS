import SwiftUI

@main
struct WatchBuddyApp: App {
    @StateObject private var selection = SessionSelection()
    var body: some Scene {
        WindowGroup {
            WatchContentView()
                .environmentObject(selection)
        }
    }
}
