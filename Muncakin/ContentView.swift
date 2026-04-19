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
                                    .foregroundStyle(.muncakinPrimary)
                            } description: {
                                Text("Ayo Rencanakan Pendakianmu")
                                    .foregroundStyle(.muncakinSecondary)
                            } actions: {
                                NavigationLink {
                                    AddTripView()
                                } label: {
                                    Text("Create Trip")
                                        .primaryCTAStyle()
                                }
                                .frame(maxWidth: 260)
                            }
                        } else {
                            ChecklistView(trip: trips.first!)
                        }
                    }
                }
                .tint(.muncakinPrimary)
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
