import SwiftUI

// ═══════════════════════════════════════════════════
//  CLEX — Typography Tokens
//  Ported from Android CxTypography
// ═══════════════════════════════════════════════════

enum CxTypography {
    // Sizes (mobile scale, 1pt ≈ 1sp)
    static let textXs:   CGFloat = 11
    static let textSm:   CGFloat = 13
    static let textBase: CGFloat = 15
    static let textLg:   CGFloat = 17
    static let textXl:   CGFloat = 19
    static let text2xl:  CGFloat = 22
    static let text3xl:  CGFloat = 28
    static let text4xl:  CGFloat = 34
    static let text5xl:  CGFloat = 42
    static let text6xl:  CGFloat = 54
    static let text7xl:  CGFloat = 68
    static let text8xl:  CGFloat = 88

    // Weights — mapped to SwiftUI Font.Weight
    static let weightRegular:   Font.Weight = .regular
    static let weightMedium:    Font.Weight = .medium
    static let weightSemibold:  Font.Weight = .semibold
    static let weightBold:      Font.Weight = .bold
    static let weightExtrabold: Font.Weight = .heavy
    static let weightBlack:     Font.Weight = .black

    // Font families — system monospace for display/mono, system sans for body
    static func mono(_ size: CGFloat, weight: Font.Weight = .regular) -> Font {
        .system(size: size, weight: weight, design: .monospaced)
    }

    static func display(_ size: CGFloat, weight: Font.Weight = .bold) -> Font {
        .system(size: size, weight: weight, design: .monospaced)
    }

    static func body(_ size: CGFloat, weight: Font.Weight = .regular) -> Font {
        .system(size: size, weight: weight, design: .default)
    }
}
