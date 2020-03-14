import SwiftSyntax
import HTMLEntities

public struct Token {
    public var text: String
    public var className: String?

    public init<Kind: TokenKind>(_ text: String, kind: Kind.Type) {
        self.text = text
        self.className = kind.className
    }
}

extension Token {
    public var html: String {
        let escapedText = text.htmlEscape(useNamedReferences: true)

        if let className = className {
            return #"<span class="\#(className)">\#(escapedText)</span>"#
        } else {
            return escapedText
        }
    }
}
