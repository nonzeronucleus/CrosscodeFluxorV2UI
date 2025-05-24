struct AppState/*: Encodable*/ {
    var layouts = LayoutsState()
    var navigation = NavigationState()
    var levelEdit: LayoutEditState?
}
