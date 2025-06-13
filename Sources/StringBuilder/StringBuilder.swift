// The Swift Programming Language
// https://docs.swift.org/swift-book
import Foundation   // only for StringProtocol conveniences

// MARK: - 1. Core protocol

/// Anything that can be reduced to a plain `String`
public protocol StringBuildable {
    var stringValue: String { get }
}

extension String: StringBuildable { public var stringValue: String { self } }

// MARK: - 2. Result-builder

@resultBuilder
public enum StringBuilder {

    // 2.1  transform every sub-expression
    public static func buildExpression(_ expression: StringBuildable) -> String {
        expression.stringValue
    }

    // 2.2  concatenate a series of items
    public static func buildBlock(_ components: StringBuildable...) -> String {
        components.map(\.stringValue).joined()
    }

    // 2.3  handle `if/else`
    public static func buildEither(first component: StringBuildable)  -> String { component.stringValue }
    public static func buildEither(second component: StringBuildable) -> String { component.stringValue }

    // 2.4  handle `if` with no `else`
    public static func buildOptional(_ component: StringBuildable?) -> String { component?.stringValue ?? "" }

    // 2.5  handle `for-loop` results
    public static func buildArray(_ components: [StringBuildable]) -> String {
        components.map(\.stringValue).joined()
    }

    // 2.6  handle `#availability` blocks
    public static func buildLimitedAvailability(_ component: StringBuildable) -> String { component.stringValue }
}

// MARK: - 3. Example usage

struct Hello: StringBuildable {
    let nationality: String
    let name: String

    @StringBuilder
    var stringValue: String {
        if nationality == "american" {
            "Howdy"
        } else {
            "Hello"
        }

        " "    // ← a literal space

        name   // the actual name
    }
}

// MARK: - 4. Result

let msg = Hello(nationality: "american", name: "Liz").stringValue
print(msg)            // → "Howdy Liz"
