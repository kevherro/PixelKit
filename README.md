# Introduction

PixelKit is a SwiftUI package that provides custom,
reusable UI components for enhancing your app's user interface.

## Features

- Custom button styles (e.g., [SpringyButtonStyle](./Sources/PixelKit/Styles/SpringyButtonStyle.swift))
- Indicators (e.g., [BlinkingEllipsis](./Sources/PixelKit/Indicators/BlinkingEllipsis.swift))

## Requirements

- Swift 6.0+
- macOS 15.0+
- Optional: [swiftformat](https://github.com/nicklockwood/SwiftFormat)

## Installation

Add the following to your `Package.swift` file:

```swift
dependencies: [
    .package(url: "https://github.com/kevherro/PixelKit.git", from: "0.1.0")
]
```

## Basic Usage

Here's a quick example of how to use the SpringyButtonStyle:

```swift
import SwiftUI
import PixelKit

struct ContentView: View {
    var body: some View {
        Button("Press Me!") {
            print("Button pressed!")
        }
        .buttonStyle(
            PixelKit.Styles.SpringyButtonStyle(
                width: 200,
                height: 50,
                color: .blue
            )
        )
    }
}
```

## License

[MIT](./LICENSE)

## Contact

Kevin Herro - herro [at] sent [dot] com
