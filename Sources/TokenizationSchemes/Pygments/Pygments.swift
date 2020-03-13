import Highlighter
import SwiftSyntax

public enum Pygments: TokenizationScheme {
    public static func tokens(for syntax: Syntax) -> [Token] {
        return tokens(for: syntax.leadingTrivia) +
                syntax.tokens.map { token(for: $0) } +
                tokens(for: syntax.trailingTrivia)
    }

    static func token(for token: TokenSyntax) -> Token {
        switch token.tokenClassification.kind {
        case .attribute:
            return Token(token.text, kind: Keyword.Declaration.self)
        case .buildConfigId:
            return Token(token.text, kind: Comment.Preprocessor.self)
        case .dollarIdentifier:
            return Token(token.text, kind: Name.Variable.self)
        case .editorPlaceholder:
            return Token(token.text, kind: Other.self)
        case .floatingLiteral:
            return Token(token.text, kind: Literal.Number.FloatingPoint.self)
        case .identifier:
            return Token(token.text, kind: Name.self)
        case .integerLiteral:
            return Token(token.text, kind: Literal.Number.Integer.self)
        case .keyword:
            return Token(token.text, kind: Keyword.self)
        case .objectLiteral:
            return Token(token.text, kind: Literal.self)
        case .poundDirectiveKeyword:
            return Token(token.text, kind: Keyword.Pseudo.self)
        case .stringInterpolationAnchor:
            return Token(token.text, kind: Literal.String.Interpolated.self)
        case .stringLiteral:
            return Token(token.text, kind: Literal.String.self)
        case .typeIdentifier:
            return Token(token.text, kind: Keyword.TypeIdentifier.self)
        default:
            return Token(token.text, kind: Text.self)
        }
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
                 .docLineComment(let text):
                return Token(text, kind: Comment.SingleLine.self)
            case .blockComment(let text),
                 .docBlockComment(let text):
                return Token(text, kind: Comment.MultiLine.self)
            case .garbageText:
                return nil
            }
        }
    }
}

public protocol PygmentsTokenKind: Highlighter.TokenKind where Scheme == Pygments {}
