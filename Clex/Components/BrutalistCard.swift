import SwiftUI

// ═══════════════════════════════════════════════════
//  BrutalistCard / Badge / Divider / TapeStrip
//  Hard-bordered container with offset shadow.
// ═══════════════════════════════════════════════════

struct BrutalistCard<Content: View>: View {
    var padding: CGFloat = CxSpacing.cardPadding
    var borderColor: Color? = nil
    var borderWidth: CGFloat = CxBorders.thin
    var background: Color? = nil
    var shadow: CGFloat = 0
    let content: () -> Content

    @EnvironmentObject private var theme: ThemeManager

    var body: some View {
        let colors = theme.colors
        let bg = background ?? colors.bgCard
        let border = borderColor ?? colors.borderColor

        content()
            .padding(padding)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(bg)
            .overlay(Rectangle().stroke(border, lineWidth: borderWidth))
            .modifier(ConditionalShadow(offset: shadow, color: colors.shadowColor))
    }
}

private struct ConditionalShadow: ViewModifier {
    let offset: CGFloat
    let color: Color
    func body(content: Content) -> some View {
        if offset > 0 {
            content.hardShadow(x: offset, y: offset, color: color)
        } else {
            content
        }
    }
}

struct BrutalistBadge: View {
    let text: String
    var color: Color? = nil
    var filled: Bool = false

    @EnvironmentObject private var theme: ThemeManager

    var body: some View {
        let colors = theme.colors
        let c = color ?? colors.accent
        HStack(spacing: 6) {
            Circle().fill(c).frame(width: 5, height: 5)
            MonoText(
                text: text.uppercased(),
                size: CxTypography.textXs,
                weight: .bold,
                color: filled ? colors.textInverse : c,
                letterSpacing: 1
            )
        }
        .padding(.horizontal, CxSpacing.sm + 2)
        .padding(.vertical, 6)
        .background(filled ? c : Color.clear)
        .overlay(Rectangle().stroke(c, lineWidth: CxBorders.thin))
    }
}

struct BrutalistDivider: View {
    var color: Color? = nil
    @EnvironmentObject private var theme: ThemeManager
    var body: some View {
        Rectangle()
            .fill(color ?? theme.colors.borderColor)
            .frame(height: 1)
            .frame(maxWidth: .infinity)
    }
}

struct TapeStrip: View {
    var height: CGFloat = 4
    var color: Color? = nil
    @EnvironmentObject private var theme: ThemeManager
    var body: some View {
        Rectangle()
            .fill(color ?? theme.colors.accent)
            .frame(height: height)
            .frame(maxWidth: .infinity)
    }
}
