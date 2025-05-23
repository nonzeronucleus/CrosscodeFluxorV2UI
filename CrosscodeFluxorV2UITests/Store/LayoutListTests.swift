import Testing
import Foundation
import Factory
import Fluxor
import FluxorTestSupport
@testable import CrosscodeFluxorV2UI
//import CrosscodeDataLibrary



struct LayoutsEffectsTests {
    init() {
        
    }
    

    @Test
    func testImportFlow() async throws {
        
        // Given
        let mockAPI = MockLayoutsService()
        let environment = AppEnvironment(layoutsAPI: mockAPI)
        let store = MockStore(
            initialState: LayoutsState(),
            environment: environment,
            reducers: [layoutsReducer]
        )
        
        
        store.register(reducer: layoutsReducer)
        
        store.register(effects: LayoutsEffects() )
        
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
        #expect(mockAPI.calledFunctions.contains("importLayouts()"))
        #expect(mockAPI.calledFunctions.count == 1)
    }
        
        

}


class MockLayoutsService: LayoutsAPI {
    let test = "MockLayoutsService"
    var calledFunctions: [String] = []
    
    init() {
        
    }
    
    func importLayouts() async throws {
        calledFunctions.append(#function)
        importCalled = true
        if shouldThrow {
            throw MockError.importFailed
        }
    }
    
    func addNewLayout() async throws -> [Layout] {
        calledFunctions.append(#function)
        return []
    }
    
    func fetchAllLayouts() async throws -> [Layout] {
        calledFunctions.append(#function)
        return []
    }
    
    func deleteLayout(id: UUID) async throws -> [Layout] {
        calledFunctions.append(#function)
        return []
    }
    
    func saveLevel(level: Layout) async throws {
        calledFunctions.append(#function)
    }
    
    func populateCrossword(crosswordLayout: String) async throws -> (String, String) {
        calledFunctions.append(#function)
        return (crosswordLayout, "")
    }
    
    func depopulateCrossword(crosswordLayout: String) async throws -> (String, String) {
        calledFunctions.append(#function)
        return (crosswordLayout, "")
    }
    
    func cancel() async {
        calledFunctions.append(#function)
    }
    
    var importCalled = false
    var shouldThrow = false
    
    enum MockError: Error {
        case importFailed
    }
}

