// Models/GearCondition.swift

import Foundation

struct GearCondition: Codable, Hashable, Sendable {
    var minAltitude: Int?
    var requiresRain: Bool
    var minDurationDays: Int?

    init(minAltitude: Int? = nil, requiresRain: Bool = false, minDurationDays: Int? = nil) {
        self.minAltitude = minAltitude
        self.requiresRain = requiresRain
        self.minDurationDays = minDurationDays
    }
}
