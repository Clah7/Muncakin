// Views/Components/TripCard.swift

import SwiftUI

struct TripCard: View {
    let trip: Trip

    private var packedCount: Int {
        trip.gearList.filter(\.isPacked).count
    }

    private var totalCount: Int {
        trip.gearList.count
    }

    private var progress: Double {
        totalCount == 0 ? 0 : Double(packedCount) / Double(totalCount)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 8) {
                Image(systemName: "mountain.2.fill")
                    .font(.caption)
                    .foregroundStyle(.muncakinPrimary)

                Text(trip.mountain?.name ?? "Unknown")
                    .font(.subheadline.weight(.semibold))
                    .lineLimit(1)
            }

            HStack(spacing: 10) {
                Label("\(trip.durationInDays)d", systemImage: "calendar")
                Label("\(trip.numberOfPeople)", systemImage: "person")
            }
            .font(.caption)
            .foregroundStyle(.muncakinSecondary)

            if totalCount > 0 {
                ProgressView(value: progress)
                    .tint(progress == 1.0 ? .green : .muncakinPrimary)

                Text("\(packedCount)/\(totalCount) packed")
                    .font(.caption2)
                    .foregroundStyle(.muncakinSecondary)
                    .monospacedDigit()
            }
        }
        .frame(width: 160, alignment: .leading)
        .floatingCard()
    }
}
