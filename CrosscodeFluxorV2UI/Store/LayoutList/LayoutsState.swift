import CrosscodeDataLibrary

struct LayoutsState : Encodable, Equatable {
    var layouts = [LevelLayout]()
    var loadingLayouts = false
    var error: String?
}
