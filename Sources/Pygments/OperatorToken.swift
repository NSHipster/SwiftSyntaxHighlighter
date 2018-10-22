/// Operators (commonly +, -, /, *)
public class OperatorToken: Token {
    override class var shortName: String? {
        return "o"
    }
}

/// Word operators (e.g. and)
public final class WordOperatorToken: OperatorToken {
    override class var shortName: String? {
        return "ow"
    }
}
