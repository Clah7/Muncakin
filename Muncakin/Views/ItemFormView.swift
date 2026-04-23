// Views/ItemFormView.swift

import SwiftUI
import SwiftData

struct ItemFormView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    var existingItem: GearItem?
    var trip: Trip?

    @State private var name: String = ""
    @State private var quantity: Int = 1
    @State private var unit: String = "pcs"
    @State private var category: GearCategory = .others
    @State private var priority: GearPriority = .optional
    @State private var ownership: GearOwnership = .personal

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
                            .keyboardType(.numberPad)
                            .multilineTextAlignment(.trailing)
                            .frame(width: 80)
                            .foregroundStyle(.muncakinPrimary)
                    }
                    HStack {
                        Text("Satuan")
                        Spacer()
                        TextField("Unit", text: $unit)
                            .multilineTextAlignment(.trailing)
                            .frame(width: 120)
                            .foregroundStyle(.muncakinPrimary)
                    }
                }

                Section("Klasifikasi") {
                    Picker("Category", selection: $category) {
                        ForEach(GearCategory.allCases) { cat in
                            Text(cat.rawValue).tag(cat)
                        }
                    }
                    Picker("Priority", selection: $priority) {
                        ForEach(GearPriority.allCases) { p in
                            Text(p.rawValue).tag(p)
                        }
                    }
                    Picker("Ownership", selection: $ownership) {
                        ForEach(GearOwnership.allCases) { o in
                            Text(o.rawValue).tag(o)
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
                quantity: quantity,
                unit: unit,
                category: category,
                ownership: ownership,
                priority: priority
            )
            modelContext.insert(item)
            trip?.generatedList.append(item)
        }

        dismiss()
    }
}

#Preview("Add Mode") {
    ItemFormView(trip: Trip(
        mountain: Mountain(name: "Gunung Rinjani", peakAltitude: 3726, terrainType: .mixed, grade: "Advanced", gradeLevel: 4, durationEstimation: 3),
        startDate: .now,
        endDate: Date().addingTimeInterval(86400 * 3)
    ))
    .modelContainer(for: Trip.self, inMemory: true)
}
