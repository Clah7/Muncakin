// Views/Components/HeroHeaderCard.swift

import SwiftUI

struct HeroHeaderCard: View {
    let trip: Trip

    private var mountain: Mountain? { trip.mountain }

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            // Background: mountain image or gradient fallback
            mountainBackground

            // Gradient overlay so white text stays readable
            LinearGradient(
                colors: [.clear, .black.opacity(0.75)],
                startPoint: .center,
                endPoint: .bottom
            )

            // Foreground text content
            VStack(alignment: .leading, spacing: 8) {
                Spacer()

                Text(mountain?.name ?? "Gunung")
                    .font(.title2.weight(.bold))
                    .foregroundStyle(.white)

                Text(mountain?.terrainType.rawValue ?? "")
                    .font(.subheadline)
                    .foregroundStyle(.white.opacity(0.8))

                HStack(spacing: 16) {
                    Label(
                        "\(trip.durationInDays) Hari",
                        systemImage: "calendar"
                    )
                    Label(
                        "\(trip.numberOfPeople) Orang",
                        systemImage: "person.2"
                    )
                }
                .font(.caption.weight(.medium))
                .foregroundStyle(.white.opacity(0.9))

                // Remaining items indicator
                remainingBadge
            }
            .padding(Theme.cardPadding)
        }
        .frame(height: 220)
        .clipShape(RoundedRectangle(cornerRadius: Theme.cardRadius, style: .continuous))
    }

    // MARK: - Sub-views

    @ViewBuilder
    private var mountainBackground: some View {
        if let imageName = mountain?.imageName,
           UIImage(named: imageName) != nil {
            Image(imageName)
                .resizable()
                .scaledToFill()
                .frame(height: 220)
                .clipped()
        } else {
            // Gradient placeholder when no image is available
            LinearGradient(
                colors: [
                    Color.muncakinPrimary,
                    Color.muncakinPrimary.opacity(0.6)
                ],
                startPoint: .topTrailing,
                endPoint: .bottomLeading
            )
            .overlay(alignment: .topTrailing) {
                Image(systemName: "mountain.2.fill")
                    .font(.system(size: 64))
                    .foregroundStyle(.white.opacity(0.15))
                    .padding(20)
            }
        }
    }

    private var remainingBadge: some View {
        let remaining = trip.remainingItems
        let total = trip.gearList.count
        let allPacked = remaining == 0 && total > 0

        return HStack(spacing: 6) {
            Image(systemName: allPacked ? "checkmark.seal.fill" : "backpack.fill")
                .font(.caption2)

            if allPacked {
                Text("Semua sudah dikemas!")
            } else if total == 0 {
                Text("Belum ada barang")
            } else {
                Text("\(remaining) barang belum dikemas")
            }
        }
        .font(.caption.weight(.semibold))
        .foregroundStyle(allPacked ? .green : .white)
        .padding(.horizontal, 10)
        .padding(.vertical, 5)
        .background(.ultraThinMaterial, in: Capsule())
    }
}
