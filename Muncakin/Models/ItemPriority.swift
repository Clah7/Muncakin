// Models/ItemPriority.swift

import Foundation

enum ItemPriority: String, Codable, CaseIterable, Identifiable {
    case wajib
    case opsional

    var id: String { rawValue }
}
