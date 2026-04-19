// Views/AddTripView.swift

import SwiftUI
import SwiftData

// MARK: - Mock Data

private struct MockMountain: Identifiable, Equatable {
    let id = UUID()
    let name: String
    let altitude: Int
    let terrain: TerrainType
    let grade: String

    static func == (lhs: MockMountain, rhs: MockMountain) -> Bool {
        lhs.name == rhs.name
    }
}

private let allMockMountains: [MockMountain] = [
    MockMountain(name: "Mt. Rinjani", altitude: 3726, terrain: .volcanic, grade: "Hard"),
    MockMountain(name: "Mt. Semeru", altitude: 3676, terrain: .jungle, grade: "Hard"),
    MockMountain(name: "Mt. Bromo", altitude: 2329, terrain: .volcanic, grade: "Easy"),
    MockMountain(name: "Mt. Merbabu", altitude: 3145, terrain: .alpine, grade: "Medium"),
    MockMountain(name: "Mt. Prau", altitude: 2590, terrain: .rocky, grade: "Easy"),
    MockMountain(name: "Mt. Ciremai", altitude: 3078, terrain: .jungle, grade: "Medium"),
    MockMountain(name: "Mt. Kerinci", altitude: 3805, terrain: .jungle, grade: "Hard"),
    MockMountain(name: "Mt. Papandayan", altitude: 2665, terrain: .volcanic, grade: "Easy"),
]

// MARK: - AddTripView

struct AddTripView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    @State private var selectedMountain: MockMountain?
    @State private var startDate = Date()
    @State private var endDate = Date().addingTimeInterval(86400 * 2)
    @State private var numberOfPeople = 1
    @State private var mountainSearchText = ""

    private var filteredMountains: [MockMountain] {
        if mountainSearchText.isEmpty {
            return allMockMountains
        }
        return allMockMountains.filter {
            $0.name.localizedCaseInsensitiveContains(mountainSearchText)
        }
    }

    private var durationDays: Int {
        let days = Calendar.current.dateComponents([.day], from: startDate, to: endDate).day ?? 0
        return days + 1
    }

    var body: some View {
        Form {
            Section("Destinasi") {
                NavigationLink {
                    MountainPickerView(
                        mountains: filteredMountains,
                        selection: $selectedMountain,
                        searchText: $mountainSearchText
                    )
                } label: {
                    HStack {
                        Text("Gunung")
                        Spacer()
                        if let mountain = selectedMountain {
                            Text(mountain.name)
                                .foregroundStyle(.muncakinSecondary)
                            GradeTag(grade: mountain.grade)
                        } else {
                            Text("Pilih")
                                .foregroundStyle(.muncakinSecondary)
                        }
                    }
                }
            }

            Section("Schedule") {
                DatePicker("Start Date", selection: $startDate, displayedComponents: .date)
                DatePicker("End Date", selection: $endDate, in: startDate..., displayedComponents: .date)
                HStack {
                    Text("Duration")
                    Spacer()
                    Text("\(durationDays) day\(durationDays == 1 ? "" : "s")")
                        .foregroundStyle(.muncakinSecondary)
                }
            }

            Section("Group") {
                Stepper("\(numberOfPeople) \(numberOfPeople == 1 ? "person" : "people")", value: $numberOfPeople, in: 1...20)
            }

            Section {
                Button {
                    createTrip()
                } label: {
                    Text("Tambah Pendakian")
                        .primaryCTAStyle(isDisabled: selectedMountain == nil)
                }
                .disabled(selectedMountain == nil)
                .listRowInsets(EdgeInsets())
                .listRowBackground(Color.clear)
            }
        }
        .navigationTitle("Pendakian Baru")
        .navigationBarTitleDisplayMode(.inline)
        .onChange(of: startDate) { _, newStart in
            if endDate < newStart {
                endDate = newStart
            }
        }
    }

    private func createTrip() {
        guard let data = selectedMountain else { return }

        let mountain = Mountain(
            name: data.name,
            peakAltitude: data.altitude,
            terrainType: data.terrain,
            grade: data.grade
        )
        modelContext.insert(mountain)

        let trip = Trip(
            mountain: mountain,
            startDate: startDate,
            endDate: endDate,
            numberOfPeople: numberOfPeople
        )
        // TODO: Generate dynamic packing list based on mountain data and trip duration
        modelContext.insert(trip)
        dismiss()
    }
}

// MARK: - Mountain Picker

private struct MountainPickerView: View {
    let mountains: [MockMountain]
    @Binding var selection: MockMountain?
    @Binding var searchText: String
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        List(mountains) { mountain in
            Button {
                selection = mountain
                dismiss()
            } label: {
                HStack {
                    VStack(alignment: .leading, spacing: 6) {
                        HStack(spacing: 8) {
                            Text(mountain.name)
                                .font(.body.weight(.medium))
                                .foregroundStyle(.primary)
                            GradeTag(grade: mountain.grade)
                        }
                        HStack(spacing: 4) {
                            Image(systemName: "arrow.up.right")
                                .font(.caption2)
                            Text("\(mountain.altitude)m")
                            Text("·")
                            Text(mountain.terrain.rawValue.capitalized)
                        }
                        .font(.caption)
                        .foregroundStyle(.muncakinSecondary)
                    }
                    Spacer()
                    if selection?.name == mountain.name {
                        Image(systemName: "checkmark")
                            .foregroundStyle(.muncakinPrimary)
                            .fontWeight(.semibold)
                    }
                }
                .padding(.vertical, 4)
            }
        }
        .navigationTitle("Pilih Gunung")
        .navigationBarTitleDisplayMode(.inline)
        .searchable(text: $searchText, prompt: "Cari Gunung")
    }
}

// MARK: - Grade Tag

private struct GradeTag: View {
    let grade: String

    private var color: Color {
        switch grade {
        case "Easy": .muncakinPrimary
        case "Medium": .orange
        case "Hard": .red
        default: .muncakinSecondary
        }
    }

    var body: some View {
        Text(grade)
            .font(.caption2)
            .fontWeight(.semibold)
            .padding(.horizontal, 7)
            .padding(.vertical, 3)
            .background(color.opacity(0.15))
            .foregroundStyle(color)
            .clipShape(RoundedRectangle(cornerRadius: 6))
    }
}

#Preview {
    NavigationStack {
        AddTripView()
    }
    .modelContainer(for: Trip.self, inMemory: true)
}
