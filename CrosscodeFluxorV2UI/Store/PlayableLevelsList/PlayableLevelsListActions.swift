import Foundation
import Fluxor
import CrosscodeDataLibrary

typealias PlayableLevelsActions = LevelListActions<PlayableLevel> 

extension PlayableLevelsActions where L == PlayableLevel {
    enum CreatePlayableLevel: LevelActionNamespace {
        typealias LevelType = PlayableLevel

        static var start: ActionTemplate<Void> { action("Create/Start") }
        static var success: ActionTemplate<[L]> { action("Create/Success", payload: [L].self) }
        static var failure: ActionTemplate<Error> { action("Create/Failure", payload: Error.self) }
    }
}


//extension LevelListActions where L == PlayableLevel {
//    enum Create: LevelActionNamespace {
//        typealias L = PlayableLevel
//        
//        static var start: ActionTemplate<Void> { action("Start", payload: Void.self) }
//        static var success: ActionTemplate<[PlayableLevel]> { action("Success", payload: [PlayableLevel].self) }
//    }
//}
