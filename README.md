# string-builder
Swift @ViewBuilder but for Strings

StringBuilder 🧱

A lightweight Swift @resultBuilder that lets you assemble a String with the same declarative style as SwiftUI’s @ViewBuilder.

Motivation

Writing multi‑line, conditional strings in Swift often devolves into + concatenations or String(format:) spaghetti. StringBuilder replaces that with a tiny, type‑safe DSL that is:
	•	Expressive – write strings almost exactly like SwiftUI views.
	•	Safe – fully checked at compile time.
	•	Fast – concatenates in a single pass with joined().

Requirements
	•	Swift 5.4 or later
	•	iOS 14+ / macOS 11+ / tvOS 14+ / watchOS 7+

Installation

Swift Package Manager

dependencies: [
    .package(url: "https://github.com/your‑org/StringBuilder.git", from: "1.0.0")
]

Then import StringBuilder wherever you want to use it.

Quick start

struct Hello: StringBuildable {
    let nationality: String
    let name: String

    @StringBuilder var stringValue: String {
        if nationality == "american" {
            "Howdy"
        } else {
            "Hello"
        }

        " "      // literal space
        name
    }
}

print(Hello(nationality: "american", name: "Liz
