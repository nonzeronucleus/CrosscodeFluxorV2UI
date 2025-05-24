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
       return createTestStoreAndAPI(initialState: NavigationState(), reducers: [navigationReducer])
    }

    @Test
    func testNavigateToLevel() async throws {
        @Injected(\.uuid) var uuid

        // Given
        let (store, mockAPI) = self.setup()
        
        // When
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
    }
}
        
