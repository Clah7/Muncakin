// Models/Mountain+Seed.swift

import Foundation

extension Mountain {
    /// Creates a fresh set of default mountains.
    /// Returns new instances each time (required for SwiftData).
    static var defaultMountains: [Mountain] {
        [
            // MARK: - Grade I

            Mountain(
                name: "Gunung Bromo",
                peakAltitude: 2329,
                terrainType: .rocky,
                grade: "Beginner",
                gradeLevel: 1,
                durationEstimation: 1,
                gradeExplanation: "Medan sangat mudah diakses. Satwa liar ada namun tidak berbahaya dan jauh dari keramaian. Barang wajib: masker, kacamata, serta makanan dan minuman ringan.",
                imageName: "mountain_bromo"
            ),

            // MARK: - Grade II

            Mountain(
                name: "Gunung Ambang",
                peakAltitude: 1795,
                terrainType: .rocky,
                grade: "Beginner-Intermediate",
                gradeLevel: 2,
                durationEstimation: 1,
                gradeExplanation: "Medan memiliki area gas beracun dari kawah. Waspada terhadap Macaca Nigra (Yaki), monyet hitam endemik Sulawesi. Barang wajib: masker gas atau kain untuk menghindari bau belerang yang menyengat.",
                imageName: "mountain_ambang"
            ),
            Mountain(
                name: "Gunung Ijen",
                peakAltitude: 2769,
                terrainType: .rocky,
                grade: "Beginner-Intermediate",
                gradeLevel: 2,
                durationEstimation: 1,
                gradeExplanation: "Medan didominasi tanah merah, berpasir, dan berbatu. Beberapa bagian cukup licin dengan jurang di kanan dan kiri jalur. Terdapat macan namun jauh dari jalur pendakian. Barang wajib: masker respirator, terutama untuk turun ke area blue fire.",
                imageName: "mountain_ijen"
            ),
            Mountain(
                name: "Gunung Kaba",
                peakAltitude: 1952,
                terrainType: .forest,
                grade: "Beginner-Intermediate",
                gradeLevel: 2,
                durationEstimation: 1,
                gradeExplanation: "Medan dengan track yang mudah dan jarak tempuh singkat. Terdapat owa siamang yang aman. Barang wajib: perlengkapan standar pendakian.",
                imageName: "mountain_kaba"
            ),
            Mountain(
                name: "Gunung Bulubaria",
                peakAltitude: 2730,
                terrainType: .forest,
                grade: "Beginner-Intermediate",
                gradeLevel: 2,
                durationEstimation: 2,
                gradeExplanation: "Medan cukup sulit. Kondisi satwa liar aman. Barang wajib: perlengkapan standar pendakian.",
                imageName: "mountain_bulubaria"
            ),
            Mountain(
                name: "Gunung Mambulilling",
                peakAltitude: 2873,
                terrainType: .forest,
                grade: "Beginner-Intermediate",
                gradeLevel: 2,
                durationEstimation: 1,
                gradeExplanation: "Medan berlumut tebal, berkabut, dan licin. Kondisi satwa liar aman. Barang wajib: trekking pole.",
                imageName: "mountain_mambulilling"
            ),
            Mountain(
                name: "Gunung Papandayan",
                peakAltitude: 2665,
                terrainType: .rocky,
                grade: "Beginner-Intermediate",
                gradeLevel: 2,
                durationEstimation: 1,
                gradeExplanation: "Medan berupa jalur yang landai, tertata, dan tidak terlalu curam. Kondisi satwa liar aman. Barang wajib: masker karena terdapat kawah belerang.",
                imageName: "mountain_papandayan"
            ),
            Mountain(
                name: "Gunung Bulusaraung",
                peakAltitude: 1353,
                terrainType: .rocky,
                grade: "Beginner-Intermediate",
                gradeLevel: 2,
                durationEstimation: 2,
                gradeExplanation: "Medan bebatuan dengan kondisi cukup terjal. Terdapat satwa yang tidak berbahaya, termasuk banyak kupu-kupu. Barang wajib: perlengkapan standar pendakian.",
                imageName: "mountain_bulusaraung"
            ),
            Mountain(
                name: "Gunung Batur",
                peakAltitude: 1717,
                terrainType: .rocky,
                grade: "Beginner-Intermediate",
                gradeLevel: 2,
                durationEstimation: 1,
                gradeExplanation: "Medan tanah berpasir dan batuan vulkanik. Terdapat monyet ekor panjang. Barang wajib: masker untuk menghindari belerang dan gaiter untuk medan pasir.",
                imageName: "mountain_batur"
            ),
            Mountain(
                name: "Gunung Maras",
                peakAltitude: 669,
                terrainType: .forest,
                grade: "Beginner-Intermediate",
                gradeLevel: 2,
                durationEstimation: 1,
                gradeExplanation: "Medan berupa tanah dengan kondisi cukup terjal. Satwa liar ada namun tidak berbahaya dan jauh dari keramaian. Barang wajib: perlengkapan standar pendakian.",
                imageName: "mountain_maras"
            ),

            // MARK: - Grade III

            Mountain(
                name: "Gunung Kelimutu",
                peakAltitude: 1639,
                terrainType: .rocky,
                grade: "Intermediate",
                gradeLevel: 3,
                durationEstimation: 1,
                gradeExplanation: "Medan berupa jalan setapak rapi dengan tangga semen dan pagar pembatas di bawah pepohonan pinus. Kondisi satwa liar aman. Barang wajib: masker karena terdapat kawah belerang aktif.",
                imageName: "mountain_kelimutu"
            ),
            Mountain(
                name: "Gunung Ciremai",
                peakAltitude: 3078,
                terrainType: .mixed,
                grade: "Intermediate",
                gradeLevel: 3,
                durationEstimation: 2,
                gradeExplanation: "Medan terjal dengan ketersediaan air yang minim. Terdapat babi hutan di area pos 6, hindari makanan dengan bau menyengat yang dapat mengundang hewan. Barang wajib: trekking pole.",
                imageName: "mountain_ciremai"
            ),
            Mountain(
                name: "Gunung Bawakaraeng",
                peakAltitude: 2830,
                terrainType: .mixed,
                grade: "Intermediate",
                gradeLevel: 3,
                durationEstimation: 2,
                gradeExplanation: "Medan terjal dengan hutan lumut yang licin dan suhu rendah sekitar 7-8°C. Terdapat babi hutan. Barang wajib: trekking pole, sepatu trekking, dan pakaian ekstra untuk menghindari hipotermia.",
                imageName: "mountain_bawakaraeng"
            ),
            Mountain(
                name: "Gunung Pangrango",
                peakAltitude: 3026,
                terrainType: .rocky,
                grade: "Intermediate",
                gradeLevel: 3,
                durationEstimation: 2,
                gradeExplanation: "Medan didominasi tanah berbatu dengan suhu rendah di bawah 5°C pada malam hari, terjal, dan sering hujan. Harap waspada terhadap macan tutul yang terkadang turun jika ekosistemnya terganggu. Barang wajib: sepatu trekking, trekking pole, dan pakaian ekstra untuk menghindari hipotermia.",
                imageName: "mountain_pangrango"
            ),
            Mountain(
                name: "Gunung Gede",
                peakAltitude: 2958,
                terrainType: .rocky,
                grade: "Intermediate",
                gradeLevel: 3,
                durationEstimation: 2,
                gradeExplanation: "Medan berbatu, berakar, dan terjal di beberapa trek tertentu dengan curah hujan yang tinggi. Harap waspada terhadap macan tutul yang terkadang turun jika ekosistemnya terganggu. Barang wajib: trekking pole, sepatu trekking, dan pakaian ekstra untuk menghindari hipotermia.",
                imageName: "mountain_gede"
            ),
            Mountain(
                name: "Halimun Salak",
                peakAltitude: 1929,
                terrainType: .forest,
                grade: "Intermediate",
                gradeLevel: 3,
                durationEstimation: 2,
                gradeExplanation: "Medan hutan hujan tropis pegunungan yang rapat, lembap, dan sering berkabut. Waspada terhadap Macan Tutul Jawa, biawak, dan ular. Barang wajib: jas hujan dan sepatu anti air.",
                imageName: "mountain_halimun_salak"
            ),
            Mountain(
                name: "Gunung Merbabu",
                peakAltitude: 3145,
                terrainType: .savanna,
                grade: "Intermediate",
                gradeLevel: 3,
                durationEstimation: 2,
                gradeExplanation: "Medan didominasi oleh banyak batuan besar. Terdapat Elang Jawa. Barang wajib: jaket tebal, topi kupluk, dan sarung tangan.",
                imageName: "mountain_merbabu"
            ),
            Mountain(
                name: "Gunung Nokilalaki",
                peakAltitude: 2357,
                terrainType: .forest,
                grade: "Intermediate",
                gradeLevel: 3,
                durationEstimation: 2,
                gradeExplanation: "Medan berupa jalur terjal menanjak dengan vegetasi hutan yang rapat dan cuaca yang tidak menentu. Terdapat satwa endemik seperti anoa, maleo, dan tarsius yang aman. Barang wajib: trekking pole dan sepatu trekking.",
                imageName: "mountain_nokilalaki"
            ),
            Mountain(
                name: "Gunung Masurai",
                peakAltitude: 2916,
                terrainType: .forest,
                grade: "Intermediate",
                gradeLevel: 3,
                durationEstimation: 3,
                gradeExplanation: "Medan ekstrem, lebat, dan lembap dengan jalur didominasi akar pohon, hutan lumut rapat, serta tanjakan curam. Waspada terhadap Harimau Sumatra. Barang wajib: jas hujan dan sepatu anti air.",
                imageName: "mountain_masurai"
            ),
            Mountain(
                name: "Gunung Tujuh",
                peakAltitude: 2732,
                terrainType: .forest,
                grade: "Intermediate",
                gradeLevel: 3,
                durationEstimation: 1,
                gradeExplanation: "Medan berupa hutan hujan tropis yang lebat. Waspada terhadap Harimau Sumatra. Barang wajib: jas hujan dan sepatu anti air.",
                imageName: "mountain_tujuh"
            ),
            Mountain(
                name: "Gunung Kelam",
                peakAltitude: 1002,
                terrainType: .rocky,
                grade: "Intermediate",
                gradeLevel: 3,
                durationEstimation: 1,
                gradeExplanation: "Medan berupa dinding batu curam. Terdapat beruang madu. Barang wajib: sarung tangan (gloves).",
                imageName: "mountain_kelam"
            ),

            // MARK: - Grade IV

            Mountain(
                name: "Gunung Kerinci",
                peakAltitude: 3805,
                terrainType: .mixed,
                grade: "Advanced",
                gradeLevel: 4,
                durationEstimation: 2,
                gradeExplanation: "Medan berupa hutan tropis lebat, jalur berlumpur yang licin, akar pohon yang menonjol, tanjakan tanah dan batu yang curam, serta pasir dan bebatuan vulkanik. Waspada terhadap Harimau Sumatra. Barang wajib: sepatu trekking, trekking pole, masker, dan gaiters.",
                imageName: "mountain_kerinci"
            ),
            Mountain(
                name: "Gunung Argopuro",
                peakAltitude: 3088,
                terrainType: .forest,
                grade: "Advanced",
                gradeLevel: 4,
                durationEstimation: 4,
                gradeExplanation: "Medan dengan jalur terpanjang di Jawa, lingkungan bervegetasi lebat, dengan tiga puncak: Arca, Argapura, dan Rengganis. Terdapat satwa liar seperti merak dan elang. Barang wajib: GPS, waterbag, dan sepatu trekking yang nyaman.",
                imageName: "mountain_argopuro"
            ),
            Mountain(
                name: "Bukit Raya",
                peakAltitude: 2278,
                terrainType: .forest,
                grade: "Advanced",
                gradeLevel: 4,
                durationEstimation: 5,
                gradeExplanation: "Medan berupa hutan hujan tropis yang lembab. Terdapat orang utan, beruang madu, dan macan dahan. Barang wajib: sepatu waterproof, dry bag, dan raincoat.",
                imageName: "mountain_raya"
            ),
            Mountain(
                name: "Gandang Dewata",
                peakAltitude: 3037,
                terrainType: .mixed,
                grade: "Advanced",
                gradeLevel: 4,
                durationEstimation: 7,
                gradeExplanation: "Medan gunung tertinggi di Sulawesi Barat dengan jalur sempit yang licin dan kemiringan hingga 70 derajat. Terdapat satwa endemik. Barang wajib: sepatu dengan grip kuat, trekking pole, dan tali.",
                imageName: "mountain_gandang_dewata"
            ),
            Mountain(
                name: "Gunung Binaiya",
                peakAltitude: 3027,
                terrainType: .rocky,
                grade: "Advanced",
                gradeLevel: 4,
                durationEstimation: 11,
                gradeExplanation: "Medan didominasi bebatuan keras. Terdapat burung nuri bayan dan kasturi. Barang wajib: sepatu trekking yang kuat dan helm.",
                imageName: "mountain_binaiya"
            ),
            Mountain(
                name: "Gunung Rinjani",
                peakAltitude: 3726,
                terrainType: .mixed,
                grade: "Advanced",
                gradeLevel: 4,
                durationEstimation: 3,
                gradeExplanation: "Medan terjal dengan puncak yang didominasi pasir serta kerikil vulkanik yang licin. Terdapat monyet dan elang flores. Barang wajib: masker atau buff, sepatu trekking, dan kacamata pelindung.",
                imageName: "mountain_rinjani"
            ),

            // MARK: - Grade V

            Mountain(
                name: "Gunung Leuser",
                peakAltitude: 3466,
                terrainType: .forest,
                grade: "Expert",
                gradeLevel: 5,
                durationEstimation: 10,
                gradeExplanation: "Medan berupa hutan hujan tropis perawan yang padat, terjal, berakar, dan berlumpur. Terdapat burung kucica ekor kuning. Barang wajib: sepatu waterproof, gaiter, dan raincoat.",
                imageName: "mountain_leuser"
            ),
            Mountain(
                name: "Carstensz Pyramid",
                peakAltitude: 4884,
                terrainType: .rocky,
                grade: "Expert",
                gradeLevel: 5,
                durationEstimation: 10,
                gradeExplanation: "Medan berupa tebing batu kapur vertikal menanjak yang licin dengan suhu di bawah 0°C dan medan teknis. Terdapat satwa liar lokal. Barang wajib: harness dan tali panjat, sepatu climbing, serta jaket tebal karena suhu ekstrem.",
                imageName: "mountain_carstensz_pyramid"
            ),
            Mountain(
                name: "Gunung Trikora",
                peakAltitude: 4751,
                terrainType: .mixed,
                grade: "Expert",
                gradeLevel: 5,
                durationEstimation: 7,
                gradeExplanation: "Medan berupa panjat tebing, hutan ericaceous, tanah lembur, dan sering berkabut. Terdapat puyuh salju dan bebek liar. Barang wajib: peralatan panjat dan sepatu high ankle.",
                imageName: "mountain_trikora"
            ),
        ]
    }
}
