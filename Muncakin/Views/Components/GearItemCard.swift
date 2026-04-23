// Views/Components/GearItemRow.swift

import SwiftUI
import SwiftData

struct GearItemRow: View {
    @Bindable var item: GearItem

    var body: some View {
        HStack(spacing: 12) {
            // Checkbox: toggles isPacked directly via @Bindable
            Button {
                withAnimation(.easeInOut(duration: 0.2)) {
                    item.isPacked.toggle()
                }
            } label: {
                Image(systemName: item.isPacked ? "checkmark.circle.fill" : "circle")
                    .font(.title3)
                    .foregroundStyle(
                        item.isPacked
                            ? .muncakinPrimary
                            : .muncakinSecondary.opacity(0.4)
                    )
            }
            .buttonStyle(.plain)

            // Item details
            VStack(alignment: .leading, spacing: 4) {
                Text(item.name)
                    .font(.body.weight(.medium))
                    .strikethrough(item.isPacked, color: .muncakinSecondary)
                    .foregroundStyle(item.isPacked ? .muncakinSecondary : .primary)

                HStack(spacing: 8) {
                    Label("\(item.quantity) \(item.unit)", systemImage: "scalemass")
                        .font(.caption)
                        .foregroundStyle(.muncakinSecondary)

                    if item.isRented {
                        Text("Sewa")
                            .font(.caption2.weight(.medium))
                            .foregroundStyle(.orange)
                            .padding(.horizontal, 5)
                            .padding(.vertical, 1)
                            .background(.orange.opacity(0.12))
                            .clipShape(RoundedRectangle(cornerRadius: 4))
                    }
                }

                // Ownership & Priority tags
                HStack(spacing: 6) {
                    Text(item.priority.rawValue)
                        .font(.caption2.weight(.medium))
                        .foregroundStyle(item.priority == .mandatory ? .red : .muncakinPrimary)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 3)
                        .background(
                            (item.priority == .mandatory ? Color.red : Color.muncakinPrimary)
                                .opacity(0.12)
                        )
                        .clipShape(Capsule())

                    Text(item.ownership.rawValue)
                        .font(.caption2.weight(.medium))
                        .foregroundStyle(.muncakinSecondary)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 3)
                        .background(Color.muncakinSecondary.opacity(0.1))
                        .clipShape(Capsule())
                }

                // Notes: read-only, only shown when not empty
                if !item.notes.isEmpty {
                    Text(item.notes)
                        .font(.caption)
                        .foregroundStyle(.orange)
                        .lineLimit(2)
                }
            }

            Spacer()

            // Chevron indicates the row is tappable (edit)
            Image(systemName: "chevron.right")
                .font(.caption.weight(.semibold))
                .foregroundStyle(.muncakinSecondary.opacity(0.5))
        }
        .padding(Theme.cardPadding)
        .background(Color.muncakinCardBackground)
        .clipShape(RoundedRectangle(cornerRadius: Theme.cardRadius, style: .continuous))
    }
}
