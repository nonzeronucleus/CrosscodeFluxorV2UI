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
}

struct NavigationState: Equatable {
    var selectedTab: NavTab = .edit
    var presentedRoute: Route? = nil
}







//import CrosscodeDataLibrary

//struct NavigationState: Equatable {
//    enum Tab: String, CaseIterable {
//        case playableLevels
//        case editableLayouts
//    }
//    
//    var activeTab: Tab = .playableLevels
//    var playableLevelsStack: [Route] = []
//    var editableLayoutsStack: [Route] = []
//    var isShowingSettings = false
//    
//    // Shared selected item ID
//    var selectedLevelID: UUID?
//}
//
//enum Route: Equatable {
//    case levelList
//    case levelDetail(UUID)
//    case layoutList
//    case layoutDetail(UUID)
//}
//    
    
    
    
//    Equatable {
//    var route: Route?  // Current route
//    var sheet: Route?  // For modals
//}
//
//enum Route: Equatable {
//    case layoutDetail(id: UUID)
//    case settings
//    // Add all routes
//}
