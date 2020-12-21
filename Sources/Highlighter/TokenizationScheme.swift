import SwiftSyntax

/// A type that provides tokens for a highlighter syntax.
public protocol TokenizationScheme {

    /// Returns the highlighted tokens for a SwiftSyntax node.
    /// - Parameter syntax: The syntax node to be highlighted.
    /// - Returns: An array of highlighted tokens.
    static func tokens(for syntax: Syntax) -> [Token]
}
