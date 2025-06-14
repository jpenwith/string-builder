# StringBuilder

A Swift ResultBuilder for easily composing `String` values (and any types conforming to `StringBuildable`) in a declarative, DSL-style.

## Features

- Concatenate literal `String` and optional `String` expressions
- Conditional blocks (`if`/`else`)
- Arrays of strings
- Custom types via the `StringBuildable` protocol
- Nested builders
- Final result transformation

## Installation

Add to your `Package.swift`:

```swift
dependencies: [
  .package(url: "https://github.com/your-username/string-builder.git", from: "1.0.0"),
],
targets: [
  .target(name: "YourTarget", dependencies: ["StringBuilder"]),
]
```
                            
#Usage
                            
##Basic string concatenation
```swift
import StringBuilder

let greeting = buildString {
  "Hello, "
  "world!"
}
// greeting == "Hello, world!"
```

##Conditionals
```swift
let isMorning = true
let salutation = buildString {
  if isMorning {
    "Good morning"
  } else {
    "Good evening"
  }
}
// salutation == "Good morning"
```

##Arrays
```swift
let parts = ["red", "green", "blue"]
let combined = StringBuilder.buildArray(parts)
// combined == "redgreenblue"
```

##Custom StringBuildable types
Conform your type by implementing a `@StringBuilder var stringValue: String`:
```swift
struct Person: StringBuildable {
  let name: String

  @StringBuilder
  var stringValue: String {
    "Name: "
    name
  }
}

let p = Person(name: "Alice")
let description = StringBuilder.buildExpression(p)
// description == "Name: Alice"
```
##Nested builders
```swift
struct Weather: StringBuildable {
  let desc: String

  @StringBuilder
  var stringValue: String {
    "Weather: "
    desc
  }
}

struct Report: StringBuildable {
  let person: Person
  let weather: Weather

  @StringBuilder
  var stringValue: String {
    person
    ", "
    weather
  }
}

let report = buildString { Report(person: p, weather: Weather(desc: "sunny")) }
// report == "Name: Alice, Weather: sunny"
```
