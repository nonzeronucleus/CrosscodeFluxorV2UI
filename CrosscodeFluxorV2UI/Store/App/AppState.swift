//import Fluxor
//import Factory
//import SwiftUI
import CrosscodeDataLibrary


struct AppState: Encodable {
//    var layouts = LayoutsState()
    var levelLayouts = LevelListState<LevelLayout>()
    var playableLevels = LevelListState<PlayableLevel>()
    var navigation = NavigationState()
    var levelEdit: LayoutEditState?
    var settings = SettingsState()
}
