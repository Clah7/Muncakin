// Views/ContentView.swift

import SwiftUI
import SwiftData

struct ContentView: View {
    @Query private var trips: [Trip]
    @State private var showSplash = true
    @State private var searchText = ""
    @State private var activeGradeAlert: Int?

    private var groupedMountains: [(grade: Int, mountains: [MountainInfo])] {
        MountainCatalog.groupedByGrade(filtered: searchText)
    }

    var body: some View {
        ZStack {
            if showSplash {
                SplashView()
                    .transition(.opacity)
                    .zIndex(1)
            } else {
                NavigationStack {
                    ScrollView {
                        LazyVStack(alignment: .leading, spacing: Theme.cardSpacing) {
                            // MARK: - My Trips
                            if !trips.isEmpty {
                                myTripsSection
                            }

                            // MARK: - Explore Mountains
                            exploreMountainsSection
                        }
                        .padding(.horizontal, Theme.screenPadding)
                        .padding(.vertical, 8)
                    }
                    .background(Color.muncakinScreenBackground.ignoresSafeArea())
                    .navigationTitle("Muncakin")
                    .searchable(text: $searchText, prompt: "Cari Gunung")
                    .alert(
                        "Grade \(activeGradeAlert ?? 0)",
                        isPresented: Binding(
                            get: { activeGradeAlert != nil },
                            set: { if !$0 { activeGradeAlert = nil } }
                        )
                    ) {
                        Button("OK", role: .cancel) {}
                    } message: {
                        Text(gradeDescription(for: activeGradeAlert ?? 0))
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

    // MARK: - My Trips Section

    private var myTripsSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("My Trips")
                .font(.headline)
                .padding(.leading, 4)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: Theme.cardSpacing) {
                    ForEach(trips) { trip in
                        NavigationLink {
                            ChecklistView(trip: trip)
                        } label: {
                            TripCard(trip: trip)
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
        }
        .padding(.bottom, 8)
    }

    // MARK: - Explore Mountains Section

    private var exploreMountainsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Explore Mountains")
                .font(.headline)
                .padding(.leading, 4)

            ForEach(groupedMountains, id: \.grade) { group in
                VStack(alignment: .leading, spacing: 8) {
                    // Grade section header with info icon
                    HStack(spacing: 6) {
                        Text("Grade \(group.grade)")
                            .font(.subheadline.weight(.semibold))
                            .foregroundStyle(.muncakinSecondary)

                        Button {
                            activeGradeAlert = group.grade
                        } label: {
                            Image(systemName: "info.circle")
                                .font(.subheadline)
                                .foregroundStyle(.muncakinPrimary)
                        }
                        .buttonStyle(.plain)
                    }
                    .padding(.leading, 4)

                    ForEach(group.mountains) { mountain in
                        NavigationLink {
                            AddTripView(selectedMountain: mountain)
                        } label: {
                            MountainCard(mountain: mountain)
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
        }
    }

    // MARK: - Grade Description Helper

    private func gradeDescription(for grade: Int) -> String {
        switch grade {
        case 1: "Beginner friendly. Easy trails suitable for first-time hikers and casual tourists."
        case 2: "Moderate difficulty. Requires basic fitness and some hiking experience."
        case 3: "Challenging. Steep terrain and dense forests requiring good stamina and preparation."
        case 4: "Very difficult. Demanding trails for experienced hikers with full gear."
        case 5: "Expert mountaineers only. Extreme conditions requiring advanced skills and equipment."
        default: "No description available."
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Trip.self, inMemory: true)
}
