import SwiftUI

// ═══════════════════════════════════════════════════
//  BrutalistButton
//  Primary / Secondary / Ghost variants.
//  Hard directional shadow. Shadow collapses +
//  element shifts on press — no ripple.
// ═══════════════════════════════════════════════════

enum BrutalistButtonVariant {
    case primary, secondary, ghost
}

enum BrutalistButtonSize {
    case small, medium, large

    var vertical: CGFloat {
        switch self {
        case .small:  return 10
        case .medium: return 14
        case .large:  return 18
        }
    }
    var horizontal: CGFloat {
        switch self {
        case .small:  return 16
        case .medium: return 24
        case .large:  return 32
        }
    }
    var fontSize: CGFloat {
        switch self {
        case .small:  return CxTypography.textXs
        case .medium: return CxTypography.textSm
        case .large:  return CxTypography.textBase
        }
    }
}

struct BrutalistButton: View {
    let title: String
    var variant: BrutalistButtonVariant = .primary
    var size: BrutalistButtonSize = .medium
    var fullWidth: Bool = false
    let action: () -> Void

    @EnvironmentObject private var theme: ThemeManager
    @State private var isPressed: Bool = false

    var body: some View {
        let colors = theme.colors
        let bg: Color = {
            switch variant {
            case .primary:   return colors.accent
            case .secondary: return colors.bgCard
            case .ghost:     return .clear
            }
        }()
        let fg: Color = {
            switch variant {
            case .primary:   return colors.textInverse
            case .secondary: return colors.textPrimary
            case .ghost:     return colors.textPrimary
            }
        }()
        let border: Color = {
            switch variant {
            case .primary:   return colors.accent
            case .secondary: return colors.borderBold
            case .ghost:     return colors.borderBold
            }
        }()

        let shadowOffset: CGFloat = isPressed ? 1 : 5

        return Text(title.uppercased())
            .font(CxTypography.mono(size.fontSize, weight: .bold))
            .tracking(1.2)
            .foregroundColor(fg)
            .padding(.vertical, size.vertical)
            .padding(.horizontal, size.horizontal)
            .frame(maxWidth: fullWidth ? .infinity : nil)
            .background(bg)
            .overlay(
                Rectangle().stroke(border, lineWidth: CxBorders.medium)
            )
            .offset(x: isPressed ? 4 : 0, y: isPressed ? 4 : 0)
            .hardShadow(x: shadowOffset, y: shadowOffset, color: colors.shadowColor)
            .animation(CxSpringSpecs.press, value: isPressed)
            .contentShape(Rectangle())
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { _ in
                        if !isPressed {
                            isPressed = true
                            performPress()
                        }
                    }
                    .onEnded { _ in
                        isPressed = false
                        action()
                    }
            )
    }

    private func performPress() {
        // Tactile feedback
        #if os(iOS)
        let gen = UIImpactFeedbackGenerator(style: .medium)
        gen.impactOccurred()
        #endif
    }
}
