//import CrosscodeDataLibrary

struct LayoutsState : Encodable, Equatable {
    var layouts = [Layout]()
    var loadingLayouts = false
    var error: String?
}
