// Views/Components/MountainCard.swift

import SwiftUI

struct MountainCard: View {
    let mountain: MountainInfo

    var body: some View {
        HStack(spacing: 14) {
            Image(systemName: "mountain.2.fill")
                .font(.title3)
                .foregroundStyle(.muncakinPrimary)
                .frame(width: 36)

            VStack(alignment: .leading, spacing: 5) {
                HStack(spacing: 8) {
                    Text(mountain.name)
                        .font(.body.weight(.semibold))
                        .foregroundStyle(.primary)

                    Spacer()

                    GradeTag(gradeLevel: mountain.gradeLevel)
                }

                HStack(spacing: 12) {
                    Label("\(mountain.altitude)m", systemImage: "arrow.up.right")
                    Label(mountain.terrain.rawValue.capitalized, systemImage: "leaf")
                }
                .font(.caption)
                .foregroundStyle(.muncakinSecondary)
            }

            Image(systemName: "chevron.right")
                .font(.caption.weight(.semibold))
                .foregroundStyle(.muncakinSecondary.opacity(0.5))
        }
        .floatingCard()
    }
}
