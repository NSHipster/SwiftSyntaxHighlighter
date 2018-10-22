/// Token for data not matched by a parser (e.g. HTML markup in PHP code)
public final class OtherToken: Token {
    override class var shortName: String? {
        return "x"
    }
}
