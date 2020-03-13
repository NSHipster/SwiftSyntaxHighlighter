import Foundation
import SwiftSyntax
import HTMLEntities
import Pygments

class SwiftSyntaxHighlighter: SyntaxAnyVisitor {
    var highlightTokens: [Pygments.Token?] = []

    public var html: String {
        let tags = highlightTokens.compactMap { $0?.html }.joined()
        return #"<pre class="highlight"><code>\#(tags)</code></pre>"#
    }

    override func visitAny(_ node: Syntax) -> SyntaxVisitorContinueKind {
        for token in node.tokens {
            highlightTokens.append(contentsOf: node.leadingTrivia?.map { Pygments.Token.create(for: $0) } ?? [])
            highlightTokens.append(Pygments.Token.create(for: token))
            highlightTokens.append(contentsOf: node.trailingTrivia?.map { Pygments.Token.create(for: $0) } ?? [])
        }

        return .visitChildren
    }
}

public func highlight(_ source: String) throws -> String {
    let highlighter = SwiftSyntaxHighlighter()
    let tree = try SyntaxParser.parse(source: source)
    _ = highlighter.visit(tree)
    return highlighter.html
}

public func highlight(_ url: URL) throws -> String {
    let highlighter = SwiftSyntaxHighlighter()
    let tree = try SyntaxParser.parse(url)
    _ = highlighter.visit(tree)
    return highlighter.html
}
