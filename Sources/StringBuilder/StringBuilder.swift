// The Swift Programming Language
// https://docs.swift.org/swift-book
import Foundation   // only for StringProtocol conveniences


@resultBuilder
public enum StringBuilder {
    /// Collect every partial result and glue them together.
    public static func buildBlock(_ components: String...) -> String { components.joined() }

    /// Allow plain `String` expressions.
    public static func buildExpression(_ expression: String) -> String { expression }

    /// Gracefully ignore `nil` strings.
    public static func buildExpression(_ expression: String?) -> String { expression ?? "" }

    /// Support `if/else`.
    public static func buildEither(first component: String) -> String  { component }
    public static func buildEither(second component: String) -> String { component }

    /// Support `if let` / `switch`.
    public static func buildOptional(_ component: String?) -> String   { component ?? "" }

    /// Support `for` loops.
    public static func buildArray(_ components: [String]) -> String    { components.joined() }

    /// Support  if #available` loops.
    public static func buildLimitedAvailability(_ component: String) -> String { component }

    /// (Optional) hook that runs last.
    public static func buildFinalResult(_ component: String) -> String { component }
    
    /// Collect every partial result and glue them together.
    public static func buildBlock<T: StringBuildable>(_ components: T...) -> String { components.map(\.stringValue).joined() }

    /// Allow plain `String` expressions.
    public static func buildExpression<T: StringBuildable>(_ expression: T) -> String { expression.stringValue }

    /// Optional value
    public static func buildExpression<T: StringBuildable>(_ expression: T?) -> String { expression?.stringValue ?? "" }

    /// Support `if/else`.
    public static func buildEither<T: StringBuildable>(first component: T) -> String  { component.stringValue }
    public static func buildEither<T: StringBuildable>(second component: T) -> String { component.stringValue }

    /// Support `if let` / `switch`.
    public static func buildOptional<T: StringBuildable>(_ component: T?) -> String   { component?.stringValue ?? "" }

    /// Support `for` loops.
    public static func buildArray<T: StringBuildable>(_ components: [T]) -> String { components.map(\.stringValue).joined() }

    /// Support  if #available` loops.
    public static func buildLimitedAvailability<T: StringBuildable>(_ component: T) -> String { component.stringValue }

    /// (Optional) hook that runs last.
    public static func buildFinalResult<T: StringBuildable>(_ component: T) -> String { component.stringValue }

}

public func buildString(@StringBuilder builder: () -> String) -> String {
    builder()
}

public protocol StringBuildable {
    /// Conforming types implement this just like `body` in `View`.
    @StringBuilder var stringValue: String { get }
}
