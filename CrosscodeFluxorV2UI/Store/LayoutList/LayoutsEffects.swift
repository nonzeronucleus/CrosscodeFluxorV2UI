import Combine
import Fluxor
import Foundation
import Factory
import CrosscodeDataLibrary


typealias BaseLayoutsEffects = LevelListEffects<LevelLayout>

class LayoutsEffects: Effects {
    typealias Environment = AppEnvironment

    let createNewLayout = Effect<Environment>.dispatchingOne { actions, environment in
        actions
            .wasCreated(from: LayoutsActions.CreateLayout.start)
            .flatMap { _ -> AnyPublisher<Action, Never> in
                Future<Action, Never> { promise in
                    Task {
                        do {
                            let api = environment.layoutsAPI
                            
                            let levels = try await api.addNewLayout()
                            
                            promise(.success(LayoutsActions.CreateLayout.success(payload: levels)))
                        } catch {
                            promise(.success(LayoutsActions.CreateLayout.failure(payload: error)))
                        }
                    }
                }
                .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}


