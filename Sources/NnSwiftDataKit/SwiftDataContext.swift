//
//  SwiftDataContainer.swift
//  NnSwiftDataKit
//
//  Created by Nikolai Nobadi on 3/18/25.
//

import SwiftData
import Foundation

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
