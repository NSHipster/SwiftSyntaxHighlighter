public class TextToken: Token {}

/// Specially highlighted whitespace
public final class WhitespaceToken: TextToken {
    override class var shortName: String? {
        return "w"
    }
}
