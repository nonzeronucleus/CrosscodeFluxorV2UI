import Fluxor
import Factory
import CrosscodeDataLibrary

public extension Container {
    internal var store: Factory<Store<AppState, AppEnvironment>> {
        Factory(self) {
            self.createStore()
        }.singleton
    }
    
    internal func createStore() -> Store<AppState, AppEnvironment> {
        let store = Store(
            initialState: AppState(),
            environment: AppEnvironment(
                layoutsAPI: LayoutsAPIImpl(),
                playableLevelsAPI: PlayableLevelsAPIImpl(),
            ))
        
        store.register(reducer: appReducer)
        store.register(effects: AppEffects())
        
//        store.register(reducer: layoutsReducer, for: \.layouts)
//        store.register(effects: LayoutsEffects())
        
        store.register(reducer: navigationReducer, for: \.navigation)
        
        store.register(reducer: layoutEditReducer, for: \.levelEdit)
        store.register(effects: LayoutEditEffects())
        
        store.register(reducer: settingsReducer, for: \.settings)
        
        
        let levelLayoutReducer: Reducer<LevelListState<LevelLayout>> = makeLevelListReducer()
        store.register(reducer: levelLayoutReducer, for: \.levelLayouts)
        
        let levelLayoutEffects: LevelListEffects<LevelLayout> = LevelListEffects()
        store.register(effects: levelLayoutEffects)
//        
////        store.environment.levelListReducerContainer.register(levelLayoutReducer, for: LevelLayout.Type)
//
        let playableLevelReducer: Reducer<LevelListState<PlayableLevel>> = makeLevelListReducer()
        store.register(reducer: playableLevelReducer, for: \.playableLevels)
        
        let playableLevelEffects: LevelListEffects<PlayableLevel> = LevelListEffects()
        store.register(effects: playableLevelEffects)

//
//        store.environment.levelListReducerContainer.register(levelLayoutReducer, for: LevelLayout.self)
//        store.environment.levelListReducerContainer.register(playableLevelReducer, for: PlayableLevel.self)

        
//        store.register(effects: LevelListEffects())

#if DEBUG
//        store.register(interceptor: PrintInterceptor())
        //    store.register(interceptor: FluxorExplorerInterceptor(displayName: UIDevice.current.name))
#endif
        return store
    }
    
}
