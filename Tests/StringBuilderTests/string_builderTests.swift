import Testing
@testable import StringBuilder

private func build(@StringBuilder _ content: () -> String) -> String {
    content()
}

@Test func testBuildExpression() async throws {
    let result = StringBuilder.buildExpression("test")
    #expect(result) == "test"
}

@Test func testBuildBlock() async throws {
    let result = StringBuilder.buildBlock("a", "b", "c")
    #expect(result) == "abc"
}

@Test func testConditional() async throws {
    let first = StringBuilder.buildEither(first: "first")
    #expect(first) == "first"
    let second = StringBuilder.buildEither(second: "second")
    #expect(second) == "second"
}

@Test func testOptional() async throws {
    #expect(StringBuilder.buildOptional(nil)) == ""
    #expect(StringBuilder.buildOptional("opt")) == "opt"
}

@Test func testArray() async throws {
    let result = StringBuilder.buildArray(["x", "y", "z"])
    #expect(result) == "xyz"
}

@Test func testLimitedAvailability() async throws {
    let result = StringBuilder.buildLimitedAvailability("avail")
    #expect(result) == "avail"
}

@Test func testResultBuilderSyntax() async throws {
    #expect(build {
        "Hello"
        if true {
            " "
            "World"
        }
    }) == "Hello World"
}
