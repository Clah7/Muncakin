// Views/ChecklistView.swift

import SwiftUI
import SwiftData

struct ChecklistView: View {
    @Environment(\.modelContext) private var modelContext
    @Bindable var trip: Trip

    @State private var showAddItem = false
    @State private var itemToEdit: GearItem?

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
            // Progress section
            Section {
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text(trip.mountain?.name ?? "Unknown Mountain")
                            .font(.headline)
                        Spacer()
                        Text("\(packedCount)/\(totalCount) packed")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    ProgressView(value: progress)
                        .tint(progress == 1.0 ? .green : .accentColor)
                }
                .padding(.vertical, 4)
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

            // Delete trip button
            Section {
                Button(role: .destructive) {
                    deleteTrip()
                } label: {
                    HStack {
                        Spacer()
                        Text("Delete Trip")
                            .fontWeight(.semibold)
                        Spacer()
                    }
                }
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
        HStack {
            Toggle(isOn: $item.isPacked) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(item.name)
                        .strikethrough(item.isPacked, color: .secondary)
                        .foregroundStyle(item.isPacked ? .secondary : .primary)

                    HStack(spacing: 8) {
                        Text(quantityLabel)
                            .font(.caption)
                            .foregroundStyle(.secondary)

                        PriorityTag(priority: item.priority)
                    }
                }
            }
            .toggleStyle(.switch)

            Image(systemName: "chevron.right")
                .font(.caption)
                .foregroundStyle(.tertiary)
        }
    }
}

// MARK: - Priority Tag

private struct PriorityTag: View {
    let priority: ItemPriority

    private var color: Color {
        switch priority {
        case .mandatory: .red
        case .optional: .blue
        }
    }

    var body: some View {
        Text(priority.rawValue.capitalized)
            .font(.caption2)
            .fontWeight(.medium)
            .padding(.horizontal, 5)
            .padding(.vertical, 1)
            .background(color.opacity(0.12))
            .foregroundStyle(color)
            .clipShape(RoundedRectangle(cornerRadius: 3))
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
