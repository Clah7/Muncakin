// Views/ItemFormView.swift

import SwiftUI
import SwiftData

struct ItemFormView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    var existingItem: GearItem?
    var trip: Trip?

    @State private var name: String = ""
    @State private var quantity: Double = 1
    @State private var unit: MeasurementUnit = .pcs
    @State private var category: GearCategory = .tambahan
    @State private var priority: ItemPriority = .opsional
    @State private var ownership: ItemOwnership = .pribadi

    private var isEditing: Bool { existingItem != nil }

    private var isValid: Bool {
        !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty && quantity > 0
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("Deskripsi Barang") {
                    TextField("Nama Barang", text: $name)
                    HStack {
                        Text("Kuantitas")
                        Spacer()
                        TextField("Qty", value: $quantity, format: .number)
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                            .frame(width: 80)
                            .foregroundStyle(.muncakinPrimary)
                    }
                    Picker("Satuan", selection: $unit) {
                        ForEach(MeasurementUnit.allCases) { u in
                            Text(u.abbreviation).tag(u)
                        }
                    }
                }

                Section("Klasifikasi") {
                    Picker("Category", selection: $category) {
                        ForEach(GearCategory.allCases) { cat in
                            Text(cat.rawValue.capitalized).tag(cat)
                        }
                    }
                    Picker("Priority", selection: $priority) {
                        ForEach(ItemPriority.allCases) { p in
                            Text(p.rawValue.capitalized).tag(p)
                        }
                    }
                    Picker("Ownership", selection: $ownership) {
                        ForEach(ItemOwnership.allCases) { o in
                            Text(o.rawValue.capitalized).tag(o)
                        }
                    }
                }

                Section {
                    Button {
                        save()
                    } label: {
                        Text("Simpan")
                            .primaryCTAStyle(isDisabled: !isValid)
                    }
                    .disabled(!isValid)
                    .listRowInsets(EdgeInsets())
                    .listRowBackground(Color.clear)
                }
            }
            .navigationTitle(isEditing ? "Ubah Barang" : "Tambah Barang")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Batalkan") { dismiss() }
                        .tint(.red)
                }
            }
            .onAppear {
                if let item = existingItem {
                    name = item.name
                    quantity = item.quantity
                    unit = item.unit
                    category = item.category
                    priority = item.priority
                    ownership = item.ownership
                }
            }
        }
        .tint(.muncakinPrimary)
    }

    private func save() {
        let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedName.isEmpty else { return }

        if let item = existingItem {
            item.name = trimmedName
            item.quantity = quantity
            item.unit = unit
            item.category = category
            item.priority = priority
            item.ownership = ownership
        } else {
            let item = GearItem(
                name: trimmedName,
                category: category,
                triggerCondition: GearCondition(),
                priority: priority,
                ownership: ownership,
                quantity: quantity,
                unit: unit
            )
            modelContext.insert(item)
            trip?.generatedList.append(item)
        }

        dismiss()
    }
}

#Preview("Add Mode") {
    ItemFormView(trip: Trip(
        mountain: Mountain(name: "Mt. Rinjani", peakAltitude: 3726, terrainType: .volcanic, grade: "Hard"),
        startDate: .now,
        endDate: Date().addingTimeInterval(86400 * 3)
    ))
    .modelContainer(for: Trip.self, inMemory: true)
}
