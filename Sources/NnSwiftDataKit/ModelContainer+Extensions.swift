//
//  ModelContainer+Extensions.swift
//  NnSwiftDataKit
//
//  Created by Nikolai Nobadi on 11/29/25.
//

import SwiftData

public extension ModelContainer {
    func printDataStoreURL() {
        if let url = configurations.first?.url {
            print("SwiftData store location:", url.path(percentEncoded: false))
        } else {
            print("SwiftData store location: <unknown>")
        }
    }
}
