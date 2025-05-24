import Factory
import CrosscodeDataLibrary

class MockLayoutsService: LayoutsAPI {
    func test() -> String {
        "MockLayoutsService"
    }
    
    var calledFunctions: [String] = []
    var layouts:[LevelLayout] = []
    var layoutToAdd:LevelLayout? = nil
    
    init() {
        
    }
    
    func importLayouts() async throws {
        calledFunctions.append(#function)
        importCalled = true
        if shouldThrow {
            throw MockError.importFailed
        }
    }
    
    func addNewLayout() async throws -> [LevelLayout] {
        @Injected(\.uuid) var uuid
        calledFunctions.append(#function)
        if let layoutToAdd {
            layouts.append(layoutToAdd)
        }
        else {
            let layout: LevelLayout = LevelLayout(id: uuid.uuidGenerator(), number: 1, gridText: "..|..|")
            layouts.append(layout)
        }
        
        return layouts
    }
    
    func fetchAllLayouts() async throws -> [LevelLayout] {
        calledFunctions.append(#function)
        return layouts
    }
    
    func deleteLayout(id: UUID) async throws -> [LevelLayout] {
        calledFunctions.append(#function)
        return []
    }
    
    func saveLevel(level: LevelLayout) async throws {
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
