import Combine
import Fluxor
import Foundation
import Factory
import CrosscodeDataLibrary

class LevelListEffects<L: Level>: Effects {
    typealias Environment = AppEnvironment
    
    let importLevels = Effect<Environment>.dispatchingOne { actions, environment in
        actions
            .wasCreated(from: LevelListActions<L>.Import.start)
            .flatMap { _ -> AnyPublisher<Action, Never> in
                Future<Action, Never> { promise in
                    Task {
                        do {
//                            try await L.getApi().importLevels()
                            let api = environment.apis[L.getApi()]
                            try await api?.importLevels()
                            promise(.success(LevelListActions<L>.Import.success()))
                        } catch {
                            promise(.success(LevelListActions<L>.Import.failure(payload: error)))
                        }
                    }
                }
                .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
    
    
    let importedLevelsSuccess = Effect<Environment>.dispatchingOne { actions, environment in
        actions
            .wasCreated(from: LevelListActions<L>.Import.success)
            .flatMap { _ -> AnyPublisher<Action, Never> in
                Future<Action, Never> { promise in
                    Task {
                        promise(.success(LevelListActions<L>.FetchAll.start()))
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
                            let api = environment.apis[L.getApi()]

                            let levels = try await api?.fetchAllLevels()

                            guard let levels = levels as? [L] else {
                                fatalError("Could not convert \(String(describing: levels)) to [L]")
                            }
                            promise(.success(LevelListActions<L>.FetchAll.success(payload: levels)))
                        } catch {
                            promise(.success(LevelListActions<L>.FetchAll.failure(payload: error)))
                        }
                    }
                }
                .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
    
    let deleteLayout = Effect<Environment>.dispatchingOne { actions, environment in
        actions
            .wasCreated(from: LevelListActions<L>.Delete.start)  // Match the delete action
            .flatMap { action -> AnyPublisher<Action, Never> in
                // Extract the layout ID from the action payload
                let layoutID = action.payload
                
                return Future<Action, Never> { promise in
                    Task {
                        do {
//                            let levels = try await L.getApi().deleteLevel(id: layoutID) as! [L]
                            let api = environment.apis[L.getApi()]
                            let levels = try await api?.deleteLevel(id: layoutID) as! [L]
                            promise(.success(LevelListActions<L>.Delete.success(payload: levels)))
                        } catch {
                            promise(.success(LevelListActions<L>.Delete.failure(
                                payload: error
                            )))
                        }
                    }
                }
                .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}
