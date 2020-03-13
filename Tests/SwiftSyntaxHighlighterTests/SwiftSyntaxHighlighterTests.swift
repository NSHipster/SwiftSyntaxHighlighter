import XCTest
import SwiftSyntaxHighlighter
import Pygments

final class SwiftSyntaxHighlighterTests: XCTestCase {
    func testExample() throws {
        let source = #"""
        /// Returns a personalized greeting.
        func greet(name: String) -> String {
            return "Hello, \(name)!" // 👋
        }
        """#

        let actual = try highlight(source, using: Pygments.self)

        let empty = #"""
        <pre class="highlight"><code></code></pre>
        """#


        XCTAssertNotEqual(actual, empty)
    }
}
