//
//  LibraryApp.swift
//  Library
//
//  Created by özgün aksoy on 2024-03-26.
//

import SwiftUI
import SwiftData

@main
struct LibraryApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Book.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            BookListView()
        }
        .modelContainer(sharedModelContainer)
    }
}
