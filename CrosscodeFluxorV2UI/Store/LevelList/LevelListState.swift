import CrosscodeDataLibrary
import Fluxor

//struct LevelListState<Level> /*Encodable, Equatable*/ {
//    var levels: [Level] = [] // Concrete type instead of `any Level`
struct LevelListState<L: Level>: Equatable, Encodable {
    var levels: [L] = []
    var loading = false
    var error: String? = nil
}


//struct LevelListState<L: Level>: Equatable {
//    var levels: [L] = []
//    var loading = false
//    var error: String? = nil
//}


//enum LevelSystemActions<Level> {
//    enum Templates {
//        static let load = ActionTemplate(id: "LevelSystem/Load")
//        static let loadFailure = ActionTemplate(id: "LevelSystem/LoadFailure", payloadType: Error.self)
//    }


//enum LevelListActions {
//    enum Import {
//        static let start = ActionTemplate(id: "Levels/Import/Start")



//import Fluxor
//import Foundation
//
//// 1. Define a non-generic action namespace
//enum LevelSystemActions<Level> {
//    enum Templates {
//        static let load = ActionTemplate(id: "LevelSystem/Load")
//        static let loadFailure = ActionTemplate(id: "LevelSystem/LoadFailure", payloadType: Error.self)
//    }
//    
//    // Generic action creators
//    struct Creators<LevelType> {
//        static func loadSuccess(items: [LevelType]) -> Action<[LevelType]> {
//            Action(
//                payload: items,
//                template: ActionTemplate(id: "LevelSystem/LoadSuccess", payloadType: [LevelType].self)
//            )
//        }
//        
//        static func delete(indices: IndexSet) -> Action<IndexSet> {
//            Action(
//                payload: indices,
//                template: ActionTemplate(id: "LevelSystem/Delete", payloadType: IndexSet.self)
//            )
//        }
//    }
//}
//
//// 2. State and Reducer in generic struct
//struct LevelSystem<LevelType: Identifiable> {
//    struct State: FluxorState {
//        var items: [LevelType]
//        var isLoading: Bool
//        var error: String?
//        
//        static var initialState: State {
//            State(items: [], isLoading: false, error: nil)
//        }
//    }
//    
//    static func reducer() -> Reducer<State> {
//        Reducer(
//            ReduceOn(LevelSystemActions.Templates.load) { state, _ in
//                state.isLoading = true
//                state.error = nil
//            },
//            
//            ReduceOn(ActionTemplate(id: "LevelSystem/LoadSuccess", payloadType: [LevelType].self)) { state, action in
//                state.items = action.payload
//                state.isLoading = false
//            },
//            
//            ReduceOn(LevelSystemActions.Templates.loadFailure) { state, action in
//                state.error = action.payload.localizedDescription
//                state.isLoading = false
//            },
//            
//            ReduceOn(ActionTemplate(id: "LevelSystem/Delete", payloadType: IndexSet.self)) { state, action in
//                state.items.remove(atOffsets: action.payload)
//            }
//        )
//    }
//}
