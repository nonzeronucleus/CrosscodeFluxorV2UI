import Fluxor

enum NavigationSelectors {
    static let currentRoute = Selector<AppState, Route?>(
        projector: \.navigation.route
    )
    
    static let currentSheet = Selector<AppState, Route?>(
        projector: \.navigation.sheet
    )
}
