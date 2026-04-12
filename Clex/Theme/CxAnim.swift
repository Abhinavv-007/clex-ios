import SwiftUI

// ═══════════════════════════════════════════════════
//  CLEX — Animation Tokens
//  Spring presets match Android CxSpringSpecs
//  SwiftUI's .spring uses (response, dampingFraction)
// ═══════════════════════════════════════════════════

enum CxAnim {
    // Durations
    static let durationFast:       Double = 0.15
    static let durationNormal:     Double = 0.30
    static let durationSlow:       Double = 0.50
    static let durationStatement:  Double = 0.80
    static let durationCinematic:  Double = 1.20

    // Stagger
    static let staggerDelay: Double = 0.09
    static let microDelay:   Double = 0.05
}

enum CxSpringSpecs {
    // Snap — buttons, chips, small UI
    static let snap = Animation.spring(response: 0.28, dampingFraction: 0.70)
    // Panel — screen enters, micro-app windows
    static let panel = Animation.spring(response: 0.42, dampingFraction: 0.72)
    // Bounce — onboarding, success
    static let bounce = Animation.spring(response: 0.55, dampingFraction: 0.55)
    // Gentle — idle drift
    static let gentle = Animation.spring(response: 0.80, dampingFraction: 0.85)
    // Slam — hero stamps, screen transitions
    static let slam = Animation.spring(response: 0.22, dampingFraction: 0.65)
    // Press — physical button depression
    static let press = Animation.spring(response: 0.16, dampingFraction: 0.90)
}
