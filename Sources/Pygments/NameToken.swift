/// Variable/function names
public class NameToken: Token {
    override class var shortName: String? {
        return "n"
    }
}

/// Attributes (in HTML for instance)
public final class AttributeNameToken: NameToken {
    override class var shortName: String? {
        return "na"
    }
}

/// Builtin names which are available in the global namespace
public class BuiltinNameToken: NameToken {
    override class var shortName: String? {
        return "nb"
    }
}

/// Builtin names that are implicit (such as self in Ruby)
public final class PseudoBuiltinNameToken: BuiltinNameToken {
    override class var shortName: String? {
        return "bp"
    }
}

/// For class declaration
public final class ClassNameToken: NameToken {
    override class var shortName: String? {
        return "nc"
    }
}

/// For constants
public final class ConstantNameToken: NameToken {
    override class var shortName: String? {
        return "no"
    }
}

/// For decorators in languages such as Python or Java
public final class DecoratorNameToken: NameToken {
    override class var shortName: String? {
        return "nd"
    }
}

/// Token for entitites such as &nbsp; in HTML
public final class EntityNameToken: NameToken {
    override class var shortName: String? {
        return "ni"
    }
}

/// Exceptions and errors (e.g. ArgumentError in Ruby)
public final class ExceptionNameToken: NameToken {
    override class var shortName: String? {
        return "ne"
    }
}

/// Function names
public final class FunctionNameToken: NameToken {
    override class var shortName: String? {
        return "nf"
    }
}

/// Token for properties
public final class PropertyNameToken: NameToken {
    override class var shortName: String? {
        return "py"
    }
}

/// For label names
public final class LabelNameToken: NameToken {
    override class var shortName: String? {
        return "nl"
    }
}

/// Token for namespaces
public final class NamespaceNameToken: NameToken {
    override class var shortName: String? {
        return "nn"
    }
}

/// For other names
public final class OtherNameToken: NameToken {
    override class var shortName: String? {
        return "nx"
    }
}

/// Tag mainly for markup such as XML or HTML
public final class TagNameToken: NameToken {
    override class var shortName: String? {
        return "nt"
    }
}

/// Token for variables
public class VariableNameToken: NameToken {
    override class var shortName: String? {
        return "nv"
    }
}

/// Token for class variables (e.g. @@var in Ruby)
public final class ClassVariableNameToken: VariableNameToken {
    override class var shortName: String? {
        return "vc"
    }
}

/// For global variables (such as $LOAD_PATH in Ruby)
public final class GlobalVariableNameToken: VariableNameToken {
    override class var shortName: String? {
        return "vg"
    }
}

/// Token for instance variables (such as @var in Ruby)
public final class InstanceVariableNameToken: VariableNameToken {
    override class var shortName: String? {
        return "vi"
    }
}
