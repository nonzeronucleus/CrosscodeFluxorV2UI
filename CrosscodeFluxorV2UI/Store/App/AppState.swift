//import Fluxor
//import Factory
//import SwiftUI
import CrosscodeDataLibrary


struct AppState /*: Encodable*/ {
    var layouts = LayoutsState()
//    var playableLevels = LevelListState<PlayableLevel>()
//    var levelLayouts = LevelListState<LevelLayout>()
    var levelLayouts = LevelListState<LevelLayout>()
    var navigation = NavigationState()
    var levelEdit: LayoutEditState?
    var settings = SettingsState()
}
