import Basic
import Foundation
import SwiftSyntax
import HTMLEntities
import Pygments

class SwiftSyntaxHighlighter: SyntaxRewriter {
    var previousToken: TokenSyntax?

    var highlightTokens: [Pygments.Token?] = []
    public var html: String {
        return "<pre class=\"highlight\"><code>\(highlightTokens.compactMap { $0?.html }.joined())</code></pre>"
    }
    
    override func visit(_ token: TokenSyntax) -> Syntax {
        defer { previousToken = token }

        highlightTokens.append(contentsOf: highlightedTokens(for: token.leadingTrivia))
        highlightTokens.append(highlightedToken(for: token))
        highlightTokens.append(contentsOf: highlightedTokens(for: token.trailingTrivia))

        return token
    }

    private func highlightedToken(for token: TokenSyntax) -> Pygments.Token? {
        var output: Pygments.Token? = nil

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
             let .unspacedBinaryOperator(string):
            output = OperatorToken(string)
        case .stringLiteral(let string),
             .stringSegment(let string):
            output = DoubleQuoteStringLiteralToken(string)
        case .stringInterpolationAnchor:
            output = InterpolatedStringLiteralToken(token.text)
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
             .poundImageLiteralKeyword:
            output = PreprocessorCommentToken(token.text)
        case .contextualKeyword(let string):
            output = PseudoKeywordToken(string)
        case .equal, .arrow, .comma, .period, .colon, .semicolon,
             .stringQuote, .backslash,
             .postfixQuestionMark, .wildcardKeyword,
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
        case .eof:
            return nil
        default:
            print("unknown: \(token.tokenKind) \(token.text)")
            break
        }

        if let previousTokenKind = previousToken?.tokenKind {
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

        if let text = output?.text,
            output is NameToken,
            token.leadingTrivia.containsBackticks,
            token.trailingTrivia.containsBackticks {
            output?.text = "`\(text)`"
        }

        return output
    }

    private func highlightedTokens(for trivia: Trivia) -> [Pygments.Token?] {
        return trivia.map { piece in
            highlightedToken(for: piece)
        }
    }

    private func highlightedToken(for piece: TriviaPiece) -> Pygments.Token? {
        switch piece {
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
        case .backticks:
            return nil
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
}

public func highlight(_ code: String) throws -> String {
    let tempfile = try TemporaryFile(deleteOnClose: true)
    defer { tempfile.fileHandle.closeFile() }
    tempfile.fileHandle.write(code.data(using: .utf8)!)
    
    let url = URL(fileURLWithPath: tempfile.path.asString)
    return try highlight(url)
}

public func highlight(_ url: URL) throws -> String {
    let sourceFile = try SyntaxTreeParser.parse(url)

    let highlighter = SwiftSyntaxHighlighter()
    _ = highlighter.visit(sourceFile)

    return highlighter.html
}
