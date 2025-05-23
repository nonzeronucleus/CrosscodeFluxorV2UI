import Fluxor
import Factory

public extension Container {
    internal var store: Factory<Store<AppState, AppEnvironment>> {
        Factory(self) {
            self.createStore()
        }.singleton
    }
    
    internal func createStore() -> Store<AppState, AppEnvironment> {
        let store = Store(initialState: AppState(), environment: AppEnvironment(layoutsAPI: TmpLayoutsService()))
        store.register(reducer: layoutsReducer, for: \.layouts)
//        store.register(reducer: appReducer)
//        store.register(effects: AppEffects(store: store) )
        
#if DEBUG
        //    store.register(interceptor: PrintInterceptor())
        //    store.register(interceptor: FluxorExplorerInterceptor(displayName: UIDevice.current.name))
#endif
        return store
    }
    
}
