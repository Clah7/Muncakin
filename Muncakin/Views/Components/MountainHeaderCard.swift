// Views/Components/MountainHeaderCard.swift

import SwiftUI

struct MountainHeaderCard: View {
    let mountain: MountainInfo

    @State private var showGradeInfo = false

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 14) {
                Image(systemName: "mountain.2.fill")
                    .font(.title2)
                    .foregroundStyle(.muncakinPrimary)
                    .frame(width: 40)

                VStack(alignment: .leading, spacing: 5) {
                    HStack(spacing: 8) {
                        Text(mountain.name)
                            .font(.headline)

                        Button {
                            showGradeInfo = true
                        } label: {
                            Image(systemName: "info.circle")
                                .font(.caption)
                                .foregroundStyle(.muncakinPrimary)
                        }
                        .buttonStyle(.plain)
                    }

                    HStack(spacing: 12) {
                        Label("\(mountain.altitude)m", systemImage: "arrow.up.right")
                        Label(mountain.terrain.rawValue, systemImage: "leaf")
                    }
                    .font(.caption)
                    .foregroundStyle(.muncakinSecondary)
                }

                Spacer()

                GradeTag(gradeLevel: mountain.gradeLevel)
            }
        }
        .floatingCard()
        .overlay {
            RoundedRectangle(cornerRadius: Theme.cardRadius, style: .continuous)
                .strokeBorder(Color.muncakinPrimary.opacity(0.3), lineWidth: 1.5)
        }
        .alert("Grade \(mountain.gradeLevel)", isPresented: $showGradeInfo) {
            Button("OK", role: .cancel) {}
        } message: {
            Text(mountain.gradeExplanation)
        }
    }
}
