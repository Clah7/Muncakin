// Models/ItemOwnership.swift

import Foundation

enum GearOwnership: String, Codable, CaseIterable, Identifiable {
    case personal = "Pribadi"
    case group = "Kelompok"

    var id: String { rawValue }
}
