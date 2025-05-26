import Fluxor
import Foundation


enum NavigationActions {
    static let selectTab = ActionTemplate(id: "[Navigation] Select Tab", payloadType: NavTab.self)
    static let navigateToDetail = ActionTemplate(id: "[Nav] Detail", payloadType: UUID.self)
    static let showSettings = ActionTemplate(id: "[Navigation] Show Settings")
    static let dismissPresentedRoute = ActionTemplate(id: "[Navigation] Dismiss Presented Route")
}

//enum NavigationActions {
//    static let navigate = ActionTemplate(id: "[NavigationActions] Navigate", payloadType: Route.self)
//    static let presentSheet = ActionTemplate(id: "[NavigationActions] PresentSheet", payloadType: Route.self)
//    static let dismiss = ActionTemplate(id: "[NavigationActions] Dismiss")
//}



//enum NavigationActions {
//    static let switchTab = ActionTemplate(id: "[Nav] Switch Tab", payloadType: NavigationState.Tab.self)
//    static let navigateToDetail = ActionTemplate(id: "[Nav] Detail", payloadType: UUID.self)
//    static let navigateBack = ActionTemplate(id: "[Nav] Back")
//    static let showSettings = ActionTemplate(id: "[Nav] Show Settings")
//    static let dismissSettings = ActionTemplate(id: "[Nav] Dismiss Settings")
//}
