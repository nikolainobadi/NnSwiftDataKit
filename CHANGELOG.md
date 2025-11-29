# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.6.0] - 2025-11-28

### Added
- Scene extension `initializeSwiftDataModelContainer` for easy SwiftData container setup in SwiftUI apps
- Optional `printDatabasePath` parameter to log database location for debugging
- iOS platform support (iOS 17+)

### Changed
- Updated README with usage examples and clearer API behavior documentation

### Fixed
- SwiftDataInitializer access modifiers now properly expose public API

## [0.5.0] - 2025-03-25

### Added
- Initial release of NnSwiftDataKit
- `configureSwiftDataContainer` function for shared app group container setup
- Support for macOS 14+
