// Views/Components/OwnershipTag.swift

import SwiftUI

struct OwnershipTag: View {
    let ownership: GearOwnership

    var body: some View {
        Text(ownership.rawValue)
            .font(.caption2)
            .fontWeight(.medium)
            .padding(.horizontal, 6)
            .padding(.vertical, 2)
            .foregroundStyle(.muncakinSecondary)
            .background(Color.muncakinSecondary.opacity(0.08))
            .overlay {
                RoundedRectangle(cornerRadius: 5)
                    .strokeBorder(Color.muncakinSecondary.opacity(0.25), lineWidth: 1)
            }
            .clipShape(RoundedRectangle(cornerRadius: 5))
    }
}
