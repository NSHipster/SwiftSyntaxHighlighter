import XCTest
import SwiftSyntaxHighlighter
import Pygments

final class PygmentsTests: XCTestCase {
    func testExample() throws {
        let source = #"""
        /// Returns a personalized greeting.
        func greet(name: String) -> String {
            return "Hello, \(name)!" // 👋
        }
        """#

        let actual = try SwiftSyntaxHighlighter.highlight(source: source, using: Pygments.self)

        let expected = #"""
        <pre class="highlight"><code><span class="c1">/// Returns a personalized greeting.</span><span class="w">
        </span><span class="kd">func</span><span class="w"> </span><span class="n">greet</span><span class="p">(</span><span class="n">name</span><span class="p">:</span><span class="w"> </span><span class="nc">String</span><span class="p">)</span><span class="w"> </span><span class="p">-&gt;</span><span class="w"> </span><span class="n">String</span><span class="w"> </span><span class="p">{</span><span class="w">
        </span><span class="w">    </span><span class="k">return</span><span class="w"> </span><span class="p">&quot;</span><span class="s2">Hello, </span><span class="p">\</span><span class="p">(</span><span class="n">name</span><span class="si">)</span><span class="s2">!</span><span class="p">&quot;</span><span class="w"> </span><span class="c1">// 👋</span><span class="w">
        </span><span class="p">}</span></code></pre>
        """#

        XCTAssertEqual(actual, expected)
    }
}
