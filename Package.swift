// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftSyntaxHighlighter",
    products: [
        .library(
            name: "SwiftSyntaxHighlighter",
            targets: ["SwiftSyntaxHighlighter", "Pygments"]),
        .executable(name: "swift-highlight",
                    targets: ["swift-highlight"])
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-syntax.git", .revision("swift-5.2-DEVELOPMENT-SNAPSHOT-2020-03-09-a")),
        .package(url: "https://github.com/IBM-Swift/swift-html-entities.git", .upToNextMajor(from: "3.0.0"))
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(name: "Highlighter",
                dependencies: ["SwiftSyntax", "HTMLEntities"]),
        .target(name: "Pygments",
                dependencies: ["Highlighter"],
                path: "Sources/TokenizationSchemes/Pygments"),
        .target(
            name: "swift-highlight",
            dependencies: ["SwiftSyntaxHighlighter"]),
        .target(
            name: "SwiftSyntaxHighlighter",
            dependencies: ["SwiftSyntax", "Highlighter"]),
        .testTarget(
            name: "SwiftSyntaxHighlighterTests",
            dependencies: ["SwiftSyntaxHighlighter", "Pygments"]),
    ]
)

