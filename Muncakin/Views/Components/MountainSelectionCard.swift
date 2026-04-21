// Views/Components/MountainSelectionCard.swift

import SwiftUI

struct MountainSelectionCard: View {
    let name: String
    let altitude: Int
    let terrain: TerrainType
    let gradeLevel: Int
    let gradeExplanation: String
    let isSelected: Bool
    let onTap: () -> Void

    @State private var showGradeInfo = false

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

                        // Info icon — does NOT select the mountain
                        Button {
                            showGradeInfo = true
                        } label: {
                            Image(systemName: "info.circle")
                                .font(.caption)
                                .foregroundStyle(.muncakinSecondary)
                        }
                        .buttonStyle(.plain)

                        Spacer()

                        GradeTag(gradeLevel: gradeLevel)
                    }

                    HStack(spacing: 12) {
                        Label("\(altitude)m", systemImage: "arrow.up.right")
                        Label(terrain.rawValue.capitalized, systemImage: "leaf")
                    }
                    .font(.caption)
                    .foregroundStyle(.muncakinSecondary)
                }

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
        .alert("Grade \(gradeLevel)", isPresented: $showGradeInfo) {
            Button("OK", role: .cancel) {}
        } message: {
            Text(gradeExplanation)
        }
    }
}
