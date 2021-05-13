// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftSyntaxHighlighter",
    platforms: [
        .macOS(.v10_13)
    ],
    products: [
        .library(
            name: "SwiftSyntaxHighlighter",
            targets: ["SwiftSyntaxHighlighter"]),
        .executable(name: "swift-highlight",
                    targets: ["swift-highlight"])
    ],
    dependencies: [
        .package(name: "SwiftSyntax",
                 url: "https://github.com/apple/swift-syntax.git",
                 .revision("release/5.5")),
        .package(name: "swift-argument-parser",
                 url: "https://github.com/apple/swift-argument-parser.git",
                 .upToNextMinor(from: "0.3.2"))
    ],
    targets: [
        .target(name: "Highlighter",
                dependencies: ["SwiftSyntax"]),
        .target(name: "Pygments",
                dependencies: ["Highlighter"],
                path: "Sources/TokenizationSchemes/Pygments"),
        .target(name: "Xcode",
                dependencies: ["Highlighter"],
                path: "Sources/TokenizationSchemes/Xcode"),
        .target(
            name: "swift-highlight",
            dependencies: [
                "SwiftSyntaxHighlighter",
                .product(name: "ArgumentParser", package: "swift-argument-parser")
            ]),
        .target(
            name: "SwiftSyntaxHighlighter",
            dependencies: ["SwiftSyntax", "Highlighter", "Xcode", "Pygments"]),
        .testTarget(
            name: "SwiftSyntaxHighlighterTests",
            dependencies: ["SwiftSyntaxHighlighter"]),
    ]
)
