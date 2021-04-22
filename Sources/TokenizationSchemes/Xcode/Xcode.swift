import Highlighter
import SwiftSyntax

public enum Xcode: TokenizationScheme {
    /// Returns the highlighted tokens for a SwiftSyntax node.
    /// - Parameter syntax: The syntax node to be highlighted.
    /// - Returns: An array of highlighted tokens.
    public static func tokens(for syntax: Syntax) -> [Token] {
        return syntax.tokens.flatMap { tokens(for: $0) }
    }

    /// Returns the highlighted tokens for a `TokenSyntax` node.
    /// - Parameter tokenSyntax: The syntax node to be highlighted.
    /// - Returns: An array of highlighted tokens.
    static func tokens(for tokenSyntax: TokenSyntax) -> [Token] {
        var token: Token?

        switch tokenSyntax.tokenClassification.kind {
        case .keyword:
            token = Token(tokenSyntax.text, kind: Keyword.self)
        case .identifier:
            switch tokenSyntax.previousToken?.tokenKind {
                case .funcKeyword:
                    token = Token(tokenSyntax.text, kind: FunctionName.self)
                case .atSign:
                    token = Token(tokenSyntax.text, kind: Attribute.self)
                case .classKeyword,
                     .enumKeyword,
                     .structKeyword,
                     .protocolKeyword,
                     .isKeyword,
                     .asKeyword,
                     .colon:
                    token = Token(tokenSyntax.text, kind: TypeName.self)
                case .period,
                     .leftSquareBracket:
                    guard tokenSyntax.text.first?.isUppercase == true else { fallthrough }
                    token = Token(tokenSyntax.text, kind: TypeName.self)
                default:
                    token = Token(tokenSyntax.text, kind: Variable.self)
                }
        case .typeIdentifier:
            token = Token(tokenSyntax.text, kind: TypeName.self)
        case .dollarIdentifier:
            token = Token(tokenSyntax.text, kind: Variable.self)
        case .integerLiteral,
             .floatingLiteral:
            token = Token(tokenSyntax.text, kind: NumberLiteral.self)
        case .stringLiteral,
             .stringInterpolationAnchor:
            token = Token(tokenSyntax.text, kind: StringLiteral.self)
        case .poundDirectiveKeyword,
             .buildConfigId:
            token = Token(tokenSyntax.text, kind: Directive.self)
        case .attribute:
            token = Token(tokenSyntax.text, kind: Attribute.self)
        case .editorPlaceholder:
            token = Token(tokenSyntax.text, kind: Placeholder.self)
        case .lineComment,
             .blockComment:
            token = Token(tokenSyntax.text, kind: Comment.self)
        case .docLineComment,
             .docBlockComment:
            token = Token(tokenSyntax.text, kind: Documentation.self)
        default:
            break
        }

        return tokens(for: tokenSyntax.leadingTrivia) +
                [token ?? Token(tokenSyntax.text, kind: Text.self)] +
                tokens(for: tokenSyntax.trailingTrivia)
    }

    static func tokens(for trivia: Trivia?) -> [Token] {
        guard let trivia = trivia else { return [] }

        return trivia.compactMap { piece in
            switch piece {
            case .spaces(let count):
                return Token(String(repeating: " ", count: count), kind: Text.self)
            case .tabs(let count):
                return Token(String(repeating: "\t", count: count), kind: Text.self)
            case .verticalTabs(let count):
                return Token(String(repeating: "\u{11}", count: count), kind: Text.self)
            case .formfeeds(let count):
                return Token(String(repeating: "\u{12}", count: count), kind: Text.self)
            case .newlines(let count):
                return Token(String(repeating: "\n", count: count), kind: Text.self)
            case .carriageReturns(let count):
                return Token(String(repeating: "\r", count: count), kind: Text.self)
            case .carriageReturnLineFeeds(let count):
                return Token(String(repeating: "\r\n", count: count), kind: Text.self)
            case .lineComment(let text),
                 .blockComment(let text):
                return Token(text, kind: Comment.self)
            case .docLineComment(let text),
                 .docBlockComment(let text):
                return Token(text, kind: Documentation.self)
            case .garbageText:
                return nil
            }
        }
    }
}

public protocol XcodeTokenKind: Highlighter.TokenKind where Scheme == Xcode {}
