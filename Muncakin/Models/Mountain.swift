// Models/Mountain.swift

import Foundation
import SwiftData

@Model
final class Mountain {
    @Attribute(.unique) var id: UUID
    var name: String
    var peakAltitude: Int
    var terrainType: TerrainType
    var grade: String

    init(name: String, peakAltitude: Int, terrainType: TerrainType, grade: String) {
        self.id = UUID()
        self.name = name
        self.peakAltitude = peakAltitude
        self.terrainType = terrainType
        self.grade = grade
    }
}
