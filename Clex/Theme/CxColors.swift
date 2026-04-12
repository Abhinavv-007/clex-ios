import SwiftUI

// ═══════════════════════════════════════════════════
//  CLEX — Color Tokens
//  Neo-Brutalist palette. Ported from Android
//  CxColors in DesignTokens.kt
// ═══════════════════════════════════════════════════

enum CxColors {
    // ── Dark mode (default) ────────────────────────
    static let bgPrimary     = Color(hex: 0x0A0A0A)
    static let bgSecondary   = Color(hex: 0x111111)
    static let bgTertiary    = Color(hex: 0x1A1A1A)
    static let bgCard        = Color(hex: 0x141414)
    static let bgCardHover   = Color(hex: 0x1E1E1E)
    static let bgElevated    = Color(hex: 0x1A1A1A)
    static let bgInput       = Color(hex: 0x111111)

    static let textPrimary   = Color(hex: 0xF0F0E8)
    static let textSecondary = Color(hex: 0x999999)
    static let textTertiary  = Color(hex: 0x666666)
    static let textInverse   = Color(hex: 0x0A0A0A)

    static let accent          = Color(hex: 0xC8FF00)  // Clex Yellow
    static let accentHover     = Color(hex: 0xD4FF33)
    static let accentMuted     = Color(hex: 0xC8FF00, alpha: 0.15)
    static let accentSecondary = Color(hex: 0xFF3D00)  // red-orange
    static let accentTertiary  = Color(hex: 0x00D4FF)  // cyan

    static let borderColor   = Color(hex: 0x2A2A2A)
    static let borderBold    = Color(hex: 0xF0F0E8)
    static let borderSubtle  = Color(hex: 0x1E1E1E)

    static let shadowColor   = Color(hex: 0x000000)
    static let surfaceOverlay = Color(hex: 0x000000, alpha: 0.6)

    // ── Light mode ─────────────────────────────────
    static let lightBgPrimary    = Color(hex: 0xF5F0E8)
    static let lightBgSecondary  = Color(hex: 0xEBE5D9)
    static let lightBgTertiary   = Color(hex: 0xE0D9CC)
    static let lightBgCard       = Color(hex: 0xFFFFFF)
    static let lightBgElevated   = Color(hex: 0xFFFFFF)
    static let lightBgInput      = Color(hex: 0xF5F0E8)

    static let lightTextPrimary   = Color(hex: 0x0A0A0A)
    static let lightTextSecondary = Color(hex: 0x555555)
    static let lightTextTertiary  = Color(hex: 0x888888)
    static let lightTextInverse   = Color(hex: 0xF0F0E8)

    static let lightBorderColor   = Color(hex: 0xD0C9BA)
    static let lightBorderBold    = Color(hex: 0x0A0A0A)
    static let lightBorderSubtle  = Color(hex: 0xE0D9CC)
    static let lightShadowColor   = Color(hex: 0x0A0A0A)

    // ── Feature tool accents ───────────────────────
    static let toolCyan   = Color(hex: 0x22D3EE)
    static let toolPurple = Color(hex: 0x9B7FFF)
    static let toolAmber  = Color(hex: 0xFFAA00)
    static let toolGreen  = Color(hex: 0x00E570)
    static let toolRed    = Color(hex: 0xFF4466)

    // ── Status ─────────────────────────────────────
    static let success = Color(hex: 0x00E570)
    static let error   = Color(hex: 0xFF3D00)
    static let warning = Color(hex: 0xFFAA00)
    static let info    = Color(hex: 0x00D4FF)

    // ── Pure ───────────────────────────────────────
    static let black     = Color(hex: 0x000000)
    static let white     = Color(hex: 0xFFFFFF)
    static let pureBlack = Color(hex: 0x0A0A0A)
}

// ── Premium layer (for cinematic splash/hero) ──────
enum CxPremium {
    static let neonLime    = Color(hex: 0xC8FF00)
    static let neonCyan    = Color(hex: 0x00E5FF)
    static let neonMagenta = Color(hex: 0xFF2BD6)
    static let neonViolet  = Color(hex: 0x8B5CF6)
    static let neonOrange  = Color(hex: 0xFF6A00)
    static let neonMint    = Color(hex: 0x32FFB7)

    static let surface0 = Color(hex: 0x050505)
    static let surface1 = Color(hex: 0x0B0B0F)
    static let surface2 = Color(hex: 0x111117)
    static let surface3 = Color(hex: 0x171722)
    static let surface4 = Color(hex: 0x1F1F2E)

    static let glassStroke = Color(hex: 0xFFFFFF, alpha: 0.20)
}

// ── Color(hex:) helper ─────────────────────────────
extension Color {
    init(hex: UInt32, alpha: Double = 1.0) {
        let r = Double((hex >> 16) & 0xFF) / 255.0
        let g = Double((hex >> 8)  & 0xFF) / 255.0
        let b = Double( hex        & 0xFF) / 255.0
        self = Color(.sRGB, red: r, green: g, blue: b, opacity: alpha)
    }
}
