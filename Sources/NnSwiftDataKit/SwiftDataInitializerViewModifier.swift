//
//  SwiftDataInitializerViewModifier.swift
//  NnSwiftDataKit
//
//  Created by Nikolai Nobadi on 4/5/25.
//

import SwiftUI
import SwiftData

struct SwiftDataInitializerViewModifier: ViewModifier {
    let container: ModelContainer
    
    init(schema: Schema, migrationPlan: (any SchemaMigrationPlan.Type)?, configuration: ModelConfiguration) {
        do {
            container = try .init(for: schema, migrationPlan: migrationPlan, configurations: configuration)
            print(URL.applicationSupportDirectory.path(percentEncoded: false))
        } catch {
            fatalError("Cannot use the app if the container doesn't initialize")
        }
    }
    
    func body(content: Content) -> some View {
        content
            .modelContainer(container)
    }
}

public extension View {
    func initializeSwiftDataModelContainer(schema: Schema, migrationPlan: (any SchemaMigrationPlan.Type)? = nil, configuration: ModelConfiguration = .init()) -> some View {
        modifier(SwiftDataInitializerViewModifier(schema: schema, migrationPlan: migrationPlan, configuration: configuration))
    }
}
