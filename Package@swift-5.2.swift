// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftSyntaxHighlighter",
    products: [
        .library(
            name: "SwiftSyntaxHighlighter",
            targets: ["SwiftSyntaxHighlighter"]),
        .executable(name: "swift-highlight",
                    targets: ["swift-highlight"])
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-syntax.git", .revision("0.50200.0")),
        .package(url: "https://github.com/IBM-Swift/swift-html-entities.git", .upToNextMajor(from: "3.0.0")),
        .package(url: "https://github.com/apple/swift-argument-parser.git", .upToNextMinor(from: "0.0.4")),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(name: "Highlighter",
                dependencies: ["SwiftSyntax", "HTMLEntities"]),
        .target(name: "Pygments",
                dependencies: ["Highlighter"],
                path: "Sources/TokenizationSchemes/Pygments"),
        .target(name: "Xcode",
                dependencies: ["Highlighter"],
                path: "Sources/TokenizationSchemes/Xcode"),
        .target(
            name: "swift-highlight",
            dependencies: ["SwiftSyntaxHighlighter", "ArgumentParser"]),
        .target(
            name: "SwiftSyntaxHighlighter",
            dependencies: ["SwiftSyntax", "Highlighter", "Xcode", "Pygments"]),
        .testTarget(
            name: "SwiftSyntaxHighlighterTests",
            dependencies: ["SwiftSyntaxHighlighter"]),
    ]
)
