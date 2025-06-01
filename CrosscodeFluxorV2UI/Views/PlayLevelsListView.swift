//import SwiftUI
//import Fluxor
//import CrosscodeDataLibrary
//
//struct PlayLevelsListView: View {
//    @EnvironmentObject var store: Store<AppState, AppEnvironment>
//    @StateSelector(LevelSelectors.levels) private var levels
//    @State private var showDeleteAlert = false
//    @State private var layoutToDelete: UUID?
//    
//    var body: some View {
//        VStack{
//            List {
//                ForEach(levels, id: \.id) { layout in
//                    NavigationLink(value: layout.id) {
//                        Text("\(layout.id)")
//                    }
//                    .simultaneousGesture(
//                        TapGesture().onEnded {
//                            store.dispatch(action: NavigationActions.navigateToDetail(payload: layout.id))
//                        }
//                    )
//                    .swipeActions(edge: .trailing) {
//                        Button(role: .destructive) {
//                            layoutToDelete = layout.id
//                            showDeleteAlert = true
//                        } label: {
//                            Label("Delete", systemImage: "trash")
//                        }
//                    }
//                }
//            }
//        }
////        .alert("Delete Layout",
////               isPresented: $showDeleteAlert,
////               presenting: layoutToDelete) { id in
////            Button("Cancel", role: .cancel) {}
////            Button("Delete", role: .destructive) {
////                store.dispatch(action: LayoutsActions.deleteLayout(payload: id))
////            }
////        } message: { id in
////            Text("Are you sure you want to delete this layout?")
////        }
//        .onAppear() {
////            store.dispatch(action: LayoutsActions.importLayouts())
//            store.dispatch(action: LevelListActions<LevelLayout>.FetchAll.start())
////            store.dispatch(action: LevelListActions<PlayableLevel>.FetchAll.start())
//        }
//    }}
//
//
//struct EditLayoutsListView: View {
//    var body: some View {
//        Text("EditLayoutsListView")
//    }
//}
