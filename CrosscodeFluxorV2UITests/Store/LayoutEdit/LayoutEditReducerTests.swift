import Testing
import Foundation
import Factory
import Fluxor
import FluxorTestSupport
@testable import CrosscodeFluxorV2UI
import CrosscodeDataLibrary



struct LayoutEditEffectsTests {
    init() {
        initTestEnv()
    }

    func setup(layout: LevelLayout) -> (MockStore<LayoutEditState?, AppEnvironment>, MockLayoutsService) {
        return createTestStoreAndAPI(initialState: LayoutEditState(level: layout), reducers: [layoutEditReducer], effects: { store in LayoutEditEffects() })
    }
    
    @Test
    func testSelectCell() async throws {
        @Injected(\.uuid) var uuid
        // Given
        let layout = LevelLayout(id: uuid(), number: 1, gridText: "...|...|...|")

        let (store, _) = setup(layout: layout)
        
        let cell_0_0_id = store.state?.level.crossword[0,0].id

        #expect(store.state?.level.crossword[0,0].letter == nil)
        #expect(store.state?.level.crossword[1,1].letter == nil)
        #expect(store.state?.level.crossword[2,2].letter == nil)

        store.dispatch(action: LayoutEditActions.selectCell(payload:cell_0_0_id))
        
        try await Task.sleep(for: .seconds(0.2))

        // Top left and bottom right should toggle.
        #expect(store.state?.level.crossword[0,0].letter == " ")
        #expect(store.state?.level.crossword[1,1].letter == nil)
        #expect(store.state?.level.crossword[2,2].letter == " ")
    }

}
