import Foundation
import Combine

struct MuseSession: Identifiable, Hashable {
    let id: String
    let title: String
    let url: URL

    static let all: [MuseSession] = [
        MuseSession(id: "muse3", title: "Muse 3", url: URL(string: "https://muse.ai")!),
        MuseSession(id: "muse2", title: "Muse 2", url: URL(string: "https://muse.ai")!),
        MuseSession(id: "muse1", title: "Muse 1", url: URL(string: "https://muse.ai")!)
    ]
}

@MainActor
final class SessionSelection: ObservableObject {
    @Published var selectedID: String {
        didSet { UserDefaults.standard.set(selectedID, forKey: "selectedSessionID") }
    }

    init() {
        selectedID = UserDefaults.standard.string(forKey: "selectedSessionID") ?? MuseSession.all[0].id
    }

    var selected: MuseSession {
        MuseSession.all.first(where: { $0.id == selectedID }) ?? MuseSession.all[0]
    }
}
