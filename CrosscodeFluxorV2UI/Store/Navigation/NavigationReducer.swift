import Fluxor

let navigationReducer = Reducer<NavigationState>(
    ReduceOn(NavigationActions.navigate) { state, action in
        state.route = action.payload
    },
    ReduceOn(NavigationActions.presentSheet) { state, action in
        state.sheet = action.payload
    },
    ReduceOn(NavigationActions.dismiss) { state, action in
        state.sheet = nil
        state.route = nil
    }
)
