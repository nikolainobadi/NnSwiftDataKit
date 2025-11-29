//
//  ModelContainer+Extensions.swift
//  NnSwiftDataKit
//
//  Created by Nikolai Nobadi on 11/29/25.
//

import SwiftData

public extension ModelContainer {
    /// Prints the file system path of the SwiftData store to the console.
    ///
    /// This method retrieves and prints the URL path of the first configuration's
    /// data store. Useful for debugging and locating the physical SQLite file.
    ///
    /// Example output:
    /// ```
    /// SwiftData store location: /Users/.../Application Support/default.store
    /// ```
    ///
    /// - Note: If no configuration URL is available, prints "<unknown>"
    func printStoreFilePath() {
        if let url = configurations.first?.url {
            print("SwiftData store location:", url.path(percentEncoded: false))
        } else {
            print("SwiftData store location: <unknown>")
        }
    }
}
