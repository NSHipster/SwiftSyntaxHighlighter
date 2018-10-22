
/// Any keyword
public class KeywordToken: Token {
    override class var shortName: String? {
        return "k"
    }
}

/// Keywords that are constants
public final class ConstantKeywordToken: KeywordToken {
    override class var shortName: String? {
        return "kc"
    }
}

/// Keywords used for variable declaration (e.g. var in javascript)
public final class DeclarationKeywordToken: KeywordToken {
    override class var shortName: String? {
        return "kd"
    }
}

/// Keywords used for namespace declarations
public final class NamespaceKeywordToken: KeywordToken {
    override class var shortName: String? {
        return "kn"
    }
}

/// Keywords that aren't really keywords
public final class PseudoKeywordToken: KeywordToken {
    override class var shortName: String? {
        return "kp"
    }
}

/// Keywords which are reserved (such as end in Ruby)
public final class ReservedKeywordToken: KeywordToken {
    override class var shortName: String? {
        return "kr"
    }
}

/// Keywords wich refer to a type id (such as int in C)
public final class TypeKeywordToken: KeywordToken {
    override class var shortName: String? {
        return "kr"
    }
}
