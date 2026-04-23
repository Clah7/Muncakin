// Models/GearCategory.swift

import Foundation

enum GearCategory: String, Codable, CaseIterable, Identifiable {
    case shelter = "Shelter"
    case personal = "Barang Pribadi"
    case logistics = "Logistik & Makanan"
    case safety = "Safety Tools"
    case medical = "P3K"
    case others = "Lainnya"

    var id: String { rawValue }
}
