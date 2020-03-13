/// Any literal (if not further defined)
public enum Literal: PygmentsTokenKind {
    public static var className: Swift.String? { "l" }

    /// Date literals
    public enum Date: PygmentsTokenKind {
        public static var className: Swift.String? { "ld" }
    }

    /// String literals
    public enum String: PygmentsTokenKind {
        public static var className: Swift.String? { "s" }

        /// String enclosed in backticks
        public enum BacktickQuoted: PygmentsTokenKind {
            public static var className: Swift.String? { "sb" }
        }

        /// Token type for single characters
        public enum Character: PygmentsTokenKind {
            public static var className: Swift.String? { "sc" }
        }

        ///  Documentation strings (such as in Python)
        public enum Documentation: PygmentsTokenKind {
            public static var className: Swift.String? { "sd" }
        }

        /// Single quoted strings
        public enum SingleQuoted: PygmentsTokenKind {
            public static var className: Swift.String? { "s1" }
        }

        /// Double quoted strings
        public enum DoubleQuoted: PygmentsTokenKind {
            public static var className: Swift.String? { "s2" }
        }

        /// Escaped Sequence in String Literal
        public enum EscapedSequence: PygmentsTokenKind {
            public static var className: Swift.String? { "se" }
        }

        /// For "heredoc" strings (e.g. in Ruby)
        public enum Heredoc: PygmentsTokenKind {
            public static var className: Swift.String? { "sh" }
        }

        /// For interpoled part in strings (e.g. in Ruby)
        public enum Interpolated: PygmentsTokenKind {
            public static var className: Swift.String? { "si" }
        }

        /// Regular expressions literals
        public enum RegularExpression: PygmentsTokenKind {
            public static var className: Swift.String? { "sr" }
        }

        /// Symbols (such as :foo in Ruby)
        public enum Symbol: PygmentsTokenKind {
            public static var className: Swift.String? { "ss" }
        }

        /// Token type for any other strings (for example %q{foo} string constructs in Ruby)
        public enum Other: PygmentsTokenKind {
            public static var className: Swift.String? { "sx" }
        }
    }

    /// Any number literal (if not further defined)
    public enum Number: PygmentsTokenKind {
        public static var className: Swift.String? { "m" }

        /// Integer literals
        public enum Integer: PygmentsTokenKind {
            public static var className: Swift.String? { "mi" }

            /// Long interger literals
            public enum Long: PygmentsTokenKind {
                public static var className: Swift.String? { "il" }
            }
        }

        /// Float numbers
        public enum FloatingPoint: PygmentsTokenKind {
            public static var className: Swift.String? { "mf" }
        }

        /// Binary literals
        public enum Binary: PygmentsTokenKind {
            public static var className: Swift.String? { "mb" }
        }

        /// Octal literals
        public enum Octal: PygmentsTokenKind {
            public static var className: Swift.String? { "mo" }
        }

        /// Hex numbers
        public enum Hexadecimal: PygmentsTokenKind {
            public static var className: Swift.String? { "mh" }
        }
    }
}
