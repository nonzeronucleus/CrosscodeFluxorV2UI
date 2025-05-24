import Fluxor
import SwiftUI

struct RootView: View {
    @EnvironmentObject var store:Store<AppState, AppEnvironment>
//    @ObservedObject var store: Store<AppState, AppEnvironment>
    
//
    var body: some View {
        NavigationView {
            LayoutsListView()
//                .toolbar {
//                    Button("Add") {
//                        store.dispatch(action: NavigationActions.showAddSheet())
//                    }
//                }
        }
        .onAppear {
//            store.dispatch(action: LayoutsActions.importLayouts())
//            store.dispatch(action: LayoutsActions.fetchLayouts())
        }
//        .navigationViewStyle(.stack)
//        .inspectableSheet(isPresented: store.binding(get: NavigationSelectors.shoulShowAddShet,
//                                                     enable: NavigationActions.showAddSheet,
//                                                     disable: NavigationActions.hideAddSheet)) {
//            AddTodoView(store: store)
//        }
    }
}

//#if !TESTING
//struct RootView_Previews: PreviewProvider {
//    static var previews: some View {
//        RootView(store: previewStore)
//    }
//}
//#endif
