# NnSwiftDataKit

NnSwiftDataKit is a lightweight Swift package that streamlines the setup of SwiftData containers in apps that use App Groups. It provides:

- a clean way to create a `ModelConfiguration` that stores data inside an App Group  
- automatic access to the correct `UserDefaults` suite  
- a one-liner to build a `ModelContainer` and `UserDefaults` together  
- a convenient `Scene` extension for initializing a `ModelContainer`  
- optional database path printing for debugging via a `ModelContainer` helper  

The package does **not** define any SwiftData models and does **not** manage schema or migrations. Your app remains fully in control of its domain and data types.

---

## Features
- Builds a `ModelConfiguration` using an App Group identifier.
- Returns the correct `UserDefaults` suite for the same App Group.
- Provides a `Scene.initializeSwiftDataModelContainer` helper to inject containers cleanly.
- Migrates existing SwiftData stores between App Groups with optional automatic cleanup.
- Supports custom schemas and migration plans.
- Works with iOS and macOS targets.

---

## Installation

Add the package to your `Package.swift` file:

```swift
    .package(url: "https://github.com/nikolainobadi/NnSwiftDataKit", from: "0.8.0")
```

---

## Usage

### Importing the Package

```swift
import NnSwiftDataKit
```

---

## API Overview
- `makeAppGroupConfiguration(appGroupId:fileManager:)` → `ModelConfiguration` + `UserDefaults`
- `makeAppGroupModelContainer(schema:appGroupId:fileManager:migrationPlan:)` → `ModelContainer` + `UserDefaults`
- `migrateAppGroupSwiftDataStoreIfNeeded(from:to:fileManager:deleteOldAfterMigration:)` → migrates database between App Groups
- `Scene.initializeSwiftDataModelContainer(schema:migrationPlan:configuration:printDatabasePath:)` → attaches a configured container to a scene
- `ModelContainer.printStoreFilePath()` → logs the resolved store location

---

## Configuring the SwiftData Container

Use `makeAppGroupConfiguration` to prepare a `ModelConfiguration` and the App Group `UserDefaults` instance (throws `SwiftDataContextError.noAppGroupAccess` if the group is unavailable):

```swift
do {
    let (config, defaults) = try makeAppGroupConfiguration(
        appGroupId: "group.com.example.app"
    )

    print("App Group UserDefaults:", defaults)
} catch {
    print("Failed to configure SwiftData container:", error)
}
```

---

## Creating a ModelContainer Directly

Build a ready-to-use `ModelContainer` and `UserDefaults` in one step. You can pass a migration plan when needed:

```swift
let (container, defaults) = try makeAppGroupModelContainer(
    schema: Schema([MyModel.self]),
    appGroupId: "group.com.example.app",
    migrationPlan: MyMigrationPlan.self
)

container.printStoreFilePath() // optional: logs the store location
```

---

## Migrating Between App Groups

If you need to change your App Group identifier, use `migrateAppGroupSwiftDataStoreIfNeeded` to safely migrate your existing database. **This must be called before creating the ModelContainer:**

```swift
do {
    // Migrate from old App Group to new App Group
    try migrateAppGroupSwiftDataStoreIfNeeded(
        from: "group.com.example.oldapp",
        to: "group.com.example.newapp",
        deleteOldAfterMigration: true  // automatically removes old database after successful migration
    )

    // Now create the container with the new App Group
    let (container, defaults) = try makeAppGroupModelContainer(
        schema: Schema([MyModel.self]),
        appGroupId: "group.com.example.newapp"
    )
} catch {
    print("Migration or container setup failed:", error)
}
```

The migration function:
- Checks if the new App Group container exists
- If not, but the old container exists, copies all SwiftData files to the new location
- Optionally deletes the old container after successful migration (set `deleteOldAfterMigration: false` to keep it)
- Is safe to call repeatedly (no-op if migration is already complete)

---

## Initializing the ModelContainer in your App

Use the `initializeSwiftDataModelContainer` modifier inside your `Scene` builder:

```swift
@main
struct ExampleApp: App {
    var body: some Scene {
        let (config, _) = try! makeAppGroupConfiguration(
            appGroupId: "group.com.example.app"
        )

        WindowGroup {
            ContentView()
        }
        .initializeSwiftDataModelContainer(
            schema: Schema([MyModel.self]),
            migrationPlan: MyMigrationPlan.self,
            configuration: config,
            printDatabasePath: true
        )
    }
}
```

This initializes a SwiftData container using your App Group and applies it to the scene.

---

## Error Handling

If the App Group container or the associated `UserDefaults` suite cannot be accessed, the helpers throw:

```swift
SwiftDataContextError.noAppGroupAccess
```

---

## Contributing
Any feedback or ideas to enhance NnSwiftDataKit would be well received. Please feel free to [open an issue](https://github.com/nikolainobadi/NnSwiftDataKit/issues/new) if you'd like to help improve this Swift package.

## License
NnSwiftDataKit is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
