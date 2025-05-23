import Fluxor
import Factory

@propertyWrapper
struct AppSelector<Value> {
    @Injected(\.store) var store
    private let selector: Selector<AppState, Value>
    
    init(_ selector: Selector<AppState, Value>) {
        self.selector = selector
    }
    
    var wrappedValue: Value {
        store.selectCurrent(selector)
    }
}
