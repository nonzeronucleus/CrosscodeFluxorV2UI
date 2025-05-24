import Foundation
import Fluxor
import CrosscodeDataLibrary


enum LayoutEditSelectors {
    static let level = Selector<AppState, LevelLayout?>(projector: { (state) in
        guard let levelEdit = state.levelEdit else { return nil }
        return levelEdit.level
    })
    
    static let selectedCell = Selector<AppState, UUID?>(projector: { (state) in
        guard let levelEdit = state.levelEdit else { return nil }
        return levelEdit.selectedCell
    })
    
    static let checking = Selector<AppState, Bool>(projector: {(state) in
        guard let levelEdit = state.levelEdit else { return false }
        return levelEdit.checking
    })
    
    static let isBusy = Selector<AppState, Bool>(projector: {(state) in
        guard let levelEdit = state.levelEdit else { return false }
        return levelEdit.populationState == .populating
    })
    
    static let isPopulated = Selector<AppState, Bool>(projector: {(state) in
        guard let levelEdit = state.levelEdit else { return false }
        return levelEdit.populationState == .populated
    })
    
    static let saveState = Selector<AppState, SaveState>(projector: {(state) in
        guard let levelEdit = state.levelEdit else { return .saving }
        return levelEdit.saveState
    })
}


