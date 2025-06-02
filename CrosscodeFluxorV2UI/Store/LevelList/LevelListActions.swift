import Foundation
import Fluxor
import CrosscodeDataLibrary

//enum LevelListActions {
//    enum Import {
//        static let start = ActionTemplate(id: "Levels/Import/Start")
//        static let success = ActionTemplate(id: "Levels/Import/Success")
//        static let failure = ActionTemplate(id: "Levels/Import/Failure", payloadType: Error.self)
//    }
//    
//    enum Create {
//        static let start = ActionTemplate(id: "Levels/Create/Start")
//        static let success = ActionTemplate(id: "Levels/Create/Success", payloadType: [any Level].self)
//        static let failure = ActionTemplate(id: "Levels/Create/Failure", payloadType: Error.self)
//    }
//    
//    enum FetchAll {
//        static let start = ActionTemplate(id: "Levels/FetchAll/Start")
//        static let success = ActionTemplate(id: "Levels/FetchAll/Success", payloadType: [any Level].self)
//        static let failure = ActionTemplate(id: "Levels/Fetch/Failure", payloadType: Error.self)
//    }
//    
//    enum Delete {
//        static let start = ActionTemplate(id: "Levels/Delete/Start", payloadType: UUID.self)
//        static let success = ActionTemplate(id: "Levels/Delete/Success", payloadType: [any Level].self)
//        static let failure = ActionTemplate(id: "Levels/Delete/Failure", payloadType: Error.self)
//    }
//}


struct LevelListActions<L: Level> {
    private static func action(_ id: String) -> ActionTemplate<Void> {
        ActionTemplate(id: "\(L.self)/\(id)")
    }
    
    private static func action<P>(_ id: String, payload: P.Type) -> ActionTemplate<P> {
        ActionTemplate(id: "\(L.self)/\(id)", payloadType: P.self)
    }
    
    // Common Actions
    enum Import {
        static var start: ActionTemplate<Void> { action("Import/Start") }
        static var success: ActionTemplate<Void> { action("Import/Success") }
        static var failure: ActionTemplate<Error> { action("Import/Failure", payload: Error.self) }
    }
    
    enum FetchAll {
        static var start: ActionTemplate<Void> { action("FetchAll/Start") }
        static var success: ActionTemplate<[L]> { action("Import/Success", payload: [L].self) }
        static var failure: ActionTemplate<Error> { action("Import/Failure", payload: Error.self) }
    }

    
    enum Create {
        static var start: ActionTemplate<Void> { action("Create/Start") }
        static var success: ActionTemplate<[L]> { action("Create/Success", payload: [L].self) }
        static var failure: ActionTemplate<Error> { action("Create/Failure", payload: Error.self) }
    }
    
    enum Delete {
        static var start: ActionTemplate<UUID> { action("Delete/Start", payload: UUID.self) }
        static var success: ActionTemplate<[L]> { action("Delete/Success", payload: [L].self) }
        static var failure: ActionTemplate<Error> { action("Delete/Failure", payload: Error.self) }
    }

    
    // Type-Specific Actions
    static func customAction() -> ActionTemplate<L> {
        action("CustomAction", payload: L.self)
    }
}
