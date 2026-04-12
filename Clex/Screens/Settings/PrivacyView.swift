import SwiftUI

struct PrivacyView: View {
    @Environment(\.clexPalette) private var palette

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 20) {
                ClexHeader(icon: "hand.raised.fill", title: "Privacy", status: nil)
                ForEach(Array(sections.enumerated()), id: \.offset) { index, section in
                    ClexGlassCard {
                        VStack(alignment: .leading, spacing: 10) {
                            Text(section.title)
                                .font(.system(size: 18, weight: .bold, design: .rounded))
                                .foregroundStyle(palette.textPrimary)
                            Text(section.body)
                                .font(.system(size: 15, weight: .medium, design: .rounded))
                                .foregroundStyle(palette.textSecondary)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                    }
                    .clexReveal(index)
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
            .padding(.bottom, 40)
        }
        .background(ClexGlassBackground())
        .toolbar(.hidden, for: .navigationBar)
    }

    private let sections = [
        (title: "LOCAL FIRST", body: "Direct transfers and vault notes stay on-device by default. Clex does not upload files unless you explicitly choose a cloud flow."),
        (title: "ENCRYPTION", body: "Vault content and secret payloads are protected before sync or share operations are created."),
        (title: "PUBLIC CHAIN", body: "The Chain stores verification metadata and hashes, not the original file contents."),
        (title: "CONTROL", body: "You choose when to sync, when to export, and when to reveal a secret. The app does not auto-publish private content.")
    ]
}
