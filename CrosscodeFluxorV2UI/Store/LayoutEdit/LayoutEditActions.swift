import Foundation
import Fluxor
import CrosscodeDataLibrary

typealias PopulationPayload = (crossword: Crossword, letterMap: CharacterIntMap?)

enum LayoutEditActions {
    static let selectLevel = ActionTemplate(id: "[Editing] Selected level",
                                            payloadType: LevelLayout.self,
    )
    static let selectCell = ActionTemplate(id: "[Editing] Selected cell", payloadType: UUID?.self)
    static let requestCancelPopulation = ActionTemplate(id: "[Editing] Request to cancel", payloadType: Crossword.self)
    static let requestPopulation = ActionTemplate(id: "[Editing] Request to populate level", payloadType: Crossword.self)
    static let populationComplete = ActionTemplate(id: "[Editing] Population complete", payloadType: PopulationPayload.self)
    static let populationCancelled = ActionTemplate(id: "[Editing] Population cancelled")
    static let populationFailed = ActionTemplate(id: "[Editing] Population failed", payloadType: String.self)
    static let depopulateGrid = ActionTemplate(id: "[Editing] Deopulate grid", payloadType: Crossword.self)
    static let depopulationComplete = ActionTemplate(id: "[Editing] Depopulation complete", payloadType: PopulationPayload.self)

    // Save layout
    static let saveLayout = ActionTemplate(id: "[Editing] Save Level", payloadType: LevelLayout.self)
    static let saveLayoutSuccess = ActionTemplate(id: "[Editing] Save success")
    static let saveLayoutFailure = ActionTemplate(id: "[Editing] Save failure", payloadType: String.self)
    
    // Export populated level
}

