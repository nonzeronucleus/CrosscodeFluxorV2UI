import Testing
import Foundation
import Factory
import Fluxor
import FluxorTestSupport
@testable import CrosscodeFluxorV2UI
import CrosscodeDataLibrary



struct NavigationReducerTests {
    init() {
        initTestEnv()
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
        let dispatchedAction = NavigationActions.navigateToDetail(payload: levelToNavTo.id)
        
        store.dispatch(action: dispatchedAction)
        // Then
        let expectedActions = [
            dispatchedAction
        ] as [any Action]
        
        try await Task.sleep(for: .seconds(0.2))
        
        #expect(store.dispatchedActions.count == expectedActions.count)
        #expect(compareActions(store.dispatchedActions, expectedActions))
        
        #expect(mockAPI.calledFunctions.count == 0)
        #expect(store.state.presentedRoute ==  .layoutDetail(levelToNavTo.id))
    }
    
    @Test func testNavigateToSettings() async throws {
        // Given
        let (store, _) = self.setup()
        #expect(store.state.presentedRoute == nil)
        
        // When
        let dispatchedAction = NavigationActions.showSettings()
        
        store.dispatch(action: dispatchedAction)

        // Then
        let expectedActions = [
            dispatchedAction
        ] as [any Action]
        
        try await Task.sleep(for: .seconds(0.2))
        
        #expect(store.dispatchedActions.count == expectedActions.count)

        #expect(store.state.presentedRoute == .settings)

        
    }
}
        
