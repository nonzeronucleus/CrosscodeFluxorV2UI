import Foundation

public protocol LayoutsAPI {
    func importLayouts() async throws

    func addNewLayout() async throws -> [Layout]
    
    func fetchAllLayouts() async throws -> [Layout]
    
    func deleteLayout(id: UUID) async throws -> [Layout]
    
    func saveLevel(level: Layout) async throws
    
    func populateCrossword(crosswordLayout: String) async throws -> (String, String)
    
    func depopulateCrossword(crosswordLayout: String) async throws -> (String, String)
    
    func cancel() async
}


class TmpLayoutsService: LayoutsAPI {
    let test = "TmpLayoutsService"
    init() {
        
    }
    
    func importLayouts() async throws {
        importCalled = true
        if shouldThrow {
            throw MockError.importFailed
        }
    }
    
    func addNewLayout() async throws -> [Layout] {
        fatalError("\(#function) not implemented")
    }
    
    func fetchAllLayouts() async throws -> [Layout] {
        fatalError("\(#function) not implemented")
    }
    
    func deleteLayout(id: UUID) async throws -> [Layout] {
        fatalError("\(#function) not implemented")
    }
    
    func saveLevel(level: Layout) async throws {
        fatalError("\(#function) not implemented")
    }
    
    func populateCrossword(crosswordLayout: String) async throws -> (String, String) {
        fatalError("\(#function) not implemented")
    }
    
    func depopulateCrossword(crosswordLayout: String) async throws -> (String, String) {
        fatalError("\(#function) not implemented")
    }
    
    func cancel() async {
        fatalError("\(#function) not implemented")
    }
    
    var importCalled = false
    var shouldThrow = false
    
    enum MockError: Error {
        case importFailed
    }
}
