import Fluxor

enum SettingsActions {
    static let setEditMode = ActionTemplate(id: "[Settings] setEditMode", payloadType: Bool.self)
    static let setDarkMode = ActionTemplate(id: "[Settings] setDarkMode", payloadType: Bool.self)
}
