// Views/Components/GearItemCard.swift

import SwiftUI
import SwiftData

struct GearItemCard: View {
    @Bindable var item: GearItem
    let onEdit: () -> Void
    let onDelete: () -> Void

    private var quantityLabel: String {
        let formatted = item.quantity.truncatingRemainder(dividingBy: 1) == 0
            ? String(format: "%.0f", item.quantity)
            : String(format: "%.1f", item.quantity)
        return "\(formatted) \(item.unit.abbreviation)"
    }

    var body: some View {
        HStack(spacing: 12) {
            // Checkbox
            Button {
                withAnimation(.easeInOut(duration: 0.2)) {
                    item.isPacked.toggle()
                }
            } label: {
                Image(systemName: item.isPacked ? "checkmark.circle.fill" : "circle")
                    .font(.title3)
                    .foregroundStyle(item.isPacked ? .muncakinPrimary : .muncakinSecondary.opacity(0.4))
            }
            .buttonStyle(.plain)

            // Content — tappable to edit
            Button(action: onEdit) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(item.name)
                        .font(.body)
                        .strikethrough(item.isPacked, color: .muncakinSecondary)
                        .foregroundStyle(item.isPacked ? .muncakinSecondary : .primary)

                    HStack(spacing: 6) {
                        Label(quantityLabel, systemImage: "scalemass")
                            .font(.caption)
                            .foregroundStyle(.muncakinSecondary)

                        PriorityTag(priority: item.priority)
                        OwnershipTag(ownership: item.ownership)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .buttonStyle(.plain)

            // Delete
            Button(role: .destructive, action: onDelete) {
                Image(systemName: "trash")
                    .font(.caption)
                    .foregroundStyle(.red.opacity(0.6))
            }
            .buttonStyle(.plain)
        }
        .padding(.vertical, 10)
        .contentShape(Rectangle())
    }
}
