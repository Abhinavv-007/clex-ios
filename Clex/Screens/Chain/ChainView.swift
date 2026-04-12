import SwiftUI

struct ChainView: View {
    @Environment(\.clexPalette) private var palette
    @State private var selectedChain = "IMAGE → COMPRESS → CONVERT → SHARE"

    private let chainPresets = [
        "IMAGE → COMPRESS → CONVERT → SHARE",
        "PDF → MERGE → COMPRESS → ZIP → SHARE",
        "DOCX → PDF → SHARE"
    ]

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 20) {
                ClexHeader(icon: "point.3.connected.trianglepath.dotted", title: "Chain", status: "LIVE")
                    .clexReveal(0)

                VStack(alignment: .leading, spacing: 12) {
                    ClexSectionTitle(title: "VERIFIABLE TRANSFERS")
                    Text("Public ledger. Private payload.")
                        .font(.system(size: 38, weight: .black, design: .rounded))
                        .foregroundStyle(palette.textPrimary)
                    Text("Every transfer publishes only the hash trail and session metadata. Files never touch the ledger.")
                        .font(.system(size: 16, weight: .medium, design: .rounded))
                        .foregroundStyle(palette.textSecondary)
                }
                .clexReveal(1)

                HStack(spacing: 14) {
                    ClexMetricCard(title: "LIVE SESSIONS", value: "20")
                    ClexMetricCard(title: "CHAINS", value: "12")
                }
                .clexReveal(2)

                ClexGlassCard {
                    VStack(alignment: .leading, spacing: 14) {
                        ClexSectionTitle(title: "HOW IT WORKS")
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                            ChainStep(number: "01", title: "DROP", detail: "Bring files into the workflow without uploading them first.")
                            ChainStep(number: "02", title: "HASH", detail: "Generate the proof on-device before transfer begins.")
                            ChainStep(number: "03", title: "SIGN", detail: "Sign with your vault key and attach session metadata.")
                            ChainStep(number: "04", title: "VERIFY", detail: "Open the public record and confirm the chain later.")
                        }
                    }
                }
                .clexReveal(3)

                ClexGlassCard {
                    VStack(alignment: .leading, spacing: 14) {
                        ClexSectionTitle(title: "TOOL CHAINING")
                        Text("One thing leads to the next.")
                            .font(.system(size: 28, weight: .bold, design: .rounded))
                            .foregroundStyle(palette.textPrimary)

                        HStack(spacing: 10) {
                            ForEach(["DROP", "COMPRESS", "CONVERT", "SHARE"], id: \.self) { item in
                                Text(item)
                                    .font(.system(size: 12, weight: .bold, design: .rounded))
                                    .foregroundStyle(item == "CONVERT" ? Color.black.opacity(0.88) : palette.textPrimary)
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 12)
                                    .background(
                                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                                            .fill(item == "CONVERT" ? palette.accent : palette.surfaceStrong)
                                    )
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                                            .stroke(palette.border, lineWidth: 1)
                                    )
                            }
                        }
                    }
                }
                .clexReveal(4)

                VStack(alignment: .leading, spacing: 12) {
                    ClexSectionTitle(title: "POPULAR CHAINS")
                    ForEach(Array(chainPresets.enumerated()), id: \.offset) { index, item in
                        Button {
                            selectedChain = item
                        } label: {
                            ClexGlassCard {
                                VStack(alignment: .leading, spacing: 8) {
                                    Text(item)
                                        .font(.system(size: 15, weight: .bold, design: .rounded))
                                        .foregroundStyle(palette.textPrimary)
                                    if selectedChain == item {
                                        Text("Selected chain ready for the next transfer.")
                                            .font(.system(size: 13, weight: .medium, design: .rounded))
                                            .foregroundStyle(palette.accent)
                                    }
                                }
                            }
                        }
                        .buttonStyle(.plain)
                        .clexReveal(index + 5)
                    }
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
            .padding(.bottom, 130)
        }
    }
}

private struct ChainStep: View {
    @Environment(\.clexPalette) private var palette

    let number: String
    let title: String
    let detail: String

    var bodyView: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(number)
                .font(.system(size: 28, weight: .bold, design: .rounded))
                .foregroundStyle(palette.accent)
            Text(title)
                .font(.system(size: 16, weight: .bold, design: .rounded))
                .foregroundStyle(palette.textPrimary)
            Text(detail)
                .font(.system(size: 13, weight: .medium, design: .rounded))
                .foregroundStyle(palette.textSecondary)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(16)
        .frame(maxWidth: .infinity, minHeight: 148, alignment: .topLeading)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 18, style: .continuous))
        .overlay(RoundedRectangle(cornerRadius: 18, style: .continuous).stroke(palette.border, lineWidth: 1))
    }

    var body: some View { bodyView }
}
