// Views/ContentView.swift

import SwiftUI
import SwiftData

struct ContentView: View {
    @Query private var trips: [Trip]

    @State private var showSplash = true

    var body: some View {
        ZStack {
            if showSplash {
                SplashView()
                    .transition(.opacity)
            } else {
                NavigationStack {
                    Group {
                        if trips.isEmpty {
                            ContentUnavailableView {
                                Label("No Trips", systemImage: "mountain.2")
                            } description: {
                                Text("Plan your first hike by creating a trip.")
                            } actions: {
                                NavigationLink("Create Trip") {
                                    AddTripView()
                                }
                                .buttonStyle(.borderedProminent)
                            }
                        } else {
                            ChecklistView(trip: trips.first!)
                        }
                    }
                }
            }
        }
        .animation(.easeInOut, value: showSplash)
        .task {
            try? await Task.sleep(for: .seconds(1.5))
            showSplash = false
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Trip.self, inMemory: true)
}
