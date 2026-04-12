import SwiftUI

struct RootView: View {
    @Environment(\.colorScheme) private var colorScheme
    @State private var selection: AppTab = .home
    @State private var path: [AppRoute] = []

    private var palette: ClexPalette { ClexPalette(isDark: colorScheme == .dark) }

    var body: some View {
        NavigationStack(path: $path) {
            ZStack(alignment: .bottom) {
                ClexGlassBackground()

                Group {
                    switch selection {
                    case .home:
                        HomeView()
                    case .vault:
                        VaultView()
                    case .chain:
                        ChainView()
                    case .settings:
                        SettingsView(
                            onNavigateHelp: { path.append(.help) },
                            onNavigatePrivacy: { path.append(.privacy) },
                            onNavigateDeveloper: { path.append(.developer) }
                        )
                    }
                }
                .clexPalette(palette)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)

                BottomNavBar(selection: $selection)
                    .clexPalette(palette)
                    .padding(.horizontal, 16)
                    .padding(.bottom, 8)
            }
            .navigationDestination(for: AppRoute.self) { route in
                switch route {
                case .help:
                    HelpFaqView()
                        .clexPalette(palette)
                case .privacy:
                    PrivacyView()
                        .clexPalette(palette)
                case .developer:
                    DeveloperView()
                        .clexPalette(palette)
                }
            }
            .toolbar(.hidden, for: .navigationBar)
        }
        .clexPalette(palette)
    }
}
