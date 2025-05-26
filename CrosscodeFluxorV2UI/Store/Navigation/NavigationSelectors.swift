import Fluxor

enum NavigationSelectors {
    static let state = Selector(keyPath: \AppState.navigation)

    static let selectedTab = Selector(keyPath: \AppState.navigation.selectedTab)
    
    static let presentedRoute = Selector(keyPath: \AppState.navigation.presentedRoute)
}

