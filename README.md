# SwiftSyntaxHighlighter

A syntax highlighter for Swift code that uses
[SwiftSyntax](https://github.com/apple/swift-syntax).
You can use it either from the command-line,
via the `swift-highlight` executable,
or in Swift code using the `SwiftSyntaxHighlighter` module.

This functionality is discussed in the NSHipster article
[SwiftSyntax](https://nshipster.com/swiftsyntax/).

## Requirements

- Xcode 11.4+ and Swift 5.2+

## Command-Line Usage

The `swift-highlight` executable can be run from the command line
to highlight either a path to a source file or source code:

```terminal
$ swift highlight 'print("Hello, world!")"
<pre class="highlight"><code><span class="keyword">let</span> <span class="variable">greeting</span> = <span class="string literal">&quot;</span><span class="string literal">Hello, world!</span><span class="string literal">&quot;</span></code></pre>
```

Pass the `--scheme pygments` option
to generate [Pygments](http://pygments.org)-compatible HTML:

```terminal
$ swift highlight 'print("Hello, world!")" --scheme pygments
<pre class="highlight"><code><span class="n">print</span><span class="p">(</span><span class="p">&quot;</span><span class="s2">Hello, world!</span><span class="p">&quot;</span><span class="p">)</span></code></pre>
```

`swift-highlight` also accepts arguments piped from standard input (`stdin`):

```terminal
echo 'print("Hello, world!")' | swift highlight
<pre class="highlight"><code><span class="variable">print</span>(<span class="string literal">&quot;</span><span class="string literal">Hello, world!</span><span class="string literal">&quot;</span>)
</code></pre>
```

### Installation

#### Homebrew

Run the following command to install using [homebrew](https://brew.sh/):

```terminal
$ brew install nshipster/formulae/swift-syntax-highlight
```

#### Manually

Run the following commands to build and install manually:

```terminal
$ git clone https://github.com/NSHipster/SwiftSyntaxHighlighter.git
$ cd SwiftSyntaxHighlighter
$ make install
```

## Code Usage

`SwiftSyntaxHighlighter` provides type methods named `highlight`
that take either
source code as a `String`,
a source file `URL`, 
or a `SourceFileSyntax` AST created by SwiftSyntax.

```swift
import SwiftSyntaxHighlighter

let code = """
print("Hello, world!")
"""

let html = try SwiftSyntaxHighlighter.highlight(source: source, using: Xcode.self)
```

After running this code, 
`html` contains the following string:

```
<pre class="highlight"><code><span class="keyword">let</span> <span class="variable">greeting</span> = <span class="string literal">&quot;</span><span class="string literal">Hello, world!</span><span class="string literal">&quot;</span></code></pre>
```

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
        from: "1.0.0"
    ),
  ]
)
```

Then run the `swift build` command to build your project.

#### Carthage

To use `SwiftSyntaxHighlighter` in your Xcode project using Carthage,
specify it in `Cartfile`:

```
github "NSHipster/SwiftSyntaxHighlighter" ~> 1.0.0
```

Then run the `carthage update` command to build the framework,
and drag the built SwiftSyntaxHighlighter.framework into your Xcode project.

## License

MIT

## Contact

Mattt ([@mattt](https://twitter.com/mattt))
