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
        let appGroupURL = fileManager.containerURL(forSecurityApplicationGroupIdentifier: appGroupId)
    else {
        throw SwiftDataContextError.noAppGroupAccess
    }
    
    let appSupportURL = appGroupURL
        .appendingPathComponent("Library", isDirectory: true)
        .appendingPathComponent("Application Support", isDirectory: true)

    try fileManager.createDirectory(at: appSupportURL, withIntermediateDirectories: true)

    let configuration = ModelConfiguration(groupContainer: .identifier(appGroupId))
    
    return (configuration, userDefaults)
}


// MARK: - Error
public enum SwiftDataContextError: Error {
    case noAppGroupAccess
}
