import Fluxor


let navigationReducer = Reducer<NavigationState>(
    ReduceOn(NavigationActions.selectTab) { state, action in
        state.selectedTab = action.payload
    },
    ReduceOn(NavigationActions.showSettings) { state, _ in
        state.presentedRoute = .settings
    },
    ReduceOn(NavigationActions.dismissPresentedRoute) { state, _ in
        state.presentedRoute = nil
    },
    ReduceOn(NavigationActions.navigateToDetail) { state, action in
        state.presentedRoute = .layoutDetail(action.payload)
    },
)



//let navigationReducer = Reducer<NavigationState>(
//    ReduceOn(NavigationActions.navigate) { state, action in
//        state.route = action.payload
//    },
//    ReduceOn(NavigationActions.presentSheet) { state, action in
//        state.sheet = action.payload
//    },
//    ReduceOn(NavigationActions.dismiss) { state, action in
//        state.sheet = nil
//        state.route = nil
//    }
//)

//
//let navigationReducer = Reducer<NavigationState>(
//    ReduceOn(NavigationActions.switchTab) { state, action in
//        state.activeTab = action.payload
//    },
//    ReduceOn(NavigationActions.navigateToDetail) { state, action in
//        let id = action.payload
//        state.selectedLevelID = id
//        switch state.activeTab {
//        case .playableLevels:
//            state.playableLevelsStack.append(.levelDetail(id))
//        case .editableLayouts:
//            state.editableLayoutsStack.append(.layoutDetail(id))
//        }
//    },
//    ReduceOn(NavigationActions.navigateBack) { state, _ in
//        switch state.activeTab {
//        case .playableLevels:
//            _ = state.playableLevelsStack.popLast()
//        case .editableLayouts:
//            _ = state.editableLayoutsStack.popLast()
//        }
//    },
//    ReduceOn(NavigationActions.showSettings) { state, _ in
//        state.isShowingSettings = true
//    },
//    ReduceOn(NavigationActions.dismissSettings) { state, _ in
//        state.isShowingSettings = false
//    }
//)
