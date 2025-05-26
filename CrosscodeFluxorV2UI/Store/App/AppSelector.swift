import Fluxor

struct AppSelectors {
    static let navigationState = Selector(
        keyPath: \AppState.navigation
    )
    
//    static let levels = Selector(
//        keyPath: \AppState.levels
//    )
}
