//import Fluxor
//
//let layoutsReducer = Reducer<LayoutsState>(
//    ReduceOn(LayoutsActions.fetchLayouts) { state, action in
//        state.loadingLayouts = true
//        state.error = nil
//    },
//    ReduceOn(LayoutsActions.didFetchLayouts) { state, action in
//        state.layouts = action.payload
//        state.loadingLayouts = false
//        state.error = nil
//    },
//    ReduceOn(LayoutsActions.didCreateNewLayout) { state, action in
//        state.layouts = action.payload
//        state.loadingLayouts = false
//        state.error = nil
//    },
//    ReduceOn(LayoutsActions.didDeleteLayout) { state, action in
//        state.layouts = action.payload
//        state.loadingLayouts = false
//        state.error = nil
//    },
//    ReduceOn(LayoutsActions.importLayouts) { state, action in
//        state.error = nil
//    }
//)
