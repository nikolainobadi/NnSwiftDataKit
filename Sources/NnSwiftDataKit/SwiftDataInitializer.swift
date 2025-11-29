//
//  SwiftDataInitializer.swift
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
            let container = try ModelContainer(
                for: schema,
                migrationPlan: migrationPlan,
                configurations: configuration
            )
            
            if printDatabasePath {
                if let url = container.configurations.first?.url {
                    print("SwiftData store location:", url.path(percentEncoded: false))
                } else {
                    print("SwiftData store location: <unknown>")
                }
            }
            
            return self.modelContainer(container)
            
        } catch {
            fatalError("Failed to initialize SwiftData ModelContainer: \(error)")
        }
    }
}
