import Foundation
import Fluxor

//protocol ActionNamespace {
//    associatedtype ActionType
//    static func action<P>(_ id: String, payload: P.Type) -> ActionTemplate<P>
//}
//
//extension ActionNamespace {
//    static func action<P>(_ id: String, payload: P.Type = Void.self) -> ActionTemplate<P> {
//        let namespace = String(describing: Self.self)
//        let type = String(describing: ActionType.self)
//        return ActionTemplate(id: "\(namespace)/\(type)/\(id)", payloadType: payload)
//    }
//}



protocol ActionNamespace {
    associatedtype ActionType = Self  // Default to Self
    static func action<P>(_ id: String, payload: P.Type) -> ActionTemplate<P>
}

extension ActionNamespace {
    static func action<P>(_ id: String, payload: P.Type = Void.self) -> ActionTemplate<P> {
        let namespace = String(describing: Self.self)
        let type = String(describing: ActionType.self)
        return ActionTemplate(id: "\(namespace)/\(type)/\(id)", payloadType: payload)
    }
}
