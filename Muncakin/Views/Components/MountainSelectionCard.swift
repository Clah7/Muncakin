// Views/Components/MountainSelectionCard.swift

import SwiftUI

struct MountainSelectionCard: View {
    let name: String
    let altitude: Int
    let terrain: TerrainType
    let grade: String
    let isSelected: Bool
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 14) {
                // Mountain icon
                Image(systemName: "mountain.2.fill")
                    .font(.title3)
                    .foregroundStyle(.muncakinPrimary)
                    .frame(width: 36)

                // Info
                VStack(alignment: .leading, spacing: 5) {
                    HStack(spacing: 8) {
                        Text(name)
                            .font(.body.weight(.semibold))
                            .foregroundStyle(.primary)
                        GradeTag(grade: grade)
                    }

                    HStack(spacing: 12) {
                        Label("\(altitude)m", systemImage: "arrow.up.right")
                        Label(terrain.rawValue.capitalized, systemImage: "leaf")
                    }
                    .font(.caption)
                    .foregroundStyle(.muncakinSecondary)
                }

                Spacer()

                if isSelected {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.title3)
                        .foregroundStyle(.muncakinPrimary)
                }
            }
        }
        .floatingCard()
        .overlay {
            if isSelected {
                RoundedRectangle(cornerRadius: Theme.cardRadius, style: .continuous)
                    .strokeBorder(Color.muncakinPrimary, lineWidth: 2)
            }
        }
    }
}
