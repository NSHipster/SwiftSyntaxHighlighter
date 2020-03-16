public enum Text: XcodeTokenKind {
    public static var className: String? { nil }
}

public enum Comment: XcodeTokenKind {
    public static var className: String? { "comment" }
}

public enum Documentation: XcodeTokenKind {
    public static var className: String? { "documentation" }
}

public enum StringLiteral: XcodeTokenKind {
    public static var className: String? { "string literal" }
}

public enum CharacterLiteral: XcodeTokenKind {
    public static var className: String? { "character literal" }
}

public enum NumberLiteral: XcodeTokenKind {
    public static var className: String? { "number literal" }
}

public enum Keyword: XcodeTokenKind {
    public static var className: String? { "keyword" }
}

public enum Directive: XcodeTokenKind {
    public static var className: String? { "directive" }
}

public enum Attribute: XcodeTokenKind {
    public static var className: String? { "attribute" }
}

public enum TypeDeclaration: XcodeTokenKind {
    public static var className: String? { "declaration type" }
}

public enum OtherDeclaration: XcodeTokenKind {
    public static var className: String? { "declaration other" }
}

public enum ClassName: XcodeTokenKind {
    public static var className: String? { "class" }
}

public enum FunctionName: XcodeTokenKind {
    public static var className: String? { "function" }
}

public enum Constant: XcodeTokenKind {
    public static var className: String? { "constant" }
}

public enum TypeName: XcodeTokenKind {
    public static var className: String? { "type" }
}

public enum Variable: XcodeTokenKind {
    public static var className: String? { "variable" }
}

public enum Placeholder: XcodeTokenKind {
    public static var className: String? { "placeholder" }
}
