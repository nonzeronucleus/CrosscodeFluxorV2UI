import Testing
import Foundation
import Factory
import Fluxor
import FluxorTestSupport
@testable import CrosscodeFluxorV2UI
import CrosscodeDataLibrary



struct LayoutsEffectsTests {
    init() {
        initTestEnv()
    }
    
    func setup() -> (MockStore<LevelListState<LevelLayout>, AppEnvironment>, MockLayoutsService) {
        let levelLayoutReducer: Reducer<LevelListState<LevelLayout>> = makeLevelListReducer()
        
        let (store, mockAPI) = createTestStoreAndAPI(
            initialState: LevelListState<LevelLayout>(),
            reducers: [levelLayoutReducer, makeLayoutCreateReducer()]
        )
        
        store.register(effects: LevelListEffects<LevelLayout>() )
        store.register(effects: LayoutsEffects())
        
        return (store, mockAPI)
    }
    
    @Test
    func testImportFlow() async throws {
        // Given
        let (store, mockAPI) = setup()
        print("***Setup***")

        
        debugPrint("1 : \(mockAPI.calledFunctions.count)")
        // When
        store.dispatch(action: LayoutsActions.Import.start())
        
        // Then
        let expectedActions = [
            LevelListActions<LevelLayout>.Import.start(),
            LevelListActions<LevelLayout>.Import.success(),
            LevelListActions<LevelLayout>.FetchAll.start(),
            LevelListActions<LevelLayout>.FetchAll.success(payload: [])
        ] as [any Action]
        
        try await Task.sleep(for: .seconds(0.2))
        
        #expect(store.dispatchedActions.count == expectedActions.count)
        #expect(compareActions(store.dispatchedActions, expectedActions))
        
        debugPrint("2 : \(mockAPI.calledFunctions.count)")

        
        // Make sure all APIs have been called
        #expect(mockAPI.calledFunctions.count == 2)
        #expect(mockAPI.calledFunctions.contains("importLevels()"))
        #expect(mockAPI.calledFunctions.contains("fetchAllLevels()"))
    }
        

    @Test
    func testCreateNewLayout() async throws {
        @Injected(\.uuid) var uuid
        // Given
        let (store, mockAPI) = self.setup()
        let layoutToAdd = LevelLayout(id: uuid(), number: 1, gridText: "..|..|")
        mockAPI.levelToAdd = layoutToAdd
        
        debugPrint("3 : \(mockAPI.calledFunctions.count)")

        // When
        store.dispatch(action: LayoutsActions.Create.start())
        
        try await Task.sleep(for: .seconds(0.2))
        
        // Then
        let expectedActions = [
            LayoutsActions.Create.start(),
            LayoutsActions.Create.success(payload: [layoutToAdd])
        ] as [any Action]
        
        #expect(store.dispatchedActions.count == expectedActions.count)
        #expect(compareActions(store.dispatchedActions, expectedActions))
        
        
        debugPrint("4 : \(mockAPI.calledFunctions.count)")

        #expect(mockAPI.calledFunctions.count == 1)
        #expect(mockAPI.calledFunctions.contains("addNewLayout()"))
    }
}
