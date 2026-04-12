import SwiftUI

private enum HomePanel: String, CaseIterable {
    case send = "SEND"
    case receive = "RECEIVE"
    case tools = "TOOLS"
}

struct HomeView: View {
    @Environment(\.clexPalette) private var palette
    @State private var panel: HomePanel = .send

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 20) {
                HStack(spacing: 14) {
                    ClexLogoMark(size: 52)
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Clex")
                            .font(.system(size: 28, weight: .bold, design: .rounded))
                            .foregroundStyle(palette.textPrimary)
                        Text("Workspace")
                            .font(.system(size: 13, weight: .bold, design: .rounded))
                            .tracking(1.4)
                            .foregroundStyle(palette.textSecondary)
                    }
                    Spacer()
                    HStack(spacing: 8) {
                        Circle()
                            .fill(palette.accent)
                            .frame(width: 8, height: 8)
                        Text("WORKSPACE")
                            .font(.system(size: 12, weight: .semibold, design: .rounded))
                            .tracking(0.8)
                    }
                    .padding(.horizontal, 14)
                    .padding(.vertical, 10)
                    .background(.ultraThinMaterial, in: Capsule())
                    .overlay(Capsule().stroke(palette.border, lineWidth: 1))
                }
                .clexReveal(0)

                VStack(alignment: .leading, spacing: 14) {
                    Text("DROP. PREPARE. SHARE.")
                        .font(.system(size: 44, weight: .black, design: .rounded))
                        .foregroundStyle(palette.textPrimary)
                        .lineLimit(2)
                        .minimumScaleFactor(0.7)
                    Text("Direct transfer, local routes, and built-in tools from one mobile-first workspace.")
                        .font(.system(size: 17, weight: .medium, design: .rounded))
                        .foregroundStyle(palette.textSecondary)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .clexReveal(1)

                ClexGlassCard {
                    VStack(spacing: 14) {
                        Picker("Panel", selection: $panel) {
                            ForEach(HomePanel.allCases, id: \.self) { item in
                                Text(item.rawValue).tag(item)
                            }
                        }
                        .pickerStyle(.segmented)

                        switch panel {
                        case .send:
                            HomeSendPanel()
                        case .receive:
                            HomeReceivePanel()
                        case .tools:
                            HomeToolsPanel()
                        }
                    }
                }
                .clexReveal(2)

                HStack(spacing: 14) {
                    ClexMetricCard(title: "TRANSFER ROUTE", value: "DIRECT")
                    ClexMetricCard(title: "PRIVACY MODE", value: "LOCAL")
                }
                .clexReveal(3)

                ClexGlassCard {
                    VStack(alignment: .leading, spacing: 14) {
                        ClexSectionTitle(title: "WHY CLEX")
                        Text("Clex keeps send, receive, tools, vault, and chain flows in one mobile workspace without forcing a cloud-first workflow.")
                            .font(.system(size: 15, weight: .medium, design: .rounded))
                            .foregroundStyle(palette.textSecondary)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
                .clexReveal(4)
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
            .padding(.bottom, 130)
        }
    }
}

private struct HomeSendPanel: View {
    @Environment(\.clexPalette) private var palette

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            ClexSectionTitle(title: "SEND FILES")
            Text("Pick files, choose the fastest route, and start transfer instantly.")
                .font(.system(size: 15, weight: .medium, design: .rounded))
                .foregroundStyle(palette.textSecondary)
            ClexPrimaryButton(title: "SELECT FILES", systemImage: "arrow.up.right") {}
            HStack(spacing: 12) {
                ClexSecondaryButton(title: "DIRECT") {}
                ClexSecondaryButton(title: "LOCAL") {}
            }
        }
    }
}

private struct HomeReceivePanel: View {
    @Environment(\.clexPalette) private var palette

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            ClexSectionTitle(title: "RECEIVE FILES")
            Text("Scan QR, paste the share code, or open a receive link on this device.")
                .font(.system(size: 15, weight: .medium, design: .rounded))
                .foregroundStyle(palette.textSecondary)

            HStack(spacing: 10) {
                ForEach(Array(repeating: "—", count: 6), id: \.self) { char in
                    Text(char)
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                        .foregroundStyle(palette.textPrimary)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
                        .overlay(RoundedRectangle(cornerRadius: 16, style: .continuous).stroke(palette.border, lineWidth: 1))
                }
            }

            ClexPrimaryButton(title: "SCAN OR ENTER CODE", systemImage: "qrcode.viewfinder") {}
        }
    }
}

private struct HomeToolsPanel: View {
    @Environment(\.clexPalette) private var palette

    private let tools = [
        "IMAGE → WEBP",
        "IMAGE → JPEG",
        "PDF MERGE",
        "DOCX → PDF"
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            ClexSectionTitle(title: "BUILT-IN TOOLS")
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                ForEach(tools, id: \.self) { tool in
                    Text(tool)
                        .font(.system(size: 13, weight: .bold, design: .rounded))
                        .foregroundStyle(palette.textPrimary)
                        .frame(maxWidth: .infinity, minHeight: 68)
                        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 18, style: .continuous))
                        .overlay(RoundedRectangle(cornerRadius: 18, style: .continuous).stroke(palette.border, lineWidth: 1))
                }
            }
        }
    }
}
