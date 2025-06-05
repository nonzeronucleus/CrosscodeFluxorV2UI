import Foundation
import Fluxor
import CrosscodeDataLibrary


protocol LevelActionNamespace {
    associatedtype LevelType: Level
    static func action<P>(_ id: String, payload: P.Type) -> ActionTemplate<P>
}

extension LevelActionNamespace {
    static func action<P>(_ id: String, payload: P.Type = Void.self) -> ActionTemplate<P> {
        ActionTemplate(id: "\(LevelType.self)/\(String(describing: Self.self))/\(id)", payloadType: payload)
    }
}

//struct LevelListActions<L: Level> {
//    enum Import: LevelActionNamespace {
//        typealias LevelType = L
//        static var start: ActionTemplate<Void> { action("Start", payload: Void.self) }
//        static var success: ActionTemplate<Void> { action("Success", payload: Void.self) }
//    }
//}
//

struct LevelListActions<L: Level> {
    typealias LevelType = L
    
//    static func action(_ id: String) -> ActionTemplate<Void> {
//        ActionTemplate(id: "\(L.self)/\(id)")
//    }
//    
//    static func action<P>(_ id: String, payload: P.Type = Void.self) -> ActionTemplate<P> {
//        ActionTemplate(id: "\(L.self)/\(id)", payloadType: P.self)
//    }
    
    // Common Actions
//    enum Import {
////        static var start: ActionTemplate<Void> { LevelListActions.action("Import/Start") }
////        static var start: ActionTemplate<Void> { action("Import/Start") }
//        static var success: ActionTemplate<Void> { action("Import/Success") }
//        static var failure: ActionTemplate<Error> { action("Import/Failure", payload: Error.self) }
//    }
    
    enum Import: LevelActionNamespace {
        typealias LevelType = L

        static var start: ActionTemplate<Void> { action("Start") }
        static var success: ActionTemplate<Void> { action("Success") }
        static var failure: ActionTemplate<Error> { action("Failure", payload: Error.self) }
    }

    
    enum FetchAll: LevelActionNamespace {
        typealias LevelType = L

        static var start: ActionTemplate<Void> { action("FetchAll/Start") }
        static var success: ActionTemplate<[L]> { action("Import/Success", payload: [L].self) }
        static var failure: ActionTemplate<Error> { action("Import/Failure", payload: Error.self) }
    }

    
    enum Delete: LevelActionNamespace {
        typealias LevelType = L
        
        static var start: ActionTemplate<UUID> { action("Delete/Start", payload: UUID.self) }
        static var success: ActionTemplate<[L]> { action("Delete/Success", payload: [L].self) }
        static var failure: ActionTemplate<Error> { action("Delete/Failure", payload: Error.self) }
    }

    
//    // Type-Specific Actions
//    static func customAction() -> ActionTemplate<L> {
//        action("CustomAction", payload: L.self)
//    }
}
