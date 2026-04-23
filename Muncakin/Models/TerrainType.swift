// Models/TerrainType.swift

import Foundation

enum TerrainType: String, Codable, CaseIterable, Identifiable {
    case forest = "Hutan Tropis"
    case rocky = "Berbatu / Vulkanik"
    case savanna = "Sabana"
    case mixed = "Campuran"

    var id: String { rawValue }
}
