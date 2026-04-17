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
    @Relationship var generatedList: [GearItem]
    var isPacked: Bool

    var durationDays: Int {
        Calendar.current.dateComponents([.day], from: startDate, to: endDate).day ?? 1
    }

    init(
        mountain: Mountain,
        startDate: Date,
        endDate: Date,
        numberOfPeople: Int = 1,
        generatedList: [GearItem] = [],
        isPacked: Bool = false
    ) {
        self.id = UUID()
        self.mountain = mountain
        self.startDate = startDate
        self.endDate = endDate
        self.numberOfPeople = numberOfPeople
        self.generatedList = generatedList
        self.isPacked = isPacked
    }
}
