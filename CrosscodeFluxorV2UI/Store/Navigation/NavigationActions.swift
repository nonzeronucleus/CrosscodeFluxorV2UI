import Fluxor

enum NavigationActions {
    static let navigate = ActionTemplate(id: "[NavigationActions] Navigate", payloadType: Route.self)
    static let presentSheet = ActionTemplate(id: "[NavigationActions] PresentSheet", payloadType: Route.self)
    static let dismiss = ActionTemplate(id: "[NavigationActions] Dismiss")
}
