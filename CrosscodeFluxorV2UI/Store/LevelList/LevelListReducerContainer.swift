import Fluxor
import CrosscodeDataLibrary

class LevelListReducerContainer {
    private var reducers: [ObjectIdentifier: Any] = [:]
    
    func register<L: Level>(_ reducer: Reducer<LevelListState<L>>, for type: L.Type) {
        reducers[ObjectIdentifier(type)] = reducer
    }
    
    func get<L: Level>(for type: L.Type) -> Reducer<LevelListState<L>>? {
        return reducers[ObjectIdentifier(type)] as? Reducer<LevelListState<L>>
    }
}
