//
//  Scene+ModelContainer.swift
//  NnSwiftDataKit
//
//  Created by Nikolai Nobadi on 4/5/25.
//

import SwiftUI
import SwiftData

public extension Scene {
    /// Initializes and configures a SwiftData ModelContainer for the scene.
    ///
    /// This method creates a ModelContainer with the provided schema and configuration,
    /// then attaches it to the scene. If initialization fails, the app will terminate
    /// with a fatal error.
    ///
    /// - Parameters:
    ///   - schema: The schema defining the data models for the container.
    ///   - migrationPlan: Optional migration plan for handling schema changes. Defaults to nil.
    ///   - configuration: The model configuration settings. Defaults to a standard configuration.
    ///   - printDatabasePath: When true, prints the data store URL to the console. Defaults to false.
    /// - Returns: A scene with the initialized ModelContainer attached.
    func initializeSwiftDataModelContainer(
        schema: Schema,
        migrationPlan: (any SchemaMigrationPlan.Type)? = nil,
        configuration: ModelConfiguration = .init(),
        printDatabasePath: Bool = false
    ) -> some Scene {
        do {
            let container = try ModelContainer(for: schema, migrationPlan: migrationPlan, configurations: configuration)
            
            if printDatabasePath {
                container.printDataStoreURL()
            }
            
            return self.modelContainer(container)
        } catch {
            fatalError("Failed to initialize SwiftData ModelContainer: \(error)")
        }
    }
}
