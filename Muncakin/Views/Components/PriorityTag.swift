// Views/Components/PriorityTag.swift

import SwiftUI

struct PriorityTag: View {
    let priority: GearPriority

    private var color: Color {
        switch priority {
        case .mandatory: .red
        case .optional: .muncakinPrimary
        }
    }

    var body: some View {
        Text(priority.rawValue)
            .font(.caption2)
            .fontWeight(.medium)
            .padding(.horizontal, 6)
            .padding(.vertical, 2)
            .background(color.opacity(0.12))
            .foregroundStyle(color)
            .clipShape(RoundedRectangle(cornerRadius: 5))
    }
}
