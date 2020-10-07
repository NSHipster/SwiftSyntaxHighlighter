import SwiftSyntax
import Foundation

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
        if let className = className {
            return #"<span class="\#(className)">\#(text.escaped)</span>"#
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
