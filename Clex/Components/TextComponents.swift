import SwiftUI

// ═══════════════════════════════════════════════════
//  CLEX — Text Components
//  HeroTitle, SectionTitle, MonoText, BodyText, etc.
//  All uppercase display uses system monospace.
// ═══════════════════════════════════════════════════

struct MonoText: View {
    let text: String
    var size: CGFloat = CxTypography.textSm
    var weight: Font.Weight = .regular
    var color: Color? = nil
    var letterSpacing: CGFloat = 0
    var align: TextAlignment = .leading

    @EnvironmentObject private var theme: ThemeManager

    var body: some View {
        Text(text)
            .font(CxTypography.mono(size, weight: weight))
            .foregroundColor(color ?? theme.colors.textPrimary)
            .tracking(letterSpacing)
            .multilineTextAlignment(align)
    }
}

struct BodyText: View {
    let text: String
    var size: CGFloat = CxTypography.textBase
    var weight: Font.Weight = .regular
    var color: Color? = nil
    var align: TextAlignment = .leading
    var lineSpacing: CGFloat = 4

    @EnvironmentObject private var theme: ThemeManager

    var body: some View {
        Text(text)
            .font(CxTypography.body(size, weight: weight))
            .foregroundColor(color ?? theme.colors.textSecondary)
            .multilineTextAlignment(align)
            .lineSpacing(lineSpacing)
    }
}

struct HeroTitle: View {
    let text: String
    var color: Color? = nil

    @EnvironmentObject private var theme: ThemeManager

    var body: some View {
        Text(text.uppercased())
            .font(CxTypography.display(CxTypography.text5xl, weight: .black))
            .foregroundColor(color ?? theme.colors.textPrimary)
            .tracking(-1.5)
            .lineSpacing(-4)
    }
}

struct SectionTitle: View {
    let text: String
    var color: Color? = nil

    @EnvironmentObject private var theme: ThemeManager

    var body: some View {
        Text(text.uppercased())
            .font(CxTypography.display(CxTypography.text2xl, weight: .black))
            .foregroundColor(color ?? theme.colors.textPrimary)
            .tracking(-0.5)
    }
}

struct SectionLabel: View {
    let text: String
    var color: Color? = nil

    @EnvironmentObject private var theme: ThemeManager

    var body: some View {
        HStack(spacing: CxSpacing.sm) {
            Circle()
                .fill(color ?? theme.colors.accent)
                .frame(width: 6, height: 6)
            MonoText(
                text: text.uppercased(),
                size: CxTypography.textXs,
                weight: .bold,
                color: color ?? theme.colors.textSecondary,
                letterSpacing: 1.5
            )
        }
    }
}
