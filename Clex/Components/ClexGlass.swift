import SwiftUI

enum ThemeMode: String, CaseIterable, Identifiable {
    case system
    case light
    case dark

    var id: String { rawValue }

    var title: String {
        switch self {
        case .system: return "System"
        case .light: return "Light"
        case .dark: return "Dark"
        }
    }

    var preferredScheme: ColorScheme? {
        switch self {
        case .system: return nil
        case .light: return .light
        case .dark: return .dark
        }
    }
}

struct ClexPalette {
    let isDark: Bool

    var background: Color { isDark ? Color(red: 0.07, green: 0.08, blue: 0.10) : Color(red: 0.95, green: 0.94, blue: 0.90) }
    var backgroundSecondary: Color { isDark ? Color(red: 0.10, green: 0.11, blue: 0.14) : Color(red: 0.98, green: 0.97, blue: 0.94) }
    var surface: Color { isDark ? Color.white.opacity(0.08) : Color.white.opacity(0.72) }
    var surfaceStrong: Color { isDark ? Color.white.opacity(0.12) : Color.white.opacity(0.84) }
    var border: Color { isDark ? Color.white.opacity(0.14) : Color.black.opacity(0.08) }
    var textPrimary: Color { isDark ? .white : Color.black.opacity(0.92) }
    var textSecondary: Color { isDark ? Color.white.opacity(0.70) : Color.black.opacity(0.58) }
    var accent: Color { isDark ? Color(red: 0.78, green: 1.0, blue: 0.12) : Color(red: 0.56, green: 0.82, blue: 0.12) }
    var accentSoft: Color { accent.opacity(isDark ? 0.26 : 0.18) }
    var shadow: Color { Color.black.opacity(isDark ? 0.30 : 0.10) }
}

private struct ClexPaletteKey: EnvironmentKey {
    static let defaultValue = ClexPalette(isDark: false)
}

extension EnvironmentValues {
    var clexPalette: ClexPalette {
        get { self[ClexPaletteKey.self] }
        set { self[ClexPaletteKey.self] = newValue }
    }
}

extension View {
    func clexPalette(_ palette: ClexPalette) -> some View {
        environment(\.clexPalette, palette)
    }

    func clexReveal(_ index: Int) -> some View {
        modifier(ClexReveal(index: index))
    }
}

struct ClexGlassBackground: View {
    @Environment(\.clexPalette) private var palette

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [palette.background, palette.backgroundSecondary],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            Circle()
                .fill(palette.accent.opacity(palette.isDark ? 0.18 : 0.12))
                .frame(width: 340, height: 340)
                .blur(radius: 54)
                .offset(x: -120, y: -250)

            Circle()
                .fill(Color.cyan.opacity(palette.isDark ? 0.12 : 0.08))
                .frame(width: 280, height: 280)
                .blur(radius: 60)
                .offset(x: 150, y: -140)
        }
    }
}

struct ClexGlassCard<Content: View>: View {
    @Environment(\.clexPalette) private var palette

    let padding: CGFloat
    let content: Content

    init(padding: CGFloat = 18, @ViewBuilder content: () -> Content) {
        self.padding = padding
        self.content = content()
    }

    var body: some View {
        content
            .padding(padding)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 24, style: .continuous))
            .background(
                RoundedRectangle(cornerRadius: 24, style: .continuous)
                    .fill(palette.surface)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 24, style: .continuous)
                    .stroke(palette.border, lineWidth: 1)
            )
            .shadow(color: palette.shadow, radius: 20, x: 0, y: 10)
    }
}

struct ClexHeader: View {
    @Environment(\.clexPalette) private var palette

    let icon: String
    let title: String
    let status: String?

    var body: some View {
        HStack(spacing: 14) {
            HStack(spacing: 10) {
                ZStack {
                    RoundedRectangle(cornerRadius: 14, style: .continuous)
                        .fill(palette.accentSoft)
                        .frame(width: 40, height: 40)
                    Image(systemName: icon)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(palette.accent)
                }

                Text(title)
                    .font(.system(size: 24, weight: .bold, design: .rounded))
                    .foregroundStyle(palette.textPrimary)
            }

            Spacer()

            if let status {
                HStack(spacing: 8) {
                    Circle()
                        .fill(palette.accent)
                        .frame(width: 8, height: 8)
                    Text(status)
                        .font(.system(size: 12, weight: .semibold, design: .rounded))
                        .tracking(0.8)
                }
                .foregroundStyle(palette.textPrimary)
                .padding(.horizontal, 14)
                .padding(.vertical, 10)
                .background(.ultraThinMaterial, in: Capsule())
                .overlay(Capsule().stroke(palette.border, lineWidth: 1))
            }
        }
    }
}

struct ClexLogoMark: View {
    let size: CGFloat

    var body: some View {
        Image("ClexLogo")
            .resizable()
            .scaledToFit()
            .frame(width: size, height: size)
            .clipShape(RoundedRectangle(cornerRadius: size * 0.24, style: .continuous))
    }
}

struct ClexSectionTitle: View {
    @Environment(\.clexPalette) private var palette

    let title: String

    var body: some View {
        HStack(spacing: 8) {
            Circle()
                .fill(palette.accent)
                .frame(width: 7, height: 7)
            Text(title)
                .font(.system(size: 12, weight: .bold, design: .rounded))
                .tracking(1.6)
                .foregroundStyle(palette.textSecondary)
        }
    }
}

struct ClexPrimaryButton: View {
    @Environment(\.clexPalette) private var palette

    let title: String
    let systemImage: String?
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 10) {
                Text(title)
                if let systemImage {
                    Image(systemName: systemImage)
                }
            }
            .font(.system(size: 15, weight: .semibold, design: .rounded))
            .foregroundStyle(Color.black.opacity(0.88))
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .background(
                LinearGradient(
                    colors: [palette.accent, palette.accent.opacity(0.84)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ),
                in: RoundedRectangle(cornerRadius: 18, style: .continuous)
            )
            .shadow(color: palette.accent.opacity(0.24), radius: 16, x: 0, y: 8)
        }
        .buttonStyle(.plain)
    }
}

struct ClexSecondaryButton: View {
    @Environment(\.clexPalette) private var palette

    let title: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 14, weight: .semibold, design: .rounded))
                .foregroundStyle(palette.textPrimary)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 14)
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 18, style: .continuous))
                .overlay(
                    RoundedRectangle(cornerRadius: 18, style: .continuous)
                        .stroke(palette.border, lineWidth: 1)
                )
        }
        .buttonStyle(.plain)
    }
}

struct ClexMetricCard: View {
    @Environment(\.clexPalette) private var palette

    let title: String
    let value: String

    var body: some View {
        ClexGlassCard {
            VStack(alignment: .leading, spacing: 10) {
                Text(title)
                    .font(.system(size: 11, weight: .bold, design: .rounded))
                    .tracking(1.4)
                    .foregroundStyle(palette.textSecondary)
                Text(value)
                    .font(.system(size: 34, weight: .bold, design: .rounded))
                    .foregroundStyle(palette.textPrimary)
            }
        }
    }
}

private struct ClexReveal: ViewModifier {
    let index: Int
    @State private var visible = false

    func body(content: Content) -> some View {
        content
            .opacity(visible ? 1 : 0)
            .offset(y: visible ? 0 : 18)
            .scaleEffect(visible ? 1 : 0.985)
            .animation(
                .spring(response: 0.48, dampingFraction: 0.88)
                    .delay(Double(index) * 0.05),
                value: visible
            )
            .onAppear {
                visible = true
            }
    }
}
