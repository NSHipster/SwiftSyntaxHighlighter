# SwiftSyntaxHighlighter

A syntax highlighter for Swift code that uses
[SwiftSyntax](https://github.com/apple/swift-syntax) to generate
[Pygments](http://pygments.org)-compatible HTML.

This functionality is discussed in the NSHipster article
[SwiftSyntax](https://nshipster.com/swiftsyntax/).

## Requirements

- Swift 4.2+

## Installation

### Swift Package Manager

Add the SwiftSyntaxHighlighter package to your target dependencies in `Package.swift`:

```swift
import PackageDescription

let package = Package(
  name: "YourProject",
  dependencies: [
    .package(
        url: "https://github.com/NSHipster/SwiftSyntaxHighlighter",
        from: "0.0.1"
    ),
  ]
)
```

Then run the `swift build` command to build your project.

### Carthage

To use `SwiftSyntaxHighlighter` in your Xcode project using Carthage,
specify it in `Cartfile`:

```
github "NSHipster/SwiftSyntaxHighlighter" ~> 0.0.1
```

Then run the `carthage update` command to build the framework,
and drag the built SwiftSyntaxHighlighter.framework into your Xcode project.

## Usage

`SwiftSyntaxHighlighter` provides two top-level functions named `highlight(_:)`,
with overloads for providing a file URL
or passing source code directly as a `String`:

```swift
import SwiftSyntaxHighlighter

let code = """
print("Hello, world!")
"""

let html = highlight(code)
```

After running this code, `html` contains the following string:

<samp>
&lt;pre class=&quot;highlight&quot;&gt;&lt;code&gt;&lt;span class=&quot;n&quot;&gt;print&lt;/span&gt;&lt;span class=&quot;p&quot;&gt;(&lt;/span&gt;&lt;span class=&quot;s2&quot;&gt;&quot;Hello, world!&quot;&lt;/span&gt;&lt;span class=&quot;p&quot;&gt;)&lt;/span&gt;&lt;/code&gt;&lt;/pre&gt;
</samp>

This package also contains the `Highlight` executable target,
which can be run from the command line.
The command takes a single argument,
which can be either a path to a source file or source code:

```terminal
$ ./Highlight "print(\"Hello, world!\")"
<pre class="highlight"><code><span class="n">print</span><span class="p">(</span><span class="s2">"Hello, world!"</span><span class="p">)</span></code></pre>
```

## Example Output

SwiftSyntaxHighlighter (0.0.1):

<pre class="highlight"><code><span class="kd">import</span> <span class="nn">Foundation</span>

<span class="cm">/*
 This is a multi-line comment block
 */</span>
<span class="cp">#if</span> <span class="n">os</span><span class="p">(</span><span class="n">macOS</span><span class="p">)</span>
<span class="kd">class</span> <span class="nc">Class</span><span class="p">:</span> <span class="nc">NSObject</span> <span class="p">{</span>
    <span class="kd">private</span> <span class="kd">static</span> <span class="kd">let</span> <span class="n">message</span> <span class="p">=</span> <span class="s2">"""
        Hello, world!
    """</span>
    <span class="na">@</span><span class="na">objc</span> <span class="kd">var</span> <span class="n">storedProperty</span><span class="p">:</span> <span class="nc">Int</span> <span class="p">=</span> <span class="mi">0</span>
    
    <span class="kd">override</span> <span class="kd">init</span><span class="p">(</span><span class="p">)</span> <span class="p">{</span>
        <span class="bp">self</span><span class="p">.</span><span class="nc">storedProperty</span> <span class="p">=</span> <span class="mb">0b10101010</span>
        <span class="bp">super</span><span class="p">.</span><span class="nc">init</span><span class="p">(</span><span class="p">)</span>
    <span class="p">}</span>
    
    <span class="kd">func</span> <span class="nf">printSelectorAndKeyPath</span><span class="p">(</span><span class="p">)</span> <span class="p">{</span>
        <span class="n">print</span><span class="p">(</span><span class="cp">#selector</span><span class="p">(</span><span class="n">emptyFunction</span><span class="p">)</span><span class="p">)</span>
        <span class="n">print</span><span class="p">(</span><span class="cp">#keyPath</span><span class="p">(</span><span class="n">storedProperty</span><span class="p">)</span><span class="p">)</span>
    <span class="p">}</span>
    
    <span class="na">@</span><span class="na">objc</span> <span class="kd">func</span> <span class="nf">emptyFunction</span><span class="p">(</span><span class="p">)</span> <span class="p">{</span> <span class="p">}</span>
<span class="p">}</span>
<span class="cp">#endif</span>
</code></pre>

Standard highlighter output:

```swift
import Foundation

/*
 This is a multi-line comment block
 */
#if os(macOS)
class Class: NSObject {
    private static let message = """
        Hello, world!
    """
    @objc var storedProperty: Int = 0

    override init() {
        self.storedProperty = 0b10101010
        super.init()
    }

    func printSelectorAndKeyPath() {
        print(#selector(emptyFunction))
        print(#keyPath(storedProperty))
    }

    @objc func emptyFunction() { }
}
#endif
```

## License

MIT

## Contact

Mattt ([@mattt](https://twitter.com/mattt))
