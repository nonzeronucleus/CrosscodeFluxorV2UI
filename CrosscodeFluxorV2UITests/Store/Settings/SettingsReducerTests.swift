import Testing
import Foundation
import Factory
import Fluxor
import FluxorTestSupport
@testable import CrosscodeFluxorV2UI
import CrosscodeDataLibrary



struct SettingsReducerTests {
    init() {
        initTestEnv()
    }
    
    func setup() -> (MockStore<SettingsState, AppEnvironment>, MockLayoutsService) {
        return createTestStoreAndAPI(initialState: SettingsState(), reducers: [settingsReducer])
    }
    
    @Test
    func testToggleEditMode() async throws {
        // Given
        let (store, mockAPI) = self.setup()
        
        // When
        let dispatchedAction_true = SettingsActions.setEditMode(payload: true)
        #expect(store.state.editMode ==  false)
        
        store.dispatch(action: dispatchedAction_true)
        
        // Then
        var expectedActions = [
            dispatchedAction_true
        ] as [any Action]
        
        try await Task.sleep(for: .seconds(0.2))
        
        #expect(store.dispatchedActions.count == expectedActions.count)
        #expect(compareActions(store.dispatchedActions, expectedActions))
        
        #expect(mockAPI.calledFunctions.count == 0)
        
        #expect(store.state.editMode ==  true)
        #expect(store.state.darkMode ==  false)

        let dispatchedAction_false = SettingsActions.setEditMode(payload: false)
        store.dispatch(action: dispatchedAction_false)
        
        //And then
        expectedActions = [
            dispatchedAction_true,
            dispatchedAction_false
        ] as [any Action]
        
        #expect(store.dispatchedActions.count == expectedActions.count)
        #expect(compareActions(store.dispatchedActions, expectedActions))
        #expect(store.state.editMode ==  false)
    }
    
    @Test
    func testToggleDarkMode() async throws {
        // Given
        let (store, mockAPI) = self.setup()
        
        // When
        let dispatchedAction_true = SettingsActions.setDarkMode(payload: true)
        #expect(store.state.darkMode ==  false)
        
        store.dispatch(action: dispatchedAction_true)

        // Then
        var expectedActions = [
            dispatchedAction_true
        ] as [any Action]
        
        try await Task.sleep(for: .seconds(0.2))
        
        #expect(store.dispatchedActions.count == expectedActions.count)
        #expect(compareActions(store.dispatchedActions, expectedActions))
        
        #expect(mockAPI.calledFunctions.count == 0)

        #expect(store.state.darkMode ==  true)
        
        let dispatchedAction_false = SettingsActions.setDarkMode(payload: false)
        store.dispatch(action: dispatchedAction_false)

        //And then
        expectedActions = [
            dispatchedAction_true,
            dispatchedAction_false
        ] as [any Action]

        #expect(store.dispatchedActions.count == expectedActions.count)
        #expect(compareActions(store.dispatchedActions, expectedActions))
        #expect(store.state.darkMode ==  false)

    }
}
