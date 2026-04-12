import SwiftUI

struct SettingsView: View {
    @Environment(\.clexPalette) private var palette
    @AppStorage("clex.theme.mode") private var themeModeRaw: String = ThemeMode.system.rawValue

    let onNavigateHelp: () -> Void
    let onNavigatePrivacy: () -> Void
    let onNavigateDeveloper: () -> Void

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 20) {
                ClexHeader(icon: "gearshape.fill", title: "Settings", status: "v\(AppRelease.versionName)")
                    .clexReveal(0)

                ClexGlassCard {
                    VStack(alignment: .leading, spacing: 14) {
                        ClexSectionTitle(title: "APPEARANCE")
                        Picker("Theme", selection: $themeModeRaw) {
                            ForEach(ThemeMode.allCases) { mode in
                                Text(mode.title).tag(mode.rawValue)
                            }
                        }
                        .pickerStyle(.segmented)
                    }
                }
                .clexReveal(1)

                ClexGlassCard {
                    VStack(alignment: .leading, spacing: 12) {
                        ClexSectionTitle(title: "ABOUT")
                        SettingsRow(title: "HELP & FAQ", subtitle: "How Clex works", action: onNavigateHelp)
                        SettingsRow(title: "PRIVACY", subtitle: "Zero knowledge · No server storage", action: onNavigatePrivacy)
                        SettingsRow(title: "ABOUT THE DEVELOPER", subtitle: "Release notes and profile", action: onNavigateDeveloper)
                    }
                }
                .clexReveal(2)

                ClexGlassCard {
                    VStack(alignment: .leading, spacing: 12) {
                        ClexSectionTitle(title: "VERSION")
                        Text("Native iOS glass shell with aligned product copy and release metadata for v\(AppRelease.versionName).")
                            .font(.system(size: 15, weight: .medium, design: .rounded))
                            .foregroundStyle(palette.textSecondary)
                    }
                }
                .clexReveal(3)
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
            .padding(.bottom, 130)
        }
    }
}

private struct SettingsRow: View {
    @Environment(\.clexPalette) private var palette

    let title: String
    let subtitle: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                VStack(alignment: .leading, spacing: 6) {
                    Text(title)
                        .font(.system(size: 16, weight: .bold, design: .rounded))
                        .foregroundStyle(palette.textPrimary)
                    Text(subtitle)
                        .font(.system(size: 14, weight: .medium, design: .rounded))
                        .foregroundStyle(palette.textSecondary)
                }
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundStyle(palette.textSecondary)
            }
            .padding(.vertical, 6)
        }
        .buttonStyle(.plain)
    }
}
