import Combine
import Fluxor
import Foundation
import Factory
import CrosscodeDataLibrary

class LevelListEffects<L: Level>: Effects {
    typealias Environment = AppEnvironment
    
//    let importLevels = Effect<Environment>.dispatchingOne { actions, environment in
//        actions
//            .wasCreated(from: LevelListActions.Import.start)
//            .flatMap { _ -> AnyPublisher<Action, Never> in
//                Future<Action, Never> { promise in
//                    Task {
//                        do {
//                            try await L.api.importLevels()
//                            promise(.success(LevelListActions.Import.success()))
//                        } catch {
//                            promise(.success(LevelListActions.Import.failure(payload: error)))
//                        }
//                    }
//                }
//                .eraseToAnyPublisher()
//            }
//            .eraseToAnyPublisher()
//    }
//    
//    
//    let importedLevels = Effect<Environment>.dispatchingOne { actions, environment in
//        actions
//            .wasCreated(from: LevelListActions.Import.success)
//            .flatMap { _ -> AnyPublisher<Action, Never> in
//                Future<Action, Never> { promise in
//                    Task {
//                        promise(.success(LevelListActions.FetchAll.start()))
//                    }
//                }
//                .eraseToAnyPublisher()
//            }
//            .eraseToAnyPublisher()
//    }
    
    
    let createNewLayout = Effect<Environment>.dispatchingOne { actions, environment in
        actions
            .wasCreated(from: LevelListActions<L>.Create.start)
            .flatMap { _ -> AnyPublisher<Action, Never> in
                Future<Action, Never> { promise in
                    Task {
                        do {
//                            let levels = try await L.api.fetchAllLevels() as! [L]
                            let levels = try await L.api.addNewLevel() as! [L]

                            promise(.success(LevelListActions<L>.Create.success(payload: levels)))
                        } catch {
                            promise(.success(LevelListActions<L>.Create.failure(payload: error)))
                        }
                    }
                }
                .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }


    let fetchLevels = Effect<Environment>.dispatchingOne { actions, environment in
        Publishers.Merge(
            actions.wasCreated(from: LevelListActions<L>.FetchAll.start),
            actions.wasCreated(from: NavigationActions.dismissPresentedRoute)
        )
        .flatMap { _ -> AnyPublisher<Action, Never> in
                Future<Action, Never> { promise in
                    Task {
                        do {
                            let levels = try await L.api.fetchAllLevels()
                            
                            guard let levels = levels as? [L] else {
                                fatalError("Could not convert \(levels) to [L]")
                            }
                            
//                            let levels = try await environment.layoutsAPI.fetchAllLevels()
//                            let levels = try await L.api.fetchAllLevels() as? [L] ?? []
                            
//                            promise(.success(LevelListActions.FetchAll.success(payload: levels)))
                            promise(.success(LevelListActions<L>.FetchAll.success(payload: levels)))
                        } catch {
                            promise(.success(LevelListActions<L>.FetchAll.failure(payload: error)))
//                            promise(.success(LevelListActions.FetchAll.failure(payload: error)))
                        }
                    }
                }
                .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
    
//    let deleteLayout = Effect<Environment>.dispatchingOne { actions, environment in
//        actions
//            .wasCreated(from: LevelListActions.Delete.start)  // Match the delete action
//            .flatMap { action -> AnyPublisher<Action, Never> in
//                // Extract the layout ID from the action payload
//                let layoutID = action.payload
//                
//                return Future<Action, Never> { promise in
//                    Task {
//                        do {
//                            // 1. Attempt deletion in service layer
////                            let levels = try await environment.layoutsAPI.deleteLevel(id: layoutID)
//                            let levels = try await L.api.deleteLevel(id: layoutID)
//                            // 2. On success, confirm deletion
//                            promise(.success(LevelListActions.Delete.success(payload: levels)))
////                            promise(.success(LevelListActions.fetchLevels()))
//                            
//                            // Optional: Refresh the list after deletion
////                            promise(.success(LevelListActions.fetchLevels))
//                        } catch {
//                            // 3. Handle failure
//                            promise(.success(LevelListActions.Delete.failure(
//                                payload: error
//                            )))
//                        }
//                    }
//                }
//                .eraseToAnyPublisher()
//            }
//            .eraseToAnyPublisher()
//    }
}
