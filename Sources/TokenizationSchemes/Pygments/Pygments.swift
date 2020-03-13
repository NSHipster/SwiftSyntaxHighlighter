import Highlighter
import SwiftSyntax

public enum Pygments: TokenizationScheme {
    public static func tokens(for syntax: Syntax) -> [Token] {
        return syntax.tokens.flatMap { tokens(for: $0) }
    }
    
    static func tokens(for tokenSyntax: TokenSyntax) -> [Token] {
        var token: Token?

        switch tokenSyntax.tokenKind {
        case .integerLiteral(let string):
            if string.hasPrefix("0b") {
                token = Token(string, kind: Literal.Number.Binary.self)
            } else if string.hasPrefix("0o") {
                token = Token(string, kind: Literal.Number.Octal.self)
            } else if string.hasPrefix("0x") {
                token = Token(string, kind: Literal.Number.Hexadecimal.self)
            } else {
                token = Token(string, kind: Literal.Number.Integer.self)
            }
        case .floatingLiteral(let string):
            token = Token(string, kind: Literal.Number.FloatingPoint.self)
        case let .spacedBinaryOperator(string),
             let .unspacedBinaryOperator(string),
             let .postfixOperator(string),
             let .prefixOperator(string):
            token = Token(string, kind: Operator.self)
        case .stringLiteral(let string),
             .stringSegment(let string):
            token = Token(string, kind: Literal.String.DoubleQuoted.self)
        case .stringInterpolationAnchor:
            token = Token(tokenSyntax.text, kind: Literal.String.Interpolated.self)
        case .rawStringDelimiter(let string):
            token = Token(string, kind: Literal.String.Interpolated.self)
        case .atSign:
            token = Token(tokenSyntax.text, kind: Name.Attribute.self)
        case .selfKeyword, .superKeyword:
            token = Token(tokenSyntax.text, kind: Keyword.Pseudo.self)
        case .anyKeyword:
            token = Token(tokenSyntax.text, kind: Keyword.Reserved.self)
        case .breakKeyword,
             .caseKeyword,
             .continueKeyword,
             .defaultKeyword,
             .doKeyword,
             .elseKeyword,
             .fallthroughKeyword,
             .ifKeyword,
             .inKeyword,
             .forKeyword,
             .returnKeyword,
             .yield,
             .switchKeyword,
             .whereKeyword,
             .whileKeyword,
             .tryKeyword,
             .catchKeyword,
             .throwKeyword,
             .guardKeyword,
             .deferKeyword,
             .repeatKeyword,
             .asKeyword,
             .isKeyword,
             .capitalSelfKeyword,
             .__dso_handle__Keyword,
             .__column__Keyword,
             .__file__Keyword,
             .__function__Keyword,
             .__line__Keyword,
             .inoutKeyword,
             .operatorKeyword,
             .throwsKeyword,
             .rethrowsKeyword,
             .precedencegroupKeyword:
            token = Token(tokenSyntax.text, kind: Keyword.self)
        case .classKeyword,
             .deinitKeyword,
             .enumKeyword,
             .extensionKeyword,
             .funcKeyword,
             .importKeyword,
             .initKeyword,
             .internalKeyword,
             .letKeyword,
             .privateKeyword,
             .protocolKeyword,
             .publicKeyword,
             .staticKeyword,
             .structKeyword,
             .subscriptKeyword,
             .typealiasKeyword,
             .varKeyword,
             .associatedtypeKeyword,
             .fileprivateKeyword:
            token = Token(tokenSyntax.text, kind: Keyword.Declaration.self)
        case .trueKeyword, .falseKeyword, .nilKeyword:
            token = Token(tokenSyntax.text, kind: Keyword.Constant.self)
        case .poundEndifKeyword,
             .poundElseKeyword,
             .poundElseifKeyword,
             .poundIfKeyword,
             .poundSourceLocationKeyword,
             .poundFileKeyword,
             .poundLineKeyword,
             .poundColumnKeyword,
             .poundDsohandleKeyword,
             .poundFunctionKeyword,
             .poundSelectorKeyword,
             .poundKeyPathKeyword,
             .poundColorLiteralKeyword,
             .poundFileLiteralKeyword,
             .poundImageLiteralKeyword,
             .poundFilePathKeyword,
             .poundAssertKeyword,
             .poundWarningKeyword,
             .poundErrorKeyword,
             .poundAvailableKeyword:
            token = Token(tokenSyntax.text, kind: Comment.Preprocessor.self)
        case .contextualKeyword(let string):
            token = Token(string, kind: Keyword.Pseudo.self)
        case .equal, .arrow, .comma, .period, .colon, .semicolon, .ellipsis,
             .exclamationMark,
             .stringQuote, .singleQuote, .multilineStringQuote, .backslash,
             .pound,
             .wildcardKeyword,
             .prefixAmpersand,
             .prefixPeriod,
             .infixQuestionMark,
             .postfixQuestionMark,
             .backtick,
             .leftAngle, .rightAngle,
             .leftBrace, .rightBrace,
             .leftParen, .rightParen,
             .leftSquareBracket, .rightSquareBracket:
            token = Token(tokenSyntax.text, kind: Punctuation.self)
        case .identifier(let identifier):
            switch identifier {
            case "override":
                token = Token(tokenSyntax.text, kind: Keyword.Declaration.self)
            default:
                token = Token(tokenSyntax.text, kind: Name.self)
            }
        case .dollarIdentifier(let identifier):
            token = Token(identifier, kind: Name.PseudoBuiltin.self)
        case .unknown(let string):
            token = Token(string, kind: Other.self)
        case .eof:
            break
        }

        if tokenSyntax.tokenClassification.kind == .typeIdentifier,
            let previousTokenKind = tokenSyntax.previousToken?.tokenKind
        {
            switch previousTokenKind {
            case .importKeyword:
                token = Token(tokenSyntax.text, kind: Name.Namespace.self)
            case .classKeyword,
                 .enumKeyword,
                 .structKeyword,
                 .protocolKeyword,
                 .isKeyword,
                 .asKeyword,
                 .period,
                 .colon,
                 .leftSquareBracket
                where tokenSyntax.text == tokenSyntax.text.capitalized:
                token = Token(tokenSyntax.text, kind: Name.Class.self)
            case .funcKeyword:
                token = Token(tokenSyntax.text, kind: Name.Function.self)
            case .atSign:
                token = Token(tokenSyntax.text, kind: Name.Attribute.self)
            default:
                break
            }
        }

        return tokens(for: tokenSyntax.leadingTrivia) +
                [token].compactMap { $0 } +
                tokens(for: tokenSyntax.trailingTrivia)
    }

    static func tokens(for trivia: Trivia?) -> [Token] {
        guard let trivia = trivia else { return [] }

        return trivia.compactMap { piece in
            switch piece {
            case .spaces(let count):
                return Token(String(repeating: " ", count: count), kind: Text.Whitespace.self)
            case .tabs(let count):
                return Token(String(repeating: "\t", count: count), kind: Text.Whitespace.self)
            case .verticalTabs(let count):
                return Token(String(repeating: "\u{11}", count: count), kind: Text.Whitespace.self)
            case .formfeeds(let count):
                return Token(String(repeating: "\u{12}", count: count), kind: Text.Whitespace.self)
            case .newlines(let count):
                return Token(String(repeating: "\n", count: count), kind: Text.Whitespace.self)
            case .carriageReturns(let count):
                return Token(String(repeating: "\r", count: count), kind: Text.Whitespace.self)
            case .carriageReturnLineFeeds(let count):
                return Token(String(repeating: "\r\n", count: count), kind: Text.Whitespace.self)
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
