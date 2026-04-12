import SwiftUI

// ═══════════════════════════════════════════════════
//  CLEX — Theme Provider
//  Runtime dark/light switch. Views observe ThemeManager
//  and read the current CxColorScheme via CxTheme.colors
// ═══════════════════════════════════════════════════

struct CxColorScheme {
    let bgPrimary:   Color
    let bgSecondary: Color
    let bgTertiary:  Color
    let bgCard:      Color
    let bgElevated:  Color
    let bgInput:     Color

    let textPrimary:   Color
    let textSecondary: Color
    let textTertiary:  Color
    let textInverse:   Color

    let accent:          Color
    let accentMuted:     Color
    let accentSecondary: Color
    let accentTertiary:  Color

    let borderColor:  Color
    let borderBold:   Color
    let borderSubtle: Color
    let shadowColor:  Color
}

extension CxColorScheme {
    static let dark = CxColorScheme(
        bgPrimary:   CxColors.bgPrimary,
        bgSecondary: CxColors.bgSecondary,
        bgTertiary:  CxColors.bgTertiary,
        bgCard:      CxColors.bgCard,
        bgElevated:  CxColors.bgElevated,
        bgInput:     CxColors.bgInput,
        textPrimary:   CxColors.textPrimary,
        textSecondary: CxColors.textSecondary,
        textTertiary:  CxColors.textTertiary,
        textInverse:   CxColors.textInverse,
        accent:          CxColors.accent,
        accentMuted:     CxColors.accentMuted,
        accentSecondary: CxColors.accentSecondary,
        accentTertiary:  CxColors.accentTertiary,
        borderColor:  CxColors.borderColor,
        borderBold:   CxColors.borderBold,
        borderSubtle: CxColors.borderSubtle,
        shadowColor:  CxColors.shadowColor
    )

    static let light = CxColorScheme(
        bgPrimary:   CxColors.lightBgPrimary,
        bgSecondary: CxColors.lightBgSecondary,
        bgTertiary:  CxColors.lightBgTertiary,
        bgCard:      CxColors.lightBgCard,
        bgElevated:  CxColors.lightBgElevated,
        bgInput:     CxColors.lightBgInput,
        textPrimary:   CxColors.lightTextPrimary,
        textSecondary: CxColors.lightTextSecondary,
        textTertiary:  CxColors.lightTextTertiary,
        textInverse:   CxColors.lightTextInverse,
        accent:          CxColors.accent,
        accentMuted:     CxColors.accentMuted,
        accentSecondary: CxColors.accentSecondary,
        accentTertiary:  CxColors.accentTertiary,
        borderColor:  CxColors.lightBorderColor,
        borderBold:   CxColors.lightBorderBold,
        borderSubtle: CxColors.lightBorderSubtle,
        shadowColor:  CxColors.lightShadowColor
    )
}

// ── Theme manager — observed by all screens ───────

final class ThemeManager: ObservableObject {
    private let storeKey = "cx.theme.isDark"

    @Published private(set) var isDark: Bool

    init() {
        if UserDefaults.standard.object(forKey: storeKey) != nil {
            self.isDark = UserDefaults.standard.bool(forKey: storeKey)
        } else {
            self.isDark = true
        }
    }

    var colors: CxColorScheme {
        isDark ? .dark : .light
    }

    func toggle() {
        isDark.toggle()
        UserDefaults.standard.set(isDark, forKey: storeKey)
    }

    func set(dark: Bool) {
        isDark = dark
        UserDefaults.standard.set(isDark, forKey: storeKey)
    }
}
