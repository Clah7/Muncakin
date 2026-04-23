// Views/ChecklistView.swift

import SwiftUI
import SwiftData

struct ChecklistView: View {
    @Environment(\.modelContext) private var modelContext
    @Bindable var trip: Trip

    @State private var showAddItem = false
    @State private var showFinishConfirmation = false
    @State private var itemToEdit: GearItem?

    // MARK: - Derived Data

    private var packedCount: Int {
        trip.gearList.filter(\.isPacked).count
    }

    private var totalCount: Int {
        trip.gearList.count
    }

    private var progress: Double {
        totalCount == 0 ? 0 : Double(packedCount) / Double(totalCount)
    }

    /// Groups gear items by category, preserving the canonical enum order.
    private var groupedItems: [(category: GearCategory, items: [GearItem])] {
        let grouped = Dictionary(grouping: trip.gearList) { $0.category }
        return GearCategory.allCases.compactMap { category in
            guard let items = grouped[category], !items.isEmpty else { return nil }
            return (category: category, items: items)
        }
    }

    // MARK: - Body

    var body: some View {
        ScrollView {
            VStack(spacing: Theme.cardSpacing) {
                // Hero header combines mountain info + trip summary
                HeroHeaderCard(trip: trip)

                // Progress bar
                progressCard

                // Gear list grouped by category
                if trip.gearList.isEmpty {
                    emptyState
                } else {
                    gearList
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
                    Label("Tambah Barang", systemImage: "plus")
                }
            }

            ToolbarItem(placement: .topBarLeading) {
                Button {
                    showFinishConfirmation = true
                } label: {
                    Label("Selesaikan", systemImage: "xmark.circle")
                        .foregroundStyle(.red)
                }
            }
        }
        .sheet(isPresented: $showAddItem) {
            ItemFormView(trip: trip)
        }
        .sheet(item: $itemToEdit) { item in
            EditGearView(item: item)
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
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("\(packedCount)/\(totalCount) dikemas")
                    .font(.subheadline.weight(.semibold))
                    .monospacedDigit()
                Spacer()
                if progress == 1.0 && totalCount > 0 {
                    Image(systemName: "checkmark.seal.fill")
                        .foregroundStyle(.green)
                }
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

    // MARK: - Gear List

    private var gearList: some View {
        LazyVStack(spacing: Theme.cardSpacing) {
            ForEach(groupedItems, id: \.category) { group in
                VStack(alignment: .leading, spacing: 8) {
                    Text(group.category.rawValue)
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(.muncakinSecondary)
                        .padding(.leading, 4)

                    ForEach(group.items) { item in
                        GearItemRow(item: item)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                itemToEdit = item
                            }
                    }
                }
            }
        }
    }

    // MARK: - Actions

    private func deleteTrip() {
        if let mountain = trip.mountain {
            modelContext.delete(mountain)
        }
        modelContext.delete(trip)
    }
}

#Preview {
    NavigationStack {
        ChecklistView(trip: Trip(
            mountain: Mountain(
                name: "Gunung Rinjani",
                peakAltitude: 3726,
                terrainType: .mixed,
                grade: "Advanced",
                gradeLevel: 4,
                durationEstimation: 3
            ),
            startDate: .now,
            endDate: Date().addingTimeInterval(86400 * 3)
        ))
    }
    .modelContainer(for: Trip.self, inMemory: true)
}
