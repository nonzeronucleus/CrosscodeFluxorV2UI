import SwiftUI
import Fluxor
import Foundation
import CrosscodeDataLibrary


struct LayoutEditView: View {
    let layoutID: UUID
    @EnvironmentObject var store: Store<AppState, AppEnvironment>
    @StateSelector(LayoutEditSelectors.level) var selectedLayout
    @StateSelector(LayoutEditSelectors.selectedCell) var selectedCell
    @StateSelector(LayoutEditSelectors.checking) var checking
    @StateSelector(LayoutEditSelectors.isBusy) var isBusy
    @StateSelector(LayoutEditSelectors.isPopulated) var isPopulated

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                if let selectedLayout = self.selectedLayout {
                    // Background Layer
                    backgroundGradient
                    
                    VStack(spacing: 0) { // Changed to 0 spacing between sections
                        crosswordView(geometry: geometry)
                            .padding(.top, 5)
                        
//                        Text("\(selectedLayout.getDuplicateWords().count)")
                        
                        // Bottom area with priority
                        VStack(spacing: 0) {
                            Spacer(minLength: 0) // Will compress first
                            
                            // Action Buttons (fixed at bottom)
                            actionButtons
                                .frame(height: Layout.buttonHeight)
                                .padding(.bottom, 20) // Keep bottom padding
                        }
                        .padding(.horizontal, UIDevice.current.userInterfaceIdiom == .pad ? 120 : 10)
                    }
                    if isBusy {
                        OverlayView(
                            VStack {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                    .scaleEffect(2.5)
                                
                                Button("Cancel") {
                                    store.dispatch(action: LayoutEditActions.CancelPopulation.start(payload: selectedLayout.crossword))
                                }
                            }
                        )
                    }
                }
            }
            .ignoresSafeArea(.keyboard, edges: .bottom)
            .onDisappear {
                store.dispatch(action: NavigationActions.dismissPresentedRoute())
            }
        }
        .onAppear {
            store.dispatch(action: LayoutEditActions.Load.start(payload: self.layoutID))
        }
    }
    
    
    private func crosswordView(geometry: GeometryProxy) -> some View {
        ZStack {
            if let selectedLayout = self.selectedLayout {

                CrosswordView(
                    grid: selectedLayout.crossword,
                    viewMode: .actualValue,
                    letterValues: selectedLayout.letterMap,
//                    selectedNumber: selectedNumber,
//                    selectedNumber: nil,
                    attemptedletterValues: nil//selectedLayout.attemptedLetters,
//                    checking: checking,
//                    editMode: !isPopulated
                ) { id in
                    store.dispatch(action: LayoutEditActions.Cell.select(payload: id))
//                    store.send(.cellSelected(id))
                }
                .frame(
                    width: Layout.crosswordSize(geometry),
                    height: Layout.crosswordSize(geometry)
                )
                .clipShape(RoundedRectangle(cornerRadius: Layout.cornerRadius))
                .overlay(
                    RoundedRectangle(cornerRadius: Layout.cornerRadius)
                        .stroke(Color.gray, lineWidth: 2)
                )
                .shadow(radius: 5)
            }
        }
    }
    
    private var backButton: some View {
        Text("Back button")
//        Button(action: { dismiss() }) {
//            Image(systemName: "chevron.backward.circle.fill")
//                .symbolRenderingMode(.hierarchical)
//                .font(.system(size: UIDevice.current.userInterfaceIdiom == .pad ? 30 : 24))
//                .foregroundColor(.blue)
//                .contentShape(Circle())
//        }
//        .buttonStyle(.plain)
//        .accessibilityLabel("Back")
    }
    
    private var backgroundGradient: some View {
        LinearGradient(
            gradient: Gradient(colors: [.purple.opacity(0.2), .blue.opacity(0.2)]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .edgesIgnoringSafeArea(.all)
    }
    
    private var actionButtons: some View {
        HStack(spacing: Layout.buttonSpacing) {
            
            if isPopulated {
                Button(action: { store.dispatch(action: LayoutEditActions.Populate.start(payload: selectedLayout!.crossword) ) }) {
                    Text("Export")
                        .font(.system(size: Layout.buttonFontSize(), weight: .bold))
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .contentShape(Rectangle())
                }
                .buttonStyle(.borderedProminent)
                .tint(.green)

                Button(action: { store.dispatch(action: LayoutEditActions.Depopulate.start(payload: selectedLayout!.crossword) ) }) {
                    Text("Clear")
                        .font(.system(size: Layout.buttonFontSize(), weight: .bold))
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .contentShape(Rectangle())
                }
                .buttonStyle(.borderedProminent)
                .tint(.red)

            }
            else {
                Button(action: { store.dispatch(action: LayoutEditActions.Populate.start(payload: selectedLayout!.crossword) ) }) {
                    Text("Populate")
                        .font(.system(size: Layout.buttonFontSize(), weight: .bold))
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .contentShape(Rectangle())
                }
                .buttonStyle(.borderedProminent)
                .tint(.blue)
            }
            
//            Button(action: { store.send(.deleteRequested) }) {
//                Text("Delete")
//                    .font(.system(size: Layout.buttonFontSize(), weight: .bold))
//                    .frame(maxWidth: .infinity, maxHeight: .infinity)
//                    .contentShape(Rectangle())
//            }
//            .buttonStyle(.borderedProminent)
//            .tint(.green)
        }
    }
}

extension LayoutEditView {
    private enum Layout {
        static func crosswordSize(_ geometry: GeometryProxy) -> CGFloat {
            UIDevice.current.userInterfaceIdiom == .pad ?
                min(geometry.size.width * 0.8, geometry.size.height * 0.6) :
                geometry.size.width * 0.95
        }
        
        static func buttonFontSize() -> CGFloat {
            UIDevice.current.userInterfaceIdiom == .pad ? 22 : 17
        }
        
        static let buttonHeight: CGFloat = UIDevice.current.userInterfaceIdiom == .pad ? 60 : 50
        static let keyboardHeight: CGFloat = UIDevice.current.userInterfaceIdiom == .pad ? 220 : 160
        static let buttonSpacing: CGFloat = UIDevice.current.userInterfaceIdiom == .pad ? 50 : 20
        static let verticalSpacing: CGFloat = UIDevice.current.userInterfaceIdiom == .pad ? 30 : 15
        static let cornerRadius: CGFloat = UIDevice.current.userInterfaceIdiom == .pad ? 2 : 1
    }
}




//
//
//
//
//#Preview {
//    withDependencies {
//        $0.uuid = .incrementing
//    } operation: {
//        @Dependency(\.uuid) var uuid
//        
//        let text =  "    .    .. ...| ..  .. ... . .| .. ... ...    |    ..    ... .|. .  ... .... .|. ....   .... .|       .      .|...... . ......|.      .       |. ....   .... .|. .... ...  . .|. ...    ..    |    ... ... .. |. . ... ..  .. |... ..    .    |"
//        
//        let level = Level(id: uuid(),
//                          number: 1,
//                          packId: uuid(),
//                          gridText: text,
//                          letterMap: nil,
//                          attemptedLetters: nil,
//                          numCorrectLetters: 0)
//        
//        let store = Store(
//            initialState: LayoutEditFeature.State(level: level),
//            reducer: { LayoutEditFeature() }
//        )
//        
//        return LayoutEditView(store: store)
//    }
//}

