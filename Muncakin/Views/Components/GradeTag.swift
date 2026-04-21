// Views/Components/GradeTag.swift

import SwiftUI

struct GradeTag: View {
    let gradeLevel: Int

    private var label: String { "Grade \(gradeLevel)" }

    private var color: Color {
        switch gradeLevel {
        case 1: .muncakinPrimary
        case 2: .yellow
        case 3: .orange
        case 4: .red
        case 5: .red
        default: .muncakinSecondary
        }
    }

    var body: some View {
        Text(label)
            .font(.caption2)
            .fontWeight(.semibold)
            .padding(.horizontal, 7)
            .padding(.vertical, 3)
            .background(color.opacity(0.15))
            .foregroundStyle(color)
            .clipShape(RoundedRectangle(cornerRadius: 6))
    }
}
