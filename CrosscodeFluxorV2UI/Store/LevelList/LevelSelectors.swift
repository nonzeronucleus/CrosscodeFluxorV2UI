import Fluxor
import CrosscodeDataLibrary


enum LevelSelectors {
    static let levels = Selector<AppState, [PlayableLevel]>(projector: { $0.playableLevels.levels })

//    static let isLoading = Selector<AppState, Bool>(projector: { $0.layouts.loadingLayouts })
//    static let error = Selector<AppState, String?>(projector: { $0.layouts.error })
}
