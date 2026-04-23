// Models/ItemPriority.swift

import Foundation

enum GearPriority: String, Codable, CaseIterable, Identifiable {
    case mandatory = "Wajib"
    case optional = "Opsional"

    var id: String { rawValue }
}
