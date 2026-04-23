// Models/GearItem+Seed.swift

import Foundation

extension GearItem {
    /// Creates a fresh set of default gear items for a new trip.
    /// Returns new instances each time (required for SwiftData).
    static var defaultGear: [GearItem] {
        [
            // MARK: - Shelter
            // All shelter items require camping (overnight stay).

            GearItem(name: "Sleeping Bag", quantity: 1, unit: "pcs", category: .shelter, ownership: .personal, requiresCamping: true),
            GearItem(name: "Matras", quantity: 1, unit: "pcs", category: .shelter, ownership: .personal, requiresCamping: true),
            GearItem(name: "Hammock", quantity: 1, unit: "pcs", category: .shelter, ownership: .personal, priority: .optional, requiresCamping: true),
            GearItem(name: "Tali Tenda", quantity: 1, unit: "set", category: .shelter, ownership: .group, requiresCamping: true),
            GearItem(name: "Pasak", quantity: 1, unit: "set", category: .shelter, ownership: .group, requiresCamping: true),
            GearItem(name: "Rangka Tenda", quantity: 1, unit: "set", category: .shelter, ownership: .group, requiresCamping: true),
            GearItem(name: "Flysheet", quantity: 1, unit: "set", category: .shelter, ownership: .group, requiresCamping: true),

            // MARK: - Barang Pribadi

            GearItem(name: "Sepatu Gunung", quantity: 1, unit: "pasang", category: .personal, ownership: .personal),
            GearItem(name: "Jaket Gunung", quantity: 1, unit: "pcs", category: .personal, ownership: .personal),
            GearItem(name: "Jas Ujan", quantity: 1, unit: "pcs", category: .personal, ownership: .personal, isRainGear: true),
            GearItem(name: "Sarung Tangan", quantity: 1, unit: "pasang", category: .personal, ownership: .personal, minGradeLevel: 2, isSteepGear: true),
            GearItem(name: "KTP", quantity: 1, unit: "pcs", category: .personal, ownership: .personal),
            GearItem(name: "Surat Izin Pendakian", quantity: 1, unit: "berkas", category: .personal, ownership: .personal),
            GearItem(name: "Sandal", quantity: 1, unit: "pasang", category: .personal, ownership: .personal, priority: .optional, minGradeLevel: 2, requiresCamping: true),
            GearItem(name: "Sunscreen", quantity: 1, unit: "tube", category: .personal, ownership: .personal),
            GearItem(name: "Peralatan Mandi", quantity: 1, unit: "set", category: .personal, ownership: .personal, minGradeLevel: 2, requiresCamping: true),
            GearItem(name: "Kaos Kaki", quantity: 2, unit: "pasang", category: .personal, ownership: .personal),
            GearItem(name: "Pakaian Layering", quantity: 1, unit: "set", category: .personal, ownership: .personal, minGradeLevel: 2),
            GearItem(name: "Baju Ganti", quantity: 1, unit: "set", category: .personal, ownership: .personal, minGradeLevel: 2, requiresCamping: true),
            GearItem(name: "Celana Ganti", quantity: 1, unit: "set", category: .personal, ownership: .personal, minGradeLevel: 2, requiresCamping: true),
            GearItem(name: "Pakaian Dalam Ganti", quantity: 3, unit: "pcs", category: .personal, ownership: .personal, minGradeLevel: 2, requiresCamping: true),
            GearItem(name: "Masker Respirator / Gas", quantity: 2, unit: "pcs", category: .personal, ownership: .personal, isSulfurGear: true),
            GearItem(name: "Topi", quantity: 1, unit: "pcs", category: .personal, ownership: .personal),
            GearItem(name: "Sunblock", quantity: 1, unit: "tube", category: .personal, ownership: .personal),
            GearItem(name: "Kacamata Pelindung", quantity: 1, unit: "pcs", category: .personal, ownership: .personal, isSulfurGear: true),

            // MARK: - Logistik & Makanan

            GearItem(name: "Nesting", quantity: 1, unit: "set", category: .logistics, ownership: .group, requiresCamping: true),
            GearItem(name: "Korek Api", quantity: 1, unit: "pcs", category: .logistics, ownership: .group, minGradeLevel: 2, requiresCamping: true),
            GearItem(name: "Botol Air", quantity: 2, unit: "botol", category: .logistics, ownership: .personal),
            GearItem(name: "Makanan Ringan", quantity: 3, unit: "pack", category: .logistics, ownership: .personal),
            GearItem(name: "Gas Kaleng", quantity: 1, unit: "kaleng", category: .logistics, ownership: .group, minGradeLevel: 2, requiresCamping: true),
            GearItem(name: "Filter Air Portable", quantity: 1, unit: "pcs", category: .logistics, ownership: .group, priority: .optional, minGradeLevel: 3),
            GearItem(name: "Piring", quantity: 1, unit: "pcs", category: .logistics, ownership: .personal, requiresCamping: true),
            GearItem(name: "Sendok", quantity: 1, unit: "pcs", category: .logistics, ownership: .personal, requiresCamping: true),

            // MARK: - Safety Tools

            GearItem(name: "Headlamp", quantity: 1, unit: "pcs", category: .safety, ownership: .personal),
            GearItem(name: "Tali Prusik", quantity: 1, unit: "roll", category: .safety, ownership: .group, minGradeLevel: 3, isSteepGear: true),
            GearItem(name: "Alat Jahit", quantity: 1, unit: "set", category: .safety, ownership: .group, minGradeLevel: 2),
            GearItem(name: "Trekking Pole", quantity: 1, unit: "pasang", category: .safety, ownership: .personal, minGradeLevel: 2, isSteepGear: true),
            GearItem(name: "Pisau Lipat", quantity: 1, unit: "pcs", category: .safety, ownership: .group, minGradeLevel: 2),
            GearItem(name: "Peta", quantity: 1, unit: "lembar", category: .safety, ownership: .group, minGradeLevel: 2),
            GearItem(name: "Kompas", quantity: 1, unit: "pcs", category: .safety, ownership: .group, minGradeLevel: 2),

            // MARK: - P3K

            GearItem(name: "Gulungan Kasa Steril", quantity: 1, unit: "roll", category: .medical, ownership: .group),
            GearItem(name: "Pembersih Berbahan Dasar Alkohol", quantity: 1, unit: "botol", category: .medical, ownership: .group),
            GearItem(name: "Pinset", quantity: 1, unit: "pcs", category: .medical, ownership: .group),
            GearItem(name: "Salep Antiseptik", quantity: 1, unit: "tube", category: .medical, ownership: .group),
            GearItem(name: "Perban Elastis", quantity: 1, unit: "roll", category: .medical, ownership: .group),
            GearItem(name: "Sarung Tangan Lateks", quantity: 1, unit: "pasang", category: .medical, ownership: .group),
            GearItem(name: "Ibuprofen dan Antihistamin", quantity: 1, unit: "strip", category: .medical, ownership: .group),
            GearItem(name: "Bubuk Elektrolit", quantity: 3, unit: "sachet", category: .medical, ownership: .group),
            GearItem(name: "Minyak Kayu Putih", quantity: 1, unit: "botol kecil", category: .medical, ownership: .group),
            GearItem(name: "Plester", quantity: 1, unit: "pack", category: .medical, ownership: .group),
            GearItem(name: "Betadine", quantity: 1, unit: "botol kecil", category: .medical, ownership: .group),
            GearItem(name: "Kapas", quantity: 1, unit: "bungkus", category: .medical, ownership: .group),
            GearItem(name: "Obat Maag", quantity: 1, unit: "strip", category: .medical, ownership: .group),
            GearItem(name: "Parasetamol", quantity: 1, unit: "strip", category: .medical, ownership: .group),
            GearItem(name: "Obat Diare", quantity: 1, unit: "strip", category: .medical, ownership: .group),
            GearItem(name: "Oralit", quantity: 3, unit: "sachet", category: .medical, ownership: .group),
            GearItem(name: "Salep Memar", quantity: 1, unit: "tube", category: .medical, ownership: .group),
            GearItem(name: "Obat Tetes Mata", quantity: 1, unit: "botol kecil", category: .medical, ownership: .group, isSulfurGear: true),
            GearItem(name: "Obat-obatan Pribadi", quantity: 1, unit: "set", category: .medical, ownership: .personal),

            // MARK: - Lainnya

            GearItem(name: "Lakban", quantity: 1, unit: "roll", category: .others, ownership: .group, minGradeLevel: 2),
            GearItem(name: "Trashbag", quantity: 3, unit: "pcs", category: .others, ownership: .group),
            GearItem(name: "Powerbank", quantity: 1, unit: "pcs", category: .others, ownership: .personal),
            GearItem(name: "Baterai Cadangan", quantity: 1, unit: "set", category: .others, ownership: .personal),
            GearItem(name: "Rain Cover", quantity: 1, unit: "pcs", category: .others, ownership: .personal, isRainGear: true),
        ]
    }
}
