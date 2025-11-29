//
//  Scene+ModelContainer.swift
//  NnSwiftDataKit
//
//  Created by Nikolai Nobadi on 4/5/25.
//

import SwiftUI
import SwiftData

public extension Scene {
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
