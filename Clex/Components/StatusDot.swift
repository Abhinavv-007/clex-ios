import SwiftUI

// ═══════════════════════════════════════════════════
//  StatusDot
//  Colored dot with optional pulse animation.
//  Used for route status, connection state, etc.
// ═══════════════════════════════════════════════════

struct StatusDot: View {
    var color: Color
    var size: CGFloat = 8
    var pulsing: Bool = false

    @State private var pulseScale: CGFloat = 1
    @State private var pulseAlpha: Double = 0.6

    var body: some View {
        ZStack {
            if pulsing {
                Circle()
                    .fill(color.opacity(pulseAlpha))
                    .frame(width: size, height: size)
                    .scaleEffect(pulseScale)
            }
            Circle()
                .fill(color)
                .frame(width: size, height: size)
        }
        .onAppear {
            guard pulsing else { return }
            withAnimation(.easeInOut(duration: 1.2).repeatForever(autoreverses: true)) {
                pulseScale = 2.2
                pulseAlpha = 0
            }
        }
    }
}

// ── Progress bar (smooth) ──────────────────────────

struct BrutalistProgressBar: View {
    var progress: Double  // 0...1
    var height: CGFloat = 10
    var color: Color? = nil

    @EnvironmentObject private var theme: ThemeManager

    var body: some View {
        let colors = theme.colors
        GeometryReader { geo in
            ZStack(alignment: .leading) {
                Rectangle()
                    .fill(colors.bgInput)
                Rectangle()
                    .fill(color ?? colors.accent)
                    .frame(width: geo.size.width * max(0, min(1, progress)))
            }
            .overlay(Rectangle().stroke(colors.borderBold, lineWidth: CxBorders.thin))
        }
        .frame(height: height)
    }
}
