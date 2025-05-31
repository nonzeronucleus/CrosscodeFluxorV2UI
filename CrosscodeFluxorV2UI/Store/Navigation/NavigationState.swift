import Foundation

enum NavTab: Equatable, Encodable {
    case play
    case edit
}

enum Route: Identifiable, Equatable, Encodable {
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

struct NavigationState: Equatable, Encodable {
    var selectedTab: NavTab = .edit
    var presentedRoute: Route? = nil
}
