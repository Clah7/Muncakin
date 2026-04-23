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
    var isRented: Bool
    var isPacked: Bool
    var notes: String

    @Relationship(inverse: \Trip.generatedList)
    var trips: [Trip]?

    init(
        name: String,
        quantity: Int,
        unit: String,
        category: GearCategory,
        ownership: GearOwnership,
        priority: GearPriority = .mandatory,
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
        self.isRented = isRented
        self.isPacked = isPacked
        self.notes = notes
    }
}
