import Testing
@testable import StringBuilder

private func build(@StringBuilder _ content: () -> String) -> String {
    content()
}

@Test func testBuildExpression() async throws {
    let result = StringBuilder.buildExpression("test")
    #expect(result == "test")
}

@Test func testBuildBlock() async throws {
    let result = StringBuilder.buildBlock("a", "b", "c")
    #expect(result == "abc")
}

@Test func testConditional() async throws {
    let first = StringBuilder.buildEither(first: "first")
    #expect(first == "first")
    let second = StringBuilder.buildEither(second: "second")
    #expect(second == "second")
}

@Test func testOptional() async throws {
    #expect(StringBuilder.buildOptional(nil) == "")
    #expect(StringBuilder.buildOptional("opt") == "opt")
}

@Test func testArray() async throws {
    let result = StringBuilder.buildArray(["x", "y", "z"])
    #expect(result == "xyz")
}

@Test func testLimitedAvailability() async throws {
    let result = StringBuilder.buildLimitedAvailability("avail")
    #expect(result == "avail")
}

@Test func testResultBuilderSyntax() async throws {
    #expect(build {
        "Hello"
        if true {
            " "
            "World"
        }
    } == "Hello World")
}

@Test func testBasicStringBuildable() async throws {
    struct Greeting: StringBuildable {
        let name: String
        let sex: Sex
        let nationality: Nationality

        enum Sex {
            case male
            case female
        }

        enum Nationality {
            case american
            case british
            case australian
            case french
        }

        var stringValue: String {
            switch nationality {
                case .american:
                    "Howdy"
                case .british:
                    "Alright"
                case .australian:
                    "G'day"
                case .french:
                    "Bonjour"
            }
            
            " "
            
            if sex == .male {
                "Mr."
            }
            else if sex == .female {
                "Mrs."
            }
            
            " "
            
            name
        }
    }
    
    let greeting1 = Greeting(name: "John", sex: .male, nationality: .american)
    let greeting2 = Greeting(name: "Sally", sex: .female, nationality: .british)
    let greeting3 = Greeting(name: "Bogan", sex: .male, nationality: .australian)
    let greeting4 = Greeting(name: "Gisette", sex: .female, nationality: .french)
    
    #expect(greeting1.stringValue == "Howdy Mr. John")
    #expect(greeting2.stringValue == "Alright Mrs. Sally")
    #expect(greeting3.stringValue == "G'day Mr. Bogan")
    #expect(greeting4.stringValue == "Bonjour Mrs. Gisette")
}

@Test func testCompoundStringBuildable() async throws {
    struct Greeting: StringBuildable {
        let name: String
        let weather: Weather

        struct Weather: StringBuildable {
            let description: String
            
            var stringValue: String {
                "looks like it's "
                description
                " today!"
            }
        }

        var stringValue: String {
            "Hello"
            
            " "
            
            name
            
            ", "
            
            weather
        }
    }
    
    let greeting1 = Greeting(name: "John", weather: .init(description: "sunny"))
    let greeting2 = Greeting(name: "Sally", weather: .init(description: "wet"))
    
    #expect(greeting1.stringValue == "Hello John, looks like it's sunny today!")
    #expect(greeting2.stringValue == "Hello Sally, looks like it's wet today!")
}

@Test func testBuildString() {
    let result = buildString {
        "How"
        "are"
        "you"
        "?"
    }
    
    #expect(result == "Howareyou?")
}

@Test func testExpressionWithStringBuildable() async throws {
    struct X: StringBuildable { let v: String; @StringBuilder var stringValue: String { v + "!" } }
    let x = X(v: "Hi")
    #expect(StringBuilder.buildExpression(x) == "Hi!")
}

@Test func testOptionalStringBuildableExpression() async throws {
    struct Y: StringBuildable { let v: String; @StringBuilder var stringValue: String { v + "?" } }
    let y: Y? = nil
    #expect(StringBuilder.buildExpression(y) == "")
    let y2: Y? = Y(v: "Yo")
    #expect(StringBuilder.buildExpression(y2) == "Yo?")
}

@Test func testArrayOfStringBuildable() async throws {
    struct Z: StringBuildable { let v: String; @StringBuilder var stringValue: String { v } }
    let arr: [Z] = [Z(v: "A"), Z(v: "B"), Z(v: "C")]
    #expect(StringBuilder.buildArray(arr) == "ABC")
}

@Test func testNestedStringBuildableInBuilder() {
    struct Inner: StringBuildable { let i: Int; @StringBuilder var stringValue: String { "inner:\(i)" } }
    struct Outer: StringBuildable { let o: String; let inner: Inner; @StringBuilder var stringValue: String { o; ": "; inner } }
    let result = buildString { Outer(o: "out", inner: Inner(i: 7)) }
    #expect(result == "out: inner:7")
}
