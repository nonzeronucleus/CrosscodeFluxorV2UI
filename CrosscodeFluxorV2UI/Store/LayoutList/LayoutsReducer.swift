import Fluxor
import CrosscodeDataLibrary

func makeLayoutCreateReducer() -> Reducer<LevelListState<LevelLayout>> {
    return Reducer<LevelListState<LevelLayout>>(
        ReduceOn(LayoutsActions.CreateLayout.success) { state, action in
            state.levels = action.payload
            state.loading = false
        },
        ReduceOn(LayoutsActions.CreateLayout.failure) { state, action in
            state.error = String(action.payload.localizedDescription)
            state.loading = false
        }
    )
}
