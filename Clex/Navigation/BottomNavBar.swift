import SwiftUI

struct BottomNavBar: View {
    @Environment(\.clexPalette) private var palette
    @Binding var selection: AppTab

    var body: some View {
        HStack(spacing: 12) {
            ForEach(AppTab.allCases, id: \.self) { tab in
                Button {
                    withAnimation(.spring(response: 0.34, dampingFraction: 0.84)) {
                        selection = tab
                    }
                } label: {
                    VStack(spacing: 8) {
                        Image(systemName: tab.icon)
                            .font(.system(size: 16, weight: .semibold))
                        Text(tab.title)
                            .font(.system(size: 11, weight: .bold, design: .rounded))
                            .tracking(1.2)
                    }
                    .foregroundStyle(selection == tab ? palette.textPrimary : palette.textSecondary)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .background(
                        RoundedRectangle(cornerRadius: 18, style: .continuous)
                            .fill(selection == tab ? palette.accentSoft : Color.clear)
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 18, style: .continuous)
                            .stroke(selection == tab ? palette.border : Color.clear, lineWidth: 1)
                    )
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.horizontal, 16)
        .padding(.top, 12)
        .padding(.bottom, 10)
        .background(.ultraThinMaterial)
        .background(palette.surfaceStrong)
        .clipShape(RoundedRectangle(cornerRadius: 28, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 28, style: .continuous)
                .stroke(palette.border, lineWidth: 1)
        )
        .shadow(color: palette.shadow, radius: 16, x: 0, y: 8)
    }
}
