import Foundation
import Fluxor
import CrosscodeDataLibrary

enum LayoutsActions {
    static let importLayouts = ActionTemplate(id: "[Importing] Import Layouts")
    static let didImportLayouts = ActionTemplate(id: "[Importing] Did import Layouts")
    static let didFailImportingLayouts = ActionTemplate(id: "[Importing] Did fail importing Layouts", payloadType: String.self)

    static let createNewLayout = ActionTemplate(id: "[Creating] Create new layout")
    static let didCreateNewLayout = ActionTemplate(id: "[Creating] Did create new layout", payloadType: [LevelLayout].self)
    static let fetchLayouts = ActionTemplate(id: "[Fetching] Fetch layouts")
    static let didFetchLayouts = ActionTemplate(id: "[Fetching] Did fetch layouts", payloadType: [LevelLayout].self)
    static let didFailFetchingLayouts = ActionTemplate(id: "[Fetching] Did fail fetching layouts", payloadType: String.self)
    
    static let deleteLayout = ActionTemplate(id: "[Deleting] delete layouts", payloadType: UUID.self)
    static let didDeleteLayout = ActionTemplate(id: "[Deleting] Did delete layouts", payloadType: [LevelLayout].self)
    static let didFailDeletingLayout = ActionTemplate(id: "[Deleting] Did fail deleting layouts", payloadType: (id: UUID, error: String).self)
}
