/// Comments
public enum Comment: PygmentsTokenKind {
    public static var className: String? { "c" }

    /// Comments that end at the end of the line
    public enum SingleLine: PygmentsTokenKind {
        public static var className: String? { "c1" }
    }

    /// Mutliline comments
    public enum MultiLine: PygmentsTokenKind {
        public static var className: String? { "cm" }
    }

    /// Preprocessor comments such as <% %> in ERb
    public enum Preprocessor: PygmentsTokenKind {
        public static var className: String? { "cp" }
    }

    /// Special data in comments such as @license in Javadoc
    public enum SpecialData: PygmentsTokenKind {
        public static var className: String? { "cs" }
    }
}
