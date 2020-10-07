import XCTest
import SwiftSyntaxHighlighter
import Xcode

final class XcodeTests: XCTestCase {
    func testExample() throws {
        let source = #"""
        /// Returns a personalized greeting.
        func greet(name: String) -> String {
            return "Hello, \(name)!" // 👋
        }
        """#

        let actual = try SwiftSyntaxHighlighter.highlight(source: source, using: Xcode.self)

        let expected = #"""
        <pre class="highlight"><code><span class="documentation">/// Returns a personalized greeting.</span>
        <span class="keyword">func</span> <span class="function">greet</span>(<span class="variable">name</span>: <span class="type">String</span>) -&gt; <span class="type">String</span> {
            <span class="keyword">return</span> <span class="string literal">&quot;</span><span class="string literal">Hello, </span>\<span class="string literal">(</span><span class="variable">name</span><span class="string literal">)</span><span class="string literal">!</span><span class="string literal">&quot;</span> <span class="comment">// 👋</span>
        }</code></pre>
        """#

        XCTAssertEqual(actual, expected)
    }
}
