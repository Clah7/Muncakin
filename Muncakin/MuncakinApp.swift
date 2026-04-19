//
//  MuncakinApp.swift
//  Muncakin
//
//  Created by Darren Christian Liharja on 18/04/26.
//

import SwiftUI
import SwiftData

@main
struct MuncakinApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Mountain.self,
            GearItem.self,
            Trip.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    init() {
        Theme.configureNavigationBarAppearance()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
