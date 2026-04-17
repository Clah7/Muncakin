// Models/TerrainType.swift

import Foundation

enum TerrainType: String, Codable, CaseIterable, Identifiable {
    case jungle
    case rocky
    case volcanic
    case alpine
    case desert

    var id: String { rawValue }
}
