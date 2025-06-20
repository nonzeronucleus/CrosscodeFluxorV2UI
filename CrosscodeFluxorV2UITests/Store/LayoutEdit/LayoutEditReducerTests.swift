import Testing
import Foundation
import Factory
import Fluxor
import FluxorTestSupport
@testable import CrosscodeFluxorV2UI
import CrosscodeDataLibrary



struct LayoutEditEffectsTests {
    @Injected(\.uuid) var uuid

    init() {
//        initTestEnv()
    }

    func setup(layout: LevelLayout? = nil) -> (MockStore<LayoutEditState?, AppEnvironment>, MockLayoutsService) {
        Container.shared.layoutsAPI.register { MockLayoutsService() }
        
        guard let layout else {
            return createTestStoreAndAPI(initialState:nil, reducers: [layoutEditReducer], effects: { store in LayoutEditEffects() })
        }
        return createTestStoreAndAPI(initialState: LayoutEditState(level: layout), reducers: [layoutEditReducer], effects: { store in LayoutEditEffects() })
    }
        
    @Test
    func testLoadLayout() async throws {
        // Given LayoutEditState is empty
        
        let (store, mockLayoutsService) = setup()
        mockLayoutsService.levels = [
            LevelLayout(id: uuid(), number: 1, gridText: "...|...|...|"),
            LevelLayout(id: uuid(), number: 2, gridText: "...|...|...|")
        ]

        // When requestiong load for an existing level
        let idToSelect = mockLayoutsService.levels[1].id
        let dispatchAction = LayoutEditActions.Load.start(payload: idToSelect)
        
        store.dispatch(action: dispatchAction)
        try await Task.sleep(for: .seconds(0.2))
        
        // Expect an action to be triggered to load the level
        // and the state to be created with the relevant level details
        
        let expectedActions = [
            dispatchAction,
            LayoutEditActions.Load.success(payload: mockLayoutsService.levels[1])
        ] as [any Action]

        #expect(store.dispatchedActions.count == expectedActions.count)
        
        if (store.dispatchedActions.count == expectedActions.count) {
            let expectedPayloadComplete = expectedActions[1]
            let actualPayloadComplete = store.dispatchedActions[1]
            
            if let expectedPayload = getPropertyValue(of: expectedPayloadComplete, propertyName: "payload") as? LevelLayout,
               let actualPayload = getPropertyValue(of: actualPayloadComplete, propertyName: "payload") as? LevelLayout {
                #expect(expectedPayload.crossword.layoutString() == actualPayload.crossword.layoutString())
            }
            else {
                Issue.record("No payloads found for requestLoadLayout")
            }
        }
        
        #expect(store.state != nil)
        #expect(store.state?.level == mockLayoutsService.levels[1])
    }
    
    @Test
    func testSelectCell() async throws {
        // Given
        let layout = LevelLayout(id: uuid(), number: 1, gridText: "...|...|...|")

        let (store, _) = setup(layout: layout)
        
        let cell_0_0_id = store.state?.level.crossword[0,0].id

        // Grid should be all nil (off)
        #expect(store.state?.level.crossword[0,0].letter == nil)
        #expect(store.state?.level.crossword[1,1].letter == nil)
        #expect(store.state?.level.crossword[2,2].letter == nil)

        //Select top left cell
        store.dispatch(action: LayoutEditActions.Cell.select(payload:cell_0_0_id))
        
        try await Task.sleep(for: .seconds(0.2))

        // Top left and bottom right should toggle on.
        #expect(store.state?.level.crossword[0,0].letter == " ")
        #expect(store.state?.level.crossword[1,1].letter == nil)
        #expect(store.state?.level.crossword[2,2].letter == " ")
        
        store.dispatch(action: LayoutEditActions.Cell.select(payload:cell_0_0_id))
        
        // Top left and bottom right should toggle back off.
        #expect(store.state?.level.crossword[0,0].letter == nil)
        #expect(store.state?.level.crossword[1,1].letter == nil)
        #expect(store.state?.level.crossword[2,2].letter == nil)
    }
    
    @Test
    func testPopulateCrossword() async throws {
        // Given
        let layout = LevelLayout(id: uuid(), number: 1, gridText: "...|...|...|")
        let (store, mockAPI) = setup(layout: layout)
        let populatedCrosswordText = "CAT|DOG|CAR|"
        let populatedLetterMapText = "{\"Z\":5,\"B\":7,\"A\":3,\"Y\":22,\"O\":12,\"M\":11,\"H\":14,\"W\":16,\"E\":4,\"F\":25,\"I\":19,\"X\":8,\"Q\":15,\"P\":6,\"G\":21,\"T\":18,\"K\":2,\"N\":1,\"J\":24,\"C\":10,\"S\":0,\"D\":20,\"U\":17,\"R\":23,\"V\":9,\"L\":13}"
        let populationResult:(String, String) = (populatedCrosswordText,populatedLetterMapText)
        #expect(store.state?.level.gridText == "...|...|...|")
        
        mockAPI.populationResult = populationResult

        // When populating the grid
        store.dispatch(action: LayoutEditActions.Populate.start(payload: store.state!.level.crossword))
        try await Task.sleep(for: .seconds(0.2))
        
        
        // Then
        let expectedActions = [
            LayoutEditActions.Populate.start(payload: store.state!.level.crossword),
            LayoutEditActions.Populate.success(payload:PopulationPayload(crossword:Crossword(initString: populatedCrosswordText), letterMap:CharacterIntMap(from: populatedLetterMapText)))
        ] as [any Action]
        
        try await Task.sleep(for: .seconds(0.2))
        
        #expect(store.dispatchedActions.count == expectedActions.count)
        
        if (store.dispatchedActions.count == expectedActions.count) {
            let expectedPayloadComplete = expectedActions[1]
            let actualPayloadComplete = store.dispatchedActions[1]
            
            if let expectedPayload = getPropertyValue(of: expectedPayloadComplete, propertyName: "payload") as? PopulationPayload,
               let actualPayload = getPropertyValue(of: actualPayloadComplete, propertyName: "payload") as? PopulationPayload {
                #expect(expectedPayload.crossword.layoutString() == actualPayload.crossword.layoutString())
            }
            else {
                Issue.record("No payloads found for populationComplete")
            }
        }
        
        #expect(store.state?.level.gridText == populatedCrosswordText)
        
        // Make sure all APIs have been called
        #expect(mockAPI.calledFunctions.count == 1)
        #expect(mockAPI.calledFunctions.contains("populateCrossword(crosswordLayout:)"))
    }
}

