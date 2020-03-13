/// Unhighlighted text
public enum Text: PygmentsTokenKind {
    public static var className: String? { nil }

    /// Specially highlighted whitespace
    public enum Whitespace: PygmentsTokenKind {
        public static var className: String? { "w" }
    }
}
