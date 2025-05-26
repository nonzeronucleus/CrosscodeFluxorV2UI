//import Fluxor
//import Factory
//import SwiftUI


struct AppState /*: Encodable*/ {
    var layouts = LayoutsState()
    var navigation = NavigationState()
    var levelEdit: LayoutEditState?
    var settings = SettingsState()
}
