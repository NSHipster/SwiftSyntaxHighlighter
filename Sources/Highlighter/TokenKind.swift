/// A type that represents a kind of token within a tokenization scheme.
public protocol TokenKind {
    /// The associated tokenization scheme.
    associatedtype Scheme: TokenizationScheme

    /// The class name associated with tokens of this kind, if any.
    static var className: String? { get }
}
