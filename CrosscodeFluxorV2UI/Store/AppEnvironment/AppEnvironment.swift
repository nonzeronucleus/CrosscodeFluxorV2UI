import Factory
import Fluxor
import CrosscodeDataLibrary

struct AppEnvironment {
    var layoutsAPI:LayoutsAPI { get {
        apis[.layoutsAPI] as! LayoutsAPI
    }}
    
    var PlayableLevelsAPI:LevelsAPI { get {
        apis[.playableLevelsAPI] as! PlayableLevelsAPI
    }}
    var apis: [APIType: any LevelsAPI] = [:]
    
    init(layoutsAPI:LayoutsAPI, playableLevelsAPI:LevelsAPI) {
        apis[.layoutsAPI] = layoutsAPI
        apis[.playableLevelsAPI] = playableLevelsAPI
    }
}
