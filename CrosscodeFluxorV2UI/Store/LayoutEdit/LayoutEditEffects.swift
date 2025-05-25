import Combine
import CrosscodeDataLibrary
import Fluxor
import Foundation

class LayoutEditEffects: Effects {
    typealias Environment = AppEnvironment
    
    
    
    
    let loadLevel = Effect<Environment>.dispatchingMultiple { actions, environment in
        actions
            .wasCreated(from: LayoutEditActions.requestLoadLayout)
            .flatMap { action in
                Future<[Action], Never> { promise in
                    Task {
                        do {
                            let levelId = action.payload
                            debugPrint("Loading level with ID: \(levelId)")
                            
                            let result = try await environment.layoutsAPI.fetchLayout(id: levelId)
                            
                            if let result {
                                promise(.success([
                                    LayoutEditActions.layoutLoaded(
                                        payload: result
                                    )]))
                            }

                            
                            // Your actual population logic here
                            // For example:
                            // let crossword = try await environment.loadLevel(id: levelId)
                            // promise(.success([populationCompleteAction]))
                            
                            // Temporary mock success
//                            promise(.success([
//                                LayoutEditActions.populationComplete(
//                                    payload: (Crossword.empty, nil)
//                                )
//                            ]))
//                        } catch {
//                            promise(.success([
//                                LayoutEditActions.populationFailed(payload: error.localizedDescription)
//                            ]))
                        }
                    }
                }
                .eraseToAnyPublisher() // This fixes the type mismatch
            }
            .eraseToAnyPublisher() // Needed for the outer chain
    }
    
//    let populateLevel = Effect<Environment>.dispatchingMultiple { actions, environment in
//        actions
//            .wasCreated(from: LayoutEditActions.loadLevel)
//            .flatMap { action in
//                Future<[Action], Never> { promise in
//                    Task {
//                        do {
//                            debugPrint(action.payload)
//                        }
//                    }
//                }
//            }
//    }

    
    //                            let result = try await environment.layoutsAPI.getLevel(
    //                                levelId: action.payload
    //                            )
    //                            if !Task.isCancelled {
    //                                promise(.success([
    //                                    LayoutEditActions.loadLevel.success(payload: result),
    //                                ]))
    //                            }

    
    let populateLevel = Effect<Environment>.dispatchingMultiple { actions, environment in
        actions
            .wasCreated(from: LayoutEditActions.requestPopulation)
            .flatMap { action in
                Future<[Action], Never> { promise in
                    Task {
                        do {
                            let initCrosswordStr = action.payload.layoutString()
                            let result = try await environment.layoutsAPI.populateCrossword(
                                crosswordLayout: initCrosswordStr
                            )
                            if !Task.isCancelled {
                                promise(.success([
                                    LayoutEditActions.populationComplete(
                                        payload: (crossword: Crossword(initString: result.0),letterMap: CharacterIntMap(from: result.1))
                                    )
                                ]))
                            }
                        } catch {
                            if !Task.isCancelled {
                                promise(.success([
                                    LayoutEditActions.populationFailed(
                                        payload: error.localizedDescription)
                                ]))
                            }
                        }
                    }
                }
                .handleEvents(receiveCancel: {
                    Task {
                        await environment.layoutsAPI.cancel()
                    }
                })
                .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
    
    let depopulateLevel = Effect<Environment>.dispatchingMultiple { actions, environment in
        actions
            .wasCreated(from: LayoutEditActions.depopulateGrid)
            .flatMap { action in
                Future<[Action], Never> { promise in
                    Task {
                        do {
                            let initCrosswordStr = action.payload.layoutString()
                            let result = try await environment.layoutsAPI.depopulateCrossword(
                                crosswordLayout: initCrosswordStr
                            )
                            if !Task.isCancelled {
                                promise(.success([
                                    LayoutEditActions.depopulationComplete(
                                        payload: (crossword: Crossword(initString: result.0),letterMap: nil)
                                    )
                                ]))
                            }
                        } catch {
                            if !Task.isCancelled {
                                promise(.success([
                                    LayoutEditActions.populationFailed(
                                        payload: error.localizedDescription)
                                ]))
                            }
                        }
                    }
                }
                .handleEvents(receiveCancel: {
                    Task {
                        await environment.layoutsAPI.cancel()
                    }
                })
                .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
    
    
    
    let cancelPopulation = Effect<Environment>.dispatchingOne { actions, environment in
        actions
            .wasCreated(from: LayoutEditActions.requestCancelPopulation)
            .map { _ -> Action in
                Task {
                    await environment.layoutsAPI.cancel()
                }
                return LayoutEditActions.populationCancelled()
            }
            .eraseToAnyPublisher()
    }
    
    let saveAfterSelectionEffect = Effect<AppEnvironment>.dispatchingOne { actions, environment in
        actions
            .wasCreated(from: LayoutEditActions.selectCell)
            .flatMap { _ -> AnyPublisher<Action, Never> in

                @AppSelector(LayoutEditSelectors.level) var level
                guard let level else {
                    return Just(LayoutEditActions.saveLayoutFailure(payload: "Level not found"))
                        .eraseToAnyPublisher()
                }


                return Future<Action, Never> { promise in
                    Task {
                        do {
                            try await environment.layoutsAPI.saveLevel(level: level)
                            promise(.success(LayoutEditActions.saveLayoutSuccess()))
                        } catch {
                            promise(.success(LayoutEditActions.saveLayoutFailure(payload: error.localizedDescription)))
                        }
                    }
                }
                .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
    
    var effects: [Effect<Environment>] {
        [populateLevel, cancelPopulation]
    }
}


    
  
