// Models/GearItem.swift

import Foundation
import SwiftData

@Model
final class GearItem {
    @Attribute(.unique) var id: UUID
    var name: String
    var category: GearCategory
    var triggerCondition: GearCondition
    var priority: ItemPriority
    var ownership: ItemOwnership
    var isPacked: Bool

    @Relationship(inverse: \Trip.generatedList)
    var trips: [Trip]?

    init(
        name: String,
        category: GearCategory,
        triggerCondition: GearCondition,
        priority: ItemPriority,
        ownership: ItemOwnership,
        isPacked: Bool = false
    ) {
        self.id = UUID()
        self.name = name
        self.category = category
        self.triggerCondition = triggerCondition
        self.priority = priority
        self.ownership = ownership
        self.isPacked = isPacked
    }
}
