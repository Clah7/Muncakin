// Models/Trip.swift

import Foundation
import SwiftData

@Model
final class Trip {
    @Attribute(.unique) var id: UUID
    var mountain: Mountain?
    var startDate: Date
    var endDate: Date
    var numberOfPeople: Int
    var isCamping: Bool
    var isRaining: Bool
    @Relationship(deleteRule: .cascade) var gearList: [GearItem]

    /// Inclusive day count using startOfDay normalization.
    /// e.g. 12th → 12th = 1 day, 12th → 13th = 2 days.
    var durationInDays: Int {
        let calendar = Calendar.current
        let start = calendar.startOfDay(for: startDate)
        let end = calendar.startOfDay(for: endDate)
        return (calendar.dateComponents([.day], from: start, to: end).day ?? 0) + 1
    }

    /// Number of gear items not yet packed.
    var remainingItems: Int {
        gearList.filter { !$0.isPacked }.count
    }

    init(
        mountain: Mountain,
        startDate: Date,
        endDate: Date,
        numberOfPeople: Int = 1,
        isCamping: Bool = false,
        isRaining: Bool = false,
        gearList: [GearItem] = []
    ) {
        self.id = UUID()
        self.mountain = mountain
        self.startDate = startDate
        self.endDate = endDate
        self.numberOfPeople = numberOfPeople
        self.isCamping = isCamping
        self.isRaining = isRaining
        self.gearList = gearList
    }
}
