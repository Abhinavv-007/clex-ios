import SwiftUI

// ═══════════════════════════════════════════════════
//  WorkspaceView — placeholder scaffold
//  Core send/receive flow. To be filled with transfer
//  state machine (WebRTC + room code + QR) once the
//  data layer is ported from Android.
// ═══════════════════════════════════════════════════

enum WorkspaceMode: String, CaseIterable {
    case send    = "SEND"
    case receive = "RECEIVE"
    case tools   = "TOOLS"
}

struct WorkspaceView: View {
    @EnvironmentObject private var theme: ThemeManager
    @State private var mode: WorkspaceMode = .send

    var body: some View {
        let colors = theme.colors
        ZStack {
            colors.bgPrimary.ignoresSafeArea()
            VStack(spacing: 0) {
                TabRow(selected: $mode)
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: CxSpacing.lg) {
                        switch mode {
                        case .send:    SendStub()
                        case .receive: ReceiveStub()
                        case .tools:   ToolsStub()
                        }
                        Spacer().frame(height: 120)
                    }
                    .padding(.horizontal, CxSpacing.screenHorizontal)
                    .padding(.top, CxSpacing.xl)
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

private struct TabRow: View {
    @Binding var selected: WorkspaceMode
    @EnvironmentObject private var theme: ThemeManager

    var body: some View {
        let colors = theme.colors
        let tabs = WorkspaceMode.allCases
        ZStack(alignment: .bottom) {
            GeometryReader { geo in
                let itemW = geo.size.width / CGFloat(tabs.count)
                let idx = CGFloat(tabs.firstIndex(of: selected) ?? 0)
                let pillW: CGFloat = 32
                let pillH: CGFloat = 3
                let x = idx * itemW + (itemW - pillW) / 2
                Rectangle()
                    .fill(colors.accent)
                    .frame(width: pillW, height: pillH)
                    .offset(x: x, y: geo.size.height - pillH)
            }
            .allowsHitTesting(false)

            HStack(spacing: 0) {
                ForEach(tabs, id: \.self) { t in
                    let active = t == selected
                    MonoText(
                        text: t.rawValue,
                        size: CxTypography.textSm,
                        weight: active ? .black : .medium,
                        color: active ? colors.accent : colors.textTertiary,
                        letterSpacing: 1.2
                    )
                    .padding(.vertical, 14)
                    .frame(maxWidth: .infinity)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        withAnimation(CxSpringSpecs.panel) { selected = t }
                    }
                }
            }
        }
        .overlay(
            Rectangle().fill(theme.colors.borderColor).frame(height: 2),
            alignment: .bottom
        )
    }
}

private struct SendStub: View {
    var body: some View {
        VStack(alignment: .leading, spacing: CxSpacing.lg) {
            SectionLabel(text: "DROP ZONE")
            BrutalistCard {
                VStack(alignment: .leading, spacing: CxSpacing.sm) {
                    MonoText(text: "⇩  DROP FILES", size: CxTypography.text2xl, weight: .bold)
                    BodyText(text: "Pick files from Photos, Files, or share from any app.", size: CxTypography.textSm)
                }
            }
            BrutalistButton(title: "PICK FILES", variant: .primary, size: .large, fullWidth: true) { }
        }
    }
}

private struct ReceiveStub: View {
    var body: some View {
        VStack(alignment: .leading, spacing: CxSpacing.lg) {
            SectionLabel(text: "RECEIVE")
            BrutalistCard {
                VStack(alignment: .leading, spacing: CxSpacing.sm) {
                    MonoText(text: "ROOM CODE", size: CxTypography.textXs, weight: .bold)
                    MonoText(text: "— — — —", size: CxTypography.text4xl, weight: .black)
                }
            }
            BrutalistButton(title: "SCAN QR", variant: .primary, size: .large, fullWidth: true) { }
        }
    }
}

private struct ToolsStub: View {
    private let tools = [
        ("⇩", "IMAGE COMPRESS"),
        ("⇄", "IMAGE → WEBP"),
        ("◌", "IMAGE → JPEG"),
        ("□", "IMAGE → PNG"),
        ("▤", "PDF MERGE"),
        ("✂", "PDF SPLIT"),
        ("◫", "PDF → IMAGE"),
        ("⬡", "DOCX → PDF"),
        ("⊞", "ZIP BUNDLE"),
        ("⟳", "SMART CHAIN")
    ]
    var body: some View {
        VStack(alignment: .leading, spacing: CxSpacing.md) {
            SectionLabel(text: "LOCAL TOOLS")
            ForEach(tools, id: \.1) { t in
                BrutalistCard(padding: CxSpacing.md) {
                    HStack(spacing: CxSpacing.md) {
                        MonoText(text: t.0, size: CxTypography.text2xl)
                        MonoText(text: t.1, size: CxTypography.textSm, weight: .bold)
                        Spacer()
                        MonoText(text: "→", size: CxTypography.textLg)
                    }
                }
            }
        }
    }
}
