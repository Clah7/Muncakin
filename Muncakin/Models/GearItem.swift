// Models/GearItem.swift

import Foundation
import SwiftData

@Model
final class GearItem {
    @Attribute(.unique) var id: UUID
    var name: String
    var quantity: Int
    var unit: String
    var category: GearCategory
    var ownership: GearOwnership
    var priority: GearPriority

    // Smart Filtering Parameters
    var minGradeLevel: Int
    var requiresCamping: Bool
    var isRainGear: Bool
    var isSulfurGear: Bool
    var isSteepGear: Bool

    var isRented: Bool
    var isPacked: Bool
    var notes: String

    @Relationship(inverse: \Trip.gearList)
    var trips: [Trip]?

    init(
        name: String,
        quantity: Int,
        unit: String,
        category: GearCategory,
        ownership: GearOwnership,
        priority: GearPriority = .mandatory,
        minGradeLevel: Int = 1,
        requiresCamping: Bool = false,
        isRainGear: Bool = false,
        isSulfurGear: Bool = false,
        isSteepGear: Bool = false,
        isRented: Bool = false,
        isPacked: Bool = false,
        notes: String = ""
    ) {
        self.id = UUID()
        self.name = name
        self.quantity = quantity
        self.unit = unit
        self.category = category
        self.ownership = ownership
        self.priority = priority
        self.minGradeLevel = minGradeLevel
        self.requiresCamping = requiresCamping
        self.isRainGear = isRainGear
        self.isSulfurGear = isSulfurGear
        self.isSteepGear = isSteepGear
        self.isRented = isRented
        self.isPacked = isPacked
        self.notes = notes
    }
}
