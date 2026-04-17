// Models/MeasurementUnit.swift

import Foundation

enum MeasurementUnit: String, Codable, CaseIterable, Identifiable {
    case pcs
    case grams
    case kg
    case ml
    case liters

    var id: String { rawValue }

    var abbreviation: String {
        switch self {
        case .pcs: "buah"
        case .grams: "gram"
        case .kg: "kilogram"
        case .ml: "Mililiter"
        case .liters: "Liter"
        }
    }
}
