// Models/GearCategory.swift

import Foundation

enum GearCategory: String, Codable, CaseIterable, Identifiable {
    case clothing
    case shelter
    case food
    case safety
    case base

    var id: String { rawValue }
}
