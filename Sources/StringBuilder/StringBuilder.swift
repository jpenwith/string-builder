// The Swift Programming Language
// https://docs.swift.org/swift-book
import Foundation   // only for StringProtocol conveniences

// MARK: - 1. Core protocol

/// Anything that can be reduced to a plain `String`
public protocol StringBuildable {
    @StringBuilder
    var stringValue: String { get }
}

extension String: StringBuildable {
    public var stringValue: String { self }
}

// MARK: - 2. Result-builder

@resultBuilder
public enum StringBuilder {

    // 2.1a transform plain String literals directly
    public static func buildExpression(_ expression: String) -> String {
        expression
    }

    // 2.1  transform every other StringBuildable
    public static func buildExpression(_ expression: StringBuildable) -> String {
        if let str = expression as? String {
            return str
        }
        return expression.stringValue
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
