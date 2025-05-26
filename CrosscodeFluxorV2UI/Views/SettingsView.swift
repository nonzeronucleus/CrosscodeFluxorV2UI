import Fluxor
import SwiftUI
//
struct SettingsView: View {
    @EnvironmentObject var store: Store<AppState, AppEnvironment>
    @StateSelector(SettingsSelectors.editMode) var editMode
    @StateSelector(SettingsSelectors.darkMode) var darkMode

    
    //    @Bindable var store: StoreOf<PreferencesFeature>
//
    var body: some View {
        Form {
            Toggle("Edit Mode", isOn: Binding<Bool>(
                get: { editMode },
                set: { newValue in store.dispatch(action: SettingsActions.setEditMode(payload: newValue)) }
            ))
            Toggle("Darl Mode", isOn: Binding<Bool>(
                get: { darkMode },
                set: { newValue in store.dispatch(action: SettingsActions.setDarkMode(payload: newValue)) }
            ))
//            Toggle("Dark Mode", isOn: $store.isDarkMode)
        }
//        .onAppear {
//            store.send(.loadPreferences)
//        }
    }
}
