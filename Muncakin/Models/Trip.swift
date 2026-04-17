// Models/Trip.swift

import Foundation
import SwiftData

@Model
final class Trip {
    @Attribute(.unique) var id: UUID
    var mountain: Mountain?
    var startDate: Date
    var durationDays: Int
    var numberOfPeople: Int
    @Relationship var generatedList: [GearItem]
    var isPacked: Bool

    init(
        mountain: Mountain,
        startDate: Date,
        durationDays: Int,
        numberOfPeople: Int = 1,
        generatedList: [GearItem] = [],
        isPacked: Bool = false
    ) {
        self.id = UUID()
        self.mountain = mountain
        self.startDate = startDate
        self.durationDays = durationDays
        self.numberOfPeople = numberOfPeople
        self.generatedList = generatedList
        self.isPacked = isPacked
    }
}
