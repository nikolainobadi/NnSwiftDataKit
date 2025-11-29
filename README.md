# NnSwiftDataKit

NnSwiftDataKit is a lightweight Swift package that streamlines the setup of SwiftData containers in apps that use App Groups. It provides:

- a clean way to create a `ModelConfiguration` that stores data inside an App Group  
- automatic access to the correct `UserDefaults` suite  
- a convenient `Scene` extension for initializing a `ModelContainer`  
- optional database path printing for debugging  

The package does **not** define any SwiftData models and does **not** manage schema or migrations. Your app remains fully in control of its domain and data types.

---

## Features
- Builds a `ModelConfiguration` using an App Group identifier.
- Returns the correct `UserDefaults` suite for the same App Group.
- Provides a `Scene.initializeSwiftDataModelContainer` helper to inject containers cleanly.
- Supports custom schemas and migration plans.
- Works with iOS and macOS targets.

---

## Installation

Add the package to your `Package.swift` file:

```swift
dependencies: [
    .package(url: "https://github.com/nikolainobadi/NnSwiftDataKit", from: "0.6.0")
]
```

---

## Usage

### Importing the Package

```swift
import NnSwiftDataKit
```

---

## Configuring the SwiftData Container

Use `configureSwiftDataContainer` to prepare a `ModelConfiguration` and the App Group `UserDefaults` instance:

```swift
do {
    let (config, defaults) = try configureSwiftDataContainer(
        appGroupId: "group.com.example.app"
    )

    print("App Group UserDefaults:", defaults)
} catch {
    print("Failed to configure SwiftData container:", error)
}
```

---

## Initializing the ModelContainer in your App

Use the `initializeSwiftDataModelContainer` modifier inside your `Scene` builder:

```swift
@main
struct ExampleApp: App {
    var body: some Scene {
        let (config, _) = try! configureSwiftDataContainer(
            appGroupId: "group.com.example.app"
        )

        WindowGroup {
            ContentView()
        }
        .initializeSwiftDataModelContainer(
            schema: Schema([MyModel.self]),
            configuration: config,
            printDatabasePath: true
        )
    }
}
```

This initializes a SwiftData container using your App Group and applies it to the scene.

---

## Error Handling

If the App Group container or the associated `UserDefaults` suite cannot be accessed,  
`configureSwiftDataContainer` throws:

```swift
SwiftDataContextError.noAppGroupAccess
```

---

## Contributing
Any feedback or ideas to enhance NnSwiftDataKit would be well received. Please feel free to [open an issue](https://github.com/nikolainobadi/NnSwiftDataKit/issues/new) if you'd like to help improve this Swift package.

## License
NnSwiftDataKit is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
