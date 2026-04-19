// Views/Components/GradeTag.swift

import SwiftUI

struct GradeTag: View {
    let grade: String

    private var color: Color {
        switch grade {
        case "Grade 1": .muncakinPrimary
        case "Grade 2": .yellow
        case "Grade 3": .yellow
        case "Grade 4": .orange
        case "Grade 5": .red
        default: .muncakinSecondary
        }
    }

    var body: some View {
        Text(grade)
            .font(.caption2)
            .fontWeight(.semibold)
            .padding(.horizontal, 7)
            .padding(.vertical, 3)
            .background(color.opacity(0.15))
            .foregroundStyle(color)
            .clipShape(RoundedRectangle(cornerRadius: 6))
    }
}
