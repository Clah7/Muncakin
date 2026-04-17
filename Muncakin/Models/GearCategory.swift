// Models/GearCategory.swift

import Foundation

enum GearCategory: String, Codable, CaseIterable, Identifiable {
    case pakaian
    case tenda
    case makanan
    case medis
    case tambahan

    var id: String { rawValue }
}
