import Factory
import Fluxor
import CrosscodeDataLibrary

struct AppEnvironment {
    let layoutsAPI:LayoutsAPI
    let playableLevelsAPI:LevelsAPI
    
    init(layoutsAPI:LayoutsAPI, playableLevelsAPI:LevelsAPI) {
        self.layoutsAPI = layoutsAPI
        self.playableLevelsAPI = playableLevelsAPI
    }
}
