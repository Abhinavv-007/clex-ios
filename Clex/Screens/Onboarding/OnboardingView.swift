import SwiftUI

// ═══════════════════════════════════════════════════
//  OnboardingView
//  3-beat horizontal pager: DROP → PREPARE → SHARE
//  Giant outlined number, floating symbol, tags.
// ═══════════════════════════════════════════════════

struct OnboardingView: View {
    let onComplete: () -> Void

    @EnvironmentObject private var theme: ThemeManager
    @State private var page: Int = 0

    private let beats: [Beat] = [
        Beat(num: "01", symbol: "⇩", title: "DROP",
             subtitle: "Pick up any file. Drag it in. Nothing leaves your device until you say so.",
             tags: ["OFFLINE FIRST", "ANY FILE"]),
        Beat(num: "02", symbol: "◇", title: "PREPARE",
             subtitle: "Convert. Compress. Encrypt. Eight tools, zero uploads.",
             tags: ["LOCAL TOOLS", "INSTANT"]),
        Beat(num: "03", symbol: "↯", title: "SHARE",
             subtitle: "Peer-to-peer, local network, or encrypted cloud link. You pick the route.",
             tags: ["P2P", "E2E ENCRYPTED"])
    ]

    var body: some View {
        let colors = theme.colors

        ZStack {
            colors.bgPrimary.ignoresSafeArea()

            VStack(spacing: 0) {
                // Top bar
                HStack {
                    MonoText(
                        text: "\(String(format: "%02d", page + 1)) / 03",
                        size: CxTypography.textXs,
                        weight: .bold,
                        color: colors.textTertiary,
                        letterSpacing: 1.5
                    )
                    Spacer()
                    if page < beats.count - 1 {
                        Button {
                            onComplete()
                        } label: {
                            MonoText(
                                text: "SKIP",
                                size: CxTypography.textXs,
                                weight: .bold,
                                color: colors.textTertiary,
                                letterSpacing: 1.5
                            )
                        }
                    }
                }
                .padding(.horizontal, CxSpacing.screenHorizontal)
                .padding(.top, CxSpacing.md)

                // Pager
                TabView(selection: $page) {
                    ForEach(beats.indices, id: \.self) { i in
                        BeatView(beat: beats[i]).tag(i)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .frame(maxHeight: .infinity)

                // Dots + CTA
                VStack(spacing: CxSpacing.lg) {
                    HStack(spacing: CxSpacing.sm) {
                        ForEach(beats.indices, id: \.self) { i in
                            Rectangle()
                                .fill(i == page ? colors.accent : colors.borderColor)
                                .frame(width: i == page ? 28 : 14, height: 4)
                                .animation(CxSpringSpecs.snap, value: page)
                        }
                    }
                    BrutalistButton(
                        title: page == beats.count - 1 ? "ENTER CLEX" : "NEXT",
                        variant: .primary,
                        size: .large,
                        fullWidth: true
                    ) {
                        if page == beats.count - 1 {
                            onComplete()
                        } else {
                            withAnimation(CxSpringSpecs.panel) { page += 1 }
                        }
                    }
                }
                .padding(.horizontal, CxSpacing.screenHorizontal)
                .padding(.bottom, CxSpacing.xl)
            }
        }
    }
}

private struct Beat {
    let num: String
    let symbol: String
    let title: String
    let subtitle: String
    let tags: [String]
}

private struct BeatView: View {
    let beat: Beat
    @EnvironmentObject private var theme: ThemeManager
    @State private var yOffset: CGFloat = 0

    var body: some View {
        let colors = theme.colors
        VStack(spacing: CxSpacing.xl) {
            ZStack {
                // Outlined giant number
                Text(beat.num)
                    .font(CxTypography.display(200, weight: .black))
                    .foregroundColor(.clear)
                    .overlay(
                        Text(beat.num)
                            .font(CxTypography.display(200, weight: .black))
                            .foregroundColor(colors.borderColor)
                    )
                // Floating symbol
                Text(beat.symbol)
                    .font(CxTypography.display(CxTypography.text7xl, weight: .bold))
                    .foregroundColor(colors.accent)
                    .offset(y: yOffset)
            }
            .padding(.top, CxSpacing.xxl)

            VStack(spacing: CxSpacing.md) {
                Text(beat.title)
                    .font(CxTypography.display(CxTypography.text5xl, weight: .black))
                    .foregroundColor(colors.textPrimary)
                    .tracking(-1)
                BodyText(
                    text: beat.subtitle,
                    size: CxTypography.textBase,
                    color: colors.textSecondary,
                    align: .center
                )
                .padding(.horizontal, CxSpacing.lg)
            }

            HStack(spacing: CxSpacing.sm) {
                ForEach(beat.tags, id: \.self) { tag in
                    BrutalistBadge(text: tag)
                }
            }
            Spacer()
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 2).repeatForever(autoreverses: true)) {
                yOffset = -8
            }
        }
    }
}
