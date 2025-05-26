import Fluxor
import Foundation


enum NavigationActions {
    static let selectTab = ActionTemplate(id: "[Navigation] Select Tab", payloadType: NavTab.self)
    static let navigateToDetail = ActionTemplate(id: "[Nav] Detail", payloadType: UUID.self)
    static let showSettings = ActionTemplate(id: "[Navigation] Show Settings")
    static let dismissPresentedRoute = ActionTemplate(id: "[Navigation] Dismiss Presented Route")
}
