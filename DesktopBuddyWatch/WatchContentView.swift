import SwiftUI

struct WatchContentView: View {
    @EnvironmentObject private var selection: SessionSelection

    var body: some View {
        VStack(spacing: 10) {
            Label("Desktop Buddy", systemImage: "3.circle.fill")
                .font(.headline)
            Text("Choose a Muse session on your iPhone or Mac")
                .font(.footnote)
                .multilineTextAlignment(.center)
                .foregroundStyle(.secondary)
            ForEach(MuseSession.all) { session in
                Button {
                    selection.selectedID = session.id
                } label: {
                    HStack {
                        Image(systemName: selection.selectedID == session.id ? "checkmark.circle.fill" : "circle")
                        Text(session.title)
                        Spacer()
                    }
                }
                .tint(selection.selectedID == session.id ? Color(red: 0.85, green: 0.47, blue: 0.34) : .accentColor)
            }
            Text("Selected: \(selection.selected.title)")
                .font(.caption2)
                .foregroundStyle(.secondary)
        }
        .padding(.horizontal, 8)
    }
}
