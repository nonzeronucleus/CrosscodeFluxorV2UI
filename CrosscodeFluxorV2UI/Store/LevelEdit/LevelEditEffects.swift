import Combine
import Fluxor
import Foundation
//import CrosscodeDataLibrary

class LevelEditEffects: Effects {
    typealias Environment = AppEnvironment
    
//    let populateLevel = Effect<Environment>.dispatchingMultiple { actions, environment in
//        actions
//            .wasCreated(from: LevelEditActions.requestPopulation)
//            .flatMap { action in
//                Future<[Action], Never> { promise in
//                    Task {
//                        do {
//                            let initCrosswordStr = action.payload.layoutString()
//                            let result = try await environment.layoutAPI.populateCrossword(
//                                crosswordLayout: initCrosswordStr
//                            )
//                            if !Task.isCancelled {
//                                promise(.success([
//                                    LevelEditActions.populationComplete(
//                                        payload: (crossword: Crossword(initString: result.0),letterMap: CharacterIntMap(from: result.1))
//                                    )
//                                ]))
//                            }
//                        } catch {
//                            if !Task.isCancelled {
//                                promise(.success([
//                                    LevelEditActions.populationFailed(
//                                        payload: error.localizedDescription)
//                                ]))
//                            }
//                        }
//                    }
//                }
//                .handleEvents(receiveCancel: {
//                    Task {
//                        await environment.layoutAPI.cancel()
//                    }
//                })
//                .eraseToAnyPublisher()
//            }
//            .eraseToAnyPublisher()
//    }
//    
//    let depopulateLevel = Effect<Environment>.dispatchingMultiple { actions, environment in
//        actions
//            .wasCreated(from: LevelEditActions.depopulateGrid)
//            .flatMap { action in
//                Future<[Action], Never> { promise in
//                    Task {
//                        do {
//                            let initCrosswordStr = action.payload.layoutString()
//                            let result = try await environment.layoutAPI.depopulateCrossword(
//                                crosswordLayout: initCrosswordStr
//                            )
//                            if !Task.isCancelled {
//                                promise(.success([
//                                    LevelEditActions.depopulationComplete(
//                                        payload: (crossword: Crossword(initString: result.0),letterMap: nil)
//                                    )
//                                ]))
//                            }
//                        } catch {
//                            if !Task.isCancelled {
//                                promise(.success([
//                                    LevelEditActions.populationFailed(
//                                        payload: error.localizedDescription)
//                                ]))
//                            }
//                        }
//                    }
//                }
//                .handleEvents(receiveCancel: {
//                    Task {
//                        await environment.layoutAPI.cancel()
//                    }
//                })
//                .eraseToAnyPublisher()
//            }
//            .eraseToAnyPublisher()
//    }
//    
//    
//    
//    let cancelPopulation = Effect<Environment>.dispatchingOne { actions, environment in
//        actions
//            .wasCreated(from: LevelEditActions.requestCancelPopulation)
//            .map { _ -> Action in
//                Task {
//                    await environment.layoutAPI.cancel()
//                }
//                return LevelEditActions.populationCancelled()
//            }
//            .eraseToAnyPublisher()
//    }
//    
//    let saveAfterSelectionEffect = Effect<AppEnvironment>.dispatchingOne { actions, environment in
//        actions
//            .wasCreated(from: LevelEditActions.selectCell)
//            .flatMap { _ -> AnyPublisher<Action, Never> in
//
//                @AppSelector(LevelEditSelectors.level) var level
//                guard let level else {
//                    return Just(LevelEditActions.saveLayoutFailure(payload: "Level not found"))
//                        .eraseToAnyPublisher()
//                }
//
//
//                return Future<Action, Never> { promise in
//                    Task {
//                        do {
//                            try await environment.layoutAPI.saveLevel(level: level)
//                            promise(.success(LevelEditActions.saveLayoutSuccess()))
//                        } catch {
//                            promise(.success(LevelEditActions.saveLayoutFailure(payload: error.localizedDescription)))
//                        }
//                    }
//                }
//                .eraseToAnyPublisher()
//            }
//            .eraseToAnyPublisher()
//    }
//    
//    var effects: [Effect<Environment>] {
//        [populateLevel, cancelPopulation]
//    }
}


    
  
