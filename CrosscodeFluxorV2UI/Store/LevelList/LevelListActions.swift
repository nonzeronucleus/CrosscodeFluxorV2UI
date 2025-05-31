import Foundation
import Fluxor
import CrosscodeDataLibrary

enum LevelListActions {
    enum Import {
        static let start = ActionTemplate(id: "Levels/Import/Start")
        static let success = ActionTemplate(id: "Levels/Import/Success")
        static let failure = ActionTemplate(id: "Levels/Import/Failure", payloadType: Error.self)
    }
    
    enum Create {
        static let start = ActionTemplate(id: "Levels/Create/Start")
        static let success = ActionTemplate(id: "Levels/Create/Success", payloadType: [any Level].self)
        static let failure = ActionTemplate(id: "Levels/Create/Failure", payloadType: Error.self)
    }
    
    enum FetchAll {
        static let start = ActionTemplate(id: "Levels/FetchAll/Start")
        static let success = ActionTemplate(id: "Levels/FetchAll/Success", payloadType: [any Level].self)
        static let failure = ActionTemplate(id: "Levels/Fetch/Failure", payloadType: Error.self)
    }
    
    enum Delete {
        static let start = ActionTemplate(id: "Levels/Delete/Start", payloadType: UUID.self)
        static let success = ActionTemplate(id: "Levels/Delete/Success", payloadType: [any Level].self)
        static let failure = ActionTemplate(id: "Levels/Delete/Failure", payloadType: Error.self)
    }
}


