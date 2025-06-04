import Foundation
import Fluxor
import CrosscodeDataLibrary

typealias LayoutsActions = LevelListActions<LevelLayout>

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
