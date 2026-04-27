// Views/AddTripView.swift

import SwiftUI
import SwiftData

struct AddTripView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    let selectedMountain: MountainInfo

    @State private var startDate = Date()
    @State private var endDate = Date()
    @State private var numberOfPeople = 1
    @State private var isRaining = false

    // MARK: - Computed Properties (UI Bindings)
    private var minimumEndDate: Date {
        let offset = max(selectedMountain.durationEstimation - 1, 0)
        return Calendar.current.date(byAdding: .day, value: offset, to: startDate) ?? startDate
    }

    var body: some View {
        ScrollView {
            LazyVStack(spacing: Theme.cardSpacing) {
                MountainHeaderCard(mountain: selectedMountain)

                // MARK: Schedule Card
                VStack(alignment: .leading, spacing: 16) {
                    Text("Jadwal")
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(.muncakinSecondary)

                    DatePicker("Tanggal Mulai", selection: $startDate, displayedComponents: .date)
                        .tint(.muncakinPrimary)

                    // endDate is restricted: the user cannot pick a date
                    // earlier than the mountain's minimum safe duration.
                    DatePicker(
                        "Tanggal Selesai",
                        selection: $endDate,
                        in: minimumEndDate...,
                        displayedComponents: .date
                    )
                    .tint(.muncakinPrimary)

                    HStack {
                        Text("Durasi")
                        Spacer()
                        Text("\(calculateDuration(from: startDate, to: endDate)) hari")
                            .foregroundStyle(.muncakinSecondary)
                    }

                    Stepper("Jumlah Orang: \(numberOfPeople)", value: $numberOfPeople, in: 1...30)
                }
                .floatingCard()

                // MARK: Conditions Card
                VStack(alignment: .leading, spacing: 16) {
                    Text("Kondisi Pendakian")
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(.muncakinSecondary)

                    Toggle("Apakah diprediksi hujan?", isOn: $isRaining)
                        .tint(.muncakinPrimary)
                }
                .floatingCard()

                // Create button
                Button {
                    createTrip()
                } label: {
                    Text("Buat Pendakian & Generate Checklist")
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
        .onAppear {
            // Set initial endDate to respect the mountain's minimum duration
            endDate = minimumEndDate
        }
        .onChange(of: startDate) { _, _ in
            // When startDate moves forward, ensure endDate stays at or past
            // the mountain's minimum safe duration boundary.
            if endDate < minimumEndDate {
                endDate = minimumEndDate
            }
        }
    }

    // MARK: - Date Math
    private func calculateDuration(from start: Date, to end: Date) -> Int {
        let calendar = Calendar.current
        let normalizedStart = calendar.startOfDay(for: start)
        let normalizedEnd = calendar.startOfDay(for: end)
        let daysBetween = calendar.dateComponents([.day], from: normalizedStart, to: normalizedEnd).day ?? 0
        return daysBetween + 1
    }

    // MARK: - Smart Filter

    private func filterGear(isCamping: Bool) -> [GearItem] {
        GearItem.defaultGear.filter { item in
            // Grade: item must not exceed the mountain's difficulty level
            guard item.minGradeLevel <= selectedMountain.gradeLevel else { return false }

            // Camping: camping-only gear excluded unless the trip requires overnight stays
            if item.requiresCamping && !isCamping { return false }

            // Rain: rain gear excluded unless rain is expected
            if item.isRainGear && !isRaining { return false }

            // Sulfur: sulfur protection gear excluded unless the mountain has sulfur
            if item.isSulfurGear && !selectedMountain.hasSulfur { return false }

            // Steep: steep terrain gear excluded unless the mountain is steep
            if item.isSteepGear && !selectedMountain.isSteep { return false }

            return true
        }
    }

    // MARK: - Quantity Scaling

    /// Determines the scaled quantity for a gear item based on trip duration.
    ///
    /// Consumable and daily-wear items scale linearly with trip length:
    /// - `.logistics` category items (food, water, gas) are consumed daily.
    /// - Items whose name contains "ganti" (spare clothes) or "kaos kaki" (socks)
    ///   need one set per day.
    ///
    /// All other items (tenda, sepatu, kompas, etc.) keep their base quantity unchanged.
    private func scaledQuantity(for template: GearItem, tripDays: Int) -> Int {
        let lowercasedName = template.name.lowercased()
        let needsScaling = template.category == .logistics
            || lowercasedName.contains("ganti")
            || lowercasedName.contains("kaos kaki")

        return needsScaling
            ? template.quantity * tripDays
            : template.quantity
    }

    // MARK: - Trip Creation (Orchestrator)

    /// Orchestrates duration math → filtering → scaling → persistence.
    private func createTrip() {
        // 1. Date math: compute exact duration and derive camping status
        let tripDurationInDays = calculateDuration(from: startDate, to: endDate)
        let autoCalculatedIsCamping = tripDurationInDays > 1

        // 2. Create the Mountain SwiftData model from the catalog info
        let mountainModel = Mountain(
            name: selectedMountain.name,
            peakAltitude: selectedMountain.altitude,
            terrainType: selectedMountain.terrain,
            grade: selectedMountain.grade,
            gradeLevel: selectedMountain.gradeLevel,
            durationEstimation: selectedMountain.durationEstimation,
            gradeExplanation: selectedMountain.gradeExplanation,
            imageName: selectedMountain.imageName,
            hasSulfur: selectedMountain.hasSulfur,
            isSteep: selectedMountain.isSteep
        )
        modelContext.insert(mountainModel)

        // 3. Filter gear templates, then clone with scaled quantities
        let filteredGear = filterGear(isCamping: autoCalculatedIsCamping)

        let clonedItems = filteredGear.map { template in
            GearItem(
                name: template.name,
                quantity: scaledQuantity(for: template, tripDays: tripDurationInDays),
                unit: template.unit,
                category: template.category,
                ownership: template.ownership,
                priority: template.priority,
                minGradeLevel: template.minGradeLevel,
                requiresCamping: template.requiresCamping,
                isRainGear: template.isRainGear,
                isSulfurGear: template.isSulfurGear,
                isSteepGear: template.isSteepGear
            )
        }

        for item in clonedItems {
            modelContext.insert(item)
        }

        // 4. Create and save the trip with the filtered, scaled gear list
        let trip = Trip(
            mountain: mountainModel,
            startDate: startDate,
            endDate: endDate,
            numberOfPeople: numberOfPeople,
            isCamping: autoCalculatedIsCamping,
            isRaining: isRaining,
            gearList: clonedItems
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
