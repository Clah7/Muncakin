// Views/Components/MountainHeaderCard.swift

import SwiftUI

struct MountainHeaderCard: View {
    let mountain: MountainInfo

    @State private var showDetail = false

    var body: some View {
        Button {
            showDetail = true
        } label: {
            ZStack(alignment: .leading) {
                mountainBackground

                LinearGradient(
                    colors: [.black.opacity(0.9), .clear],
                    startPoint: .leading,
                    endPoint: .trailing
                )

                VStack(alignment: .leading, spacing: 6) {
                    HStack(spacing: 8) {
                        Text(mountain.name)
                            .font(.title3.weight(.bold))
                            .foregroundStyle(.white)

                        
                    }

                    HStack(spacing: 12) {
                        Label("\(mountain.altitude)m", systemImage: "arrow.up.right")
                        Label(mountain.terrain.rawValue, systemImage: "leaf")
                    }
                    
                    .font(.caption.weight(.medium))
                    .foregroundStyle(.white.opacity(0.85))
                    GradeTag(gradeLevel: mountain.gradeLevel)
                }
                
                .padding(Theme.cardPadding)
            }
            .frame(height: 140)
            .clipShape(RoundedRectangle(cornerRadius: Theme.cardRadius, style: .continuous))
        }
        .buttonStyle(.plain)
        .sheet(isPresented: $showDetail) {
            mountainDetailSheet
        }
    }

    // MARK: - Background

    @ViewBuilder
    private var mountainBackground: some View {
        if UIImage(named: mountain.imageName) != nil {
            Image(mountain.imageName)
                .resizable()
                .scaledToFill()
                .frame(height: 140)
                .clipped()
        } else {
            LinearGradient(
                colors: [Color.muncakinPrimary, Color.muncakinPrimary.opacity(0.6)],
                startPoint: .topTrailing,
                endPoint: .bottomLeading
            )
            .overlay(alignment: .topTrailing) {
                Image(systemName: "mountain.2.fill")
                    .font(.system(size: 48))
                    .foregroundStyle(.white.opacity(0.15))
                    .padding(16)
            }
        }
    }

    // MARK: - Detail Sheet

    private var mountainDetailSheet: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(mountain.name)
                .font(.title2.weight(.bold))

            GradeTag(gradeLevel: mountain.gradeLevel)

            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], alignment: .leading, spacing: 12) {
                Label("\(mountain.altitude)m", systemImage: "arrow.up.right")
                Label(mountain.terrain.rawValue, systemImage: "leaf")
                Label("~\(mountain.durationEstimation) hari", systemImage: "calendar")
            }
            .font(.subheadline)
            .foregroundStyle(.secondary)

            Divider()

            Text(mountain.gradeExplanation)
                .font(.body)
                .foregroundStyle(.secondary)

            Spacer()
        }
        .padding(24)
        .frame(maxWidth: .infinity, alignment: .leading)
        .presentationDetents([.fraction(0.4), .medium])
    }
}

#Preview {
    if let mountain = MountainCatalog.all.first {
        MountainHeaderCard(mountain: mountain)
            .padding()
    }
}
