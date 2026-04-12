import SwiftUI

// ═══════════════════════════════════════════════════
//  HardShadow
//  Directional, non-blurred offset rectangle drawn
//  BEHIND a view. Matches Android HardShadow.
//  No elevation, no blur — raw geometric shadow.
// ═══════════════════════════════════════════════════

struct HardShadowModifier: ViewModifier {
    let offsetX: CGFloat
    let offsetY: CGFloat
    let color: Color
    let cornerRadius: CGFloat

    func body(content: Content) -> some View {
        content
            .background(
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .fill(color)
                    .offset(x: offsetX, y: offsetY)
            )
    }
}

extension View {
    /// Draws a hard offset shadow behind this view. No blur.
    func hardShadow(
        x: CGFloat = 5,
        y: CGFloat = 5,
        color: Color = CxColors.shadowColor,
        cornerRadius: CGFloat = 0
    ) -> some View {
        modifier(HardShadowModifier(
            offsetX: x, offsetY: y, color: color, cornerRadius: cornerRadius
        ))
    }
}
