import Foundation
import CrosscodeDataLibrary

enum PopulationState: Encodable {
    case unpopulated
    case populating
    case populated
}

enum SaveState: Encodable {
    case clean
    case dirty
    case saving
}


struct LevelEditState : Encodable, Equatable {
    var level: LevelLayout
    var savingLevelID: UUID? = nil // Id of current level being saved, if any
    var selectedCell: UUID? = nil
    var checking: Bool = false
    var populationState: PopulationState = .unpopulated
    var saveState: SaveState = .clean
}
