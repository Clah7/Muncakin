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
    var gradeExplanation: String

    init(name: String, peakAltitude: Int, terrainType: TerrainType, grade: String, gradeExplanation: String = "") {
        self.id = UUID()
        self.name = name
        self.peakAltitude = peakAltitude
        self.terrainType = terrainType
        self.grade = grade
        self.gradeExplanation = gradeExplanation
    }
}
