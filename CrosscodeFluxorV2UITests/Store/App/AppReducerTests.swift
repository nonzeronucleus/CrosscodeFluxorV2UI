import Testing
import Foundation
import Factory
import Fluxor
import FluxorTestSupport
@testable import CrosscodeFluxorV2UI
import CrosscodeDataLibrary



struct AppReducerTests {
    init() {
        
    }
    
    func setup() -> (MockStore<AppState, AppEnvironment>, MockLayoutsService) {
        let _ = Container.shared.uuid
            .register { IncrementingUUIDProvider() }
            .singleton
        
        let mockAPI = MockLayoutsService()
        
        let environment = AppEnvironment(layoutsAPI: mockAPI)
        let store = MockStore(
            initialState: AppState(),
            environment: environment,
            reducers: [appReducer]
        )
        
        store.register(reducer: appReducer)
        store.register(effects: AppEffects())
        
        return (store, mockAPI)
    }
}
        
