import Testing
import Foundation
import Factory
import Fluxor
import FluxorTestSupport
@testable import CrosscodeFluxorV2UI
import CrosscodeDataLibrary


func initTestEnv() {
    let _ = Container.shared.uuid.register { IncrementingUUIDProvider() }.singleton
}

/// Creates a test store without effects
func createTestStoreAndAPI<S: Equatable>(
    initialState: @autoclosure () -> S,
    reducers: [Reducer<S>]
) -> (MockStore<S, AppEnvironment>, MockLayoutsService) {
    // Register dependencies
    // Create mock services
    let mockAPI = MockLayoutsService()
    
    
    Container.shared.layoutsAPI.register { mockAPI }
    mockAPI.reset()



    let environment = AppEnvironment(layoutsAPI: mockAPI, playableLevelsAPI: MockPlayaLevelsAPI())
    
    // Initialize store
    let store = MockStore(
        initialState: initialState(),
        environment: environment,
        reducers: reducers
    )
    
    return (store, mockAPI)
}

/// Creates a test store with effects
func createTestStoreAndAPI<S: Equatable, E: Effects>(
    initialState: @autoclosure () -> S,
    reducers: [Reducer<S>],
    effects: (Store<S, AppEnvironment>) -> E
) -> (MockStore<S, AppEnvironment>, MockLayoutsService) where E.Environment == AppEnvironment {
    // Create base store
    let (store, mockAPI) = createTestStoreAndAPI(
        initialState: initialState(),
        reducers: reducers
    )
    
    // Register effects
    store.register(effects: effects(store))
    
    return (store, mockAPI)
}
