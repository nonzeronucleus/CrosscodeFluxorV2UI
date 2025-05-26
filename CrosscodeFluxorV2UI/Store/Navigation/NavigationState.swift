import Foundation

enum NavTab: Equatable {
    case play
    case edit
}

enum Route: Identifiable, Equatable {
    case settings
    case layoutDetail(UUID)

    var id: String {
        switch self {
        case .settings:
            return "settings"
        case .layoutDetail(let uuid):
            return uuid.uuidString
        }
    }
    
    var asModal: Route? {
        switch self {
            case .settings: return .settings
            default: return nil
        }
    }
}

struct NavigationState: Equatable {
    var selectedTab: NavTab = .edit
    var presentedRoute: Route? = nil
}
