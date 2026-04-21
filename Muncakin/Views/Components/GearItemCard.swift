// Views/Components/GearItemCard.swift

import SwiftUI
import SwiftData

struct GearItemCard: View {
    @Bindable var item: GearItem
    let onDelete: () -> Void

    private var quantityLabel: String {
        let formatted = item.quantity.truncatingRemainder(dividingBy: 1) == 0
            ? String(format: "%.0f", item.quantity)
            : String(format: "%.1f", item.quantity)
        return "\(formatted) \(item.unit.abbreviation)"
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Top row: Name, quantity, unit, toggle
            HStack(spacing: 12) {
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

                VStack(alignment: .leading, spacing: 2) {
                    Text(item.name)
                        .font(.body.weight(.medium))
                        .strikethrough(item.isPacked, color: .muncakinSecondary)
                        .foregroundStyle(item.isPacked ? .muncakinSecondary : .primary)

                    Label(quantityLabel, systemImage: "scalemass")
                        .font(.caption)
                        .foregroundStyle(.muncakinSecondary)
                }

                Spacer()

                Button(role: .destructive, action: onDelete) {
                    Image(systemName: "trash")
                        .font(.caption)
                        .foregroundStyle(.red.opacity(0.6))
                }
                .buttonStyle(.plain)
            }

            // Middle row: Priority + Ownership tags
            HStack(spacing: 6) {
                PriorityTag(priority: item.priority)
                OwnershipTag(ownership: item.ownership)
            }
            .padding(.leading, 36)

            // Bottom: Notes text field
            TextField("Add notes...", text: $item.notes, axis: .vertical)
                .font(.caption)
                .foregroundStyle(.secondary)
                .padding(10)
                .background(Color(.systemGray6))
                .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                .padding(.leading, 36)
        }
        .floatingCard()
    }
}
