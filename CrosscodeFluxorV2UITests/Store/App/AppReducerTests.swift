import Testing
import Foundation
import Factory
import Fluxor
import FluxorTestSupport
@testable import CrosscodeFluxorV2UI
import CrosscodeDataLibrary



struct AppReducerTests {
    init() {
        
    }
    
    func setup() -> (MockStore<AppState, AppEnvironment>, MockLayoutsService) {
        let _ = Container.shared.uuid
            .register { IncrementingUUIDProvider() }
            .singleton
        
        let mockAPI = MockLayoutsService()
        
        let environment = AppEnvironment(layoutsAPI: mockAPI, playableLevelsAPI: MockPlayaLevelsAPI())
        let store = MockStore(
            initialState: AppState(),
            environment: environment,
            reducers: [appReducer]
        )
        
        store.register(reducer: appReducer)
        store.register(effects: AppEffects())
        
        return (store, mockAPI)
    }
}

class MockPlayaLevelsAPI: LevelsAPI {
    func printTest() {
        print("MockPlayaLevelsAPI")
    }

    func importLevels() async throws {
        fatalError("\(#function) not implemented")
    }
    
    func addNewLevel() async throws -> [any Level] {
        fatalError("\(#function) not implemented")
    }
    
    func fetchLevel(id: UUID) async throws -> (any Level)? {
        fatalError("\(#function) not implemented")
    }
    
    func fetchAllLevels() async throws -> [any Level] {
        fatalError("\(#function) not implemented")
    }
    
    func deleteLevel(id: UUID) async throws -> [any Level] {
        fatalError("\(#function) not implemented")
    }
    
    func saveLevel(level: any Level) async throws {
        fatalError("\(#function) not implemented")
    }
    
    func cancel() async {
        fatalError("\(#function) not implemented")
    }
    
    
}
        
