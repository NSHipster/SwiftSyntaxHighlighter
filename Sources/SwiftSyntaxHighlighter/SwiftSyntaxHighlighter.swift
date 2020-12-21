import SwiftSyntax
import Highlighter
import struct Foundation.URL

@_exported import Xcode
@_exported import Pygments

/// A syntax highlighter for Swift code.
open class SwiftSyntaxHighlighter: SyntaxAnyVisitor {
    /// The tokenization scheme.
    let scheme: TokenizationScheme.Type

    /// The highlighted tokens.
    public private(set) var tokens: [Token] = []

    /// Creates a new syntax highlighter using the specified tokenization scheme.
    ///
    /// - Parameter scheme: The tokenization scheme.
    /// - SeeAlso: `Xcode`
    /// - SeeAlso: `Pygments`
    public init(using scheme: TokenizationScheme.Type) {
        self.scheme = scheme
    }

    // MARK: - SyntaxAnyVisitor

    /// Visiting `UnknownSyntax` specifically.
    ///   - Parameter node: the node we are visiting.
    ///   - Returns: how should we continue visiting.
    public override func visitAny(_ node: Syntax) -> SyntaxVisitorContinueKind {
        tokens.append(contentsOf: scheme.tokens(for: node))

        return .visitChildren
    }
}

// MARK: -

extension SwiftSyntaxHighlighter {
    public class func highlight(source: String, using scheme: TokenizationScheme.Type) throws -> String {
        let tree = try SyntaxParser.parse(source: source)
        return try highlight(syntax: tree, using: scheme)
    }

    public class func highlight(file url: URL, using scheme: TokenizationScheme.Type) throws -> String {
        let tree = try SyntaxParser.parse(url)
        return try highlight(syntax: tree, using: scheme)
    }

    public class func highlight(syntax: SourceFileSyntax, using scheme: TokenizationScheme.Type) throws -> String {
        let highlighter = SwiftSyntaxHighlighter(using: scheme)
        _ = highlighter.visit(syntax)
        let tags = highlighter.tokens.map { $0.html }.joined()
        return #"<pre class="highlight"><code>\#(tags)</code></pre>"#
    }
}
