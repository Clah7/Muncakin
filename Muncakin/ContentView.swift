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
                    .zIndex(1)
            } else {
                NavigationStack {
                    Group {
                        if trips.isEmpty {
                            ContentUnavailableView {
                                VStack(spacing: 16) {
                                    Image("img_logo")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 260)
                                    
                                    Text("No Trips")
                                        .font(.system(.title, design: .serif))
                                        .fontWeight(.bold)
                                }
                            } description: {
                                Text("Ayo Rencanakan Pendakianmu")
                                    .font(.system(.body))
                                    .foregroundStyle(.muncakinSecondary)
                            } actions: {
                                NavigationLink {
                                    AddTripView()
                                } label: {
                                    Text("Tambah Pendakian")
                                        .font(.headline)
                                        .fontWeight(.semibold)
                                        .foregroundStyle(.white)
                                        .padding(16)
                                        .background(Color.muncakinPrimary)
                                        .clipShape(Capsule())
                                }

                                .buttonStyle(.plain)
                                .padding(.top, 8)
                            }
                        } else {
                            ChecklistView(trip: trips.first!)
                        }
                    }
                }
                .transition(.move(edge: .bottom))
                .zIndex(2)
                .tint(.muncakinPrimary)
            }
        }
        .animation(.spring(response: 1, dampingFraction: 0.8), value: showSplash)
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
