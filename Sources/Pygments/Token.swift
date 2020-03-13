import HTMLEntities

/// A Pygments token
public class Token {
    class var shortName: String? {
        return nil
    }

    public var text: String

    public init(_ text: String) {
        self.text = text
    }

    public var html: String {
        guard let shortName = type(of: self).shortName else {
            return self.text
        }

        return #"<span class="\#(shortName)">\#(text.htmlEscape())</span>"#
    }
}

/**

 Really should be Token<Kind: TokenKind>

 enum Name: TokenKind { static var shortName: String { "n" } }
 */
