import SwiftSyntax
import Foundation


/// A highlighter token.
public struct Token: Equatable, Hashable, Codable {

    /// The token text.
    public var text: String

    /// The name of the token kind.
    public var className: String?

    /// Create a new highlighter token with the specified text and kind.
    /// - Parameters:
    ///   - text: The token text.
    ///   - kind: The kind of token.
    public init<Kind: TokenKind>(_ text: String, kind: Kind.Type) {
        self.text = text
        self.className = kind.className
    }

    /// An HTML representation of the highlighter token.
    public var html: String {
        if let className = className {
            return #"<span class="\#(className.escaped)">\#(text.escaped)</span>"#
        } else {
            return text.escaped
        }
    }
}

fileprivate extension StringProtocol {
    var escaped: String {
        #if os(macOS) || os(iOS) || os(watchOS) || os(tvOS)
        return (CFXMLCreateStringByEscapingEntities(nil, String(self) as NSString, nil)! as NSString) as String
        #else
        return [
            ("&", "&amp;"),
            ("<", "&lt;"),
            (">", "&gt;"),
            ("'", "&apos;"),
            ("\"", "&quot;"),
        ].reduce(String(self)) { (string, element) in
            string.replacingOccurrences(of: element.0, with: element.1)
        }
        #endif
    }

    func escapingOccurrences<Target>(of target: Target, options: String.CompareOptions = [], range searchRange: Range<String.Index>? = nil) -> String where Target : StringProtocol {
        return replacingOccurrences(of: target, with: target.escaped, options: options, range: searchRange)
    }

    func escapingOccurrences<Target>(of targets: [Target], options: String.CompareOptions = []) -> String where Target : StringProtocol {
        return targets.reduce(into: String(self)) { (result, target) in
            result = result.escapingOccurrences(of: target, options: options)
        }
    }
}
