import Foundation
import Testing
import Fluxor

// MARK: - Base Action Protocol

//protocol Action {}

// Optional: Add an identifier for matching across types
protocol IdentifiableAction: Action {
    var id: String { get }
}

// Optional: Used to get payloads for comparison
protocol HasPayload {
    var payload: Any { get }
}

// MARK: - Action Comparison Logic

/// Compares arrays of Actions
func compareActions(
    _ actual: [Action],
    _ expected: [Action],
    file: StaticString = #file,
    line: UInt = #line
) -> Bool {
    guard actual.count == expected.count else {
//        Issue.record("Action count mismatch. Actual: \(actual.count), Expected: \(expected.count)", file: file, line: line)
        return false
    }

    for (actualAction, expectedAction) in zip(actual, expected) {
        if !compareAction(actualAction, expectedAction, file: file, line: line) {
            return false
        }
    }

    return true
}

/// Compares two Actions by ID and Payload
func compareAction(
    _ actual: Action,
    _ expected: Action,
    file: StaticString = #file,
    line: UInt = #line
) -> Bool {
    let actualType = type(of: actual)
    let expectedType = type(of: expected)

    guard actualType == expectedType else {
//        Issue.record("Type mismatch: \(actualType) vs \(expectedType)", file: file, line: line)
        return false
    }

    if let a = actual as? IdentifiableAction, let e = expected as? IdentifiableAction {
        if a.id != e.id {
//            Issue.record("ID mismatch: \(a.id) vs \(e.id)", file: file, line: line)
            return false
        }
    }

    let actualPayload = getPropertyValue(of: actual, propertyName: "payload")
    let expectedPayload = getPropertyValue(of: expected, propertyName: "payload")

    if "\(String(describing: actualPayload))" != "\(String(describing: expectedPayload))"  {
//        Issue.record("Payload mismatch: \(actualPayload ?? "nil") vs \(expectedPayload ?? "nil")", file: file, line: line)
        return false
    }

    return true
}


func getPropertyValue<T>(of object: T, propertyName: String) -> Any? {
    let mirror = Mirror(reflecting: object)
    for child in mirror.children {
        if let label = child.label, label == propertyName {
            return child.value
        }
    }
    return nil // Property not found
}

/// Safely gets a string description of an Action's payload
func getPayloadDescription(action: Any) -> String? {
    guard let hasPayload = action as? HasPayload else {
        return nil
    }
    return String(describing: hasPayload.payload)
}
