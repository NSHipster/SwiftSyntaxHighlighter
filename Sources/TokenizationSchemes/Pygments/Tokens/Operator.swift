/// Operators (commonly +, -, /, *)
public enum Operator: PygmentsTokenKind {
    public static var className: String? { "o" }

    /// Word operators (e.g. and)
    public enum Word: PygmentsTokenKind {
        public static var className: String? { "ow" }
    }
}
