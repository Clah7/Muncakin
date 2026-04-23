// Views/EditGearView.swift

import SwiftUI
import SwiftData

struct EditGearView: View {
    @Environment(\.dismiss) private var dismiss
    @Bindable var item: GearItem

    var body: some View {
        NavigationStack {
            Form {
                Section("Detail Barang") {
                    TextField("Nama Barang", text: $item.name)

                    Stepper("Kuantitas: \(item.quantity)", value: $item.quantity, in: 1...99)

                    Toggle("Disewa", isOn: $item.isRented)
                        .tint(.muncakinPrimary)
                }

                Section {
                    TextField(
                        "Tulis catatan di sini...",
                        text: $item.notes,
                        axis: .vertical
                    )
                    .lineLimit(3...6)
                } header: {
                    Text("Catatan")
                } footer: {
                    Text("Catatan akan muncul di kartu barang jika diisi.")
                }
            }
            .navigationTitle("Ubah Barang")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Selesai") {
                        dismiss()
                    }
                    .fontWeight(.semibold)
                }
            }
        }
        .tint(.muncakinPrimary)
    }
}
