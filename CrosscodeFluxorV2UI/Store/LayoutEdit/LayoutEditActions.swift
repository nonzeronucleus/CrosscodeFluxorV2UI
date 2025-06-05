import Foundation
import Fluxor
import CrosscodeDataLibrary

typealias PopulationPayload = (crossword: Crossword, letterMap: CharacterIntMap?)

enum LayoutEditActions {
    enum Load: ActionNamespace {
        static var start = action("Start", payload: UUID.self)
        static var success = action("Success", payload: LevelLayout.self)
        static var failure = action("Faiure", payload: Error.self)
    }
    
    enum Cell: ActionNamespace {
        static var select = action("Select", payload: UUID?.self)
    }

    enum Populate: ActionNamespace {
        static var start = action("Start", payload: Crossword.self)
        static var success = action("Success", payload: PopulationPayload.self)
        static var failure = action("Failure", payload: Error.self)
    }
    
    enum CancelPopulation: ActionNamespace {
        static var start = action("Cancel", payload: Crossword.self)
        static var success = action("Success")
    }
    
    enum Depopulate: ActionNamespace {
        static var start = action("Cancel", payload: Crossword.self)
        static var success = action("Success", payload: PopulationPayload.self)
    }
    
    enum SaveLayout: ActionNamespace {
        static var start = action("Cancel", payload: LevelLayout.self)
        static var success = action("Success")
        static var failure = action("Failure", payload: Error.self)

    }
}

