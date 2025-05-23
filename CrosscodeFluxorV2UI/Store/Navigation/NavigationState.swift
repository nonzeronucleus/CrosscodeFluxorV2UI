import Foundation
//import CrosscodeDataLibrary

struct NavigationState: Equatable {
    var route: Route?  // Current route
    var sheet: Route?  // For modals
}

enum Route: Equatable {
    case layoutDetail(id: UUID)
    case settings
    // Add all routes
}
