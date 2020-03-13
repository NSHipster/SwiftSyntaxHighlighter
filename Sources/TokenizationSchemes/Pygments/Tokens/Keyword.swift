/// Any keyword
public enum Keyword: PygmentsTokenKind {
    public static var className: String? { "k" }

    /// Keywords that are constants
    public enum Constant: PygmentsTokenKind {
        public static var className: String? { "kc" }
    }

    /// Keywords used for variable declaration (e.g. var in javascript)
    public enum Declaration: PygmentsTokenKind {
       public static var className: String? { "kd" }
    }

    /// Keywords used for namespace declarations
    public enum Namespace: PygmentsTokenKind {
       public static var className: String? { "kn" }
    }

    /// Keywords that aren't really keywords
    public enum Pseudo: PygmentsTokenKind {
       public static var className: String? { "kp" }
    }

    /// Keywords which are reserved (such as end in Ruby)
    public enum Reserved: PygmentsTokenKind {
       public static var className: String? { "kr" }
    }

    /// Keywords which refer to a type id (such as int in C)
    public enum TypeIdentifier: PygmentsTokenKind {
       public static var className: String? { "kt" }
    }
}
