# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.9.0] - 2025-12-08

### Added
- CloudKit sync support via optional `cloudKitDatabaseId` parameter in `makeAppGroupConfiguration` and `makeAppGroupModelContainer`
- `name` parameter to distinguish multiple stores in the same container
- `readOnly` parameter to disable saves and treat stores as read-only
- Support for private CloudKit databases when `cloudKitDatabaseId` is specified

## [0.8.0] - 2025-12-06

### Added
- `migrateAppGroupSwiftDataStoreIfNeeded` function to migrate SwiftData stores between App Group containers
- `deleteOldAfterMigration` parameter to automatically clean up old database container after successful migration

### Fixed
- Removed trailing comma from `migrationPlan` parameter in function signature

## [0.7.0] - 2025-11-29

### Added
- `makeAppGroupConfiguration` function to create SwiftData configuration and UserDefaults for app groups
- `makeAppGroupModelContainer` function to create complete ModelContainer configured for app group sharing
- `ModelContainer.printStoreFilePath()` extension method for debugging database location
- Comprehensive inline documentation for all public APIs

### Changed
- Improved README with clearer usage examples and API behavior documentation

### Removed
- `configureSwiftDataContainer` function (replaced by `makeAppGroupConfiguration` and `makeAppGroupModelContainer`)

### Migration Guide
If you were using `configureSwiftDataContainer`, replace it with:
- `makeAppGroupConfiguration` - for configuration and UserDefaults only
- `makeAppGroupModelContainer` - for a complete ModelContainer setup

## [0.6.0] - 2025-11-28

### Added
- Scene extension `initializeSwiftDataModelContainer` for easy SwiftData container setup in SwiftUI apps
- Optional `printDatabasePath` parameter to log database location for debugging
- iOS platform support (iOS 17+)

### Changed
- Updated to Swift 6.0 (swift-tools-version)
- Updated README with usage examples and clearer API behavior documentation

### Fixed
- SwiftDataInitializer access modifiers now properly expose public API

## [0.5.0] - 2025-03-25

### Added
- Initial release of NnSwiftDataKit
- `configureSwiftDataContainer` function for shared app group container setup
- Support for macOS 14+
