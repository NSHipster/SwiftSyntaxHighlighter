import SwiftSyntax

public protocol TokenizationScheme {
    static func tokens(for syntax: Syntax) -> [Token]
}
