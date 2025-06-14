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
}

public func buildString(@StringBuilder builder: () -> String) -> String {
    builder()
}

public protocol StringBuildable {
    /// Conforming types implement this just like `body` in `View`.
    @StringBuilder var stringValue: String { get }
}
