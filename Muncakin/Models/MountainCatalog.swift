// Models/MountainCatalog.swift

import Foundation

struct MountainInfo: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let altitude: Int
    let terrain: TerrainType
    let gradeLevel: Int
    let durationEstimation: Int
    let gradeExplanation: String
    let imageName: String
    let hasSulfur: Bool
    let isSteep: Bool

    static func == (lhs: MountainInfo, rhs: MountainInfo) -> Bool {
        lhs.name == rhs.name
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }

    /// Maps gradeLevel to a human-readable grade string.
    var grade: String {
        switch gradeLevel {
        case 1: "Beginner"
        case 2: "Beginner-Intermediate"
        case 3: "Intermediate"
        case 4: "Advanced"
        case 5: "Expert"
        default: "Unknown"
        }
    }
}

enum MountainCatalog {
    /// Derives from the seed data to maintain a single source of truth.
    static let all: [MountainInfo] = Mountain.defaultMountains.map { m in
        MountainInfo(
            name: m.name,
            altitude: m.peakAltitude,
            terrain: m.terrainType,
            gradeLevel: m.gradeLevel,
            durationEstimation: m.durationEstimation,
            gradeExplanation: m.gradeExplanation,
            imageName: m.imageName,
            hasSulfur: m.hasSulfur,
            isSteep: m.isSteep
        )
    }

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
