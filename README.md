# SwiftSyntaxHighlighter

A syntax highlighter for Swift code that uses
[SwiftSyntax](https://github.com/apple/swift-syntax) to generate
[Pygments](http://pygments.org)-compatible HTML.
You can use it either
from the command-line, via the `swift-syntax-highlight` executable or
in Swift code using the SwiftSyntaxHighlighter module.

This functionality is discussed in the NSHipster article
[SwiftSyntax](https://nshipster.com/swiftsyntax/).

## Requirements

- Xcode 10.0+ and Swift 4.2+

## Command-Line Usage

The `swift-syntax-highlight` executable can be run from the command line
to highlight either a path to a source file or source code:

```terminal
$ swift-syntax-highlight "print(\"Hello, world!\")"
<pre class="highlight"><code><span class="n">print</span><span class="p">(</span><span class="s2">"Hello, world!"</span><span class="p">)</span></code></pre>
```

### Installation

#### Homebrew

Run the following command to install using [homebrew](https://brew.sh/):

```terminal
$ brew install nshipster/formulae/swift-syntax-highlight
```

#### Precompiled Releases

1. Download the `swift-syntax-highlight.tar.gz` asset file
   from [the latest release](https://github.com/nshipster/SwiftSyntaxHighlighter/releases/latest)
2. Unpack the downloaded archive
3. Copy the `swift-syntax-highlight` executable to a location in your `$PATH`

#### Manually

Run the following command to build and install manually:

```terminal
$ make install
```

## Code Usage

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

### Installation

#### Swift Package Manager

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

#### Carthage

To use `SwiftSyntaxHighlighter` in your Xcode project using Carthage,
specify it in `Cartfile`:

```
github "NSHipster/SwiftSyntaxHighlighter" ~> 0.0.1
```

Then run the `carthage update` command to build the framework,
and drag the built SwiftSyntaxHighlighter.framework into your Xcode project.

## License

MIT

## Contact

Mattt ([@mattt](https://twitter.com/mattt))
