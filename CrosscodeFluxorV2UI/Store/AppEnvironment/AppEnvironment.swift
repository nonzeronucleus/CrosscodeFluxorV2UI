import Factory
import Fluxor
import CrosscodeDataLibrary

struct AppEnvironment {
    let layoutsAPI:LayoutsAPI
    let playableLevelsAPI:LevelsAPI
    let levelListReducerContainer = LevelListReducerContainer()
    
    
    init(layoutsAPI:LayoutsAPI, playableLevelsAPI:LevelsAPI) {
        self.layoutsAPI = layoutsAPI
        self.playableLevelsAPI = playableLevelsAPI
    }
    
//    func levelActions(for level:any Level) -> LevelListActions {
//        levelActions[level]!
//    }
//    
//    func register<L: Level>(_ reducer: Reducer<LevelListState<L>>, for type: L.Type) {
//        reducers[type] = AnyLevelReducer(reducer)
//    }
    
    
}
