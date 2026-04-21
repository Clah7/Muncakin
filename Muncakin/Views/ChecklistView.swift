// Views/ChecklistView.swift

import SwiftUI
import SwiftData

struct ChecklistView: View {
    @Environment(\.modelContext) private var modelContext
    @Bindable var trip: Trip

    @State private var showAddItem = false
    @State private var showFinishConfirmation = false

    private var packedCount: Int {
        trip.generatedList.filter(\.isPacked).count
    }

    private var totalCount: Int {
        trip.generatedList.count
    }

    private var unpackedCount: Int {
        trip.generatedList.filter { !$0.isPacked }.count
    }

    private var progress: Double {
        totalCount == 0 ? 0 : Double(packedCount) / Double(totalCount)
    }

    private var groupedItems: [(category: GearCategory, items: [GearItem])] {
        let grouped = Dictionary(grouping: trip.generatedList) { $0.category }
        return GearCategory.allCases.compactMap { category in
            guard let items = grouped[category], !items.isEmpty else { return nil }
            return (category: category, items: items)
        }
    }

    var body: some View {
        ScrollView {
            LazyVStack(spacing: Theme.cardSpacing) {
                // Unpacked summary card
                UnpackedSummaryCard(
                    unpackedCount: unpackedCount,
                    totalCount: totalCount
                )

                // Progress card
                progressCard

                // Gear items
                if trip.generatedList.isEmpty {
                    emptyState
                } else {
                    gearCards
                }
            }
            .padding(.horizontal, Theme.screenPadding)
            .padding(.vertical, 8)
        }
        .background(Color.muncakinScreenBackground.ignoresSafeArea())
        .navigationTitle("List Barang")
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button {
                    showAddItem = true
                } label: {
                    Label("Add Item", systemImage: "plus")
                }
            }

            ToolbarItem(placement: .topBarLeading) {
                Button {
                    showFinishConfirmation = true
                } label: {
                    Label("Finish Trip", systemImage: "xmark.circle")
                        .foregroundStyle(.red)
                }
            }
        }
        .sheet(isPresented: $showAddItem) {
            ItemFormView(trip: trip)
        }
        .confirmationDialog(
            "Selesaikan Pendakian?",
            isPresented: $showFinishConfirmation,
            titleVisibility: .visible
        ) {
            Button("Selesaikan Pendakian", role: .destructive) {
                deleteTrip()
            }
        } message: {
            Text("Hal ini akan menghapus seluruh data pendakian dan list barang yang telah disimpan")
        }
    }

    // MARK: - Progress Card

    private var progressCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 10) {
                Image(systemName: "mountain.2.fill")
                    .font(.title)

                VStack(alignment: .leading, spacing: 2) {
                    Text(trip.mountain?.name ?? "Unknown Mountain")
                        .font(.headline)
                    Text("\(trip.durationDays) day\(trip.durationDays == 1 ? "" : "s") · \(trip.numberOfPeople) \(trip.numberOfPeople == 1 ? "person" : "people")")
                        .font(.caption)
                        .foregroundStyle(.muncakinSecondary)
                }

                Spacer()

                Text("\(packedCount)/\(totalCount)")
                    .font(.subheadline.weight(.bold))
                    .monospacedDigit()
                    .foregroundStyle(.muncakinPrimary)
            }

            ProgressView(value: progress)
                .tint(progress == 1.0 ? .green : .muncakinPrimary)
        }
        .floatingCard()
    }

    // MARK: - Empty State

    private var emptyState: some View {
        VStack(spacing: 12) {
            Image(systemName: "backpack")
                .font(.largeTitle)
                .foregroundStyle(.muncakinSecondary)
            Text("Belum ada barang")
                .font(.headline)
            Text("Ketuk + untuk menambahkan barang.")
                .font(.subheadline)
                .foregroundStyle(.muncakinSecondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 40)
        .floatingCard()
    }

    // MARK: - Gear Cards

    private var gearCards: some View {
        ForEach(groupedItems, id: \.category) { group in
            VStack(alignment: .leading, spacing: 8) {
                Text(group.category.rawValue.capitalized)
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(.muncakinSecondary)
                    .padding(.leading, 4)

                ForEach(group.items) { item in
                    GearItemCard(item: item) {
                        deleteItem(item)
                    }
                }
            }
        }
    }

    // MARK: - Actions

    private func deleteItem(_ item: GearItem) {
        withAnimation {
            trip.generatedList.removeAll { $0.id == item.id }
            modelContext.delete(item)
        }
    }

    private func deleteTrip() {
        for item in trip.generatedList {
            modelContext.delete(item)
        }
        if let mountain = trip.mountain {
            modelContext.delete(mountain)
        }
        modelContext.delete(trip)
    }
}

#Preview {
    NavigationStack {
        ChecklistView(trip: Trip(
            mountain: Mountain(name: "Mt. Rinjani", peakAltitude: 3726, terrainType: .volcanic, grade: "Grade 4", gradeLevel: 4),
            startDate: .now,
            endDate: Date().addingTimeInterval(86400 * 3)
        ))
    }
    .modelContainer(for: Trip.self, inMemory: true)
}
