import XCTest
import class Foundation.Bundle

final class CommandTests: XCTestCase {
    func testHighlightArguments() throws {
        guard #available(macOS 10.13, *) else { return }

        let source = #"""
        let greeting = "Hello, world!"
        """#

        let expected = #"""
        <pre class="highlight"><code><span class="kd">let</span><span class="w"> </span><span class="n">greeting</span><span class="w"> </span><span class="p">=</span><span class="w"> </span><span class="p">&quot;</span><span class="s2">Hello, world!</span><span class="p">&quot;</span></code></pre>
        """#

        let executable = productsDirectory.appendingPathComponent("swift-highlight")

        let process = Process()
        process.executableURL = executable

        process.arguments = [source, "--scheme", "pygments"]

        var data = Data()
        let outputPipe = Pipe()
        defer { outputPipe.fileHandleForReading.closeFile() }
        outputPipe.fileHandleForReading.readabilityHandler = { fileHandle in
            data.append(fileHandle.availableData)
        }
        process.standardOutput = outputPipe

        try process.run()
        process.waitUntilExit()

        let output = String(data: data, encoding: .utf8)

        XCTAssertEqual(output, expected)
    }

    func testHighlightStandardInput() throws {
        guard #available(macOS 10.13, *) else { return }

        let source = #"""
        let greeting = "Hello, world!"
        """#

        let expected = #"""
        <pre class="highlight"><code><span class="keyword">let</span> <span class="variable">greeting</span> = <span class="string literal">&quot;</span><span class="string literal">Hello, world!</span><span class="string literal">&quot;</span></code></pre>
        """#

        let executable = productsDirectory.appendingPathComponent("swift-highlight")

        let process = Process()
        process.executableURL = executable

        let inputPipe = Pipe()
        inputPipe.fileHandleForWriting.writeabilityHandler = { fileHandle in
            fileHandle.write(source.data(using: .utf8)!)
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

        try process.run()
        process.waitUntilExit()

        let output = String(data: data, encoding: .utf8)

        XCTAssertEqual(output, expected)
    }

    /// Returns path to the built products directory.
    var productsDirectory: URL {
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
