import SwiftUI
import Fluxor
import CrosscodeDataLibrary


struct LayoutsListView: View {
    @EnvironmentObject var store: Store<AppState, AppEnvironment>
    @AppSelector(LayoutSelectors.layouts) private var layouts
    
    @State private var navigationPath: [UUID] = []
    @State private var showDeleteAlert = false
    @State private var layoutToDelete: UUID?
    
    private var currentRoute: Route? {
        store.state.navigation.route
    }

    var body: some View {
        NavigationStack(path: $navigationPath) {
            LevelsList(store:store, layouts:layouts)
            .navigationDestination(for: UUID.self) { id in
                LayoutEditView(layoutID: id)
            }
            .navigationTitle("Layouts")  // Add title
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: addNewLayout) {
                        Label("Add", systemImage: "plus")
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
        }
        .onChange(of: currentRoute) { _, newRoute in
            switch newRoute {
            case .layoutDetail(let id):
                if !navigationPath.contains(id) {
                    navigationPath.append(id)
                }
            case .settings:
                break
            case nil:
                if !navigationPath.isEmpty {
                    navigationPath.removeLast()
                }
            }
        }
        .onAppear() {
            store.dispatch(action: LayoutsActions.importLayouts())
        }
    }
    
    private func addNewLayout() {
//        let newID = UUID()
        store.dispatch(action: LayoutsActions.createNewLayout())
//        store.dispatch(action: NavigationActions.Navigate(route: .layoutDetail(id: newID)))
    }
}


struct LayoutEditView: View {
    
    init(layoutID:UUID) {
        
    }
    
    var body: some View {
        Text("LayoutEditView")
    }
}

//
struct LevelsList: View {
    let store: Store<AppState, AppEnvironment>
    let layouts: [LevelLayout]
    
    var body: some View {
        List {
            ForEach(layouts, id: \.id) { layout in
                NavigationLink(value: layout.id) {
                    Text("\(layout.id)")
                }
                .simultaneousGesture(
                    TapGesture().onEnded {
//                        store.dispatch(action: LevelEditActions.selectLevel(payload: layout))
//                        store.dispatch(action: NavigationActions.navigate(payload: .layoutDetail(id: layout.id)))
                    }
                )
                .swipeActions(edge: .trailing) {
                    Button(role: .destructive) {
//                        layoutToDelete = layout.id
//                        showDeleteAlert = true
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }
                }
            }
        }
    }
}
//            
//#Preview {
//    var state = AppState()
//    LayoutsListView()
//        .environmentObject(state)
//}

