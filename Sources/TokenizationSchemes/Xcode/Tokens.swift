/// Unhighlighted text.
public enum Text: XcodeTokenKind {
    public static var className: String? { nil }
}

/// A code comment.
///
/// For example:
///
/// ```swift
/// // This is a line comment.
///
/// /*
/// This is a block comment.
/// */
/// ```
public enum Comment: XcodeTokenKind {
    public static var className: String? { "comment" }
}

/// A documentation comment.
///
/// For example:
///
/// ```swift
/// /// This is a documentation line comment.
///
/// /**
/// This is a documentation block comment
/// */
/// ```
public enum Documentation: XcodeTokenKind {
    public static var className: String? { "documentation" }
}

/// A string literal.
///
/// For example, the token `"Hello, world"` in the following code:
///
/// ```swift
/// let greeting = "Hello, world"
/// ```
public enum StringLiteral: XcodeTokenKind {
    public static var className: String? { "string literal" }
}

/// A character literal.
///
/// For example, the token `A` in the following code:
///
/// ```swift
/// let letter: Character = "A"
/// ```
public enum CharacterLiteral: XcodeTokenKind {
    public static var className: String? { "character literal" }
}

/// A number literal.
///
/// For example, the token `42` in the following code:
///
/// ```swift
/// let n = 42
/// ```
public enum NumberLiteral: XcodeTokenKind {
    public static var className: String? { "number literal" }
}

/// A language keyword.
///
/// For example, the tokens `func` and `return` in the following code:
///
/// ```swift
/// func inverse(of number: Int) -> Int {
/// return -number
/// }
/// ```
public enum Keyword: XcodeTokenKind {
    public static var className: String? { "keyword" }
}

/// A directive.
///
/// For example, the tokens `#if` and `#endif` in the following code:
///
/// ```swift
/// #if DEBUG
/// print("Hello, world!")
/// #endif
/// ```
public enum Directive: XcodeTokenKind {
    public static var className: String? { "directive" }
}

/// An attribute.
///
/// For example, the token `@available` in the following code:
///
/// ```swift
/// @available(macOS 11.0, *)
/// ```
public enum Attribute: XcodeTokenKind {
    public static var className: String? { "attribute" }
}

/// A type declaration.
///
/// For example, the token `Parent` in the following code:
///
/// ```swift
/// class Parent {}
/// ```
public enum TypeDeclaration: XcodeTokenKind {
    public static var className: String? { "declaration type" }
}

/// A non-type declaration.
///
/// For example, the token `count` in the following code:
///
/// ```swift
/// class var count: Int
/// ```
public enum OtherDeclaration: XcodeTokenKind {
    public static var className: String? { "declaration other" }
}

/// The name of a class in an expression.
///
/// For example, the token `Parent` in the following code:
///
/// ```swift
/// class Child: Parent {}
/// ```
public enum ClassName: XcodeTokenKind {
    public static var className: String? { "class" }
}

/// The name of a function in an expression.
///
/// For example, the token `print` in the following code:
///
/// ```swift
/// print("Hello, world!")
/// ```
public enum FunctionName: XcodeTokenKind {
    public static var className: String? { "function" }
}

/// The name of a constant in an expression.
///
/// For example, the token `answer` in the following code:
///
/// ```swift
/// let answer = 2
/// print("1 + 1 = \(answer)")
/// ```
public enum Constant: XcodeTokenKind {
    public static var className: String? { "constant" }
}

/// The name of a type in an expression.
///
/// For example, the token `Int` in the following code:
///
/// ```swift
/// typealias Number = Int
/// ```
public enum TypeName: XcodeTokenKind {
    public static var className: String? { "type" }
}

/// The name of a variable in an expression.
///
/// For example, the token `greeting` in the following code:
///
/// ```swift
/// var greeting = "Howdy!"
/// print(greeting)
/// ```
public enum Variable: XcodeTokenKind {
    public static var className: String? { "variable" }
}

/// A code placeholder.
///
/// For example:
///
/// ```swift
/// <#This is a placeholder#>
/// ```
public enum Placeholder: XcodeTokenKind {
    public static var className: String? { "placeholder" }
}
