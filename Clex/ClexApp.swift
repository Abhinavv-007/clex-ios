import SwiftUI

@main
struct ClexApp: App {
    @AppStorage("clex.theme.mode") private var themeModeRaw: String = ThemeMode.system.rawValue

    private var preferredScheme: ColorScheme? {
        ThemeMode(rawValue: themeModeRaw)?.preferredScheme
    }

    var body: some Scene {
        WindowGroup {
            RootView()
                .preferredColorScheme(preferredScheme)
        }
    }
}
