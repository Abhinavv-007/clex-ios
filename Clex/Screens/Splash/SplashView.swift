import SwiftUI

// ═══════════════════════════════════════════════════
//  SplashView
//  Cinematic entrance: CLEX stamps in at 2× → snaps
//  to 1× → accent underline draws → tagline fades →
//  auto-navigate.
// ═══════════════════════════════════════════════════

struct SplashView: View {
    let onComplete: () -> Void

    @EnvironmentObject private var theme: ThemeManager

    @State private var stampScale: CGFloat = 2.0
    @State private var stampOpacity: Double = 0
    @State private var underlineWidth: CGFloat = 0
    @State private var taglineOpacity: Double = 0

    var body: some View {
        let colors = theme.colors

        ZStack {
            colors.bgPrimary.ignoresSafeArea()

            VStack(spacing: CxSpacing.md) {
                Text("CLEX")
                    .font(CxTypography.display(CxTypography.text8xl, weight: .black))
                    .foregroundColor(colors.textPrimary)
                    .tracking(-4)
                    .scaleEffect(stampScale)
                    .opacity(stampOpacity)

                Rectangle()
                    .fill(colors.accent)
                    .frame(width: underlineWidth, height: 6)

                Text("DROP  ·  PREPARE  ·  SHARE")
                    .font(CxTypography.mono(CxTypography.textSm, weight: .bold))
                    .tracking(2)
                    .foregroundColor(colors.textSecondary)
                    .opacity(taglineOpacity)
            }
        }
        .onAppear {
            // Stamp in
            withAnimation(.spring(response: 0.45, dampingFraction: 0.65).delay(0.15)) {
                stampScale = 1.0
                stampOpacity = 1
            }
            // Underline draw
            withAnimation(.easeOut(duration: 0.55).delay(0.65)) {
                underlineWidth = 180
            }
            // Tagline fade
            withAnimation(.easeOut(duration: 0.6).delay(1.1)) {
                taglineOpacity = 1
            }
            // Auto-advance
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.4) {
                onComplete()
            }
        }
    }
}
