// Models/MountainCatalog.swift

import Foundation

struct MountainInfo: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let altitude: Int
    let terrain: TerrainType
    let gradeLevel: Int
    let gradeExplanation: String

    static func == (lhs: MountainInfo, rhs: MountainInfo) -> Bool {
        lhs.name == rhs.name
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}

enum MountainCatalog {
    static let all: [MountainInfo] = [
        MountainInfo(name: "Mt. Bromo", altitude: 2329, terrain: .volcanic, gradeLevel: 1, gradeExplanation: "Jalur mudah dan pendek, cocok untuk pemula dan wisatawan umum."),
        MountainInfo(name: "Mt. Prau", altitude: 2590, terrain: .rocky, gradeLevel: 1, gradeExplanation: "Jalur pendek dan landai, sangat cocok untuk pendaki pemula."),
        MountainInfo(name: "Mt. Merbabu", altitude: 3145, terrain: .alpine, gradeLevel: 2, gradeExplanation: "Jalur moderat dengan medan terbuka, cocok untuk pendaki dengan sedikit pengalaman."),
        MountainInfo(name: "Mt. Papandayan", altitude: 2665, terrain: .volcanic, gradeLevel: 2, gradeExplanation: "Jalur moderat dengan pemandangan kawah aktif, cocok untuk pendaki menengah."),
        MountainInfo(name: "Mt. Ciremai", altitude: 3078, terrain: .jungle, gradeLevel: 3, gradeExplanation: "Jalur cukup menantang dengan hutan lebat dan tanjakan curam, membutuhkan stamina baik."),
        MountainInfo(name: "Mt. Rinjani", altitude: 3726, terrain: .volcanic, gradeLevel: 4, gradeExplanation: "Jalur sangat menantang dengan medan terjal, membutuhkan pengalaman mendaki dan peralatan lengkap."),
        MountainInfo(name: "Mt. Semeru", altitude: 3676, terrain: .jungle, gradeLevel: 4, gradeExplanation: "Pendakian panjang dan berat dengan risiko aktivitas vulkanik, hanya untuk pendaki berpengalaman."),
        MountainInfo(name: "Mt. Kerinci", altitude: 3805, terrain: .jungle, gradeLevel: 4, gradeExplanation: "Gunung tertinggi di Sumatera, jalur panjang dan berat menembus hutan tropis lebat."),
    ]

    static var groupedByGrade: [(grade: Int, mountains: [MountainInfo])] {
        let grouped = Dictionary(grouping: all) { $0.gradeLevel }
        return grouped.keys.sorted().map { grade in
            (grade: grade, mountains: grouped[grade]!)
        }
    }

    static func filtered(by searchText: String) -> [MountainInfo] {
        if searchText.isEmpty { return all }
        return all.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
    }

    static func groupedByGrade(filtered searchText: String) -> [(grade: Int, mountains: [MountainInfo])] {
        let mountains = filtered(by: searchText)
        let grouped = Dictionary(grouping: mountains) { $0.gradeLevel }
        return grouped.keys.sorted().map { grade in
            (grade: grade, mountains: grouped[grade]!)
        }
    }
}
