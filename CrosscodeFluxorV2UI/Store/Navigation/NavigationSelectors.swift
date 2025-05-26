import Fluxor
import Factory

enum NavigationSelectors {
    static let state = Selector(keyPath: \AppState.navigation)

    static let selectedTab = Selector(keyPath: \AppState.navigation.selectedTab)
    
    static let presentedRoute = Selector(keyPath: \AppState.navigation.presentedRoute)
}


//enum NavigationSelectors {
//    static let editableLayoutsStack = Selector<AppState,[Route]>(
//        projector: \.navigation.editableLayoutsStack
//    )
//
//    
//    static let currentRoute = Selector<AppState, Route?>(
//        projector: \.navigation.route
//    )
//    
//    static let currentSheet = Selector<AppState, Route?>(
//        projector: \.navigation.sheet
//    )
//}


