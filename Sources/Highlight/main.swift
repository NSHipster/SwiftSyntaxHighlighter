import Foundation
import Utility
import SwiftSyntaxHighlighter

let parser = ArgumentParser(usage: "<code|path>",
                            overview: "Highlight Swift code as HTML")
let inputArgument = parser.add(positional: "input",
                               kind: String.self,
                               optional: false,
                               usage: "Code or file path")

let stdout = FileHandle.standardOutput
let stderr = FileHandle.standardError

do {
    let arguments = Array(ProcessInfo.processInfo.arguments.dropFirst())
    let parsedArguments = try parser.parse(arguments)
    
    var output: String
    let input = parsedArguments.get(inputArgument)!
    if FileManager.default.fileExists(atPath: input) {
        let url = URL(fileURLWithPath: input)
        output = try highlight(url)
    } else {
        output = try highlight(input)
    }
    
    stdout.write(output.data(using: .utf8)!)
} catch let error as ArgumentParserError {
    stderr.write(error.description.data(using: .utf8)!)
} catch {
    stderr.write(error.localizedDescription.data(using: .utf8)!)
}
