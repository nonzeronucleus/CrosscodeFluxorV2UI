import Fluxor
import CrosscodeDataLibrary

func makeLevelListReducer<L: Level>() -> Reducer<LevelListState<L>> {
    return Reducer<LevelListState<L>> { state, action in
        makeLevelListImportReducer().reduce(&state, action)
//        makeLevelListCreateReducer().reduce(&state, action)
        makeLevelListFetchAllReducer().reduce(&state, action)
        makeLevelListDeleteReducer().reduce(&state, action)
    }
}



func makeLevelListImportReducer<L: Level>() -> Reducer<LevelListState<L>> {
    return Reducer<LevelListState<L>>(
        ReduceOn(LevelListActions<L>.Import.success) { state, _ in
            state.loading = false
            state.error = nil
        },
        ReduceOn(LevelListActions<L>.Import.failure) { state, action in
            state.error = String(action.payload.localizedDescription)
            state.loading = false
        }
    )
}

//func makeLevelListCreateReducer<L: Level>() -> Reducer<LevelListState<L>> {
//    return Reducer<LevelListState<L>>(
//        ReduceOn(LevelListActions<L>.Create.success) { state, action in
//            state.levels = action.payload
//            state.loading = false
//        },
//        ReduceOn(LevelListActions<L>.Create.failure) { state, action in
//            state.error = String(action.payload.localizedDescription)
//            state.loading = false
//        }
//    )
//}


func makeLevelListFetchAllReducer<L: Level>() -> Reducer<LevelListState<L>> {
    return Reducer<LevelListState<L>>(
        ReduceOn(LevelListActions<L>.FetchAll.success) { state, action in
            print("Loaded \(action.payload.count) levels")
            state.levels = action.payload
            state.loading = false
        },
        ReduceOn(LevelListActions<L>.FetchAll.failure) { state, action in
            state.error = String(action.payload.localizedDescription)
            state.loading = false
        },
    )
}

func makeLevelListDeleteReducer<L: Level>() -> Reducer<LevelListState<L>> {
    return Reducer<LevelListState<L>>(
        ReduceOn(LevelListActions<L>.Delete.success) { state, _ in
            state.loading = false
            state.error = nil
        },
        ReduceOn(LevelListActions<L>.Delete.failure) { state, action in
            state.error = String(action.payload.localizedDescription)
            state.loading = false
        },
        // MARK: - FetchAll Reducers
        ReduceOn(LevelListActions<L>.Delete.success) { state, action in
            state.levels = action.payload
            state.loading = false
        },
    )
}




//
//let levelListReducer = Reducer<LevelListState<any Level>>(
////    // MARK: - Import Reducers
//    ReduceOn(LevelListActions.Import.success) { state, action in
//        state.loading = false
//        state.error = nil
//    },
//}
//
//    ReduceOn(LevelListActions.Import.failure) { state, action in
//        state.error = String(action.payload.localizedDescription)
//        state.loading = false
//    },
//    
//    // MARK: - Create Reducers
//    ReduceOn(LevelListActions.Create.success) { state, action in
//        state.levels.append(contentsOf: action.payload)  // Append new levels
//        state.loading = false
//    },
//    
//    // MARK: - FetchAll Reducers
//    ReduceOn(LevelListActions.FetchAll.success) { state, action in
//        state.levels = action.payload
//        state.loading = false
//    },
//    
//    // MARK: - Delete Reducers
//    ReduceOn(LevelListActions.Delete.success) { state, action in
//        state.levels = action.payload
//        state.loading = false
//    },
//    
//    // Common error handler
//    ReduceOn(LevelListActions.Create.failure) { state, action in
//        state.error = action.payload.localizedDescription
//        state.loading = false
//    },
//    
//    ReduceOn(LevelListActions.FetchAll.failure) { state, action in
//        state.error = action.payload.localizedDescription
//        state.loading = false
//    },
//    
//    ReduceOn(LevelListActions.Delete.failure) { state, action in
//        state.error = action.payload.localizedDescription
//        state.loading = false
//    }
//)
