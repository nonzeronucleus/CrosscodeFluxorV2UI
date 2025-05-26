import SwiftUI
import Fluxor

struct SaveStateView: View {
    @EnvironmentObject var store: Store<AppState, AppEnvironment>
    @StateSelector(LayoutEditSelectors.saveState) var saveState
    
    var body: some View {
        Text("\(saveState)")
    }
    
}
