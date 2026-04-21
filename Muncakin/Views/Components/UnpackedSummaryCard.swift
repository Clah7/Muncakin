// Views/Components/UnpackedSummaryCard.swift

import SwiftUI

struct UnpackedSummaryCard: View {
    let unpackedCount: Int
    let totalCount: Int

    private var allPacked: Bool { unpackedCount == 0 && totalCount > 0 }

    private var accentColor: Color { allPacked ? .green : .muncakinPrimary }

    var body: some View {
        HStack(spacing: 14) {
            Image(systemName: allPacked ? "checkmark.seal.fill" : "backpack.fill")
                .font(.title2)
                .foregroundStyle(accentColor)
                .frame(width: 36)

            VStack(alignment: .leading, spacing: 4) {
                if allPacked {
                    Text("All items packed!")
                        .font(.headline)
                    Text("Ready to go.")
                        .font(.subheadline)
                        .foregroundStyle(.muncakinSecondary)
                } else if totalCount == 0 {
                    Text("No items yet")
                        .font(.headline)
                    Text("Add items to your packing list.")
                        .font(.subheadline)
                        .foregroundStyle(.muncakinSecondary)
                } else {
                    Text("You have \(unpackedCount) item\(unpackedCount == 1 ? "" : "s") left to pack")
                        .font(.headline)
                    Text("\(totalCount - unpackedCount) of \(totalCount) packed")
                        .font(.subheadline)
                        .foregroundStyle(.muncakinSecondary)
                        .monospacedDigit()
                }
            }

            Spacer()
        }
        .floatingCard()
        .overlay {
            RoundedRectangle(cornerRadius: Theme.cardRadius, style: .continuous)
                .strokeBorder(accentColor.opacity(0.3), lineWidth: 1.5)
        }
    }
}
