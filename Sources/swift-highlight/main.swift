import SwiftSyntaxHighlighter
import Highlighter
import Xcode
import Pygments
import ArgumentParser
import Foundation

let fileManager = FileManager.default
let fileAttributes: [FileAttributeKey : Any] = [.posixPermissions: 0o744]

var standardInput = FileHandle.standardInput
var standardOutput = FileHandle.standardOutput
var standardError = FileHandle.standardError

struct SwiftHighlight: ParsableCommand {
    enum Scheme: String, ExpressibleByArgument {
        case xcode
        case pygments

        static var `default`: Scheme = .xcode

        var type: TokenizationScheme.Type {
            switch self {
            case .xcode:
                return Xcode.self
            case .pygments:
                return Pygments.self
            }
        }
    }

    struct Options: ParsableArguments {
        @Argument(help: "Swift code or a path to a Swift file")
        var input: String?

        @Option(name: .shortAndLong,
                help: "The tokenization scheme.")
        var scheme: Scheme = .default
    }

    static var configuration = CommandConfiguration(abstract: "A utility for syntax highlighting Swift code.")

    @OptionGroup()
    var options: Options

    func run() throws {
        let scheme = options.scheme.type
        var output: String

        if let input = options.input {
            if fileManager.fileExists(atPath: input) {
                let url = URL(fileURLWithPath: input)
                output = try SwiftSyntaxHighlighter.highlight(file: url, using: scheme)
            } else {
                output = try SwiftSyntaxHighlighter.highlight(source: input, using: scheme)
            }
        } else {
            let inputData = standardInput.readDataToEndOfFile()
            let source = String(data: inputData, encoding: .utf8)!
            output = try SwiftSyntaxHighlighter.highlight(source: source, using: scheme)
        }

        if let data = output.data(using: .utf8) {
            standardOutput.write(data)
        }
    }
}

SwiftHighlight.main()
