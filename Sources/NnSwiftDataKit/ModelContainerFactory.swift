//
//  ModelContainerFactory.swift
//  NnSwiftDataKit
//
//  Created by Nikolai Nobadi on 3/9/25.
//

import SwiftData

/// Creates a SwiftData model container without requiring an App Group identifier.
///
/// This helper builds a `ModelConfiguration` with optional CloudKit syncing and
/// read-only support, then initializes and returns a fully configured
/// `ModelContainer`.
///
/// - Parameters:
///   - schema: The SwiftData schema defining your models
///   - name: Optional store name used to distinguish multiple stores
///   - readOnly: When true, saves are disabled and the store is treated as read only
///   - cloudKitDatabaseId: Optional CloudKit container identifier used to enable syncing
///   - migrationPlan: Optional schema migration plan
///
/// - Returns: The configured `ModelContainer`.
public func makeModelContainer(schema: Schema, name: String? = nil, readOnly: Bool = false, cloudKitDatabaseId: String? = nil, migrationPlan: (any SchemaMigrationPlan.Type)? = nil) throws -> ModelContainer {
    let configuration: ModelConfiguration

    if let cloudKitDatabaseId {
        configuration = ModelConfiguration(name, allowsSave: !readOnly, cloudKitDatabase: .private(cloudKitDatabaseId))
    } else {
        configuration = ModelConfiguration(name, allowsSave: !readOnly)
    }

    return try ModelContainer(for: schema, migrationPlan: migrationPlan, configurations: configuration)
}
