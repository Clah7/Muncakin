// Views/Components/PriorityTag.swift

import SwiftUI

struct PriorityTag: View {
    let priority: ItemPriority

    private var color: Color {
        switch priority {
        case .wajib: .red
        case .opsional: .muncakinPrimary
        }
    }

    var body: some View {
        Text(priority.rawValue.capitalized)
            .font(.caption2)
            .fontWeight(.medium)
            .padding(.horizontal, 6)
            .padding(.vertical, 2)
            .background(color.opacity(0.12))
            .foregroundStyle(color)
            .clipShape(RoundedRectangle(cornerRadius: 5))
    }
}
