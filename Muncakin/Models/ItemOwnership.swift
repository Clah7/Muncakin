// Models/ItemOwnership.swift

import Foundation

enum ItemOwnership: String, Codable, CaseIterable, Identifiable {
    case pribadi
    case sewa

    var id: String { rawValue }
}
