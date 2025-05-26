import Fluxor
import SwiftUI


import SwiftUI
import Fluxor
import Factory

struct RootView: View {
    @EnvironmentObject var store: Store<AppState, AppEnvironment>
    @StateSelector(NavigationSelectors.presentedRoute) var presentedRoute
    @State private var navigationPath: [UUID] = []

    @StateSelector(NavigationSelectors.selectedTab)
    private var selectedTab: NavTab

    var body: some View {
        VStack {
            TabView(selection: Binding(
                get: { selectedTab },
                set: { store.dispatch(action: NavigationActions.selectTab(payload: $0)) }
            )) {
                NavigationStack {
                    PlayLevelsListView()
                }
                .tabItem { Label("Play", systemImage: "gamecontroller") }
                .tag(NavTab.play)
                
                NavigationStack(path: $navigationPath) {
                    LayoutsListView()
                        .navigationDestination(for: UUID.self) { id in
                            VStack {
                                LayoutEditView(layoutID: id)
                                    .toolbar(.hidden, for: .tabBar) // iOS 16+
                                
                            }
                        }
                }
                .onChange(of: presentedRoute) { _, newRoute in
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
                .tabItem { Label("Edit", systemImage: "pencil") }
                .tag(NavTab.edit)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        store.dispatch(action: NavigationActions.showSettings())
                    }) {
                        Image(systemName: "gearshape")
                    }
                }
            }
//            .sheet(item: Binding(
//                get: { presentedRoute },
//                set: { _ in store.dispatch(action: NavigationActions.dismissPresentedRoute()) }
//            )) { route in
//                switch route {
//                    case .settings:
//                        SettingsView()
//                    case .layoutDetail(let id):
//                        LayoutEditView(layoutID: id)
//                }
//            }
        }
    }
}



//
//struct AppView: View {
////    @Selector(NavigationSelectors.navigationState) private var navState
//    @StateSelector(AppSelectors.navigationState) private var navState
//    
//    var body: some View {
//        // Main app container
//        TabView(selection: $navState.activeTab) {
//            // Playable Levels Tab
//            NavigationStack(path: $navState.playableLevelsStack) {
//                Text("To implement")
////                PlayableLevelsView()
////                    .navigationDestination(for: Route.self) { route in
////                        switch route {
////                        case .levelDetail(let id):
////                            LevelDetailView(id: id)
////                                .toolbar(.hidden, for: .tabBar)
////                        default: EmptyView()
////                        }
////                    }
//            }
//            .tag(avigationState.Tab.playableLevels)
//            .tabItem { Label("Play", systemImage: "gamecontroller") }
//            
//            // Editable Layouts Tab
//            NavigationStack(path: $navState.editableLayoutsStack) {
//                EditableLayoutsView()
//                    .navigationDestination(for: Route.self) { route in
//                        switch route {
//                        case .layoutDetail(let id):
//                            LayoutDetailView(id: id)
//                                .toolbar(.hidden, for: .tabBar)
//                        default: EmptyView()
//                        }
//                    }
//            }
//            .tag(AppNavigationState.Tab.editableLayouts)
//            .tabItem { Label("Edit", systemImage: "pencil.and.list.clipboard") }
//        }
//        .sheet(isPresented: $navState.isShowingSettings) {
//            SettingsView()
//        }
//    }
//}
//



//
//struct RootView: View {
//    @EnvironmentObject var store:Store<AppState, AppEnvironment>
//    
//    var body: some View {
//    }
//
//}
////    @ObservedObject var store: Store<AppState, AppEnvironment>
//    
////
//    var body: some View {
//        TabView {
//            // Tab 1: Playable Levels (self-contained navigation)
//            NavigationStack {
//                Text("To implement")
////                PlayableLevelsView()
//            }
//            .tabItem {
//                Label("Play", systemImage: "gamecontroller")
//            }
//            
//            // Tab 2: Level Definitions (self-contained navigation)
//            NavigationStack {
//                LayoutsListView()
//            }
//            .tabItem {
//                Label("Edit", systemImage: "pencil.and.list.clipboard")
//            }
//        }
//        
//        
////        
////        NavigationView {
////            LayoutsListView()
//////                .toolbar {
//////                    Button("Add") {
//////                        store.dispatch(action: NavigationActions.showAddSheet())
//////                    }
//////                }
////        }
//        .onAppear {
////            store.dispatch(action: LayoutsActions.importLayouts())
////            store.dispatch(action: LayoutsActions.fetchLayouts())
//        }
////        .navigationViewStyle(.stack)
////        .inspectableSheet(isPresented: store.binding(get: NavigationSelectors.shoulShowAddShet,
////                                                     enable: NavigationActions.showAddSheet,
////                                                     disable: NavigationActions.hideAddSheet)) {
////            AddTodoView(store: store)
////        }
//    }
//}

//#if !TESTING
//struct RootView_Previews: PreviewProvider {
//    static var previews: some View {
//        RootView(store: previewStore)
//    }
//}
//#endif
