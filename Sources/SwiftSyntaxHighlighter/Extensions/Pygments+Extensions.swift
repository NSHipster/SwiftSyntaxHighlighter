import Pygments
import SwiftSyntax

extension Pygments.Token {
    public static func create(for triviaPiece: TriviaPiece) -> Pygments.Token? {
        switch triviaPiece {
        case .spaces(let count):
            return TextToken(String(repeating: " ", count: count))
        case .tabs(let count):
            return TextToken(String(repeating: "\t", count: count))
        case .verticalTabs(let count):
            return TextToken(String(repeating: "\u{11}", count: count))
        case .formfeeds(let count):
            return TextToken(String(repeating: "\u{12}", count: count))
        case .newlines(let count):
            return TextToken(String(repeating: "\n", count: count))
        case .carriageReturns(let count):
            return TextToken(String(repeating: "\r", count: count))
        case .carriageReturnLineFeeds(let count):
            return TextToken(String(repeating: "\r\n", count: count))
        case .lineComment(let text),
             .docLineComment(let text):
            return SingleLineCommentToken(text)
        case .blockComment(let text),
             .docBlockComment(let text):
            return MultiLineCommentToken(text)
        case .garbageText:
            return nil
        }
    }

    public static func create(for token: SwiftSyntax.TokenSyntax) -> Pygments.Token? {
        var output: Pygments.Token

        switch token.tokenKind {
        case .integerLiteral(let string):
            if string.hasPrefix("0b") {
                output = BinaryNumberLiteralToken(string)
            } else if string.hasPrefix("0o") {
                output = OctalNumberLiteralToken(string)
            } else if string.hasPrefix("0x") {
                output = HexadecimalNumberLiteralToken(string)
            } else {
                output = IntegerNumberLiteralToken(string)
            }
        case .floatingLiteral(let string):
            output = FloatingPointNumberLiteralToken(string)
        case let .spacedBinaryOperator(string),
             let .unspacedBinaryOperator(string),
             let .postfixOperator(string),
             let .prefixOperator(string):
            output = OperatorToken(string)
        case .stringLiteral(let string),
             .stringSegment(let string):
            output = DoubleQuoteStringLiteralToken(string)
        case .stringInterpolationAnchor:
            output = InterpolatedStringLiteralToken(token.text)
        case .rawStringDelimiter(let string):
            output = InterpolatedStringLiteralToken(string)
        case .atSign:
            output = AttributeNameToken(token.text)
        case .selfKeyword, .superKeyword:
            output = PseudoBuiltinNameToken(token.text)
        case .anyKeyword:
            output = ReservedKeywordToken(token.text)
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
            output = KeywordToken(token.text)
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
            output = DeclarationKeywordToken(token.text)
        case .trueKeyword, .falseKeyword, .nilKeyword:
            output = ConstantKeywordToken(token.text)
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
            output = PreprocessorCommentToken(token.text)
        case .contextualKeyword(let string):
            output = PseudoKeywordToken(string)
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
            output = PunctuationToken(token.text)
        case .identifier(let identifier):
            switch identifier {
            case "override":
                output = DeclarationKeywordToken(token.text)
            default:
                output = NameToken(token.text)
            }
        case .dollarIdentifier(let identifier):
            output = PseudoBuiltinNameToken(identifier)
        case .unknown(let string):
            output = OtherToken(string)
        case .eof:
            return nil
        }

        if let previousTokenKind = token.previousToken?.tokenKind {
            switch output {
            case is NameToken:
                switch previousTokenKind {
                case .importKeyword:
                    output = NamespaceNameToken(token.text)
                case .classKeyword,
                     .enumKeyword,
                     .structKeyword,
                     .protocolKeyword,
                     .isKeyword,
                     .asKeyword,
                     .period,
                     .colon,
                     .leftSquareBracket
                    where token.text == token.text.capitalized:
                    output = ClassNameToken(token.text)
                case .funcKeyword:
                    output = FunctionNameToken(token.text)
                case .atSign:
                    output = AttributeNameToken(token.text)
                default:
                    break
                }
            default:
                break
            }
        }

        return output
    }
}
