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
    var gradeLevel: Int
    var gradeExplanation: String

    init(name: String, peakAltitude: Int, terrainType: TerrainType, grade: String, gradeLevel: Int = 1, gradeExplanation: String = "") {
        self.id = UUID()
        self.name = name
        self.peakAltitude = peakAltitude
        self.terrainType = terrainType
        self.grade = grade
        self.gradeLevel = gradeLevel
        self.gradeExplanation = gradeExplanation
    }
}
