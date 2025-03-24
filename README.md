# NnSwiftDataKit

NnSwiftDataKit is a Swift package designed to simplify the configuration of SwiftData containers, particularly when working with App Groups. It provides a convenient method to create a SwiftData container with support for Application Groups and user defaults.

## Features
- Configures SwiftData containers for use with App Groups.
- Ensures the necessary directories are created.
- Returns both a `ModelConfiguration` and a `UserDefaults` instance.

## Installation

Add the package to your `Package.swift` file:

```swift
dependencies: [
    .package(url: "https://github.com/nikolainobadi/NnSwiftDataKit", branch: "main")
]
```

## Usage

### Importing the Package

```swift
import NnSwiftDataKit
```

### Configuring the SwiftData Container
Use the `configureSwiftDataContainer` function to set up the container and user defaults:

```swift
do {
    let (config, defaults) = try configureSwiftDataContainer(appGroupId: "group.com.example.app")
    print("Successfully configured container and user defaults.")
} catch {
    print("Error configuring SwiftData container: \(error)")
}
```

## Error Handling
If the specified App Group cannot be accessed, the function will throw a `SwiftDataContextError.noAppGroupAccess` error.

## Contributing
Any feedback or ideas to enhance NnSwiftDataKit would be well received. Please feel free to [open an issue](https://github.com/nikolainobadi/NnSwiftDataKit/issues/new) if you'd like to help improve this Swift package.

## License
NnSwiftDataKit is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
