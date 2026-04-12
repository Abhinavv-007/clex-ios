import SwiftUI

struct HelpFaqView: View {
    @Environment(\.clexPalette) private var palette
    @State private var openIndex: Int? = 0

    private let items: [(String, String)] = [
        ("DOES CLEX UPLOAD MY FILES?", "No. Direct and local routes stay device-to-device unless you deliberately choose a cloud path."),
        ("WHAT IS THE VAULT FOR?", "Vault stores encrypted notes, secret links, sync settings, and account protection state."),
        ("WHAT DOES THE CHAIN STORE?", "Only verification metadata and hashes. The file itself never becomes public chain content."),
        ("CAN I CHANGE THE THEME?", "Yes. Theme mode is stored locally and applied across the app shell."),
        ("WHY DID THE IOS APP CHANGE?", "This build replaces the older flat shell with the newer Android-aligned structure and motion system.")
    ]

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 20) {
                ClexHeader(icon: "questionmark.circle.fill", title: "Help", status: nil)
                ForEach(items.indices, id: \.self) { index in
                    FAQRow(title: items[index].0, detail: items[index].1, isOpen: openIndex == index) {
                        withAnimation(.spring(response: 0.35, dampingFraction: 0.86)) {
                            openIndex = openIndex == index ? nil : index
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
}

private struct FAQRow: View {
    @Environment(\.clexPalette) private var palette

    let title: String
    let detail: String
    let isOpen: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            ClexGlassCard {
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Text(title)
                            .font(.system(size: 15, weight: .bold, design: .rounded))
                            .foregroundStyle(palette.textPrimary)
                        Spacer()
                        Image(systemName: isOpen ? "minus" : "plus")
                            .foregroundStyle(palette.accent)
                    }
                    if isOpen {
                        Text(detail)
                            .font(.system(size: 15, weight: .medium, design: .rounded))
                            .foregroundStyle(palette.textSecondary)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
            }
        }
        .buttonStyle(.plain)
    }
}
