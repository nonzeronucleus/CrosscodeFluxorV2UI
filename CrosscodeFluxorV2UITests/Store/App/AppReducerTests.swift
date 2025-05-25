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
    
    
    @Test
    func testNavigateToLevel() async throws {
        @Injected(\.uuid) var uuid

        // Given
        let (store, mockAPI) = self.setup()
        
        // When
        let wrongLevel = LevelLayout(id: uuid(), number: 1, gridText: "..|..|")
        let levelToNavTo = LevelLayout(id: uuid(), number: 2, gridText: "..|..|")
        mockAPI.layouts = [wrongLevel, levelToNavTo]
        
        store.dispatch(action: NavigationActions.navigate(payload: .layoutDetail(id: levelToNavTo.id)))

        // Then
        let expectedActions = [
            NavigationActions.navigate(payload: .layoutDetail(id: levelToNavTo.id))
        ] as [any Action]
        
        try await Task.sleep(for: .seconds(0.2))
        
        #expect(store.dispatchedActions.count == expectedActions.count)
        #expect(compareActions(store.dispatchedActions, expectedActions))
        
        // Make sure all APIs have been called
        #expect(mockAPI.calledFunctions.count == 0)
//        #expect(mockAPI.calledFunctions.contains("importLayouts()"))
//        #expect(mockAPI.calledFunctions.contains("fetchAllLayouts()"))
    }
}
        
