import SwiftSyntax
import Highlighter
import struct Foundation.URL

@_exported import Xcode
@_exported import Pygments

open class SwiftSyntaxHighlighter: SyntaxAnyVisitor {
    let scheme: TokenizationScheme.Type
    public private(set) var tokens: [Token] = []

    public init(using scheme: TokenizationScheme.Type) {
        self.scheme = scheme
    }

    // MARK: - SyntaxAnyVisitor

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
