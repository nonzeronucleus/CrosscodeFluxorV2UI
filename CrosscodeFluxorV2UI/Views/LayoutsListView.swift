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
                store.dispatch(action: LayoutsActions.deleteLayout(payload: id))
            }
        } message: { id in
            Text("Are you sure you want to delete this layout?")
        }
        .onAppear() {
            store.dispatch(action: LayoutsActions.importLayouts())
            store.dispatch(action: LevelListActions<LevelLayout>.FetchAll.start())
//            store.dispatch(action: LevelListActions<PlayableLevel>.FetchAll.start())
        }
    }
}


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
//                        layoutToDelete = layout.id
//                        showDeleteAlert = true
//                    } label: {
//                        Label("Delete", systemImage: "trash")
//                    }
//                }
//            }
//        }
//        .alert("Delete Layout",
//               isPresented: $showDeleteAlert,
//               presenting: layoutToDelete) { id in
//            Button("Cancel", role: .cancel) {}
//            Button("Delete", role: .destructive) {
//                store.dispatch(action: LayoutsActions.deleteLayout(payload: id))
//            }
//        } message: { id in
//            Text("Are you sure you want to delete this layout?")
//        }
//    }
//}



//struct LayoutsListView: View {
//    @EnvironmentObject var store: Store<AppState, AppEnvironment>
//    @StateSelector(LayoutSelectors.layouts) private var layouts
////    @AppSelector(NavigationSelectors.currentRoute) var currentRoute
//    @StateSelector(NavigationSelectors.presentedRoute) var presentedRoute
////    @State private var navigationPath: [UUID] = []
//    @State private var showDeleteAlert = false
//    @State private var layoutToDelete: UUID?
//    
//    
//    var body: some View {
//        NavigationStack(/*path: $navigationPath*/) {
//
//            VStack {
//                LevelsList(store:store, layouts:layouts)
//            }
//            .navigationDestination(for: UUID.self) { id in
//                VStack {
//                    LayoutEditView(layoutID: id)
//                        .toolbar(.hidden, for: .tabBar) // iOS 16+
//
//                }
//            }
//            .navigationTitle("Layouts")  // Add title
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    Button(action: addNewLayout) {
//                        Label("Add", systemImage: "plus")
//                    }
//                }
//            }
//            .alert("Delete Layout",
//                   isPresented: $showDeleteAlert,
//                   presenting: layoutToDelete) { id in
//                Button("Cancel", role: .cancel) {}
//                Button("Delete", role: .destructive) {
//                    store.dispatch(action: LayoutsActions.deleteLayout(payload: id))
//                }
//            } message: { id in
//                Text("Are you sure you want to delete this layout?")
//            }
//        }
////        .onChange(of: presentedRoute) { _, newRoute in
////            switch newRoute {
////            case .layoutDetail(let id):
////                if !navigationPath.contains(id) {
////                    navigationPath.append(id)
////                }
////            case .settings:
////                break
////            case nil:
////                if !navigationPath.isEmpty {
////                    navigationPath.removeLast()
////                }
////            }
////        }
//        .onAppear() {
//            store.dispatch(action: LayoutsActions.importLayouts())
//        }
//    }
//    
//    private func addNewLayout() {
//        store.dispatch(action: LayoutsActions.createNewLayout())
//    }
//}

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

