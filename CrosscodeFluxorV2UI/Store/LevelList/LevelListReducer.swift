import Fluxor
import CrosscodeDataLibrary

func makeLevelListReducer<L: Level>() -> Reducer<LevelListState<L>> {
    return Reducer<LevelListState<L>>(
        ReduceOn(LevelListActions.Import.success) { state, _ in
            state.loading = false
            state.error = nil
        },
        ReduceOn(LevelListActions.Import.failure) { state, action in
            state.error = String(action.payload.localizedDescription)
            state.loading = false
        },
        // MARK: - FetchAll Reducers
        ReduceOn(LevelListActions.FetchAll.success) { state, action in
            state.levels = action.payload as! [L]
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
