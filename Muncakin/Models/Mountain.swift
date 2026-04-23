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
    var durationEstimation: Int
    var gradeExplanation: String
    var imageName: String
    var hasSulfur: Bool
    var isSteep: Bool

    init(
        name: String,
        peakAltitude: Int,
        terrainType: TerrainType,
        grade: String,
        gradeLevel: Int = 1,
        durationEstimation: Int = 1,
        gradeExplanation: String = "",
        imageName: String = "",
        hasSulfur: Bool = false,
        isSteep: Bool = false
    ) {
        self.id = UUID()
        self.name = name
        self.peakAltitude = peakAltitude
        self.terrainType = terrainType
        self.grade = grade
        self.gradeLevel = gradeLevel
        self.durationEstimation = durationEstimation
        self.gradeExplanation = gradeExplanation
        self.imageName = imageName
        self.hasSulfur = hasSulfur
        self.isSteep = isSteep
    }
}
