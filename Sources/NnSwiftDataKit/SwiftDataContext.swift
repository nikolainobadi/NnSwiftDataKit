//
//  SwiftDataContainer.swift
//  NnSwiftDataKit
//
//  Created by Nikolai Nobadi on 3/18/25.
//

import SwiftData
import Foundation

public func configureSwiftDataContainer(appGroupId: String, fileManager: FileManager = .default) throws -> (config: ModelConfiguration, defaults: UserDefaults) {
    guard
        let userDefaults = UserDefaults(suiteName: appGroupId),
        fileManager.containerURL(forSecurityApplicationGroupIdentifier: appGroupId) != nil
    else {
        throw SwiftDataContextError.noAppGroupAccess
    }
    
    let configuration = ModelConfiguration(groupContainer: .identifier(appGroupId))
    
    return (configuration, userDefaults)
}


