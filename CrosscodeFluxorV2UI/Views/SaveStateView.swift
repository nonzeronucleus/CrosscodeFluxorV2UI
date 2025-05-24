import SwiftUI
import Fluxor

struct SaveStateView: View {
    @EnvironmentObject var store: Store<AppState, AppEnvironment>
    @AppSelector(LayoutEditSelectors.saveState) var saveState
    
    var body: some View {
        Text("\(saveState)")
    }
    
}
