/// Variable/function names
public enum Name: PygmentsTokenKind {
    public static var className: String? { "n" }

    /// Attributes (in HTML for instance)
    public enum Attribute: PygmentsTokenKind {
        public static var className: String? { "na" }
    }

    /// Builtin names which are available in the global namespace
    public enum Builtin: PygmentsTokenKind {
        public static var className: String? { "nb" }
    }

    /// Builtin names that are implicit (such as self in Ruby)
    public enum PseudoBuiltin: PygmentsTokenKind {
        public static var className: String? { "bp" }
    }

    /// For class declaration
    public enum Class: PygmentsTokenKind {
        public static var className: String? { "nc" }
    }

    /// For constants
    public enum Constant: PygmentsTokenKind {
        public static var className: String? { "nc" }
    }

    /// For decorators in languages such as Python or Java
    public enum Decorator: PygmentsTokenKind {
        public static var className: String? { "nd" }
    }

    /// Token for entitites such as &nbsp; in HTML
    public enum Entity: PygmentsTokenKind {
        public static var className: String? { "ni" }
    }

    /// Exceptions and errors (e.g. ArgumentError in Ruby)
    public enum Exception: PygmentsTokenKind {
        public static var className: String? { "ne" }
    }

    /// Function names
    public enum Function: PygmentsTokenKind {
        public static var className: String? { "nf" }
    }

    /// Token for properties
    public enum Property: PygmentsTokenKind {
        public static var className: String? { "py" }
    }

    /// For label names
    public enum Label: PygmentsTokenKind {
        public static var className: String? { "nl" }
    }

    /// Token for namespaces
    public enum Namespace: PygmentsTokenKind {
        public static var className: String? { "nn" }
    }

    /// For other names
    public enum Other: PygmentsTokenKind {
        public static var className: String? { "nx" }
    }

    /// Tag mainly for markup such as XML or HTML
    public enum Tag: PygmentsTokenKind {
        public static var className: String? { "nt" }
    }

    /// Token for variables
    public enum Variable: PygmentsTokenKind {
        public static var className: String? { "nv" }

        /// Token for class variables (e.g. @@var in Ruby)
        public enum Class: PygmentsTokenKind {
               public static var className: String? { "vc" }
        }

        /// For global variables (such as $LOAD_PATH in Ruby)
        public enum Global: PygmentsTokenKind {
               public static var className: String? { "vg" }
        }

        /// Token for instance variables (such as @var in Ruby)

        public enum Instance: PygmentsTokenKind {
               public static var className: String? { "vi" }
        }
    }
}
