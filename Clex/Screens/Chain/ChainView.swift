import SwiftUI

struct ChainView: View {
    @Environment(\.clexPalette) private var palette

    @State private var feed: ChainFeed?
    @State private var loading = true
    @State private var errorMessage: String?
    @State private var selectedSession: ChainExplorerSession?
    @State private var selectedDetail: ChainSessionDetail?
    @State private var detailLoading = false
    @State private var detailError: String?
    @State private var selectedChain = "IMAGE → COMPRESS → CONVERT → SHARE"

    private let client = ChainClient.shared

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
                    ClexMetricCard(title: "SESSIONS", value: "\(feed?.stats.totalSessions ?? 0)")
                    ClexMetricCard(title: "CHAINS", value: "\(feed?.stats.totalChains ?? 0)")
                }
                .clexReveal(2)

                ClexGlassCard {
                    VStack(alignment: .leading, spacing: 14) {
                        ClexSectionTitle(title: "HOW IT WORKS")
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                            ChainStep(number: "01", title: "DROP", detail: "Bring files into the workflow without uploading them first.")
                            ChainStep(number: "02", title: "HASH", detail: "Generate the proof on-device before transfer begins.")
                            ChainStep(number: "03", title: "SIGN", detail: "Receiver ID and session route are attached when peers connect.")
                            ChainStep(number: "04", title: "VERIFY", detail: "Open the public record later and inspect route, sizes, hashes, and status.")
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
                                        Text("Selected preset can drive the next transfer workflow.")
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

                ClexGlassCard {
                    VStack(alignment: .leading, spacing: 14) {
                        HStack {
                            ClexSectionTitle(title: "LIVE LEDGER")
                            Spacer()
                            Button("Refresh") {
                                Task { await reloadFeed() }
                            }
                            .font(.system(size: 13, weight: .semibold, design: .rounded))
                            .foregroundStyle(palette.accent)
                        }

                        if loading {
                            ProgressView()
                                .progressViewStyle(.circular)
                                .tint(palette.accent)
                                .frame(maxWidth: .infinity, alignment: .center)
                                .padding(.vertical, 12)
                        } else if let errorMessage {
                            Text(errorMessage)
                                .font(.system(size: 14, weight: .medium, design: .rounded))
                                .foregroundStyle(.red)
                        } else if let feed, feed.sessions.isEmpty {
                            Text("No transfer sessions yet.")
                                .font(.system(size: 14, weight: .medium, design: .rounded))
                                .foregroundStyle(palette.textSecondary)
                        } else {
                            ForEach(feed?.sessions ?? []) { session in
                                Button {
                                    selectedSession = session
                                } label: {
                                    ChainLedgerRow(session: session)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                    }
                }
                .clexReveal(8)
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
            .padding(.bottom, 130)
        }
        .task {
            await reloadFeed()
        }
        .sheet(item: $selectedSession) { session in
            ChainDetailSheet(
                session: session,
                detail: selectedDetail?.id == session.id ? selectedDetail : nil,
                isLoading: detailLoading,
                error: detailError
            )
            .presentationDetents([.medium, .large])
            .presentationDragIndicator(.visible)
            .task(id: session.id) {
                await loadDetail(for: session.id)
            }
        }
    }

    private func reloadFeed() async {
        loading = true
        errorMessage = nil
        do {
            feed = try await client.fetchFeed(limit: 20)
        } catch {
            errorMessage = "Could not reach the chain API."
        }
        loading = false
    }

    private func loadDetail(for sessionId: String) async {
        detailLoading = true
        detailError = nil
        selectedDetail = nil
        do {
            selectedDetail = try await client.fetchSession(id: sessionId)
        } catch {
            detailError = "Could not load this session."
        }
        detailLoading = false
    }
}

private struct ChainLedgerRow: View {
    @Environment(\.clexPalette) private var palette
    let session: ChainExplorerSession

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("#\(session.recordHash.prefix(8))")
                    .font(.system(size: 12, weight: .bold, design: .rounded))
                    .foregroundStyle(palette.accent)
                Spacer()
                Text(session.status.uppercased())
                    .font(.system(size: 11, weight: .bold, design: .rounded))
                    .foregroundStyle(statusColor(session.status))
            }
            HStack {
                Text(routeLabel(session.route))
                    .font(.system(size: 13, weight: .semibold, design: .rounded))
                    .foregroundStyle(palette.textPrimary)
                Spacer()
                Text("\(session.files.count) FILE\(session.files.count == 1 ? "" : "S")")
                    .font(.system(size: 12, weight: .semibold, design: .rounded))
                    .foregroundStyle(palette.textSecondary)
            }
            Text(session.receiverChainId == nil ? "Receiver pending" : "Receiver linked")
                .font(.system(size: 12, weight: .medium, design: .rounded))
                .foregroundStyle(session.receiverChainId == nil ? palette.textSecondary : palette.accent)
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 18, style: .continuous))
        .overlay(RoundedRectangle(cornerRadius: 18, style: .continuous).stroke(palette.border, lineWidth: 1))
    }
}

private struct ChainDetailSheet: View {
    @Environment(\.clexPalette) private var palette

