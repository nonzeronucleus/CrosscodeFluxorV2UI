import Fluxor


enum SettingsSelectors {
    static let editMode = Selector<AppState, Bool> { $0.settings.editMode }
    static let darkMode = Selector<AppState, Bool> { $0.settings.darkMode }
}


let editModeSelector = Selector<AppState, Bool> { state in
    state.settings.editMode
}
