//import SwiftUI
//import Fluxor
//
//struct PlayableLevelListView: View {
//    @EnvironmentObject var store: Store<AppState, AppEnvironment>
//    @StateSelector(PlayableLevelSelectors.levels) private var levels
//    
////    init(store: StoreOf<PlayableLevelsFeature>, prefs: StoreOf<PreferencesFeature>) {
////        self.store = store
////        self.currentPrefs = prefs
////    }
//    
//    var body: some View {
//        ZStack {
//            // Background with subtle animation
//            
//            VStack(spacing: 20) {
//                // Header with game title
////                Text("Select Level")
////                    .font(.system(size: 36, weight: .bold, design: .rounded))
////                    .foregroundStyle(Color.black)
////                    .shadow(color: .black.opacity(0.4), radius: 4, x: 2, y: 2)
//                
//                
//                // Level grid
//                ScrollView {
//                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 100), spacing: 16)], spacing: 20) {
//                        ForEach(store.levels) { level in
//                            LevelCard(level: level) {
////                                store.send(.didSelectLevel(level))
//                            }
//                            .transition(.scale.combined(with: .opacity))
//                        }
//                    }
//                    .padding(.horizontal)
//                }                
//            }
//            .padding(.vertical)
//        }
//        .fullScreenCover(
//            item: $store.scope(state: \.gameView, action: \.gameView)
//        ) { store in
//            PlayableLevelView(store: store)
//        }
//    }
//}
//
//// Custom level card view
//struct LevelCard: View {
//    let level: Level
//    let action: () -> Void
//
//    var body: some View {
//        Button(action: action) {
//            ZStack {
//                Image("ButtonBackground") // Add this image to your asset catalog
//                    .resizable()
//                    .aspectRatio(1, contentMode: .fit)
//                    .cornerRadius(16)
//                    .shadow(color: .black.opacity(0.3), radius: 4, x: 2, y: 2)
//
//                Text("\(level.number ?? 0)")
//                    .font(.system(size: 24, weight: .bold, design: .rounded))
//                    .foregroundColor(.white)
//                    .shadow(color: .black.opacity(0.6), radius: 2, x: 1, y: 1)
//            }
//        }
//        .buttonStyle(.plain)
//        .frame(width: 120, height: 120) // Adjust size as needed
//    }
//}
//
//// Button press animation
//struct ScaleButtonStyle: ButtonStyle {
//    func makeBody(configuration: Configuration) -> some View {
//        configuration.label
//            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
//            .animation(.spring(response: 0.3, dampingFraction: 0.6), value: configuration.isPressed)
//    }
//}
//            
//#Preview {
//    let store = Store(
//        initialState: PlayableLevelsFeature.State(),
//        reducer: { PlayableLevelsFeature() }
//    )
//
//    
//    return PlayableLevelListView(
//        store: store,
//        prefs: Store (
//            initialState: PreferencesFeature.State(),
//            reducer: { PreferencesFeature() }
//        )
//    )
//    .onAppear {
//        let packDefinition = PackDefinition()
//        store.send(.loadLevels(packDefinition))
//    }
//}
