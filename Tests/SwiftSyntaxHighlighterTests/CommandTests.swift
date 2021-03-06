import XCTest
import class Foundation.Bundle

#if os(macOS)
final class CommandTests: XCTestCase {
    let source = #"""
    let greeting = "Hello, world!"
    """#

    let expectedOutput = #"""
    <pre class="highlight"><code><span class="keyword">let</span> <span class="variable">greeting</span> = <span class="string literal">&quot;</span><span class="string literal">Hello, world!</span><span class="string literal">&quot;</span></code></pre>
    """#

    let expectedPygmentsOutput = #"""
    <pre class="highlight"><code><span class="kd">let</span><span class="w"> </span><span class="n">greeting</span><span class="w"> </span><span class="p">=</span><span class="w"> </span><span class="p">&quot;</span><span class="s2">Hello, world!</span><span class="p">&quot;</span></code></pre>
    """#

    func testHighlightArguments() throws {
        do {
            let output = try runCommand(arguments: source, "--scheme", "xcode")
            XCTAssertEqual(output, expectedOutput)
        }

        do {
            let output = try runCommand(arguments: source, "--scheme", "pygments")
            XCTAssertEqual(output, expectedPygmentsOutput)
        }

        do {
            let output = try runCommand(arguments: source)
            XCTAssertEqual(output, expectedOutput)
        }

        do {
            let output = try runCommand(arguments: source, "--scheme", "garbage")
            XCTAssertNil(output)
        }
    }

    func testHighlightStandardInput() throws {
        do {
            let output = try runCommand(standardInput: source)
            XCTAssertEqual(output, expectedOutput)
        }

        do {
            let output = try runCommand(arguments: "--scheme", "xcode", standardInput: source)
            XCTAssertEqual(output, expectedOutput)
        }

        do {
            let output = try runCommand(arguments: "--scheme", "pygments", standardInput: source)
            XCTAssertEqual(output, expectedPygmentsOutput)
        }
    }

    private func runCommand(arguments: String..., standardInput: String = "") throws -> String? {
        let process = Process()
        process.executableURL = executable
        process.arguments = arguments

        let inputPipe = Pipe()
        inputPipe.fileHandleForWriting.writeabilityHandler = { fileHandle in
            fileHandle.write(standardInput.data(using: .utf8)!)
            inputPipe.fileHandleForWriting.closeFile()
        }
        process.standardInput = inputPipe

        var data = Data()
        let outputPipe = Pipe()
        defer { outputPipe.fileHandleForReading.closeFile() }
        outputPipe.fileHandleForReading.readabilityHandler = { fileHandle in
            data.append(fileHandle.availableData)
        }
        process.standardOutput = outputPipe

        process.standardError = FileHandle.nullDevice

        try process.run()
        process.waitUntilExit()
        guard process.terminationStatus == EXIT_SUCCESS else { return nil }

        return String(data: data, encoding: .utf8)
    }

    private var executable: URL {
        return productsDirectory.appendingPathComponent("swift-highlight")
    }

    private var productsDirectory: URL {
      #if os(macOS)
        for bundle in Bundle.allBundles where bundle.bundlePath.hasSuffix(".xctest") {
            return bundle.bundleURL.deletingLastPathComponent()
        }
        fatalError("couldn't find the products directory")
      #else
        return Bundle.main.bundleURL
      #endif
    }
}
#endif
