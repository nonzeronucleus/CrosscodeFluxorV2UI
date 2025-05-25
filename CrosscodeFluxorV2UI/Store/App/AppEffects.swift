import Combine
import Fluxor
import Foundation
import Factory
import CrosscodeDataLibrary

class AppEffects: Effects {
    typealias Environment = AppEnvironment
    
//    let importLayouts = Effect<Environment>.dispatchingOne { actions, environment in
//        actions
//            .wasCreated(from: LayoutEditActions.selectLevel)
//            .flatMap { action -> AnyPublisher<Action, Never> in
//                Future<Action, Never> { promise in
//                    Task {
//                        do {
//                            let layout = action.payload
//                            promise(.success(NavigationActions.navigate(payload: .layoutDetail(id: layout.id))))
//                        }
//                    }
//                }
//                .eraseToAnyPublisher()
//            }
//            .eraseToAnyPublisher()
//    }
}