    let session: ChainExplorerSession
    let detail: ChainSessionDetail?
    let isLoading: Bool
    let error: String?

    var body: some View {
        ZStack {
            ClexGlassBackground()
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 16) {
                    ClexHeader(icon: "point.3.connected.trianglepath.dotted", title: "Session", status: "#\(session.recordHash.prefix(8))")

                    ClexGlassCard {
                        VStack(alignment: .leading, spacing: 10) {
                            DetailRow(label: "Route", value: routeLabel(session.route))
                            DetailRow(label: "Status", value: session.status.uppercased())
                            DetailRow(label: "Sender", value: shortChain(session.senderChainId) ?? session.senderChainId)
                            DetailRow(label: "Receiver", value: shortChain(session.receiverChainId) ?? "PENDING")
                            DetailRow(label: "Duration", value: formatDuration(session.durationMs))
                            if let detail {
                                DetailRow(label: "Ledger Index", value: "\(detail.ledgerIndex)")
                            }
                        }
                    }

                    if isLoading {
                        ClexGlassCard {
                            ProgressView()
                                .progressViewStyle(.circular)
                                .tint(palette.accent)
                                .frame(maxWidth: .infinity, alignment: .center)
                                .padding(.vertical, 10)
                        }
                    } else if let error {
                        ClexGlassCard {
                            Text(error)
                                .font(.system(size: 14, weight: .medium, design: .rounded))
                                .foregroundStyle(.red)
                        }
                    } else if let detail {
                        ClexGlassCard {
                            VStack(alignment: .leading, spacing: 12) {
                                ClexSectionTitle(title: "FILES")
                                ForEach(Array(detail.files.enumerated()), id: \.offset) { _, file in
                                    VStack(alignment: .leading, spacing: 8) {
                                        Text(file.category.uppercased())
                                            .font(.system(size: 12, weight: .bold, design: .rounded))
                                            .foregroundStyle(palette.accent)
                                        Text("\(file.type) · \(formatBytes(file.size))")
                                            .font(.system(size: 13, weight: .medium, design: .rounded))
                                            .foregroundStyle(palette.textPrimary)
                                        Text(file.hash?.prefix(16) ?? "HASH PENDING")
                                            .font(.system(size: 12, weight: .medium, design: .monospaced))
                                            .foregroundStyle(file.hash == nil ? palette.textSecondary : palette.textSecondary)
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    if file != detail.files.last {
                                        Divider().overlay(palette.border)
                                    }
                                }
                            }
                        }

                        ClexGlassCard {
                            VStack(alignment: .leading, spacing: 12) {
                                ClexSectionTitle(title: "TIMELINE")
                                ForEach(detail.events) { event in
                                    HStack {
                                        Circle()
                                            .fill(statusColor(event.status))
                                            .frame(width: 8, height: 8)
                                        Text(event.status.uppercased())
                                            .font(.system(size: 13, weight: .semibold, design: .rounded))
                                            .foregroundStyle(palette.textPrimary)
                                        Spacer()
                                        Text(formatTimestamp(event.ts))
                                            .font(.system(size: 12, weight: .medium, design: .rounded))
                                            .foregroundStyle(palette.textSecondary)
                                    }
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
                .padding(.bottom, 40)
            }
        }
    }
}

private struct ChainStep: View {
    @Environment(\.clexPalette) private var palette

    let number: String
    let title: String
    let detail: String

    var body: some View {
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
}

private struct DetailRow: View {
    @Environment(\.clexPalette) private var palette
    let label: String
    let value: String

    var body: some View {
        HStack {
            Text(label.uppercased())
                .font(.system(size: 12, weight: .bold, design: .rounded))
                .foregroundStyle(palette.textSecondary)
            Spacer()
            Text(value)
                .font(.system(size: 13, weight: .semibold, design: .rounded))
                .foregroundStyle(palette.textPrimary)
        }
    }
}

private func routeLabel(_ route: String) -> String {
    switch route.lowercased() {
    case "webrtc": return "P2P DIRECT"
    case "local": return "LOCAL NETWORK"
    case "drive": return "GOOGLE DRIVE"
    default: return route.uppercased()
    }
}

private func statusColor(_ status: String) -> Color {
    switch status.lowercased() {
    case "completed": return .green
    case "failed", "cancelled", "abandoned": return .red
    default: return .yellow
    }
}

private func shortChain(_ chainId: String?) -> String? {
    guard let chainId, !chainId.isEmpty else { return nil }
    return String(chainId.suffix(8))
}

private func formatDuration(_ durationMs: Int64?) -> String {
    guard let durationMs, durationMs > 0 else { return "IN FLIGHT" }
    return String(format: "%.1fs", Double(durationMs) / 1000.0)
}

private func formatTimestamp(_ ts: Int64) -> String {
    let date = Date(timeIntervalSince1970: TimeInterval(ts) / 1000.0)
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .short
    return formatter.string(from: date)
}

private func formatBytes(_ bytes: Int64) -> String {
    let formatter = ByteCountFormatter()
    formatter.allowedUnits = [.useKB, .useMB, .useGB]
    formatter.countStyle = .file
    return formatter.string(fromByteCount: bytes)
}
