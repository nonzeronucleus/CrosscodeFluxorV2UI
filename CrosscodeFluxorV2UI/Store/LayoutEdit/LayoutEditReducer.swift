import Fluxor
import CrosscodeDataLibrary



let layoutEditReducer = Reducer<LayoutEditState?>(
    ReduceOn(LayoutEditActions.Load.success) { state, action in
        state = LayoutEditState(level: action.payload)
    },
    ReduceOn(LayoutEditActions.Cell.select) { state, action in
        if state == nil { return }
        
        if state?.populationState != .unpopulated { return } // Don't allow the squares to be clicked while the grid's been populated
        
        var level = state!.level
        let selectedCell = action.payload
        
        if let selectedCell {
            if let location = level.crossword.locationOfElement(byID: selectedCell ) {
                level.crossword.updateElement(byPos: location) { cell in
                    cell.toggle()
                }
                let opposite = Pos(row: level.crossword.columns - 1 - location.row, column: level.crossword.rows - 1 - location.column)

                if opposite != location {
                    level.crossword.updateElement(byPos: opposite) { cell in
                        cell.toggle()
                    }
                }
            }
        }
        
        state!.level = level
        state!.selectedCell = selectedCell
        state!.populationState = .unpopulated
        state!.saveState = .dirty
    },
    ReduceOn(LayoutEditActions.Populate.start) { state, action in
        if state == nil { return }
        state!.populationState = .populating
    },
    ReduceOn(LayoutEditActions.Populate.success) { state, action in
        if state == nil { return }
        state!.level.crossword = action.payload.crossword
        state!.level.letterMap = action.payload.letterMap
        state!.populationState = .populated
        state!.saveState = .clean
    },
    ReduceOn(LayoutEditActions.CancelPopulation.success) { state, action in
        if state == nil { return }
        state!.populationState = .unpopulated
    },
    ReduceOn(LayoutEditActions.Depopulate.success) { state, action in
        if state == nil { return }
        state!.level.crossword = action.payload.crossword
        state!.level.letterMap = action.payload.letterMap
        state!.populationState = .unpopulated
        state!.saveState = .clean
    },
    ReduceOn(LayoutEditActions.SaveLayout.start) { state, action in
        if state == nil { return }
        state!.saveState = .saving
    },
    ReduceOn(LayoutEditActions.SaveLayout.success) { state, action in
        if state == nil { return }
        state!.saveState = .clean
    },
    ReduceOn(LayoutEditActions.SaveLayout.failure) { state, action in
        state!.saveState = .dirty
        print("Save failed \(action.payload)")
    }
)

//
//return Effect { dispatch in
////            if !state.checking && state.populationState == .populated {
//    dispatch(LevelEditActions.saveLevel(level:level))
////            }
