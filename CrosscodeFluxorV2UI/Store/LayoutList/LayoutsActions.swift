import Foundation
import Fluxor
import CrosscodeDataLibrary

typealias LayoutsActions = LevelListActions<LevelLayout>

extension LayoutsActions {
    enum Create: LevelActionNamespace {
        typealias LevelType = L

        static var start: ActionTemplate<Void> { action("Create/Start") }
        static var success: ActionTemplate<[L]> { action("Create/Success", payload: [L].self) }
        static var failure: ActionTemplate<Error> { action("Create/Failure", payload: Error.self) }
    }
}


