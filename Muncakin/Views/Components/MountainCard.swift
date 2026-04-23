// Views/Components/MountainCard.swift

import SwiftUI

struct MountainCard: View {
    let mountain: MountainInfo

    var body: some View {
        HStack(spacing: 14) {
            Image(mountain.imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 64, height: 64)
                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
            

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
                    Label(mountain.terrain.rawValue, systemImage: "leaf")
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

#Preview {
    Group {
        if let firstMountain = MountainCatalog.all.first {
            MountainCard(mountain: firstMountain)
        } else {
            Text("No Mountains Available")
        }
    }
    .padding()
}
