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
        case .pcs: "Buah"
        case .grams: "Gram"
        case .kg: "Kilogram"
        case .ml: "Mililiter"
        case .liters: "Liter"
        }
    }
}
