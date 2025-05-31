import Fluxor

struct SettingsState: Equatable, Encodable {
    var editMode: Bool = false
    var darkMode: Bool = false
}
