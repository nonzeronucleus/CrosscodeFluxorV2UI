import Foundation
import Fluxor
import CrosscodeDataLibrary

typealias LayoutsActions = LevelListActions<LevelLayout>

extension LayoutsActions where L == LevelLayout {
    enum CreateLayout: LevelActionNamespace {
        typealias LevelType = LevelLayout

        static var start: ActionTemplate<Void> { action("Create/Start") }
        static var success: ActionTemplate<[L]> { action("Create/Success", payload: [L].self) }
        static var failure: ActionTemplate<Error> { action("Create/Failure", payload: Error.self) }
    }
}


