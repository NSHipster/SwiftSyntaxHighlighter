/// Single line comments
public class CommentToken: Token {
    override class var shortName: String? {
        return "c"
    }
}

/// Mutliline comments
public final class MultiLineCommentToken: CommentToken {
    override class var shortName: String? {
        return "cm"
    }
}

/// Preprocessor comments such as <% %> in ERb
public final class PreprocessorCommentToken: CommentToken {
    override class var shortName: String? {
        return "cp"
    }
}

/// Comments that end at the end of the line
public final class SingleLineCommentToken: CommentToken {
    override class var shortName: String? {
        return "c1"
    }
}

/// Special data in comments such as @license in Javadoc
public final class SpecialDataCommentToken: CommentToken {
    override class var shortName: String? {
        return "cs"
    }
}
