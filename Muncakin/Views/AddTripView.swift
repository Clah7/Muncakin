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
    MockMountain(name: "Mt. Rinjani", altitude: 3726, terrain: .volcanic, grade: "Grade 4"),
    MockMountain(name: "Mt. Semeru", altitude: 3676, terrain: .jungle, grade: "Grade 4"),
    MockMountain(name: "Mt. Bromo", altitude: 2329, terrain: .volcanic, grade: "Grade 1"),
    MockMountain(name: "Mt. Merbabu", altitude: 3145, terrain: .alpine, grade: "Grade 2"),
    MockMountain(name: "Mt. Prau", altitude: 2590, terrain: .rocky, grade: "Grade 1"),
    MockMountain(name: "Mt. Ciremai", altitude: 3078, terrain: .jungle, grade: "Grade 3"),
    MockMountain(name: "Mt. Kerinci", altitude: 3805, terrain: .jungle, grade: "Grade 4"),
    MockMountain(name: "Mt. Papandayan", altitude: 2665, terrain: .volcanic, grade: "Grade 2"),
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
                                .foregroundStyle(.muncakinPrimary)
                            GradeTag(grade: mountain.grade)
                        } else {
                            Text("Pilih")
                                .foregroundStyle(.muncakinPrimary)
                        }
                    }
                }
            }

            Section("Schedule") {
                DatePicker("Start Date", selection: $startDate, displayedComponents: .date)
                    .tint(.muncakinPrimary)
                DatePicker("End Date", selection: $endDate, in: startDate..., displayedComponents: .date)
                    .tint(.muncakinPrimary)
                HStack {
                    Text("Duration")
                    Spacer()
                    Text("\(durationDays) day\(durationDays == 1 ? "" : "s")")
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

// MARK: - Mountain Picker (Floating Cards)

private struct MountainPickerView: View {
    let mountains: [MockMountain]
    @Binding var selection: MockMountain?
    @Binding var searchText: String
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ScrollView {
            LazyVStack(spacing: Theme.cardSpacing) {
                ForEach(mountains) { mountain in
                    MountainSelectionCard(
                        name: mountain.name,
                        altitude: mountain.altitude,
                        terrain: mountain.terrain,
                        grade: mountain.grade,
                        isSelected: selection?.name == mountain.name
                    ) {
                        selection = mountain
                        dismiss()
                    }
                }
            }
            .padding(.horizontal, Theme.screenPadding)
            .padding(.vertical, 8)
        }
        .background(Color.muncakinScreenBackground.ignoresSafeArea())
        .navigationTitle("Pilih Gunung")
        .navigationBarTitleDisplayMode(.inline)
        .searchable(text: $searchText, prompt: "Cari Gunung")
    }
}

#Preview {
    NavigationStack {
        AddTripView()
    }
    .modelContainer(for: Trip.self, inMemory: true)
}
