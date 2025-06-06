import Combine
import CrosscodeDataLibrary
import Fluxor
import Foundation




class LayoutEditEffects: Effects {
    typealias Environment = AppEnvironment
    
    let loadLayout = Effect<Environment>.dispatchingMultiple { actions, environment in
        actions
            .wasCreated(from: LayoutEditActions.Load.start)
            .flatMap { action in
                Future<[Action], Never> { promise in
                    Task {
                        do {
                            let levelId = action.payload
                            let result = try await environment.layoutsAPI.fetchLevel(id: levelId)
                            
                            if let result {
                                promise(.success([
                                    LayoutEditActions.Load.success (
                                        payload: result as! LevelLayout
                                    )]))
                            }
                            else {
                                throw(SimpleError("Could not load layout"))
                            }
                        }
                        catch {
                            promise(.success([
                                LayoutEditActions.Load.failure(payload: error)
                            ]))

                        }
                    }
                }
                .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
    
    
    let populateLevel = Effect<Environment>.dispatchingMultiple { actions, environment in
        actions
            .wasCreated(from: LayoutEditActions.Populate.start)
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
                                    LayoutEditActions.Populate.success(
                                        payload: (crossword: Crossword(initString: result.0),letterMap: CharacterIntMap(from: result.1))
                                    )
                                ]))
                            }
                        } catch {
                            if !Task.isCancelled {
                                promise(.success([
                                    LayoutEditActions.Populate.failure(
                                        payload: error)
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
            .wasCreated(from: LayoutEditActions.Depopulate.start)
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
                                    LayoutEditActions.Depopulate.success(
                                        payload: (crossword: Crossword(initString: result.0),letterMap: nil)
                                    )
                                ]))
                            }
                        } catch {
                            if !Task.isCancelled {
                                promise(.success([
                                    LayoutEditActions.Populate.failure(
                                        payload: error)
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
            .wasCreated(from: LayoutEditActions.CancelPopulation.start)
            .map { _ -> Action in
                Task {
                    await environment.layoutsAPI.cancel()
                }
                return LayoutEditActions.CancelPopulation.success()
            }
            .eraseToAnyPublisher()
    }
    
    let saveAfterSelectionEffect = Effect<AppEnvironment>.dispatchingOne { actions, environment in
        actions
            .wasCreated(from: LayoutEditActions.Cell.select)
            .flatMap { _ -> AnyPublisher<Action, Never> in

                @StateSelector(LayoutEditSelectors.level) var level
                guard let level else {
                    return Just(LayoutEditActions.SaveLayout.failure(payload: SimpleError("Level not found")))
                        .eraseToAnyPublisher()
                }


                return Future<Action, Never> { promise in
                    Task {
                        do {
                            try await environment.layoutsAPI.saveLevel(level: level)
                            promise(.success(LayoutEditActions.SaveLayout.success()))
                        } catch {
                            promise(.success(LayoutEditActions.SaveLayout.failure(payload: SimpleError(error.localizedDescription))))
                        }
                    }
                }
                .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
    
    
    let exportPopulatedLevel = Effect<Environment>.dispatchingMultiple { actions, environment in
        actions
            .wasCreated(from: LayoutEditActions.ExportPopulatedLevel.start)
            .flatMap { action in
                Future<[Action], Never> { promise in
                    Task {
                        do {
                            let populatedLevel = action.payload
                            let api = environment.playableLevelsAPI
                            try await api.addNewLevel(layout: populatedLevel)
                        } catch {
                            promise(.success([
                                LayoutEditActions.ExportPopulatedLevel.failure(
                                    payload: error)
                            ]))
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
}


    
  
