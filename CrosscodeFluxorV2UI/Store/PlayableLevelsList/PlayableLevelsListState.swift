import CrosscodeDataLibrary

struct PlayableLevelsState : Encodable, Equatable {
    var levels = [PlayableLevel]()
    var loading = false
    var error: String?
}
