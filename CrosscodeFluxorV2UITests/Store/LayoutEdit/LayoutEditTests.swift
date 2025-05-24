import Testing
import Foundation
import Factory
import Fluxor
import FluxorTestSupport
@testable import CrosscodeFluxorV2UI
import CrosscodeDataLibrary



struct LayoutEditEffectsTests {
    init() {
        
    }
    
    func setup() -> (MockStore<LayoutsState, AppEnvironment>, MockLayoutsService) {
        let _ = Container.shared.uuid
            .register { IncrementingUUIDProvider() }
            .singleton
        
        let mockAPI = MockLayoutsService()
        
        let environment = AppEnvironment(layoutsAPI: mockAPI)
        let store = MockStore(
            initialState: LayoutsState(),
            environment: environment,
            reducers: [layoutsReducer]
        )
        
        store.register(reducer: layoutsReducer)
        
        store.register(effects: LayoutsEffects() )
        
        return (store, mockAPI)
    }
    
//    @Test
//    func testNavigateToLevel() async throws {
//        @Injected(\.uuid) var uuid
//        // Given
//        let (store, mockAPI) = self.setup()
//        let wrongLevel = LevelLayout(id: uuid(), number: 1, gridText: "..|..|")
//        let levelToNavTo = LevelLayout(id: uuid(), number: 2, gridText: "..|..|")
//        mockAPI.layouts = [wrongLevel, levelToNavTo]
//
//        store.dispatch(action: LayoutEditActions.selectLevel(payload: levelToNavTo))
//        
//        let expectedActions = [
//            LayoutsActions.createNewLayout(),
//            LayoutsActions.didCreateNewLayout(payload: [])
//        ] as [any Action]
//        
//        #expect(store.dispatchedActions.count == expectedActions.count)
//        #expect(compareActions(store.dispatchedActions, expectedActions))
//        
//        #expect(mockAPI.calledFunctions.count == 1)
//        #expect(mockAPI.calledFunctions.contains("addNewLayout()"))
//    }

}
