import Testing
import Foundation
import Factory
import Fluxor
import FluxorTestSupport
@testable import CrosscodeFluxorV2UI
import CrosscodeDataLibrary



struct NavigationReducerTests {
    init() {
        
    }
    
    func setup() -> (MockStore<NavigationState, AppEnvironment>, MockLayoutsService) {
        let _ = Container.shared.uuid
            .register { IncrementingUUIDProvider() }
            .singleton
        
        let mockAPI = MockLayoutsService()
        
        let environment = AppEnvironment(layoutsAPI: mockAPI)
        let store = MockStore(
            initialState: NavigationState(),
            environment: environment,
            reducers: [navigationReducer]
        )
        
//        store.register(effects: NavigationEffects())
        
        return (store, mockAPI)
    }
    
    
    @Test
    func testNavigateToLevel() async throws {
        @Injected(\.uuid) var uuid

        // Given
        let (store, mockAPI) = self.setup()
        
        // When
//        let wrongLevel = LevelLayout(id: uuid(), number: 1, gridText: "..|..|")
        let levelToNavTo = LevelLayout(id: uuid(), number: 2, gridText: "..|..|")
        
        store.dispatch(action: NavigationActions.navigate(payload: .layoutDetail(id: levelToNavTo.id)))
        // Then
        let expectedActions = [
            NavigationActions.navigate(payload: .layoutDetail(id: levelToNavTo.id)),
        ] as [any Action]
        
        try await Task.sleep(for: .seconds(0.2))
        
        #expect(store.dispatchedActions.count == expectedActions.count)
        #expect(compareActions(store.dispatchedActions, expectedActions))
        
        #expect(mockAPI.calledFunctions.count == 0)
        #expect(store.state.route ==  .layoutDetail(id: levelToNavTo.id))
        
//        #expect(store.state.route == .levelDetail(id: levelToNavTo.id))
    }
}
        
