//
//  AppGroupSwiftDataContext.swift
//  NnSwiftDataKit
//
//  Created by Nikolai Nobadi on 3/18/25.
//

import SwiftData
import Foundation

/// Creates a SwiftData model configuration and UserDefaults instance for an app group.
///
/// This function validates access to the specified app group and creates the necessary
/// configuration for sharing SwiftData storage between apps in the same app group.
///
/// - Parameters:
///   - appGroupId: The app group identifier (e.g., "group.com.example.myapp")
///   - fileManager: The file manager to use for validation. Defaults to `.default`
///
/// - Returns: A tuple containing:
///   - config: The `ModelConfiguration` configured for the app group
///   - defaults: The `UserDefaults` instance for the app group
///
/// - Throws: `SwiftDataContextError.noAppGroupAccess` if the app group cannot be accessed
public func makeAppGroupConfiguration(appGroupId: String, fileManager: FileManager = .default) throws -> (config: ModelConfiguration, defaults: UserDefaults) {
    guard
        let userDefaults = UserDefaults(suiteName: appGroupId),
        fileManager.containerURL(forSecurityApplicationGroupIdentifier: appGroupId) != nil
    else {
        throw SwiftDataContextError.noAppGroupAccess
    }
    
    let configuration = ModelConfiguration(groupContainer: .identifier(appGroupId))
    
    return (configuration, userDefaults)
}

/// Creates a SwiftData model container and UserDefaults instance for an app group.
///
/// This function creates a complete `ModelContainer` configured for sharing data
/// between apps in the same app group, along with the associated `UserDefaults` instance.
///
/// - Parameters:
///   - schema: The SwiftData schema defining your models
///   - appGroupId: The app group identifier (e.g., "group.com.example.myapp")
///   - fileManager: The file manager to use for validation. Defaults to `.default`
///   - migrationPlan: Optional migration plan for schema versioning
///
/// - Returns: A tuple containing:
///   - container: The `ModelContainer` configured for the app group
///   - defaults: The `UserDefaults` instance for the app group
///
/// - Throws: `SwiftDataContextError.noAppGroupAccess` if the app group cannot be accessed,
///           or any errors from `ModelContainer` initialization
public func makeAppGroupModelContainer(
    schema: Schema,
    appGroupId: String,
    fileManager: FileManager = .default,
    migrationPlan: (any SchemaMigrationPlan.Type)? = nil,
) throws -> (container: ModelContainer, defaults: UserDefaults) {
    let (config, defaults) = try makeAppGroupConfiguration(appGroupId: appGroupId, fileManager: fileManager)
    let container = try ModelContainer(for: schema, migrationPlan: migrationPlan, configurations: config)
    
    return (container, defaults)
}
