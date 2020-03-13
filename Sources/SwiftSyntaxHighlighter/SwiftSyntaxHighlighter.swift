import SwiftSyntax
import Highlighter
import struct Foundation.URL

class SwiftSyntaxHighlighter<Scheme: TokenizationScheme>: SyntaxAnyVisitor {
    var tokens: [Token] = []

    public init(scheme: Scheme.Type) {}

    public var html: String {
        let tags = tokens.map { $0.html }.joined()
        return #"<pre class="highlight"><code>\#(tags)</code></pre>"#
    }

    override func visitAny(_ node: Syntax) -> SyntaxVisitorContinueKind {
        tokens.append(contentsOf: Scheme.tokens(for: node))

        return .visitChildren
    }
}

// MARK: -

public func highlight<Scheme: TokenizationScheme>(_ source: String, using scheme: Scheme.Type) throws -> String {
    let highlighter = SwiftSyntaxHighlighter(scheme: Scheme.self)
    let tree = try SyntaxParser.parse(source: source)
    _ = highlighter.visit(tree)
    return highlighter.html
}

public func highlight<Scheme: TokenizationScheme>(_ url: URL, using scheme: Scheme.Type) throws -> String {
    let highlighter = SwiftSyntaxHighlighter(scheme: Scheme.self)
    let tree = try SyntaxParser.parse(url)
    _ = highlighter.visit(tree)
    return highlighter.html
}
