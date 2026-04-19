// Views/ChecklistView.swift

import SwiftUI
import SwiftData

struct ChecklistView: View {
    @Environment(\.modelContext) private var modelContext
    @Bindable var trip: Trip

    @State private var showAddItem = false
    @State private var itemToEdit: GearItem?
    @State private var showDeleteConfirmation = false

    private var packedCount: Int {
        trip.generatedList.filter(\.isPacked).count
    }

    private var totalCount: Int {
        trip.generatedList.count
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
                // Progress card
                progressCard

                // Gear items
                if trip.generatedList.isEmpty {
                    emptyState
                } else {
                    gearCards
                }

                // Delete trip CTA
                Button {
                    showDeleteConfirmation = true
                } label: {
                    Text("Delete Trip")
                        .destructiveCTAStyle()
                }
                .padding(.top, 8)
            }
            .padding(.horizontal, Theme.screenPadding)
            .padding(.vertical, 8)
        }
        .background(Color.muncakinScreenBackground.ignoresSafeArea())
        .navigationTitle("Checklist")
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button {
                    showAddItem = true
                } label: {
                    Label("Add Item", systemImage: "plus")
                }
            }
        }
        .sheet(isPresented: $showAddItem) {
            ItemFormView(trip: trip)
        }
        .sheet(item: $itemToEdit) { item in
            ItemFormView(existingItem: item)
        }
        .confirmationDialog(
            "Delete this trip?",
            isPresented: $showDeleteConfirmation,
            titleVisibility: .visible
        ) {
            Button("Delete Trip", role: .destructive) {
                deleteTrip()
            }
        } message: {
            Text("This will permanently remove the trip and all its gear items.")
        }
    }

    // MARK: - Progress Card

    private var progressCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 10) {
                Image(systemName: "mountain.2.fill")
                    .font(.title3)
                    .foregroundStyle(.muncakinPrimary)

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
            Text("No Items Yet")
                .font(.headline)
            Text("Tap + to add gear to your list.")
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
            VStack(alignment: .leading, spacing: 0) {
                // Category header
                Text(group.category.rawValue.capitalized)
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(.muncakinSecondary)
                    .padding(.leading, 4)
                    .padding(.bottom, 8)

                // Items card — all items in one card per category
                VStack(spacing: 0) {
                    ForEach(Array(group.items.enumerated()), id: \.element.id) { index, item in
                        GearItemCard(item: item) {
                            itemToEdit = item
                        } onDelete: {
                            deleteItem(item)
                        }

                        if index < group.items.count - 1 {
                            Divider()
                                .padding(.leading, 44)
                        }
                    }
                }
                .floatingCard()
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
            mountain: Mountain(name: "Mt. Rinjani", peakAltitude: 3726, terrainType: .volcanic, grade: "Hard"),
            startDate: .now,
            endDate: Date().addingTimeInterval(86400 * 3)
        ))
    }
    .modelContainer(for: Trip.self, inMemory: true)
}
