// Views/AddTripView.swift

import SwiftUI
import SwiftData

struct AddTripView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    let selectedMountain: MountainInfo

    @State private var startDate = Date()
    @State private var endDate = Date().addingTimeInterval(86400 * 2)
    @State private var numberOfPeople = 1

    private var durationDays: Int {
        let days = Calendar.current.dateComponents([.day], from: startDate, to: endDate).day ?? 0
        return days + 1
    }

    var body: some View {
        ScrollView {
            LazyVStack(spacing: Theme.cardSpacing) {
                // Mountain header (read-only with info icon)
                MountainHeaderCard(mountain: selectedMountain)

                // Schedule
                VStack(alignment: .leading, spacing: 16) {
                    Text("Schedule")
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(.muncakinSecondary)

                    DatePicker("Start Date", selection: $startDate, displayedComponents: .date)
                        .tint(.muncakinPrimary)
                    DatePicker("End Date", selection: $endDate, in: startDate..., displayedComponents: .date)
                        .tint(.muncakinPrimary)

                    HStack {
                        Text("Duration")
                        Spacer()
                        Text("\(durationDays) day\(durationDays == 1 ? "" : "s")")
                            .foregroundStyle(.muncakinSecondary)
                    }
                }
                .floatingCard()

                // Group
                VStack(alignment: .leading, spacing: 16) {
                    Text("Group")
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(.muncakinSecondary)

                    Stepper("\(numberOfPeople) \(numberOfPeople == 1 ? "person" : "people")", value: $numberOfPeople, in: 1...20)
                }
                .floatingCard()

                // Create button
                Button {
                    createTrip()
                } label: {
                    Text("Tambah Pendakian")
                        .primaryCTAStyle()
                }
                .padding(.top, 8)
            }
            .padding(.horizontal, Theme.screenPadding)
            .padding(.vertical, 8)
        }
        .background(Color.muncakinScreenBackground.ignoresSafeArea())
        .navigationTitle("Pendakian Baru")
        .navigationBarTitleDisplayMode(.inline)
        .onChange(of: startDate) { _, newStart in
            if endDate < newStart {
                endDate = newStart
            }
        }
    }

    private func createTrip() {
        let mountainModel = Mountain(
            name: selectedMountain.name,
            peakAltitude: selectedMountain.altitude,
            terrainType: selectedMountain.terrain,
            grade: selectedMountain.grade,
            gradeLevel: selectedMountain.gradeLevel,
            durationEstimation: selectedMountain.durationEstimation,
            gradeExplanation: selectedMountain.gradeExplanation,
            imageName: selectedMountain.imageName
        )
        modelContext.insert(mountainModel)

        let defaultItems = GearItem.defaultGear
        for item in defaultItems {
            modelContext.insert(item)
        }

        let trip = Trip(
            mountain: mountainModel,
            startDate: startDate,
            endDate: endDate,
            numberOfPeople: numberOfPeople,
            generatedList: defaultItems
        )
        modelContext.insert(trip)
        dismiss()
    }
}

#Preview {
    NavigationStack {
        AddTripView(selectedMountain: MountainCatalog.all.first!)
    }
    .modelContainer(for: Trip.self, inMemory: true)
}
