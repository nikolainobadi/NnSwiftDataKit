//
//  AppGroupSwiftDataContext.swift
//  NnSwiftDataKit
//
//  Created by Nikolai Nobadi on 3/18/25.
//

import SwiftData
import Foundation

// MARK: - Configuration
/// Creates a SwiftData model configuration and UserDefaults instance for an App Group.
///
/// This function ensures the App Group container directory exists, validates access,
/// and creates the necessary configuration for sharing SwiftData storage
/// between apps in the same App Group.
///
/// - Parameters:
///   - appGroupId: The App Group identifier (e.g., "group.com.example.myapp")
///   - fileManager: The file manager to use. Defaults to `.default`
///
/// - Returns: A tuple containing:
///   - config: The `ModelConfiguration` configured for the App Group
///   - defaults: The `UserDefaults` instance attached to the App Group
///
/// - Throws: `SwiftDataContextError.noAppGroupAccess` if the App Group cannot be accessed
public func makeAppGroupConfiguration(
    appGroupId: String,
    fileManager: FileManager = .default
) throws -> (config: ModelConfiguration, defaults: UserDefaults) {
    
    // Ensures container directory exists (prevents first-launch warnings)
    _ = try ensureAppGroupContainerExists(appGroupId, fileManager: fileManager)
    
    guard let userDefaults = UserDefaults(suiteName: appGroupId) else {
        throw SwiftDataContextError.noAppGroupAccess
    }
    
    let configuration = ModelConfiguration(groupContainer: .identifier(appGroupId))
    return (configuration, userDefaults)
}


// MARK: - Model Container
/// Creates a SwiftData model container and UserDefaults instance for an App Group.
///
/// This function sets up a complete SwiftData `ModelContainer` configured
/// for shared storage through an App Group, along with the App Group–scoped
/// `UserDefaults` instance.
///
/// - Parameters:
///   - schema: The SwiftData schema defining your models
///   - appGroupId: The App Group identifier (e.g., "group.com.example.myapp")
///   - fileManager: The file manager to use. Defaults to `.default`
///   - migrationPlan: Optional schema migration plan
///
/// - Returns: A tuple containing:
///   - container: The configured `ModelContainer`
///   - defaults: The associated App Group `UserDefaults` instance
///
/// - Throws: `SwiftDataContextError.noAppGroupAccess` if the App Group cannot be accessed,
///           or any errors thrown during container initialization.
public func makeAppGroupModelContainer(
    schema: Schema,
    appGroupId: String,
    fileManager: FileManager = .default,
    migrationPlan: (any SchemaMigrationPlan.Type)? = nil
) throws -> (container: ModelContainer, defaults: UserDefaults) {
    
    let (config, defaults) = try makeAppGroupConfiguration(appGroupId: appGroupId, fileManager: fileManager)
    let container = try ModelContainer(for: schema, migrationPlan: migrationPlan, configurations: config)
    
    return (container, defaults)
}


// MARK: - Migration
/// Migrates an existing SwiftData store from one App Group container to another, if needed.
///
/// This function handles migration between App Groups when an app changes its
/// App Group identifier. It checks for the presence of the new container,
/// and if it is missing but the old container exists, it copies all persisted
/// SwiftData files from the old container into the new one.
///
/// This must be performed *before* creating the SwiftData `ModelContainer`.
///
/// - Parameters:
///   - oldAppGroupId: The previous App Group identifier
///   - newAppGroupId: The new App Group identifier
///   - fileManager: The file manager to use. Defaults to `.default`
///
/// - Throws: Any file system errors that occur during directory creation or copying.
public func migrateAppGroupSwiftDataStoreIfNeeded(
    from oldAppGroupId: String,
    to newAppGroupId: String,
    fileManager: FileManager = .default
) throws {
    guard
        let oldURL = fileManager.containerURL(forSecurityApplicationGroupIdentifier: oldAppGroupId),
        let newURL = fileManager.containerURL(forSecurityApplicationGroupIdentifier: newAppGroupId)
    else {
        return
    }
    
    // If new container already contains data, nothing to migrate.
    if fileManager.fileExists(atPath: newURL.path) {
        return
    }
    
    // If old container does not exist, nothing to migrate.
    if !fileManager.fileExists(atPath: oldURL.path) {
        return
    }
    
    // Ensure parent directory exists for new container.
    let parent = newURL.deletingLastPathComponent()
    if !fileManager.fileExists(atPath: parent.path) {
        try fileManager.createDirectory(at: parent, withIntermediateDirectories: true)
    }
    
    // Copy existing store to new group.
    try fileManager.copyItem(at: oldURL, to: newURL)
}


// MARK: - Internal Helpers
/// Ensures the App Group container directory exists.
///
/// SwiftData will create this directory automatically if missing,
/// but doing so manually prevents first-launch warnings in Xcode.
///
/// - Parameters:
///   - appGroupId: The App Group identifier (e.g., "group.com.example.app")
///   - fileManager: The file manager to use. Defaults to `.default`
///
/// - Returns: The resolved directory URL for the App Group container
///
/// - Throws: `SwiftDataContextError.noAppGroupAccess` if the container cannot be resolved,
///           or any file system errors during directory creation.
@discardableResult
private func ensureAppGroupContainerExists(
    _ appGroupId: String,
    fileManager: FileManager = .default
) throws -> URL {
    guard let url = fileManager.containerURL(forSecurityApplicationGroupIdentifier: appGroupId) else {
        throw SwiftDataContextError.noAppGroupAccess
    }
    
    if !fileManager.fileExists(atPath: url.path) {
        try fileManager.createDirectory(at: url, withIntermediateDirectories: true)
    }
    
    return url
}
