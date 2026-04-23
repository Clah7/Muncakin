// MuncakinApp.swift

import SwiftUI
import SwiftData

@main
struct MuncakinApp: App {
    @Environment(\.scenePhase) private var scenePhase

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

        // Register the background task handler BEFORE the app finishes launching.
        // This must happen in init(), not in a view's onAppear.
        BackgroundTaskManager.shared.registerTask()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
        .onChange(of: scenePhase) { _, newPhase in
            if newPhase == .background {
                // Schedule the next step-check when the app moves to background.
                // iOS will decide when to actually run it (≥3 hours from now).
                BackgroundTaskManager.shared.scheduleNextStepCheck()
            }
        }
    }
}
