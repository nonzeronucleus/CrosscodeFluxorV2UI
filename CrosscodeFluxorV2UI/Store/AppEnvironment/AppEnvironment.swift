import Factory
import Fluxor
import CrosscodeDataLibrary

struct AppEnvironment {
    let layoutsAPI:LayoutsAPI
    let levelListReducerContainer = LevelListReducerContainer()
    
    
    init(layoutsAPI:LayoutsAPI) {
        self.layoutsAPI = layoutsAPI
    }
    
//    func levelActions(for level:any Level) -> LevelListActions {
//        levelActions[level]!
//    }
//    
//    func register<L: Level>(_ reducer: Reducer<LevelListState<L>>, for type: L.Type) {
//        reducers[type] = AnyLevelReducer(reducer)
//    }
    
    
}
