import Factory

struct AppEnvironment {
    let layoutsAPI:LayoutsAPI
    
    init(layoutsAPI:LayoutsAPI) {
        self.layoutsAPI = layoutsAPI
    }
}
