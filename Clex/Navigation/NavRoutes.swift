import Foundation

enum AppTab: String, CaseIterable, Hashable {
    case home
    case vault
    case chain
    case settings

    var title: String {
        switch self {
        case .home: return "HOME"
        case .vault: return "VAULT"
        case .chain: return "CHAIN"
        case .settings: return "SETTINGS"
        }
    }

    var icon: String {
        switch self {
        case .home: return "bolt.horizontal.circle"
        case .vault: return "lock.shield"
        case .chain: return "point.3.connected.trianglepath.dotted"
        case .settings: return "gearshape"
        }
    }
}

enum AppRoute: Hashable {
    case help
    case privacy
    case developer
}
