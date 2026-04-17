// Models/ItemOwnership.swift

import Foundation

enum ItemOwnership: String, Codable, CaseIterable, Identifiable {
    case personal
    case loaned

    var id: String { rawValue }
}
