//
//  CompareActions.swift
//  CrosscodeFluxorV2UI
//
//  Created by Ian Plumb on 23/05/2025.
//


import Fluxor
import Testing

func compareActions(
    _ actual: [Action],
    _ expected: [Action],
    file: StaticString = #file,
    line: UInt = #line
) -> Bool {
    if actual.count != expected.count {
//        Issue.record(
//            "Actual count \(actual.count) does not match expected count \(expected.count) in \(file), line \(line)"
//        )
        return false
    }
    
    for (actualAction, expectedAction) in zip(actual, expected) {
        if !compareAction(actualAction, expectedAction, file: file, line: line) {
            return false
        }
    }
    return true
}

func compareAction(
    _ actual: any Action,
    _ expected: any Action,
    file: StaticString = #file,
    line: UInt = #line
) -> Bool {
    guard let actual = actual as? IdentifiableAction else {return false}
    guard let expected = expected as? IdentifiableAction else {return false}
    
    if actual.id != expected.id {
        Issue.record(
            "Actual id \(actual.id) did not nmatch expected \(expected.id)"
        )
    }
    
    
    let actualPayload = getPropertyValue(of: actual, propertyName: "payload") as? String
    let expectedPayload = getPropertyValue(of: actual, propertyName: "payload") as? String

    if actualPayload != expectedPayload {
        return false
//        Issue.record(
//            "Actual payload \(String(describing: actualPayload)) did not nmatch expected \(String(describing: expectedPayload))"
//        )
    }
    return true
}


func getPropertyValue(of object: Any, propertyName: String) -> Any? {
    let mirror = Mirror(reflecting: object)
    
    for child in mirror.children {
        if let label = child.label, label == propertyName {
            return child.value
        }
    }
    
    return nil
}
