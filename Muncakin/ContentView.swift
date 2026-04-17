// Views/ContentView.swift

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var trips: [Trip]

    @State private var showSplash = true
    @State private var showAddTrip = false

    var body: some View {
        ZStack {
            if showSplash {
                SplashView()
                    .transition(.opacity)
            } else if trips.isEmpty {
                ContentUnavailableView {
                    Label("No Trips", systemImage: "mountain.2")
                } description: {
                    Text("Plan your first hike by creating a trip.")
                } actions: {
                    Button("Create Trip") {
                        showAddTrip = true
                    }
                    .buttonStyle(.borderedProminent)
                }
            } else {
                ChecklistView(trip: trips.first!)
            }
        }
        .animation(.easeInOut, value: showSplash)
        .task {
            try? await Task.sleep(for: .seconds(1.5))
            showSplash = false
        }
        .sheet(isPresented: $showAddTrip) {
            AddTripView()
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Trip.self, inMemory: true)
}
