public protocol TokenKind {
    associatedtype Scheme: TokenizationScheme

    static var className: String? { get }
}
