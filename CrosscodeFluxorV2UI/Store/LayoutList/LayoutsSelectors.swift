import Fluxor
import CrosscodeDataLibrary


enum LayoutSelectors {
//    static let layouts = Selector<AppState, [LevelLayout]>(projector: { $0.layouts.layouts })
    static let layouts = Selector<AppState, [LevelLayout]>(projector: { $0.levelLayouts.levels })

    static let isLoading = Selector<AppState, Bool>(projector: { $0.layouts.loadingLayouts })
    static let error = Selector<AppState, String?>(projector: { $0.layouts.error })
}
