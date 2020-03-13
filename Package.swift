// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftSyntaxHighlighter",
    dependencies: [
        .package(url: "https://github.com/apple/swift-syntax.git", .revision("swift-5.2-DEVELOPMENT-SNAPSHOT-2020-03-09-a")),
        .package(url: "https://github.com/IBM-Swift/swift-html-entities.git", .upToNextMajor(from: "3.0.0"))
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "swift-syntax-highlight",
            dependencies: ["SwiftSyntaxHighlighter"]),
        .target(
            name: "SwiftSyntaxHighlighter",
            dependencies: ["SwiftSyntax", "HTMLEntities", "Pygments"]),
        .target(
            name: "Pygments",
            dependencies: []),
        .testTarget(
            name: "SwiftSyntaxHighlighterTests",
            dependencies: ["SwiftSyntaxHighlighter"]),
    ]
)

