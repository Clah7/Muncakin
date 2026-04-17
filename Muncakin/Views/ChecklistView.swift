// Views/ChecklistView.swift

import SwiftUI
import SwiftData

struct ChecklistView: View {
    @Environment(\.modelContext) private var modelContext
    @Bindable var trip: Trip

    @State private var showAddItem = false
    @State private var newItemName = ""
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

    var body: some View {
        NavigationStack {
            List {
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

                Section("Gear List") {
                    if trip.generatedList.isEmpty {
                        ContentUnavailableView(
                            "No Items Yet",
                            systemImage: "backpack",
                            description: Text("Tap + to add gear to your list.")
                        )
                    } else {
                        ForEach(trip.generatedList) { item in
                            GearItemRow(item: item)
                        }
                        .onDelete(perform: deleteItems)
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
                ToolbarItem(placement: .destructiveAction) {
                    Button("Delete Trip", role: .destructive) {
                        showDeleteConfirmation = true
                    }
                }
            }
            .alert("Add Gear Item", isPresented: $showAddItem) {
                TextField("Item name", text: $newItemName)
                Button("Add") {
                    addCustomItem()
                }
                Button("Cancel", role: .cancel) {
                    newItemName = ""
                }
            } message: {
                Text("Enter a name for the new gear item.")
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
    }

    private func addCustomItem() {
        let trimmed = newItemName.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }

        let item = GearItem(
            name: trimmed,
            category: .base,
            triggerCondition: GearCondition(),
            priority: .optional,
            ownership: .personal
        )
        modelContext.insert(item)
        trip.generatedList.append(item)
        newItemName = ""
    }

    private func deleteItems(at offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                let item = trip.generatedList[index]
                trip.generatedList.remove(at: index)
                modelContext.delete(item)
            }
        }
    }

    private func deleteTrip() {
        for item in trip.generatedList {
            modelContext.delete(item)
        }
        modelContext.delete(trip)
        if let mountain = trip.mountain {
            modelContext.delete(mountain)
        }
    }
}

private struct GearItemRow: View {
    @Bindable var item: GearItem

    var body: some View {
        Toggle(isOn: $item.isPacked) {
            VStack(alignment: .leading, spacing: 2) {
                Text(item.name)
                    .strikethrough(item.isPacked, color: .secondary)
                    .foregroundStyle(item.isPacked ? .secondary : .primary)

                HStack(spacing: 6) {
                    Text(item.category.rawValue.capitalized)
                    if item.priority == .mandatory {
                        Text("Required")
                            .fontWeight(.medium)
                            .foregroundStyle(.red)
                    }
                }
                .font(.caption)
                .foregroundStyle(.secondary)
            }
        }
        .toggleStyle(.switch)
    }
}

#Preview {
    ChecklistView(trip: Trip(
        mountain: Mountain(name: "Mt. Rinjani", peakAltitude: 3726, terrainType: .volcanic),
        startDate: .now,
        durationDays: 3
    ))
    .modelContainer(for: Trip.self, inMemory: true)
}
