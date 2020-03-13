import XCTest
import SwiftSyntaxHighlighter

final class SwiftSyntaxHighlighterTests: XCTestCase {
    func testExample() throws {
        let source = #"""
        func greet(name: String) -> String {
            return "Hello, \(name)!"
        }
        """#

        let actual = try highlight(source)

        let expected = #"""
        <pre class="highlight"><code><span class="kd">func</span><span class="nf">greet</span><span class="p">(</span><span class="n">name</span><span class="p">:</span><span class="nc">String</span><span class="p">)</span><span class="p">-&#x3E;</span><span class="n">String</span><span class="p">{</span><span class="k">return</span><span class="p">&#x22;</span><span class="s2">Hello, </span><span class="p">\</span><span class="p">(</span><span class="n">name</span><span class="si">)</span><span class="s2">!</span><span class="p">&#x22;</span><span class="p">}</span></code></pre>
        """#


        XCTAssertEqual(actual, expected)
    }
}
