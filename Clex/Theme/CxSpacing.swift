import SwiftUI

// ═══════════════════════════════════════════════════
//  CLEX — Spacing, Borders, Radius Tokens
//  Ported from Android CxSpacing / CxBorders / CxRadius
// ═══════════════════════════════════════════════════

enum CxSpacing {
    static let xs:   CGFloat = 4
    static let sm:   CGFloat = 8
    static let md:   CGFloat = 16
    static let lg:   CGFloat = 24
    static let xl:   CGFloat = 32
    static let xxl:  CGFloat = 48
    static let xxxl: CGFloat = 64
    static let xxxxl: CGFloat = 96

    static let screenHorizontal: CGFloat = 20
    static let screenVertical:   CGFloat = 24

    static let sectionGap:  CGFloat = 56
    static let cardPadding: CGFloat = 24
    static let chipPadding: CGFloat = 12
}

enum CxBorders {
    static let thin:   CGFloat = 2
    static let medium: CGFloat = 3
    static let thick:  CGFloat = 4
    static let heavy:  CGFloat = 5
}

enum CxRadius {
    static let none: CGFloat = 0
    static let sm:   CGFloat = 4
    static let md:   CGFloat = 8
    static let lg:   CGFloat = 12
    static let full: CGFloat = 999
}
