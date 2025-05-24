import Combine
import Fluxor
import Foundation
import Factory
import CrosscodeDataLibrary

class LayoutsEffects: Effects {
    typealias Environment = AppEnvironment
    
    let importLayouts = Effect<Environment>.dispatchingOne { actions, environment in
        actions
            .wasCreated(from: LayoutsActions.importLayouts)
            .flatMap { _ -> AnyPublisher<Action, Never> in
                Future<Action, Never> { promise in
                    Task {
                        do {
                            try await environment.layoutsAPI.importLayouts()
                            promise(.success(LayoutsActions.didImportLayouts()))
                        } catch {
                            promise(.success(LayoutsActions.didFailImportingLayouts(payload: error.localizedDescription)))
                        }
                    }
                }
                .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
    
    
    let importedLayouts = Effect<Environment>.dispatchingOne { actions, environment in
        actions
            .wasCreated(from: LayoutsActions.didImportLayouts)
            .flatMap { _ -> AnyPublisher<Action, Never> in
                Future<Action, Never> { promise in
                    Task {
                        promise(.success(LayoutsActions.fetchLayouts()))
                    }
                }
                .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
    
    
    let createNewLayout = Effect<Environment>.dispatchingOne { actions, environment in
        actions
            .wasCreated(from: LayoutsActions.createNewLayout)
            .flatMap { _ -> AnyPublisher<Action, Never> in
                Future<Action, Never> { promise in
                    Task {
                        do {
                            let layouts = try await environment.layoutsAPI.addNewLayout()
                            promise(.success(LayoutsActions.didCreateNewLayout(payload: layouts)))
                        } catch {
                            promise(.success(LayoutsActions.didFailFetchingLayouts(payload: error.localizedDescription)))
                        }
                    }
                }
                .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }


    let fetchLayouts = Effect<Environment>.dispatchingOne { actions, environment in
        Publishers.Merge(
            actions.wasCreated(from: LayoutsActions.fetchLayouts),
            actions.wasCreated(from: NavigationActions.dismiss)
        )
        .flatMap { _ -> AnyPublisher<Action, Never> in
                Future<Action, Never> { promise in
                    Task {
                        do {
                            let layouts = try await environment.layoutsAPI.fetchAllLayouts()
                            promise(.success(LayoutsActions.didFetchLayouts(payload: layouts)))
                        } catch {
                            promise(.success(LayoutsActions.didFailFetchingLayouts(payload: error.localizedDescription)))
                        }
                    }
                }
                .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
    
    let deleteLayout = Effect<Environment>.dispatchingOne { actions, environment in
        actions
            .wasCreated(from: LayoutsActions.deleteLayout)  // Match the delete action
            .flatMap { action -> AnyPublisher<Action, Never> in
                // Extract the layout ID from the action payload
                let layoutID = action.payload
                
                return Future<Action, Never> { promise in
                    Task {
                        do {
                            // 1. Attempt deletion in service layer
                            let layouts = try await environment.layoutsAPI.deleteLayout(id: layoutID)
                            // 2. On success, confirm deletion
                            promise(.success(LayoutsActions.didDeleteLayout(payload: layouts)))
//                            promise(.success(LayoutsActions.fetchLayouts()))
                            
                            // Optional: Refresh the list after deletion
//                            promise(.success(LayoutsActions.fetchLayouts))
                        } catch {
                            // 3. Handle failure
                            promise(.success(LayoutsActions.didFailDeletingLayout(
                                payload: (id: layoutID, error: error.localizedDescription)
                            )))
                        }
                    }
                }
                .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}
