import Factory
import CrosscodeDataLibrary

class MockLayoutsService: LayoutsAPI {

    
    func importLevels() async throws {
        calledFunctions.append(#function)
        importCalled = true
        if shouldThrow {
            throw MockError.importFailed
        }
    }
    
    func fetchAllLevels() async throws -> [any Level] {
        calledFunctions.append(#function)
        return levels

    }
    
    func deleteLevel(id: UUID) async throws -> [any Level] {
        calledFunctions.append(#function)
        return []

    }
    
    func saveLevel(level: any Level) async throws {
        calledFunctions.append(#function)
    }
    
    func test() -> String {
        "MockLayoutsService"
    }
    
    var calledFunctions: [String] = []
    var levels:[LevelLayout] = []
    var levelToAdd:LevelLayout? = nil
    var populationResult:(String, String)? = nil
    
    init() {
        
    }
    
    func addNewLayout() async throws -> [LevelLayout] {
        @Injected(\.uuid) var uuid
        calledFunctions.append(#function)
        if let levelToAdd {
            levels.append(levelToAdd)
        }
        else {
            let level = LevelLayout(id: uuid.uuidGenerator(), number: 1, gridText: "..|..|")
            levels.append(level)
        }
        
        return levels
    }
    
    func fetchLevel(id: UUID) async throws -> (any Level)? {
        return levels.first { $0.id == id }
    }
    

    func populateCrossword(crosswordLayout: String) async throws -> (String, String) {
        calledFunctions.append(#function)
        guard let populationResult else {
            throw MockError.importFailed
        }
        return populationResult
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



extension MockLayoutsService {
    public func importLayouts() async throws {
        try await importLevels()
    }
    
    public func fetchLayout(id: UUID) async throws -> LevelLayout? {
        return try await fetchLevel(id: id) as? LevelLayout
    }
    
    public func fetchAllLayouts() async throws -> [LevelLayout] {
        return try await fetchAllLevels() as? [LevelLayout] ?? []
    }
    
    public func deleteLayout(id: UUID) async throws -> [LevelLayout] {
        return try await deleteLevel(id: id) as? [LevelLayout] ?? []
    }
    
    public func saveLayout(level: LevelLayout) async throws {
        try await saveLevel(level: level)
    }
}
