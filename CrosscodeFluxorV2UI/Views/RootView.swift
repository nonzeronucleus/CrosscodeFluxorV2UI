import Fluxor
import SwiftUI
import Factory
import CrosscodeDataLibrary



struct RootView: View {
    @EnvironmentObject var store: Store<AppState, AppEnvironment>
    
    @StateSelector(NavigationSelectors.presentedRoute)
    private var presentedRoute

    @StateSelector(NavigationSelectors.selectedTab)
    private var selectedTab

    @State private var navigationPath: [UUID] = []

    // MARK: - Computed binding for sheet
    private var modalRouteBinding: Binding<Route?> {
        Binding<Route?>(
            get: { presentedRoute?.asModal },
            set: { newValue in
                if newValue == nil {
                    store.dispatch(action: NavigationActions.dismissPresentedRoute())
                }
            }
        )
    }

    var body: some View {
        VStack {
            TabView(
                selection: Binding(
                    get: { selectedTab },
                    set: { store.dispatch(action: NavigationActions.selectTab(payload: $0)) }
                )
            ) {
                // MARK: - Play Tab
                NavigationStack {
                    VStack {
                        TitleBarView(
                            title: "Levels",
                            color: .cyan,
                            addItemAction: nil,
                            showSettingsAction: { store.dispatch(action: NavigationActions.showSettings()) }
                        )
                        
                        PlayableLevelsListView()
                            .navigationDestination(for: UUID.self) { id in
                                VStack {
                                    Text("\(id)")
//                                    LayoutEditView(layoutID: id)
//                                        .toolbar(.hidden, for: .tabBar)
                                }
                            }

                    }
                }
                .tabItem { Label("Play", systemImage: "gamecontroller") }
                .tag(NavTab.play)

                // MARK: - Edit Tab
                NavigationStack(path: $navigationPath) {
                    VStack {
                        TitleBarView(
                            title: "Layouts",
                            color: .cyan,
                            addItemAction: { store.dispatch(action: LevelListActions<LevelLayout>.CreateLayout.start()) },
                            showSettingsAction: { store.dispatch(action: NavigationActions.showSettings()) }
                        )
                        
                        LayoutsListView()
                            .navigationDestination(for: UUID.self) { id in
                                VStack {
                                    LayoutEditView(layoutID: id)
                                        .toolbar(.hidden, for: .tabBar)
                                }
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
                        break // handled by .sheet
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
        }

        // MARK: - Modal Sheet for Settings
        .sheet(item: modalRouteBinding) { route in
            switch route {
                case .settings:
                    SettingsView()
                default:
                    EmptyView()
            }
        }
    }
}

