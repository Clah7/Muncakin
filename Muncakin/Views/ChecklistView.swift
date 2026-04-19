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
        List {
            // Progress card
            Section {
                VStack(alignment: .leading, spacing: 12) {
                    HStack(spacing: 10) {
                        Image(systemName: "mountain.2.fill")
                            .foregroundStyle(.muncakinPrimary)
                        Text(trip.mountain?.name ?? "Unknown Mountain")
                            .font(.headline)
                        Spacer()
                        Text("\(packedCount)/\(totalCount)")
                            .font(.caption.weight(.semibold))
                            .monospacedDigit()
                            .foregroundStyle(.muncakinSecondary)
                    }
                    ProgressView(value: progress)
                        .tint(progress == 1.0 ? .green : .muncakinPrimary)
                }
                .padding(.vertical, 6)
            }

            // Gear items grouped by category
            if trip.generatedList.isEmpty {
                Section {
                    ContentUnavailableView(
                        "No Items Yet",
                        systemImage: "backpack",
                        description: Text("Tap + to add gear to your list.")
                    )
                }
            } else {
                ForEach(groupedItems, id: \.category) { group in
                    Section(group.category.rawValue.capitalized) {
                        ForEach(group.items) { item in
                            GearItemRow(item: item)
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    itemToEdit = item
                                }
                        }
                        .onDelete { offsets in
                            deleteItems(in: group.category, at: offsets)
                        }
                    }
                }
            }

            // Delete trip CTA
            Section {
                Button {
                    showDeleteConfirmation = true
                } label: {
                    Text("Delete Trip")
                        .destructiveCTAStyle()
                }
                .listRowInsets(EdgeInsets())
                .listRowBackground(Color.clear)
            }
        }
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

    private func deleteItems(in category: GearCategory, at offsets: IndexSet) {
        let categoryItems = trip.generatedList.filter { $0.category == category }
        withAnimation {
            for index in offsets {
                let item = categoryItems[index]
                trip.generatedList.removeAll { $0.id == item.id }
                modelContext.delete(item)
            }
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

// MARK: - Gear Item Row

private struct GearItemRow: View {
    @Bindable var item: GearItem

    private var quantityLabel: String {
        let formatted = item.quantity.truncatingRemainder(dividingBy: 1) == 0
            ? String(format: "%.0f", item.quantity)
            : String(format: "%.1f", item.quantity)
        return "\(formatted) \(item.unit.abbreviation)"
    }

    var body: some View {
        HStack(spacing: 12) {
            Toggle(isOn: $item.isPacked) {
                VStack(alignment: .leading, spacing: 5) {
                    Text(item.name)
                        .font(.body)
                        .strikethrough(item.isPacked, color: .muncakinSecondary)
                        .foregroundStyle(item.isPacked ? .muncakinSecondary : .primary)

                    HStack(spacing: 8) {
                        Label(quantityLabel, systemImage: "scalemass")
                            .font(.caption)
                            .foregroundStyle(.muncakinSecondary)

                        PriorityTag(priority: item.priority)
                    }
                }
            }
            .toggleStyle(.switch)
            .tint(.muncakinPrimary)

            Image(systemName: "chevron.right")
                .font(.caption2.weight(.semibold))
                .foregroundStyle(.muncakinSecondary.opacity(0.5))
        }
        .padding(.vertical, 4)
    }
}

// MARK: - Priority Tag

private struct PriorityTag: View {
    let priority: ItemPriority

    private var color: Color {
        switch priority {
        case .wajib: .red
        case .opsional: .muncakinPrimary
        }
    }

    var body: some View {
        Text(priority.rawValue.capitalized)
            .font(.caption2)
            .fontWeight(.medium)
            .padding(.horizontal, 6)
            .padding(.vertical, 2)
            .background(color.opacity(0.12))
            .foregroundStyle(color)
            .clipShape(RoundedRectangle(cornerRadius: 5))
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
