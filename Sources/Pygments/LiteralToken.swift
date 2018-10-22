/// Any literal (if not further defined)
public class LiteralToken: Token {
    override class var shortName: String? {
        return "l"
    }
}

/// Attributes (in HTML for instance)
public final class DateLiteralToken: LiteralToken {
    override class var shortName: String? {
        return "ld"
    }
}

/// String literals
public class StringLiteralToken: LiteralToken {
    override class var shortName: String? {
        return "s"
    }
}

/// String enclosed in backticks
public final class BacktickQuotedStringLiteralToken: StringLiteralToken {
    override class var shortName: String? {
        return "sb"
    }
}

/// Token type for single characters
public final class CharacterStringLiteralToken: StringLiteralToken {
    override class var shortName: String? {
        return "sc"
    }
}

///  Documentation strings (such as in Python)
public final class DocumentationStringLiteralToken: StringLiteralToken {
    override class var shortName: String? {
        return "sd"
    }
}

/// Double quoted strings
public final class DoubleQuoteStringLiteralToken: StringLiteralToken {
    override class var shortName: String? {
        return "s2"
    }
}

/// Escaped Sequence in String Literal
public final class EscapedSequenceStringLiteralToken: StringLiteralToken {
    override class var shortName: String? {
        return "se"
    }
}

/// For "heredoc" strings (e.g. in Ruby)
public final class HeredocStringLiteralToken: StringLiteralToken {
    override class var shortName: String? {
        return "sh"
    }
}

/// For interpoled part in strings (e.g. in Ruby)
public final class InterpolatedStringLiteralToken: StringLiteralToken {
    override class var shortName: String? {
        return "si"
    }
}

/// Token type for any other strings (for example %q{foo} string constructs in Ruby)
public final class OtherStringLiteralToken: StringLiteralToken {
    override class var shortName: String? {
        return "sx"
    }
}

/// Regular expressions literals
public final class RegularExpressionStringLiteralToken: StringLiteralToken {
    override class var shortName: String? {
        return "sr"
    }
}

/// Single quoted strings
public final class SingleQuoteStringLiteralToken: StringLiteralToken {
    override class var shortName: String? {
        return "s1"
    }
}

/// Symbols (such as :foo in Ruby)
public final class SymbolStringLiteralToken: StringLiteralToken {
    override class var shortName: String? {
        return "ss"
    }
}

/// Any number literal (if not further defined)
public class NumberLiteralToken: LiteralToken {
    override class var shortName: String? {
        return "m"
    }
}

/// Float numbers
public final class FloatingPointNumberLiteralToken: NumberLiteralToken {
    override class var shortName: String? {
        return "mf"
    }
}

/// Hex numbers
public final class HexadecimalNumberLiteralToken: NumberLiteralToken {
    override class var shortName: String? {
        return "mh"
    }
}

/// Integer literals
public class IntegerNumberLiteralToken: NumberLiteralToken {
    override class var shortName: String? {
        return "mi"
    }
}

/// Long interger literals
public final class LongIntegerNumberLiteralToken: IntegerNumberLiteralToken {
    override class var shortName: String? {
        return "il"
    }
}

/// Octal literals
public final class OctalNumberLiteralToken: NumberLiteralToken {
    override class var shortName: String? {
        return "mo"
    }
}

///// Hexadecimal literals
//public final class HexadecimalNumberLiteralToken: NumberLiteralToken {
//    override class var shortName: String? {
//        return "mx"
//    }
//}

/// Binary literals
public final class BinaryNumberLiteralToken: NumberLiteralToken {
    override class var shortName: String? {
        return "mb"
    }
}
