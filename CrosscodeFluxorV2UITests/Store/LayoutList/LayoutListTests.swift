import Testing
import Foundation
import Factory
import Fluxor
import FluxorTestSupport
@testable import CrosscodeFluxorV2UI
import CrosscodeDataLibrary



struct LayoutsEffectsTests {
    init() {
        
    }
    
    func setup() -> (MockStore<LayoutsState, AppEnvironment>, MockLayoutsService) {
       return createTestStoreAndAPI(initialState: LayoutsState(), reducers: [layoutsReducer], effects: { store in LayoutsEffects() })
    }
    
    
    @Test
    func testImportFlow() async throws {
        // Given
        let (store, mockAPI) = setup()
        
        // When
        store.dispatch(action: LayoutsActions.importLayouts())
        
        // Then
        let expectedActions = [
            LayoutsActions.importLayouts(),
            LayoutsActions.didImportLayouts(),
            LayoutsActions.fetchLayouts(),
            LayoutsActions.didFetchLayouts(payload: [])
        ] as [any Action]
        
        try await Task.sleep(for: .seconds(0.2))
        
        #expect(store.dispatchedActions.count == expectedActions.count)
        #expect(compareActions(store.dispatchedActions, expectedActions))
        
        // Make sure all APIs have been called
        #expect(mockAPI.calledFunctions.count == 2)
        #expect(mockAPI.calledFunctions.contains("importLayouts()"))
        #expect(mockAPI.calledFunctions.contains("fetchAllLayouts()"))
    }
        

    @Test
    func testCreateNewLayout() async throws {
        @Injected(\.uuid) var uuid
        // Given
        let (store, mockAPI) = self.setup()
        let layoutToAdd = LevelLayout(id: uuid(), number: 1, gridText: "..|..|")
        mockAPI.layoutToAdd = layoutToAdd
        
        // When
        store.dispatch(action: LayoutsActions.createNewLayout())
        
        try await Task.sleep(for: .seconds(0.2))
        
        // Then
        let expectedActions = [
            LayoutsActions.createNewLayout(),
            LayoutsActions.didCreateNewLayout(payload: [layoutToAdd])
        ] as [any Action]
        
        #expect(store.dispatchedActions.count == expectedActions.count)
        #expect(compareActions(store.dispatchedActions, expectedActions))
        
        #expect(mockAPI.calledFunctions.count == 1)
        #expect(mockAPI.calledFunctions.contains("addNewLayout()"))
    }
}
