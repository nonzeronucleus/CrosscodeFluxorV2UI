import Fluxor


let settingsReducer = Reducer<SettingsState>(
    ReduceOn(SettingsActions.setEditMode.self) { state, action in
        state.editMode = action.payload
    },
    ReduceOn(SettingsActions.setDarkMode.self) { state, action in
        state.darkMode = action.payload
    },
)



