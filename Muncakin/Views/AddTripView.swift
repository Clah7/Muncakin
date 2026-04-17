// Views/AddTripView.swift

import SwiftUI
import SwiftData

struct AddTripView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    // Mock mountains for selection
    private static let mockMountains: [(name: String, altitude: Int, terrain: TerrainType)] = [
        ("Mt. Rinjani", 3726, .volcanic),
        ("Mt. Semeru", 3676, .jungle),
        ("Mt. Bromo", 2329, .volcanic),
        ("Mt. Merbabu", 3145, .alpine),
        ("Mt. Prau", 2590, .rocky),
    ]

    @State private var selectedMountainIndex = 0
    @State private var startDate = Date()
    @State private var durationDays = 2
    @State private var numberOfPeople = 1

    var body: some View {
        NavigationStack {
            Form {
                Section("Destination") {
                    Picker("Mountain", selection: $selectedMountainIndex) {
                        ForEach(Self.mockMountains.indices, id: \.self) { index in
                            Text(Self.mockMountains[index].name).tag(index)
                        }
                    }
                }

                Section("Schedule") {
                    DatePicker("Start Date", selection: $startDate, displayedComponents: .date)
                    Stepper("Duration: \(durationDays) day\(durationDays == 1 ? "" : "s")", value: $durationDays, in: 1...30)
                }

                Section("Group") {
                    Stepper("\(numberOfPeople) \(numberOfPeople == 1 ? "person" : "people")", value: $numberOfPeople, in: 1...20)
                }
            }
            .navigationTitle("New Trip")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Create") {
                        createTrip()
                    }
                }
            }
        }
    }

    private func createTrip() {
        let data = Self.mockMountains[selectedMountainIndex]
        let mountain = Mountain(
            name: data.name,
            peakAltitude: data.altitude,
            terrainType: data.terrain
        )
        modelContext.insert(mountain)

        let trip = Trip(
            mountain: mountain,
            startDate: startDate,
            durationDays: durationDays,
            numberOfPeople: numberOfPeople
        )
        // TODO: Generate dynamic packing list based on mountain data and trip duration
        modelContext.insert(trip)
        dismiss()
    }
}

#Preview {
    AddTripView()
        .modelContainer(for: Trip.self, inMemory: true)
}
