import SwiftUI

struct DesktopBuddyContentView: View {
    @EnvironmentObject private var selection: SessionSelection
    @State private var reloadToken = UUID()

    var body: some View {
        VStack(spacing: 0) {
            header
            Text("Three private Muse sessions. Switch without losing your place.")
                .font(.caption)
                .foregroundStyle(.secondary)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(Color.white.opacity(0.65))

            ZStack {
                ForEach(MuseSession.all) { session in
                    MuseWebView(session: session, reloadToken: reloadToken)
                        .opacity(session.id == selection.selectedID ? 1 : 0)
                        .allowsHitTesting(session.id == selection.selectedID)
                }
            }
            .background(Color(red: 0.98, green: 0.96, blue: 0.94))

            sessionSwitcher
        }
        .frame(minWidth: 760, minHeight: 540)
        .onReceive(NotificationCenter.default.publisher(for: .desktopBuddyReload)) { _ in reloadToken = UUID() }
    }

    private var header: some View {
        HStack {
            Label("Desktop Buddy", systemImage: "3.circle.fill")
                .font(.headline)
            Spacer()
            Button { reloadToken = UUID() } label: { Image(systemName: "arrow.clockwise") }
                .help("Reload current session")
            Text(selection.selected.title)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 11)
        .background(Color(red: 0.98, green: 0.96, blue: 0.94))
    }

    private var sessionSwitcher: some View {
        HStack(spacing: 5) {
            ForEach(MuseSession.all) { session in
                Button {
                    selection.selectedID = session.id
                } label: {
                    HStack(spacing: 7) {
                        Circle().fill(selection.selectedID == session.id ? .white : .gray).frame(width: 8, height: 8)
                        Text(session.title)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 7)
                    .foregroundStyle(.white)
                    .background(selection.selectedID == session.id ? Color(red: 0.85, green: 0.47, blue: 0.34) : .clear)
                    .clipShape(RoundedRectangle(cornerRadius: 6))
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 6)
        .background(Color.black)
    }
}

