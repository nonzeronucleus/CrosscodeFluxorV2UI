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
        let store = Store(initialState: AppState(), environment: AppEnvironment(layoutsAPI: LayoutsAPIImpl()))
        store.register(reducer: appReducer)
        store.register(effects: AppEffects())
        
        store.register(reducer: layoutsReducer, for: \.layouts)
        store.register(effects: LayoutsEffects())
        
        store.register(reducer: navigationReducer, for: \.navigation)
        
        store.register(reducer: layoutEditReducer, for: \.levelEdit)
        store.register(effects: LayoutEditEffects())
        
        store.register(reducer: settingsReducer, for: \.settings)
        
        
        let levelLayoutReducer: Reducer<LevelListState<LevelLayout>> = makeLevelListReducer()
        store.register(reducer: levelLayoutReducer, for: \.levelLayouts)
        store.register(effects: LeveListEffects())
        
//        let s = testFunc<LevelLayout>() //level:LevelLayout(id: UUID(), number: 1, crossword: Crossword(initString: "-|-|"), letterMap: nil))
//                                
//        debugPrint(s)

//        let levelLayoutReducer = createLevelListReducer<LevelLayout>()
//            .reduce(on: EditableLevelActions.customAction) { state, action in
//                // EditableLevel-specific reductions
//            }
        
//        store.register(reducer: levelListReducer, for: \.levelLayouts)
        
        
        
        
        
//        store.register(reducer: appReducer)
//        store.register(effects: AppEffects(store: store) )
        
#if DEBUG
        //    store.register(interceptor: PrintInterceptor())
        //    store.register(interceptor: FluxorExplorerInterceptor(displayName: UIDevice.current.name))
#endif
        return store
    }
    
}
