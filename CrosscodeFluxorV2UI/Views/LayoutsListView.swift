import SwiftUI
import Fluxor
import CrosscodeDataLibrary


struct LayoutsListView: View {
    @EnvironmentObject var store: Store<AppState, AppEnvironment>
    @StateSelector(LayoutSelectors.layouts) private var layouts
    @State private var showDeleteAlert = false
    @State private var layoutToDelete: UUID?
    
    
    var body: some View {
        VStack{
            List {
                ForEach(layouts, id: \.id) { layout in
                    NavigationLink(value: layout.id) {
                        Text("\(layout.id)")
                    }
                    .simultaneousGesture(
                        TapGesture().onEnded {
                            store.dispatch(action: NavigationActions.navigateToDetail(payload: layout.id))
                        }
                    )
                    .swipeActions(edge: .trailing) {
                        Button(role: .destructive) {
                            layoutToDelete = layout.id
                            showDeleteAlert = true
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
                }
            }
        }
        .alert("Delete Layout",
               isPresented: $showDeleteAlert,
               presenting: layoutToDelete) { id in
            Button("Cancel", role: .cancel) {}
            Button("Delete", role: .destructive) {
//                store.dispatch(action: LayoutsActions.deleteLayout(payload: id))
                store.dispatch(action: LevelListActions<LevelLayout>.Delete.start(payload: id))
            }
        } message: { id in
            Text("Are you sure you want to delete this layout?")
        }
        .onAppear() {
            store.dispatch(action: LevelListActions<LevelLayout>.Import.start())
//            store.dispatch(action: LevelListActions<LevelLayout>.FetchAll.start())
//            store.dispatch(action: LevelListActions<PlayableLevel>.FetchAll.start())
        }
    }
}


//
//struct LevelsList: View {
//    let store: Store<AppState, AppEnvironment>
//    let layouts: [LevelLayout]
//    
//    var body: some View {
//        List {
//            ForEach(layouts, id: \.id) { layout in
//                NavigationLink(value: layout.id) {
//                    Text("\(layout.id)")
//                }
//                .simultaneousGesture(
//                    TapGesture().onEnded {
//                        store.dispatch(action: NavigationActions.navigateToDetail(payload: layout.id))
////                        store.dispatch(action: NavigationActions.navigate(payload: .layoutDetail(id: layout.id)))
//                    }
//                )
//                .swipeActions(edge: .trailing) {
//                    Button(role: .destructive) {
////                        layoutToDelete = layout.id
////                        showDeleteAlert = true
//                    } label: {
//                        Label("Delete", systemImage: "trash")
//                    }
//                }
//            }
//        }
//    }
//}
//            
//#Preview {
//    var state = AppState()
//    LayoutsListView()
//        .environmentObject(state)
//}

