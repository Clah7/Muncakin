// Models/ItemPriority.swift

import Foundation

enum ItemPriority: String, Codable, CaseIterable, Identifiable {
    case mandatory
    case optional

    var id: String { rawValue }
}
